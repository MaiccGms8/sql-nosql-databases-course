-- Maicon Henrique de Oliveira Gomes (SQL — NYCFLIGHTS13)
-- Base: voos que partiram de NYC em 2013
-- Tabelas: flights, airlines, airports, planes, weather

-- ------------------------------------------------------------
-- BLOCO 1 — CONHECENDO O BANCO
-- SELECT, LIMIT, DISTINCT, ORDER BY
-- ------------------------------------------------------------

-- 1. Mostre as 10 primeiras linhas da tabela flights.
SELECT * 
FROM flights
LIMIT 10;

-- 2. Liste apenas as colunas year, month, day, carrier, flight,
--    origin e dest dos 20 primeiros voos.
SELECT year, month, day, carrier, flight, origin, dest 
FROM flights
LIMIT 20;

-- 3. Quais aeroportos de origem aparecem na base?
--    Mostre cada código apenas uma vez.
SELECT DISTINCT origin
FROM flights;

-- 4. Quais destinos aparecem na base?
--    Liste-os sem repetição e em ordem alfabética.
SELECT DISTINCT dest 
FROM flights
ORDER BY dest;

-- 5. Liste os 20 voos com maior distância percorrida.
--    Mostre origin, dest, carrier, flight e distance.
SELECT origin, dest, carrier, flight, distance
FROM flights
ORDER BY distance  DESC
LIMIT 20;