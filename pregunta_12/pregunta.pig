/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Obtenga los apellidos que empiecen por las letras entre la 'd' y la 'k'. La 
salida esperada es la siguiente:

  (Hamilton)
  (Holcomb)
  (Garrett)
  (Fry)
  (Kinney)
  (Klein)
  (Diaz)
  (Guy)
  (Estes)
  (Jarvis)
  (Knight)

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
        num:chararray
    );

words = foreach data_table GENERATE lastname; 

filtered_ln = FILTER words BY (SUBSTRING(lastname, 0, 1)  MATCHES 'D') 
OR (SUBSTRING(lastname, 0, 1)  MATCHES 'E')
OR (SUBSTRING(lastname, 0, 1)  MATCHES 'F')
OR (SUBSTRING(lastname, 0, 1)  MATCHES 'G')
OR (SUBSTRING(lastname, 0, 1)  MATCHES 'H')
OR (SUBSTRING(lastname, 0, 1)  MATCHES 'I')
OR (SUBSTRING(lastname, 0, 1)  MATCHES 'J')
OR (SUBSTRING(lastname, 0, 1)  MATCHES 'K');

--ordered_data = ORDER words BY lastname asc;

STORE filtered_ln INTO 'output' USING PigStorage(',');