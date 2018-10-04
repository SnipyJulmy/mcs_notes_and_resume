// populate the conference table
var faker = require('faker');

let createRecord = (knex, id) => {
  return knex('conference').insert({
    confid: id,
    name: faker.lorem.word(),
    ranking: Math.floor(Math.random() * 11),
  })
}

exports.seed = (knex, Promise) => {
  return knex('conference').del()
    .then(() => {
      let records = [];

      for (let i = 1; i < 15; i++) {
        records.push(createRecord(knex, i))
      }

      return Promise.all(records);
    });
};