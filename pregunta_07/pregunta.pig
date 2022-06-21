/*
Pregunta
===========================================================================

Para el archivo `data.tsv` genere una tabla que contenga la primera columna,
la cantidad de elementos en la columna 2 y la cantidad de elementos en la 
columna 3 separados por coma. La tabla debe estar ordenada por las 
columnas 1, 2 y 3.

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

table_1 = FOREACH data_table GENERATE letter, letters, lists;
count_data = FOREACH table_1 GENERATE letter, COUNT(letters) AS c_letters, SIZE(lists) AS s_lists;
ordered_data = ORDER count_data BY letter ASC, c_letters ASC, s_lists asc;
STORE ordered_data INTO 'output' USING PigStorage(',');