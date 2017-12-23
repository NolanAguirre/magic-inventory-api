var express = require('express');
var pgp = require('pg-promise')( /*options*/ )
pgp.pg.defaults.ssl = true;
var db = {};
var database = pgp(process.env.DATABASE_URL);

db.getCards = function(queryParams, callback) {
  database.many('SELECT * FROM magic_cards WHERE name = $1', queryParams.name)
    .then(function(data) {
      callback(data);
    })
    .catch(function(err) {
      callback(null);
    });
}

db.updateSets = function(json) {
  for (var set in json) {
    json[set].cards.forEach(function(card) {
      database.one('SELECT EXISTS (SELECT 1 FROM magic_cards WHERE name = $1 AND set = $2)', [card.name, card.set])
        .then(function(data) {
          if (!data.exists) {
            database.none('INSERT INTO magic_cards (multiverseid, name, set, variations) VALUES ($1, $2, $3, $4)', [card.multiverseid, card.name, card.set,card.variations])
              .then(function() {})
              .catch(function(err) {
                console.log(err);
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
