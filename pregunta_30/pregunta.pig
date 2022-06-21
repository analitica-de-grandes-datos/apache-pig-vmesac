/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el codigo en Pig para manipulación de fechas que genere la siguiente
salida.

   1971-07-08,08,8,jue,jueves
   1974-05-23,23,23,jue,jueves
   1973-04-22,22,22,dom,domingo
   1975-01-29,29,29,mie,miercoles
   1974-07-03,03,3,mie,miercoles
   1974-10-18,18,18,vie,viernes
   1970-10-05,05,5,lun,lunes
   1969-02-24,24,24,lun,lunes
   1974-10-17,17,17,jue,jueves
   1975-02-28,28,28,vie,viernes
   1969-12-07,07,7,dom,domingo
   1973-12-24,24,24,lun,lunes
   1970-08-27,27,27,jue,jueves
   1972-12-12,12,12,mar,martes
   1970-07-01,01,1,mie,miercoles
   1974-02-11,11,11,lun,lunes
   1973-04-01,01,1,dom,domingo
   1973-04-29,29,29,dom,domingo

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
ToString(ToDate(bd,'yyyy-MM-dd'), 'dd') AS month_num,
ToString(ToDate(bd,'yyyy-MM-dd'), 'd') AS month_num_short,
LOWER(ToString(ToDate(bd,'yyyy-MM-dd'), 'EEEE')) AS month_n;

C = FOREACH B GENERATE bd, 
month_num,
month_num_short,
REPLACE(month_n, 'sunday', 'domingo') AS month_n_1;

D = FOREACH C GENERATE bd, 
month_num,
month_num_short,
REPLACE(month_n_1, 'thursday', 'jueves') AS month_n_2;

E = FOREACH D GENERATE bd, 
month_num,
month_num_short,
REPLACE(month_n_2, 'wednesday', 'miercoles') AS month_n_3;

F = FOREACH E GENERATE bd, 
month_num,
month_num_short,
REPLACE(month_n_3, 'friday', 'viernes') AS month_n_4;

G = FOREACH F GENERATE bd, 
month_num,
month_num_short,
REPLACE(month_n_4, 'monday', 'lunes') AS month_n_5;

H = FOREACH G GENERATE bd, 
month_num,
month_num_short,
REPLACE(month_n_5, 'tuesday', 'martes') AS month_n_6;

I = FOREACH H GENERATE bd,
month_num,
month_num_short,
SUBSTRING(month_n_6, 0, 3),
month_n_6;

STORE I INTO 'output' USING PigStorage(',');
