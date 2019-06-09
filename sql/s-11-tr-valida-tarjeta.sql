--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 06/06/2019
--@Descripción: Trigger Virtual Travel

set serveroutput on

create or replace trigger tr_valida_tarjeta
  before insert
  on tarjeta
  for each row

declare
  v_num_tarjetas number(1,0);

begin
  --se valida numero de tarjetas registradas por cliente
  select count(*) into v_num_tarjetas
  from tarjeta
  where usuario_id = :new.usuario_id; 
  if v_num_tarjetas >= 3 then
    raise_application_error(-20003, 'No se pueden registrar más de 3 tarjetas
      por cliente.');
  end if;
end;
/
show errors