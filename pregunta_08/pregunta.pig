/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra de la 
columna 2 y clave de al columna 3; esto es, por ejemplo, la cantidad de 
registros en tienen la letra `b` en la columna 2 y la clave `jjj` en la 
columna 3 es:

  ((b,jjj), 216)

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
data_table = LOAD 'data.tsv' USING PigStorage('\t')
    AS (
        letter:chararray,
        letters:BAG{t: TUPLE(p:chararray)},
        lists:MAP[]
    );

words = FOREACH data_table GENERATE FLATTEN(letters) AS flat_letter, FLATTEN(lists) AS flat_list;
words_2 = FOREACH words GENERATE TOTUPLE(flat_letter, flat_list) AS unicos;
grouped = GROUP words_2 BY unicos;
wordcount = FOREACH grouped GENERATE group, COUNT(words_2);

STORE wordcount INTO 'output' USING PigStorage(',');

