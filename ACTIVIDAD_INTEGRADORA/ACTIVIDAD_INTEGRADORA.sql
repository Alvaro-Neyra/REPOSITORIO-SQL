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

select * from jugadores
where altura = (select max(jug.altura) from jugadores as jug
join equipos as eq on jug.Nombre_equipo = eq.Nombre);

select Nombre_equipo, Conferencia, Division, (SELECT MAX(
CAST(SUBSTRING_INDEX(altura, '-', 1) AS DECIMAL(3,1)) +
CAST(SUBSTRING_INDEX(altura, '-', -1) AS DECIMAL(3,1)) / 12
)) AS max_altura
from jugadores as jug
join equipos as eq on eq.Nombre = jug.Nombre_equipo
group by Nombre_equipo, Conferencia, Division;

SELECT altura FROM jugadores;

select * from equipos where nombre = (
select nombre_equipo from jugadores where altura = (select max(altura) from jugadores)
);


