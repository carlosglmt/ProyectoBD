--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 06/06/2019
--@Descripción: Trigger Virtual Travel

connect lm_proy_admin/admin

set serveroutput on

create or replace trigger tr_actualiza_historico
  after insert
  or update of fecha_status, status_viaje_id
  on viaje
  for each row

begin
  insert into historico_status_viaje(historico_status_viaje_id, fecha_status,
    viaje_id, status_viaje_id)
  values(historico_status_viaje_seq.nextval, sysdate, :new.viaje_id,
    :new.status_viaje_id);
end;
/
show errors