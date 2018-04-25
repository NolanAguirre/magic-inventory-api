const express = require('express');
const app = express();
require('dotenv').config()
const jwt = require('express-jwt');
const bodyParser = require('body-parser');
const jwksRsa = require('jwks-rsa');
const cors = require('cors');
const db = require('./db');
const fs = require('fs');
db.createDatabased();
if (!process.env.AUTH0_DOMAIN || !process.env.AUTH0_AUDIENCE) {
    throw 'Make sure you have AUTH0_DOMAIN, and AUTH0_AUDIENCE in your .env file'
}

app.use(cors());
app.use(bodyParser.json());

const checkJwt = jwt({
    // Dynamically provide a signing key based on the kid in the header and the singing keys provided by the JWKS endpoint.
    secret: jwksRsa.expressJwtSecret({
        cache: true,
        rateLimit: true,
        jwksRequestsPerMinute: 5,
        jwksUri: `https://${process.env.AUTH0_DOMAIN}/.well-known/jwks.json`
    }),

    // Validate the audience and the issuer.
    audience: process.env.AUTH0_AUDIENCE,
    issuer: `https://${process.env.AUTH0_DOMAIN}/`,
    algorithms: ['RS256']
});

app.get('/api/public', function(req, res) {
    res.json({
        message: "Hello from a public endpoint! You don't need to be authenticated to see this."
    });
});

app.post('/api/typeahead', function(req, res) {
    db.typeahead(req.body.queryParams).then(
        function(data){
            if (data) {
                res.json(data.slice(0, 10));
            }
        }
    )
});

app.post('/api/search', checkJwt, function(req, res) {
    db.getCards(req.body.queryParams).then(function(data) {
        res.json(data)
    })
});
app.post('/api/role', checkJwt, function(req, res) { // checks the role
    db.checkRole(req.body)
        .then(function(roleData){
            if(roleData != 'user'){
                let queryParams = {
                    queryParams:{
                        userId: req.body.sub
                    }
                }
                db.getStore(queryParams).then(function(storeData){
                    let temp = {
                        store: storeData,
                        role: roleData
                    }
                    res.json(temp);
                })
            }else{
                let temp = {
                    store: null,
                    role: roleData
                }
                res.json(temp);
            }
        })
});
app.post('/api/admin/inventory', checkJwt, function(req, res) {
    db.addToInventory(req.body.queryParams).then(function(data) {
        res.status(200);
    })
});
app.post('/api/admin/orders')
app.post('/api/admin/settings')

app.listen(3001);
console.log('Listening on http://localhost:3001');
