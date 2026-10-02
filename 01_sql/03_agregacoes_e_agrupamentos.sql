-- ------------------------------------------------------------
-- BLOCO 3 — AGREGAÇÃO
-- COUNT, AVG, MIN, MAX, SUM, GROUP BY, HAVING
-- ------------------------------------------------------------

-- 14. Quantos voos existem na tabela flights?
SELECT COUNT(*) flight
FROM flights;

-- 15. Quantos voos partiram de cada aeroporto de origem?
--     Ordene do maior para o menor.
SELECT origin, COUNT(*) AS quant_voos
FROM flights
GROUP BY origin 
ORDER BY quant_voos DESC;

-- 16. Quais foram os 10 destinos com maior número de voos?
SELECT dest, COUNT(*) AS total_voos
FROM flights
GROUP BY dest
ORDER BY total_voos DESC
LIMIT 10;

-- 17. Calcule o atraso médio de partida de todos os voos.
--     Ignore valores ausentes automaticamente com AVG().
SELECT AVG(dep_delay) AS media_atraso
FROM flights;

-- 18. Calcule o atraso médio de chegada por aeroporto de destino.
--     Ordene do maior atraso médio para o menor.
SELECT dest, AVG(arr_delay) as media_atraso_chegada
FROM flights
GROUP BY dest
ORDER BY media_atraso_chegada DESC;

-- 19. Calcule, por companhia aérea:

--     a) número de voos;
SELECT carrier, COUNT(*) as num_voos
FROM flights
GROUP BY carrier;

--     b) atraso médio de partida;
SELECT carrier, AVG(dep_delay) AS media_partida
FROM flights
GROUP BY carrier;

--     c) atraso médio de chegada.
SELECT carrier, AVG(arr_delay) AS media_chegada
FROM flights
GROUP BY carrier;

-- 20. Quais companhias tiveram atraso médio de chegada superior a 10 minutos?
--     Use HAVING.
SELECT carrier, AVG(arr_delay) AS media_chegada
FROM flights
GROUP BY carrier
HAVING AVG(arr_delay) > 10;

-- 21. Em qual mês ocorreu o maior número de voos?
SELECT month, COUNT(*) AS total_voos
FROM flights
GROUP BY month
ORDER BY total_voos DESC
LIMIT 1;

-- 22. Calcule o número de voos cancelados por mês.
SELECT month, COUNT(*) AS voos_cancelados
FROM flights
WHERE dep_time IS NULL
GROUP BY month;

-- 23. Calcule a proporção de voos cancelados em cada mês.
--     Sugestão: compare o número de cancelados com o total de voos no mês.
SELECT 
    month,
    SUM(CASE WHEN dep_time IS NULL THEN 1.0 ELSE 0.0 END) AS cancelados,
    COUNT(*) AS total_voos,
    SUM(CASE WHEN dep_time IS NULL THEN 1.0 ELSE 0.0 END) / COUNT(*) AS proporcao_cancelados
FROM flights
GROUP BY month;