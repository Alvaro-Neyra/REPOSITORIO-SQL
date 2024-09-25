use mi_bd;
/* -- Utiliza la función PERIOD_ADD para agregar un período de 3 meses al año-mes '2022-07'.*/
SELECT PERIOD_ADD(202207, 3);

/*-- Utiliza la función PERIOD_DIFF para calcular el número de meses entre los períodos '2022-03' y '2022-12'.*/
SELECT PERIOD_DIFF(202203, 202212);

/*-- Utiliza la función QUARTER para obtener el trimestre de la fecha de entrega del envío con código de producto 'PQR456'.*/
SELECT * FROM envios;
SELECT QUARTER(fecha_envio) FROM envios WHERE codigo_producto = 'PQR456';

/* -- Utiliza la función SEC_TO_TIME para convertir 3665 segundos en formato 'hh:mm:ss'.*/
SELECT SEC_TO_TIME(3665);

/* -- Utiliza la función SECOND para obtener los segundos de la hora de envío del envío con ID 2.*/
SELECT SECOND(fecha_envio) FROM envios WHERE id = 2;

/*--Utiliza la función STR_TO_DATE para convertir la cadena '2022()08()15' en una fecha.*/
SELECT STR_TO_DATE('2022()08()15', '%Y/%m/%D');

/*-- Utiliza la función SUBDATE (o DATE_SUB) para restar 5 días a la fecha de entrega del envío con código de producto 'GHI888'.*/

SELECT SUBDATE(fecha_entrega, INTERVAL 5 DAY) FROM envios WHERE codigo_producto = 'GHI888';

/* -- Utiliza la función SUBTIME para restar 2 horas y 15 minutos a la hora de envío del envío con ID 7.*/

SELECT SUBTIME (fecha_envio, '0 1:15:00') FROM envios WHERE id = 7;

/* -- Utiliza la función TIME para extraer la porción de tiempo de la fecha de envío del envío con ID 1.*/

SELECT TIME(fecha_envio) FROM envios WHERE id = 1;

/* -- Utiliza la función TIME_FORMAT para formatear la hora de envío del envío con ID 2 en 'hh:mm:ss'.*/

SELECT TIME_FORMAT(fecha_envio, '%H:%i:%s') FROM envios WHERE id = 2;

/* --Utiliza la función TIME_TO_SEC para convertir la hora de envío del envío con ID 3 en segundos.xa*/
SELECT TIME_TO_SEC(fecha_envio) FROM envios WHERE id = 3;

/*--Utiliza la función TIMEDIFF para calcular la diferencia de horas entre las fechas de envío y entrega del envío con ID 4.*/

SELECT TIMEDIFF(fecha_envio, fecha_entrega) FROM envios WHERE id = 4;

/*-- Utiliza la función SYSDATE para obtener la hora exacta en la que se ejecuta la función en la consulta. Para comprobar esto invoca SYSDATE, luego la función SLEEP durante 5 segundos y luego vuelve a invocar la función SYSDATE, y verifica la diferencia entre ambas invocaciones con TIMEDIFF.*/
SELECT SYSDATE() AS hora_inicio;
DO SLEEP(5);
SELECT SYSDATE() AS hora_fin;
SELECT 
    TIMEDIFF(SYSDATE(), (SELECT SYSDATE() - INTERVAL 5 SECOND)) AS diferencia;

/*-- Crea una consulta que utilice la función TIMESTAMP para obtener todos los valores de fecha_envio sumandole 12 horas.*/
SELECT TIMESTAMP(fecha_envio + INTERVAL 12 HOUR) AS fecha_envio_modificada FROM envios;

/*-- Utiliza la función TIMESTAMPADD para agregar 3 horas a la fecha de entrega del envío con código de producto 'XYZ789'.*/
SELECT TIMESTAMPADD(HOUR, 3, fecha_entrega) AS fecha_entrega_modificad FROM envios WHERE codigo_producto = 'XYZ789';