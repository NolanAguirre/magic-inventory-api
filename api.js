const express = require('express');
const app = express();
require('dotenv').config()
const jwt = require('express-jwt');
const bodyParser = require('body-parser');
const jwtAuthz = require('express-jwt-authz');
const jwksRsa = require('jwks-rsa');
const cors = require('cors');
const db = require('./db')

// db.updateSets(JSON.parse(fs.readFileSync('AllSetsFormatted.json', 'utf8')));
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

const checkScopes = jwtAuthz(['read:messages']);
const checkScopesAdmin = jwtAuthz(['write:messages']);

app.get('/api/public', function(req, res) {
    res.json({
        message: "Hello from a public endpoint! You don't need to be authenticated to see this."
    });
});

app.post('/api/typeahead', function(req, res) {
    console.log(req.body)
    db.typeahead(req.body.queryParams, function(data){
        if(data){
            res.json(data.slice(0,10));
        }
    })
});

app.get('/api/typeahead', function(req, res) {
    res.json({
        message: "Hello from a public endpoint! You don't need to be authenticated to see this."
    });
});

app.post('/api/search', function(req, res) {
    function formatString(set, name){
        return set.replace(/[^a-zA-Z\d\s]/g, "").replace(/ /g, '+') + '/' + name.replace(/[^a-zA-Z\d\s]/g, "").replace(/ /g, '+');
    }
    console.log(req.body.queryParams);
    db.getCards(req.body.queryParams, function(data) {
        if (data) {
            data.forEach(function(card) {
                //  https://magic-price-api.herokuapp.com/
                card.url = "http://localhost:3002/" + formatString(card.set, card.name);
            })
            res.json(data)
        } else {
            res.json(null);
        }
    })
});

app.get('/api/private', checkJwt, checkScopes, function(req, res) {
    res.json({
        message: "Hello from a private endpoint! You need to be authenticated and have a scope of read:messages to see this."
    });
});

app.post('/api/admin', checkJwt, checkScopesAdmin, function(req, res) {
    res.json({
        message: "Hello from an admin endpoint! You need to be authenticated and have a scope of write:messages to see this."
    });
});

app.listen(3001);
console.log('Listening on http://localhost:3001');
