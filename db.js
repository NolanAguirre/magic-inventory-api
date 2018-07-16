var express = require('express');
var pgp = require('pg-promise')( /*options*/ )
pgp.pg.defaults.ssl = true;
var db = {};
const fs = require('fs');
var database = pgp(process.env.DATABASE_URL);
db.updateSets = function(json) {
  for (var set in json) {
    json[set].cards.forEach(function(card) {
      database.one('SELECT EXISTS (SELECT * FROM magic_inventory.cards WHERE name = $1 AND set_name = $2)', [card.name, card.set])
        .then(function(data) {
          if (!data.exists) {
            console.log("Inserting card");
            database.none('INSERT INTO magic_inventory.cards (name, tcg_id, multiverse_id, set_code, set_name, collectors_number, variations) VALUES ($1, $2, $3, $4, $5, $6,$7)', [card.name, 0, card.multiverseid, card.setCode, card.set, null, card.variations])
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
