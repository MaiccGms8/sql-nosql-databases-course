-- ------------------------------------------------------------
-- BLOCO 7 — WEATHER E CHAVES COMPOSTAS
-- ------------------------------------------------------------

-- 44. Observe a tabela weather. Quais aeroportos de origem possuem
--     informações meteorológicas?

SELECT *
FROM weather;

-- 45. Calcule temperatura média, mínima e máxima por aeroporto de origem.

SELECT origin, 
       AVG(temp) AS temp_media, 
       MIN(temp) AS temp_min, 
       MAX(temp) AS temp_max
FROM weather
GROUP BY origin;

-- 46. Associe flights e weather pela combinação de:
--       flights.origin = weather.origin
--       flights.time_hour = weather.time_hour
--     Mostre atraso de partida, temperatura, precipitação e velocidade do vento.

SELECT f.dep_delay, 
       w.temp, 
       w.precip, 
       w.wind_speed
FROM flights f
JOIN weather w 
  ON f.origin = w.origin 
 AND f.time_hour = w.time_hour;

-- 47. Investigue se voos com precipitação apresentaram maior atraso médio
--     de partida do que voos sem precipitação.

SELECT CASE 
           WHEN w.precip > 0 THEN 'Com precipitação'
           ELSE 'Sem precipitação'
       END AS status_precipitacao,
       AVG(f.dep_delay) AS atraso_medio_partida
FROM flights f
JOIN weather w 
  ON f.origin = w.origin 
 AND f.time_hour = w.time_hour
GROUP BY status_precipitacao;

-- 48. Divida os registros em duas categorias:
--       'com chuva'  -> precip > 0
--       'sem chuva'  -> precip = 0
--     e compare o atraso médio de partida.

SELECT CASE 
           WHEN w.precip > 0 THEN 'com chuva'
           WHEN w.precip = 0 THEN 'sem chuva'
       END AS categoria_chuva,
       AVG(f.dep_delay) AS atraso_medio_partida
FROM flights f
JOIN weather w 
  ON f.origin = w.origin 
 AND f.time_hour = w.time_hour
WHERE w.precip IS NOT NULL
GROUP BY categoria_chuva;