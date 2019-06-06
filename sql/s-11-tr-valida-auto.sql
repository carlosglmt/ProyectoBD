--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 04/06/2019
--@Descripción: Trigger Virtual Travel

set serveroutput on

create or replace trigger tr_valida_auto
  before insert
  on temp_auto
  for each row

declare
  num_autos number(1,0);

begin
  --se valida antigüedad de auto
  if extract(year from sysdate) - :new.anio > 5 then
    raise_application_error(-20001, 'No se puede registrar un auto de más de
      5 años de antigüedad.');
  end if;
  --se valida numero de autos registrados por conductor
  select count(*) into num_autos
  from auto
  where usuario_id = :new.usuario_id;
  if num_autos >= 2 then
    raise_application_error(-20002, 'No se pueden registrar más de 2 autos por
      conductor.');
  end if;
end;
/
show errors