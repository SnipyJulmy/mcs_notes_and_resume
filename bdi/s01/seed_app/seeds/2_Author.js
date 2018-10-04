// populate the author table
var faker = require('faker');

const AFFILATION = ['University of Fribourg', 'University of Bern', 'University of Neuchatel', 'EPFL', 'HEIA', 'ETH'];

let createRecord = (knex, id) => {
  return knex('author').insert({
    authorid: id,
    name: faker.name.firstName() + " " + faker.name.lastName(),
    email: faker.internet.email(),
    affiliation: AFFILATION[Math.floor(Math.random() * 6)],
  })
}

exports.seed = (knex, Promise) => {
  return knex('author').del()
    .then(() => {
      let records = [];

      for (let i = 1; i < 15; i++) {
        records.push(createRecord(knex, i))
      }

      return Promise.all(records);
    });
};