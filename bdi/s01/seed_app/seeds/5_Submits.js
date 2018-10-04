var faker = require('faker');

const primarykey_pair = [];

let createRecord = (knex, id) => {
  let paperid = Math.floor(Math.random() * 39) + 1;
  let confid = Math.floor(Math.random() * 14) + 1;
  while (primarykey_pair.indexOf(paperid+","+confid) > -1) {
    paperid = Math.floor(Math.random() * 39) + 1;
    confid = Math.floor(Math.random() * 14) + 1;
  }
  primarykey_pair.push(paperid+","+confid);
  return knex('submits').insert({
    paperid,
    confid,
    isaccepted: faker.random.boolean(),
    date: faker.date.future(),
  })
}

exports.seed = (knex, Promise) => {
  return knex('submits').del()
    .then(() => {
      let records = [];

      for (let i = 1; i < 60; i++) {
        records.push(createRecord(knex, i))
      }

      return Promise.all(records);
    });
};