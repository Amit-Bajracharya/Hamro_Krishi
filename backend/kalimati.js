const Kalimati = require('kalimati-rate');

Kalimati.retail().then((retail_price) => {
    console.log(retail_price);
});

Kalimati.wholesale().then((wholesale_price) => {
    console.log(wholesale_price);
});