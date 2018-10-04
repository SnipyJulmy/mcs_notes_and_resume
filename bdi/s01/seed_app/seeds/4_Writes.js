var faker = require('faker');

const primarykey_pair = [];

let createRecord = (knex, id) => {
  const random = Math.floor(Math.random() * 14) + 1;
  primarykey_pair.push(random+","+id);
  return knex('writes').insert({
    authorid: random,
    paperid: id,
  })
}

let createRecordRandom = (knex, id) => {
  let authorid = Math.floor(Math.random() * 14) + 1;
  let paperid = Math.floor(Math.random() * 39) + 1;
  while (primarykey_pair.indexOf(authorid+","+paperid) > -1) {
    authorid = Math.floor(Math.random() * 14) + 1;
    paperid = Math.floor(Math.random() * 39) + 1;
  }
  primarykey_pair.push(authorid+","+paperid);
  return knex('writes').insert({
    authorid,
    paperid,
  })
}

exports.seed = (knex, Promise) => {
  return knex('writes').del()
    .then(() => {
      let records = [];

      for (let i = 1; i < 40; i++) {
        records.push(createRecord(knex, i))
      }
      for (let i = 1; i < 15; i++) {
        records.push(createRecordRandom(knex, i))
      }

      return Promise.all(records);
    });
};