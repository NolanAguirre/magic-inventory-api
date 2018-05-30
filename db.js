var express = require('express');
var pgp = require('pg-promise')( /*options*/ )
pgp.pg.defaults.ssl = true;
var db = {};
const fs = require('fs');
var database = pgp(process.env.DATABASE_URL);
db.checkRole = function(auth0_id){
  return database.one('SELECT role FROM magic_inventory.users WHERE auth_id = $1', auth_id)
}
db.typeahead = function(queryParams){
    let queryString;
    let queryValues;
    if(queryParams.name){
        queryString = 'SELECT DISTINCT name FROM magic_cards WHERE name LIKE $1';
        queryValues = queryParams.name + '%';
    }else if(queryParams.setcode){
        queryString = 'SELECT DISTINCT setcode FROM magic_cards WHERE setcode LIKE $1';
        queryValues = queryParams.setCode + '%';
    }
    return database.many(queryString, queryValues)
       .then(function(data) {
         return data;
       })
       .catch(function(err) {
         return null;
       });
}
db.updateSets = function(json) {
  for (var set in json) {
    json[set].cards.forEach(function(card) {
      database.one('SELECT EXISTS (SELECT 1 FROM magic_inventory.cards WHERE name = $1 AND set_name = $2)', [card.name, card.set])
        .then(function(data) {
          if (!data.exists) {
            database.none('INSERT INTO magic_inventory.cards (name, tcg_id, multiverse_id, set_code, set_name, collectors_number, variations) VALUES ($1, $2, $3, $4, $5, $6,$7)',
                         [card.name, 0, card.multiverseid, card.setCode,card.set, card.number.replace(/\D/g,''), card.variations])
              .then(function() {})
              .catch(function(err) {
                console.log(err)
              });
          }
        })
        .catch(function(err) {
          console.log(err);
        })
    })
  }
}
module.exports = db;
