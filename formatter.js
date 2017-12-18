var fs = require('fs');
var sets = JSON.parse(fs.readFileSync('AllSets.json', 'utf8'));
for(var set in sets){
  delete sets[set].releaseDate;
  delete sets[set].border;
  delete sets[set].type;
  delete sets[set].booster;
  delete sets[set].translations;
  sets[set].cards.forEach(function(card){
    card.set = sets[set].name;
    delete card.artist;
    delete card.layout;
    delete card.watermark;
    delete card.flavor;

    delete card.rarity;
    delete card.power;
    delete card.toughness;
    delete card.manaCost;
    delete card.text;
    delete card.type;
    delete card.types;
    delete card.subtypes;
    delete card.supertypes;
    delete card.colorIdentity;
    delete card.cmc;
    delete card.colors;

    delete card.id;
    delete card.number;
    delete card.mciNumber;
    delete card.imageName;
    delete card.releaseDate;
    delete card.reserved;
  })
}
fs.writeFile('AllSetsFormatted.json', JSON.stringify(sets), 'utf8', function(err){
  if(err){
    console.log(err);
  }
});
