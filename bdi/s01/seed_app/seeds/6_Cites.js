var faker = require('faker');

const primarykey_pair = [];

let createRecord = (knex, id) => {
  let paperidfrom = Math.floor(Math.random() * 39) + 1;
  let paperidto = Math.floor(Math.random() * 39) + 1;
  while (primarykey_pair.indexOf(paperidfrom+","+paperidto) > -1) {
    paperidfrom = Math.floor(Math.random() * 39) + 1;
    paperidto = Math.floor(Math.random() * 39) + 1;
  }
  primarykey_pair.push(paperidfrom+","+paperidto);
  return knex('cites').insert({
    paperidfrom,
    paperidto,
  })
}

exports.seed = (knex, Promise) => {
  return knex('cites').del()
    .then(() => {
      let records = [];

      for (let i = 1; i < 40; i++) {
        records.push(createRecord(knex, i))
      }

      return Promise.all(records);
    });
};