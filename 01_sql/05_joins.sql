-- ------------------------------------------------------------
-- BLOCO 5 — JOINs
-- ------------------------------------------------------------

-- 30. Mostre cada voo junto com o nome completo da companhia aérea.
--     Tabelas: flights + airlines
--     Chave: carrier

SELECT f.*, a.name AS arline_name
FROM flights f 
JOIN airlines a ON f.carrier = a.carrier;

-- 31. Conte o número de voos por companhia usando o nome da companhia,
--     e não apenas o código.

SELECT a.name AS airline_name, COUNT(*) AS numero_de_voos
FROM flights f 
JOIN airlines a ON f.carrier = a.carrier
GROUP BY a.name
ORDER BY numero_de_voos DESC;

-- 32. Mostre os 10 destinos mais frequentes com o nome completo
--     do aeroporto de destino.
--     Tabelas: flights + airports
--     Chave: flights.dest = airports.faa

SELECT a.name AS destination_name, COUNT(*) AS numero_de_voos
FROM flights f 
JOIN airports a ON f.dest = a.faa
GROUP BY a.name
ORDER BY numero_de_voos DESC
LIMIT 10;

-- 33. Para cada aeroporto de destino, mostre:
--     nome do aeroporto, cidade/código FAA, número de voos
--     e atraso médio de chegada.

SELECT a.name AS airport_name,
       f.dest AS faa_code,
       COUNT(*) AS numero_de_voos,
       AVG(f.arr_delay) AS atraso_medio_chegada
FROM flights f 
JOIN airports a ON f.dest = a.faa
GROUP BY a.name, f.dest;

-- 34. Mostre os voos junto com fabricante e modelo da aeronave.
--     Tabelas: flights + planes
--     Chave: tailnum

SELECT f.*, p.manufacturer, p.model
FROM flights f
JOIN planes p ON f.tailnum = p.tailnum;

-- 35. Quais fabricantes de aeronaves aparecem em maior número de voos?

SELECT p.manufacturer, COUNT(*) AS numero_de_voos
FROM flights f 
JOIN planes p ON f.tailnum = p.tailnum
GROUP BY p.manufacturer
ORDER BY numero_de_voos DESC;

-- 36. Calcule o atraso médio de chegada por fabricante de aeronave.
--     Considere apenas fabricantes com pelo menos 1000 voos.

SELECT p.manufacturer,
       AVG(f.arr_delay) AS atraso_medio_chegada,
       COUNT(*) AS total_voos
FROM flights f
JOIN planes p ON f.tailnum = p.tailnum
GROUP BY p.manufacturer
HAVING COUNT(*) >= 1000
ORDER BY atraso_medio_chegada DESC;

-- 37. Para cada voo, mostre simultaneamente:
--     companhia aérea, aeroporto de origem e aeroporto de destino
--     com seus respectivos nomes completos.
--     Atenção: será necessário usar airports duas vezes com aliases.

SELECT f.flight, 
       al.name AS airline_name, 
       ao.name AS origin_airport_name, 
       ad.name AS destination_airport_name
FROM flights f
JOIN airlines al ON f.carrier = al.carrier
JOIN airports ao ON f.origin = ao.faa
JOIN airports ad ON f.dest = ad.faa;