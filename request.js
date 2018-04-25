const express = require('express');
const fetch = require('node-fetch');
require('dotenv').config()
var request = {};

request.tcgplayer = {};
// product query url http://api.tcgplayer.com/catalog/categories/categoryId/search
// auth token url  https://api.tcgplayer.com/token

request.tcgplayer.getAuthToken = function(){
    fetch('https://api.tcgplayer.com/token', {
        method: 'POST',
        body: `grant_type=client_credentials&client_id=${process.env.TCGPLAYER_PUBLIC_KEY}&client_secret=${process.env.TCGPLAYER_PRIVATE_KEY}`,
        headers:  {
            'Content-Type': 'application/x-www-form-urlencoded'
        }
    }).then(res => res.json())
	.then(function(json){
        request.tcgplayer.token = json;
        request.tcgplayer.token.isExpired => return new Date(request.tcgplayer.token['.expires']) - new Date() > 5000;
    });
}

request.tcgplayer.getProductId = function(params){
    if(request.tcgplayer.token.isExpired()){
        return request.tcgplayer.getAuthToken().then(() => request.tcgplayer.getProductId(params));
    }
    return fetch(`http://api.tcgplayer.com/catalog/categories/${params.categoryId}/search`),{
        method:'POST',
        body: params.filters,
        headers: {
            'Content-Type' : 'application/json',
            'Authorization' : `Bearer ${request.tcgplayer.token.access_token}`
        }
    })
        .then(res => res.json())
        .then(json => return json)
}

request.tcgplayer.getProductInfo = function(params){
    if(request.tcgplayer.token.isExpired()){
        return request.tcgplayer.getAuthToken().then(() => request.tcgplayer.getProductInfo(params));
    }
    return fetch(`http://api.tcgplayer.com/catalog/products/${params.productId}`,
        method:'GET',
        headers: {
            'Content-Type' : 'application/json',
            'Authorization' : `Bearer ${request.tcgplayer.token.access_token}`
        }
    )
    .then(res => res.json())
    .then(json => return json)
}
