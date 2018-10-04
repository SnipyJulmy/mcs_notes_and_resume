-- Drop the existing table in order to not having to remove them by hand...
DROP TABLE IF EXISTS Cites;
DROP TABLE IF EXISTS Submits;
DROP TABLE IF EXISTS Writes;
DROP TABLE IF EXISTS Conference;
DROP TABLE IF EXISTS Author;
DROP TABLE IF EXISTS Paper;

CREATE TABLE Paper (
  paperID  integer primary key,
  title    char(255),
  abstract text
);

CREATE TABLE Author (
  authorID    integer primary key,
  name        char(255),
  email       char(255),
  affiliation char(255)
);

CREATE TABLE Conference (
  confID  integer primary key,
  name    char(255),
  ranking integer
);

CREATE TABLE Writes (
  authorID integer,
  paperID  integer,
  PRIMARY KEY (authorID, paperID),
  CONSTRAINT fk_writes_author
  FOREIGN KEY (authorID)
  REFERENCES Author (authorID),
  CONSTRAINT fk_writes_paper
  FOREIGN KEY (paperID)
  REFERENCES Paper (paperID)
);

CREATE TABLE Submits (
  paperID    integer,
  confID     integer,
  isAccepted boolean,
  date       date,
  PRIMARY KEY (paperID, confID),
  CONSTRAINT fk_submits_conf
  FOREIGN KEY (confID)
  REFERENCES Conference (confID),
  CONSTRAINT fk_submits_paper
  FOREIGN KEY (paperID)
  REFERENCES Paper (paperID)
);

CREATE TABLE Cites (
  paperIDfrom integer,
  paperIDto   integer,
  PRIMARY KEY (paperIDfrom, paperIDto),
  CONSTRAINT fk_cites_paperfrom
  FOREIGN KEY (paperIDfrom)
  REFERENCES Paper (paperID),
  CONSTRAINT fk_cites_paperto
  FOREIGN KEY (paperIDto)
  REFERENCES Paper (paperID)
);