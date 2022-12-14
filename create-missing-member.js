const fs = require('fs');
let rawmeta = fs.readFileSync('meta.json');
let meta = JSON.parse(rawmeta);

module.exports = (enlabel, rulabel) => {
  return {
    type: 'item',
    labels: {
      en: enlabel,
      ru: rulabel,
    },
    descriptions: {
      en: `politician in ${meta.jurisdiction.name}`,
    },
    claims: {
      P31: { value: 'Q5' }, // human
      P106: { value: 'Q82955' }, // politician
    }
  }
}
