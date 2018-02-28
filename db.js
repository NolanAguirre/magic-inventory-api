var express = require('express');
var pgp = require('pg-promise')( /*options*/ )
pgp.pg.defaults.ssl = true;
var db = {};
const fs = require('fs');
var database = pgp(process.env.DATABASE_URL);

db.queryInvetory = function(queryParams){
    return database.many('SELECT * FROM inventory WHERE cardname = $1 AND storeid = $2', [queryParams.card.name, queryParams.store.id])
        .then(function(data){
            return data;
        }).catch(function(err) {
          return null;
        });
}
db.addToInventory = function(queryParams){
    let updateString;
    let updateValues;
    database.one('SELECT * FROM inventory WHERE cardname = $1 AND storeid = $2 AND set = $3 AND foil = $4',  [queryParams.card.name, queryParams.store.id, queryParams.card.set, queryParams.card.foil])
    .then(function(data){
        if(data !=null){
            updateString = 'UPDATE inventory SET quantity = $5 WHERE cardname = $1 AND storeid = $2 AND set = $3 AND foil = $4';
            updateValues = [queryParams.card.name, queryParams.store.id, queryParams.card.set, queryParams.card.foil, queryParams.card.quantity];
        }else{
            updateString = 'INSERT INTO inventory VALUES (cardname, storeid, set, foil, quantity)';
            updateValues = [queryParams.card.name, queryParams.store.id, queryParams.card.set, queryParams.card.quantity]
        }
    }).catch(function(err){
        return err
    })
}

db.getCards = function(queryParams) {
    let queryString;
    let queryValues;
    if(queryParams.name){
        queryString = 'SELECT * FROM magic_cards WHERE name = $1';
        queryValues = queryParams.name;
    }else if(queryParams.setcode && queryParams.collectorsnumber){
        queryString = 'SELECT * FROM magic_cards WHERE setcode = $1 AND collectorsnumber = $2';
        queryValues = [queryParams.setcode, queryParams.collectorsnumber];
    }
    return database.many(queryString, queryValues)
       .then(function(data) {
         return data;
       })
       .catch(function(err) {
         return null;
       });
}

db.typeahead = function(queryParams, callback){
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

db.createDatabased = function(){
    database.none("CREATE TABLE magic_cards (multiverseid integer,name citext,set citext, variations integer[],setcode citext, collectorsnumber integer)")
    .then(function(data){
        db.updateSets(JSON.parse(fs.readFileSync('card_data/AllSetsFormatted.json', 'utf8')));
    }).catch(function(err){
        console.log(err);
    })
}


db.updateSets = function(json) {
  for (var set in json) {
    json[set].cards.forEach(function(card) {
      database.one('SELECT EXISTS (SELECT 1 FROM magic_cards WHERE name = $1 AND set = $2)', [card.name, card.set])
        .then(function(data) {
          if (!data.exists) {
            database.none('INSERT INTO magic_cards (multiverseid, name, set, variations, setcode, collectorsnumber) VALUES ($1, $2, $3, $4, $5, $6)', [card.multiverseid, card.name, card.set,card.variations, card.setCode, card.number])
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
db.getAllSets = function() {
  database.many('SELECT * FROM magic_cards')
    .then(function(data) {
        let sets = []
        let outputSets = [];
        data.forEach(function(card){
            if(!sets.includes(card.set)){
                sets.push(card.set);
                outputSets.push(card.set + " Name: " + card.name);
            }
        })
        fs.writeFile('allSetNames.json', JSON.stringify(outputSets), 'utf8', function(err){
          if(err){
            console.log(err);
          }
        });
    })
    .catch(function(err) {
      console.log(null);
    });
}
module.exports = db;
