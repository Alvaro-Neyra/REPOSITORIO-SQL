use nba;

SELECT nombre, peso 
FROM jugadores 
WHERE posicion LIKE '%C%' AND peso > 200
ORDER BY peso DESC LIMIT 10;

SELECT * FROM jugadores;

select * from equipos;

SELECT nombre FROM equipos WHERE conferencia = 'East';

/*Mostrar los equipos donde su ciudad empieza con la letra ‘c’, ordenados por nombre.*/
SELECT * 
FROM equipos 
WHERE ciudad LIKE 'C%'
ORDER BY nombre ASC;

SELECT * FROM estadisticas;

/*Mostrar los puntos por partido del jugador ‘Pau Gasol’ en la temporada ’04/05′.*/
SELECT est.puntos_por_partido 
FROM estadisticas `est`
INNER JOIN jugadores `jug` ON est.jugador = jug.codigo
WHERE jug.nombre = 'Pau Gasol'
AND est.temporada = '04/05';

/*Mostrar los diez jugadores con más puntos en toda su carrera con un redondeo de dos decimales.*/
SELECT est.jugador, jug.nombre , round(SUM(est.puntos_por_partido), 2) `puntos_totales`
FROM estadisticas `est`
INNER JOIN jugadores `jug` ON jug.codigo = est.jugador
GROUP BY est.jugador
ORDER BY puntos_totales DESC
LIMIT 10;

/*Mostrar el nombre del equipo, conferencia y división del jugador más alto de la NBA.*/

/*Altura maxima de cada jugador*/

SELECT eq.nombre `nombre_equipo`,
MAX(jug.altura)
AS max_altura,
eq.conferencia AS conferencia, 
eq.division AS division
FROM jugadores `jug`
JOIN equipos `eq` ON jug.nombre_equipo = eq.nombre
GROUP BY nombre_equipo, conferencia, division;

/*Mostrar al mas alto de toda la NBA*/
select * from jugadores
where altura = (select max(jug.altura) from jugadores as jug
join equipos as eq on jug.Nombre_equipo = eq.Nombre);

/*Mostrar la altura mas alta de cada equipo*/
select Nombre_equipo, Conferencia, Division, (SELECT MAX(
CAST(SUBSTRING_INDEX(altura, '-', 1) AS DECIMAL(3,1)) +
CAST(SUBSTRING_INDEX(altura, '-', -1) AS DECIMAL(3,1)) / 12
)) AS max_altura
from jugadores as jug
join equipos as eq on eq.Nombre = jug.Nombre_equipo
group by Nombre_equipo, Conferencia, Division;

SELECT altura FROM jugadores;

/*Mostrar los 10 partidos (equipo_local, equipo_visitante y diferencia) con mayor diferencia de puntos.*/
SELECT equipo_local, equipo_visitante, ABS(
puntos_local - puntos_visitante) AS diferencia
FROM partidos
ORDER BY diferencia DESC LIMIT 10;

/*Muestra el nombre del equipo con la mayor diferencia de puntos totales de la temporada temporada "00/01".*/
SELECT equipo, SUM(puntos_favor - puntos_contra) AS diferencia
FROM (
    -- Puntos obtenidos como local
    SELECT equipo_local AS equipo, SUM(puntos_local) AS puntos_favor, SUM(puntos_visitante) AS puntos_contra
    FROM partidos
    WHERE temporada = '00/01'
    GROUP BY equipo_local
    UNION ALL
    -- Puntos obtenidos como visitante
    SELECT equipo_visitante AS equipo, SUM(puntos_visitante) AS puntos_favor, SUM(puntos_local) AS puntos_contra
    FROM partidos
    WHERE temporada = '00/01'
    GROUP BY equipo_visitante
) AS puntos_totales
GROUP BY equipo
ORDER BY diferencia DESC
LIMIT 1;

/*Encuentra el nombre de los diez equipos que mejor porcentaje de victorias tengan en la temporada "98/99". El número de porcentaje debe estar escrito del 1 al 100 con hasta dos decimales y acompañado por el símbolo “%”.*/
SELECT equipo, 
       CONCAT(ROUND((SUM(victorias) / COUNT(*)) * 100, 2), '%') AS porcentaje_victorias
FROM (
    -- Calcular las victorias como equipo local
    SELECT equipo_local AS equipo, 
           CASE 
               WHEN puntos_local > puntos_visitante THEN 1
               ELSE 0
           END AS victorias
    FROM partidos
    WHERE temporada = '98/99'
    
    UNION ALL
    
    -- Calcular las victorias como equipo visitante
    SELECT equipo_visitante AS equipo, 
           CASE 
               WHEN puntos_visitante > puntos_local THEN 1
               ELSE 0
           END AS victorias
    FROM partidos
    WHERE temporada = '98/99'
) AS resultados
GROUP BY equipo
ORDER BY porcentaje_victorias DESC
LIMIT 10;

/*Muestra el nombre del jugador que ha registrado el mayor número de asistencias en un solo partido.*/
SELECT j.Nombre, e.Asistencias_por_partido
FROM jugadores j
JOIN estadisticas e ON j.codigo = e.jugador
ORDER BY e.Asistencias_por_partido DESC
LIMIT 1;

/*Encuentra el total de partidos en los que el equipo local anotó más de 100 puntos y el equipo visitante anotó menos de 90 puntos.*/
SELECT COUNT(*) AS total_partidos
FROM partidos
WHERE puntos_local > 100
AND puntos_visitante < 90;

/*Calcula la diferencia de puntos promedio en todos los partidos de la temporada “00/01” y redondea el resultado a dos decimales.*/
SELECT ROUND(AVG(ABS(puntos_local - puntos_visitante)), 2) AS diferencia_promedio
FROM partidos
WHERE temporada = '00/01';

/*Encuentra el nombre del equipo que ha tenido al menos un jugador que ha promediado más de 10 rebotes por partido en la temporada “97/98”.*/
SELECT DISTINCT j.Nombre_equipo
FROM jugadores j
JOIN estadisticas e ON j.codigo = e.jugador
WHERE e.temporada = '97/98' AND e.Rebotes_por_partido > 10;






