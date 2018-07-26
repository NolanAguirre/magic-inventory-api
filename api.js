const express = require('express');
const app = express();
require('dotenv').config()
const jwt = require('express-jwt');
const bodyParser = require('body-parser');
const jwksRsa = require('jwks-rsa');
const cors = require('cors');
const db = require('./db');
const fs = require('fs');
const {postgraphile} = require("postgraphile");
const PostGraphileConnectionFilterPlugin = require("postgraphile-plugin-connection-filter");
//db.updateSets(JSON.parse(fs.readFileSync('card_data/AllSetsFormatted.json', 'utf8')));
if (!process.env.AUTH0_DOMAIN || !process.env.AUTH0_AUDIENCE) {
    throw 'Make sure you have AUTH0_DOMAIN, and AUTH0_AUDIENCE in your .env file'
}

app.use(cors());

app.use(postgraphile(process.env.DATABASE_URL, "magic_inventory", {
    dynamicJson: true,
    enableCors: true,
    graphiql: true,
    appendPlugins: [PostGraphileConnectionFilterPlugin],
    pgDefaultRole: "magic_inventory_anonymous",
    jwtPgTypeIdentifier: "magic_inventory.jwt_token_type",
    jwtSecret: "supersecretphrase" //totally the top secret password
}));

app.listen(3002);
console.log('Listening on http://localhost:3002');
