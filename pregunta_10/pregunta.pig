/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Genere una relación con el apellido y su longitud. Ordene por longitud y 
por apellido. Obtenga la siguiente salida.

  Hamilton,8
  Garrett,7
  Holcomb,7
  Coffey,6
  Conway,6

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

words = foreach data_table GENERATE lastname, SIZE(lastname) as s_last; 
ordered_data = ORDER words BY s_last desc, lastname;
limit_data = LIMIT ordered_data 5;
STORE limit_data INTO 'output' USING PigStorage(',');