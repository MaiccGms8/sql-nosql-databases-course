-- ------------------------------------------------------------
-- BLOCO 2 — FILTROS
-- WHERE, AND, OR, BETWEEN, IN, LIKE, IS NULL
-- ------------------------------------------------------------

-- 6. Liste todos os voos que tiveram como destino LAX.
SELECT *
from flights
WHERE dest = 'LAX'

-- 7. Encontre os voos que saíram de JFK e tiveram destino LAX.
SELECT *
FROM flights
WHERE origin = 'JFK' and dest = 'LAX'

-- 8. Encontre os voos com atraso de partida superior a 120 minutos.
SELECT * 
FROM flights
WHERE dep_delay > 120;

-- 9. Encontre os voos que chegaram pelo menos 30 minutos adiantados.
SELECT * 
FROM flights
WHERE arr_delay <= -30;

-- 10. Liste os voos realizados nos meses de junho, julho e agosto.
SELECT *
FROM flights
WHERE month BETWEEN 6 AND 8;

-- 11. Encontre os voos que partiram no dia 25 de dezembro de 2013.
SELECT *
FROM flights
WHERE day = 25 AND month = 12 AND year = 2013;

-- 12. Identifique os voos cancelados.
--     Dica: no conjunto nycflights13, dep_time ausente indica cancelamento.
SELECT *
FROM flights
WHERE dep_time IS NULL;

-- 13. Liste os voos cujo código da companhia aérea começa com a letra 'U'.
SELECT *
FROM flights
WHERE carrier LIKE 'U%';