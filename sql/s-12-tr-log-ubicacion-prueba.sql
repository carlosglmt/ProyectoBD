--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 09/06/2019
--@Descripción: Prueba Trigger Virtual Travel

set serveroutput on

Prompt =======================================
Prompt Prueba 1.
prompt Actualizando una ubicacion
Prompt ========================================

update ubicacion set latitud = 75.547986, longitud = 76.547986
where ubicacion_id = 1;

select * from ubicacion_log where ubicacion_id = 1;

Prompt OK, prueba 1 exitosa.

Prompt Prueba concluida, Haciendo Rollback para limpiar la BD.
rollback;
