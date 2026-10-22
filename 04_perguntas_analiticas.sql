-- ------------------------------------------------------------
-- BLOCO 4 — PERGUNTAS ANALÍTICAS
-- ------------------------------------------------------------

-- 24. Qual aeroporto de origem apresentou o maior atraso médio de partida?

SELECT origin, AVG(dep_delay) AS atraso_medio_partida
FROM flights
GROUP BY origin
ORDER BY atraso_medio_partida DESC
LIMIT 1;

-- 25. Quais são os cinco destinos com maior distância média a partir de NYC?

SELECT dest, AVG(distance) AS distancia_media
FROM flights
GROUP BY dest
ORDER BY distancia_media DESC
LIMIT 5;

-- 26. Para cada mês, calcule o atraso médio de chegada.
--     Em quais meses os atrasos médios foram maiores?

SELECT month, AVG(arr_delay) AS atraso_medio_chegada
FROM flights
GROUP BY month
ORDER BY atraso_medio_chegada DESC;

-- 27. Quais voos recuperaram tempo durante a viagem?
--     Considere que um voo recuperou tempo quando:
--        arr_delay < dep_delay
--     Mostre dep_delay, arr_delay e a diferença entre eles.

SELECT year, month, day, carrier, flight, dep_delay, arr_delay, (dep_delay - arr_delay) AS tempo_recuperado
FROM flights
WHERE arr_delay < dep_delay;

-- 28. Qual companhia aérea teve o maior número de voos cancelados?

SELECT carrier, COUNT(*) AS total_cancelados
FROM flights
WHERE dep_time IS NULL
GROUP BY carrier
ORDER BY total_cancelados DESC
LIMIT 1;

-- 29. Para cada companhia, calcule a porcentagem de voos cancelados.

SELECT carrier,
       (SUM(CASE WHEN dep_time IS NULL THEN 1.0 ELSE 0.0 END) / COUNT(*)) * 100 percentagem_cancelados
FROM flights
GROUP BY carrier
ORDER BY percentagem_cancelados DESC;
