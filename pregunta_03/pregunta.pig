/*
Pregunta
===========================================================================

Obtenga los cinco (5) valores más pequeños de la 3ra columna.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
data_table = LOAD 'data.tsv' USING PigStorage('\t')
    AS (
            letter:chararray,
            date:chararray,
            number:int
            
    );

specific_column = FOREACH data_table GENERATE number;

ordered_data = ORDER specific_column BY number asc;

subset = LIMIT ordered_data 5;

STORE subset INTO 'output' USING PigStorage(',');
