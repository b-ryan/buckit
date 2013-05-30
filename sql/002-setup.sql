CREATE TABLE accounts (
    id    SERIAL PRIMARY KEY,
    name  VARCHAR(50)
);

CREATE TABLE transactions (
    id          SERIAL PRIMARY KEY,
    account_id  INTEGER REFERENCES accounts (id),
    date        DATE,
    type        INTEGER,
    status      INTEGER
);

CREATE TABLE splits (
    id              SERIAL PRIMARY KEY,
    transaction_id  INTEGER REFERENCES transactions (id),
    amount          FLOAT
);
