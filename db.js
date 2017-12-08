var express = require('express');
var pgp = require('pg-promise')( /*options*/ )
pgp.pg.defaults.ssl = true;
var db = pgp("postgres://nolan@localhost:5432/magicInventory");
module.exports = db;
