-- ------------------------------------------------------------
-- BLOCO 6 — QUESTÕES DIRETAMENTE INSPIRADAS NO R FOR DATA SCIENCE
-- ------------------------------------------------------------

-- 38. Encontre os 10 destinos mais populares e, em seguida,
--     retorne todos os voos cujo destino pertence a esse grupo.
--     Faça usando uma subconsulta.

SELECT *
FROM flights
WHERE dest IN (
    SELECT dest
    FROM flights
    GROUP BY dest
    ORDER BY COUNT(*) DESC
    LIMIT 10
);

-- 39. Existem voos cujo aeroporto de destino não possui registro
--     correspondente na tabela airports?
--     Tente responder usando LEFT JOIN + IS NULL.

SELECT f.*
FROM flights f 
LEFT JOIN airports a ON f.dest = a.faa
WHERE a.faa IS NULL;

-- 40. Existem aeronaves (tailnum) presentes em flights que não possuem
--     registro correspondente em planes?

SELECT DISTINCT f.tailnum
FROM flights f
LEFT JOIN planes p ON f.tailnum = p.tailnum
WHERE p.tailnum IS NULL
    AND f.tailnum IS NOT NULL;

-- 41. Quais companhias aparecem com maior frequência entre os tailnum
--     que não possuem correspondência na tabela planes?

SELECT f.carrier, COUNT(*) AS frequencia_voos
FROM flights f
LEFT JOIN planes p ON f.tailnum = p.tailnum
WHERE p.tailnum IS NULL
GROUP BY f.carrier
ORDER BY frequencia_voos DESC;

-- 42. Calcule o atraso médio de chegada por destino e associe latitude
--     e longitude do aeroporto de destino.
--     Esta consulta poderia ser exportada depois para construção de um mapa.

SELECT f.dest,
       AVG(f.arr_delay) AS atraso_medio_chegada,
       a.lat,
       a.lon
FROM flights f
JOIN airports a ON f.dest = a.faa
GROUP BY f.dest, a.lat, a.lon;


-- 43. Acrescente aos voos a latitude e longitude tanto do aeroporto
--     de origem quanto do aeroporto de destino.
--     Use aliases diferentes para airports.

SELECT f.*,
       ao.lat AS origin_lat,
       ao.lon AS origin_lon,
       ad.lat AS dest_lat,
       ad.lon AS dest_lon
FROM flights f
JOIN airports ao ON f.origin = ao.faa
JOIN airports ad ON f.dest = ad.faa;