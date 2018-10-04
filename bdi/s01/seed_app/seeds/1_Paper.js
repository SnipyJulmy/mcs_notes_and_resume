// populate the paper table
var faker = require('faker');

let createRecord = (knex, id) => {
  return knex('paper').insert({
    paperid: id,
    title: faker.lorem.words(),
    abstract: faker.lorem.sentences(),
  })
}

exports.seed = (knex, Promise) => {
  return knex('paper').del()
    .then(() => {
      let records = [];

      for (let i = 1; i < 40; i++) {
        records.push(createRecord(knex, i))
      }

      return Promise.all(records);
    });
};
