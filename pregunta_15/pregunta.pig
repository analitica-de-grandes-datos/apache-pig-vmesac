/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       firstname,
       color
   FROM 
       u 
   WHERE color = 'blue' AND firstname LIKE 'Z%';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

*/
data_table = LOAD 'data.csv' USING PigStorage(',')
    AS (
        cd:int,
        name:chararray,
        lastname:chararray,
        bd:chararray,
        color:chararray,
        num:chararray
    );

words = foreach data_table GENERATE name, color; 

filtered_ln = FILTER words BY (color MATCHES 'blue')
AND (SUBSTRING(name, 0, 1) MATCHES 'Z');

STORE filtered_ln INTO 'output' USING PigStorage(' ');
