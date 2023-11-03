CREATE SCHEMA IF NOT EXISTS lesson_25;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS lesson_25.currency
(
    id   SERIAL
        CONSTRAINT PK_currency PRIMARY KEY,
    name VARCHAR DEFAULT 'USD'::CHARACTER VARYING NOT NULL
        CONSTRAINT IX_currency_name UNIQUE
);

-- INSERT INTO lesson_25.currency (name) VALUES ('EUR'), ('USD');

CREATE TABLE IF NOT EXISTS lesson_25.account
(
    id             UUID                           NOT NULL
        CONSTRAINT PK_account PRIMARY KEY,
    account_number VARCHAR(255)                   NOT NULL UNIQUE,
    balance        DOUBLE PRECISION DEFAULT 0     NOT NULL,
    closed         BOOLEAN          DEFAULT FALSE NOT NULL,
    created        DATE             DEFAULT now() NOT NULL,
    currency       INTEGER                        NOT NULL
        CONSTRAINT FK_account_currency REFERENCES lesson_25.currency DEFAULT 2
);

CREATE TABLE IF NOT EXISTS lesson_25.city
(
    id   SERIAL
        CONSTRAINT PK_city PRIMARY KEY,
    name VARCHAR(255) NOT NULL
        CONSTRAINT IX_city_name unique
);

-- INSERT INTO lesson_25.city (name) VALUES ('Amsterdam'), ('Rotterdam');

CREATE TABLE IF NOT EXISTS lesson_25.bank
(
    id   UUID         NOT NULL
        CONSTRAINT PK_bank PRIMARY KEY,
    name VARCHAR(255) NOT NULL
        CONSTRAINT IX_bank_name UNIQUE,
    city INTEGER      NOT NULL
        CONSTRAINT FK_bank REFERENCES lesson_25.city DEFAULT 1
);

CREATE TABLE IF NOT EXISTS lesson_25.email
(
    id    UUID
        CONSTRAINT PK_email PRIMARY KEY,
    inbox VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS lesson_25.customer
(
    id         UUID
        CONSTRAINT PK_customer NOT NULL PRIMARY KEY,
    birth_date DATE         NOT NULL,
    name       VARCHAR(255) NOT NULL
        constraint IX_customer_name UNIQUE,
    email      UUID         NOT NULL
        CONSTRAINT FK_customer_email REFERENCES lesson_25.email UNIQUE
);

CREATE TABLE IF NOT EXISTS lesson_25.statement
(
    customer UUID    NOT NULL
        CONSTRAINT FK_statement_customer REFERENCES lesson_25.customer,
    amount   NUMERIC(38, 2),
    currency INTEGER NOT NULL
        CONSTRAINT FK_statement_currency REFERENCES lesson_25.currency,
    PRIMARY KEY (customer, currency)
);

CREATE TABLE IF NOT EXISTS lesson_25.account_bank_customer
(
    customer UUID NOT NULL
        CONSTRAINT FK_account_bank_customer_customer REFERENCES lesson_25.customer,
    bank     UUID NOT NULL
        CONSTRAINT FK_account_bank_customer_bank REFERENCES lesson_25.bank,
    account  UUID NOT NULL
        CONSTRAINT FK_account_bank_customer_account REFERENCES lesson_25.account,
    PRIMARY KEY (customer, bank, account)
);

INSERT INTO lesson_25.email (id, inbox) VALUES ('1ecfe257-3277-47dc-b34c-13f45cba0cb5', 'ivan@mail.com');

INSERT INTO lesson_25.customer (id, birth_date, name, email) VALUES ('5ea88a83-8593-4fa9-9039-0947c8eb02cf', '1998-11-11', 'Ivan', '1ecfe257-3277-47dc-b34c-13f45cba0cb5');

-- INSERT INTO lesson_25.bank (id, name, city) VALUES ('eddb35d6-28d3-404b-abef-43efc1c044d9', 'ING', 1);
-- INSERT INTO lesson_25.bank (id, name, city) VALUES ('dcb56901-85e4-4be2-ad45-3033db471022', 'SNS', 1);

-- INSERT INTO lesson_25.account (id, account_number, balance, closed, created, currency) VALUES ('3c5f885d-d54f-43dd-ae56-e3c7e94c4f4b', 'BA39345804800211234', 200, false, '2023-11-03', 2);
-- INSERT INTO lesson_25.account (id, account_number, balance, closed, created, currency) VALUES ('0dffab99-0562-4dc8-8a8e-a50c87b541b7', 'BA39333454338002112', 100, false, '2023-11-03', 1);

INSERT INTO lesson_25.account_bank_customer (customer, bank, account) VALUES ('5ea88a83-8593-4fa9-9039-0947c8eb02cf', 'eddb35d6-28d3-404b-abef-43efc1c044d9', '0dffab99-0562-4dc8-8a8e-a50c87b541b7');
INSERT INTO lesson_25.account_bank_customer (customer, bank, account) VALUES ('5ea88a83-8593-4fa9-9039-0947c8eb02cf', 'eddb35d6-28d3-404b-abef-43efc1c044d9', '3c5f885d-d54f-43dd-ae56-e3c7e94c4f4b');

-- INSERT INTO lesson_25.statement (customer, amount, currency) VALUES ('5ea88a83-8593-4fa9-9039-0947c8eb02cf', 0.00, 2);
-- INSERT INTO lesson_25.statement (customer, amount, currency) VALUES ('5ea88a83-8593-4fa9-9039-0947c8eb02cf', 0.00, 1);