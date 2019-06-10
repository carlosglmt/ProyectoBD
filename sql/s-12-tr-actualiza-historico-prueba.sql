--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 09/06/2019
--@Descripción: Prueba Trigger Virtual Travel

set serveroutput on

Prompt =======================================
Prompt Prueba 1.
prompt Insertando un nuevo viaje
Prompt ========================================

insert into viaje(viaje_id, latitud_origen, latitud_destino, longitud_origen,
 longitud_destino, importe, hora_inicio, hora_fin, fecha_status, usuario_id,
 auto_id, status_viaje_id)
values(viaje_seq.nextval, 85.1234567, 86.123567, 87.1234567, 88.1234567, 150,
  sysdate, null, sysdate, 1, 2, 1);

var viaje number
exec :viaje := viaje_seq.currval
select * from historico_status_viaje where viaje_id = :viaje;

Prompt OK, prueba 1 exitosa.

Prompt =======================================
Prompt Prueba 2.
prompt Actualizando viaje insertado
Prompt ========================================

update viaje set status_viaje_id = 6 where viaje_id = :viaje;

select * from historico_status_viaje where viaje_id = :viaje;

Prompt OK, prueba 2 exitosa

Prompt Pruebas concluidas, se hace rollback
rollback;
