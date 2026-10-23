-- ------------------------------------------------------------
-- BLOCO 8 — DESAFIOS FINAIS (RESOLUÇÃO)
-- ------------------------------------------------------------

-- 49. Para cada companhia aérea, encontre o destino mais frequente.
--     Desafio: pode exigir CTE, função de janela ou subconsulta.

-- Passo 1: Conta os voos por companhia e destino.
-- Passo 2: Usa RANK() para ordenar os destinos de cada companhia (PARTITION BY carrier).
-- Passo 3: Filtra apenas os que ficaram em 1º lugar.
WITH ContagemDestinos AS (
    SELECT carrier, dest, COUNT(*) AS qtd_voos
    FROM flights
    GROUP BY carrier, dest
),
RankingDestinos AS (
    SELECT carrier, 
           dest, 
           qtd_voos,
           RANK() OVER (PARTITION BY carrier ORDER BY qtd_voos DESC) AS rank_destino
    FROM ContagemDestinos
)
SELECT carrier, dest, qtd_voos
FROM RankingDestinos
WHERE rank_destino = 1;


-- 50. Para cada mês, identifique a companhia aérea com o maior número de voos.

-- Semelhante ao desafio 49, mas particionando por mês.
WITH ContagemMensal AS (
    SELECT month, carrier, COUNT(*) AS total_voos
    FROM flights
    GROUP BY month, carrier
),
RankingMensal AS (
    SELECT month, 
           carrier, 
           total_voos,
           RANK() OVER (PARTITION BY month ORDER BY total_voos DESC) AS rank_mes
    FROM ContagemMensal
)
SELECT month, carrier, total_voos
FROM RankingMensal
WHERE rank_mes = 1;


-- 51. Calcule um ranking das companhias pelo atraso médio de chegada,
--     considerando somente companhias com pelo menos 1000 voos válidos.

-- Nota: Voos válidos são aqueles onde o atraso de chegada (arr_delay) não é nulo.
SELECT carrier,
       COUNT(arr_delay) AS voos_validos,
       AVG(arr_delay) AS atraso_medio_chegada,
       RANK() OVER (ORDER BY AVG(arr_delay) ASC) AS ranking_pontualidade
FROM flights
WHERE arr_delay IS NOT NULL
GROUP BY carrier
HAVING voos_validos >= 1000
ORDER BY ranking_pontualidade ASC;


-- 52. Identifique os dias de 2013 com os maiores atrasos médios de chegada.
--     Mostre ano, mês, dia, número de voos válidos e atraso médio.

SELECT year, 
       month, 
       day,
       COUNT(arr_delay) AS voos_validos,
       AVG(arr_delay) AS atraso_medio_chegada
FROM flights
WHERE year = 2013 AND arr_delay IS NOT NULL
GROUP BY year, month, day
ORDER BY atraso_medio_chegada DESC
LIMIT 10; -- Mostrando o Top 10 dias mais problemáticos


-- 53. Investigue o dia 13 de junho de 2013:
--     a) número de voos;
--     b) atraso médio de partida;
--     c) atraso médio de chegada;
--     d) número de cancelamentos;
--     e) condições meteorológicas médias por aeroporto de origem.

-- Itens de A até D (Dados de voos):
-- O padrão no nycflights13 para identificar cancelamentos é verificar se dep_time IS NULL.
SELECT COUNT(*) AS a_numero_de_voos,
       AVG(dep_delay) AS b_atraso_medio_partida,
       AVG(arr_delay) AS c_atraso_medio_chegada,
       SUM(CASE WHEN dep_time IS NULL THEN 1 ELSE 0 END) AS d_numero_cancelamentos
FROM flights
WHERE year = 2013 
  AND month = 6 
  AND day = 13;

-- Item E (Dados meteorológicos):
SELECT origin AS aeroporto_origem,
       AVG(temp) AS e_temp_media,
       AVG(wind_speed) AS e_vento_medio,
       AVG(precip) AS e_precipitacao_media,
       AVG(visib) AS e_visibilidade_media
FROM weather
WHERE year = 2013 
  AND month = 6 
  AND day = 13
GROUP BY origin;