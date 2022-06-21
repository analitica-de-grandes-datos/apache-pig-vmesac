/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código en Pig para manipulación de fechas que genere la siguiente 
salida.

   1971-07-08,jul,07,7
   1974-05-23,may,05,5
   1973-04-22,abr,04,4
   1975-01-29,ene,01,1
   1974-07-03,jul,07,7
   1974-10-18,oct,10,10
   1970-10-05,oct,10,10
   1969-02-24,feb,02,2
   1974-10-17,oct,10,10
   1975-02-28,feb,02,2
   1969-12-07,dic,12,12
   1973-12-24,dic,12,12
   1970-08-27,ago,08,8
   1972-12-12,dic,12,12
   1970-07-01,jul,07,7
   1974-02-11,feb,02,2
   1973-04-01,abr,04,4
   1973-04-29,abr,04,4

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
data_table = LOAD 'data.csv' USING PigStorage(',')
    AS (
        cd:int,
        name:chararray,
        lastname:chararray,
        bd:chararray,
        color:chararray,
        num:int
    );

B = FOREACH data_table GENERATE bd, 
LOWER(ToString(ToDate(bd,'yyyy-MM-dd'), 'MMM')) AS month_n,
ToString(ToDate(bd,'yyyy-MM-dd'), 'MM') AS month_num,
ToString(ToDate(bd,'yyyy-MM-dd'), 'M') AS month_num_short;

C = FOREACH B GENERATE bd, 
REPLACE(month_n, 'jan', 'ene') AS month_n_1,
month_num,
month_num_short;

D = FOREACH C GENERATE bd, 
REPLACE(month_n_1, 'apr', 'abr') AS month_n_2,
month_num,
month_num_short;

E = FOREACH D GENERATE bd, 
REPLACE(month_n_2, 'dec', 'dic') AS month_n_3,
month_num,
month_num_short;

F = FOREACH E GENERATE bd, 
REPLACE(month_n_3, 'aug', 'ago') AS month_n_4,
month_num,
month_num_short;

STORE F INTO 'output' USING PigStorage(',');
