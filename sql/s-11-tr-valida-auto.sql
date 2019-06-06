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
  num_registros number := 0;

begin
  --se valida antigüedad de auto
  if extract(year from sysdate) - :new.anio > 5 then
    num_registros := num_registros + 1;
    raise_application_error(-20001, 'No se puede registrar un auto de más de
      5 años de antigüedad.');
  end if;
  dbms_output.put_line('Se registro auto: ' || :new.num_placas);
  --se valida numero de autos registrados por conductor
  select count(*) into num_autos
  from temp_auto
  where usuario_id = :new.usuario_id;
  dbms_output.put_line('Autos del conductor: ' || num_autos);
  if num_autos >= 2 then
    num_registros := num_registros + 1;
    raise_application_error(-20002, 'No se pueden registrar más de 2 autos por
      conductor.');
  end if;
  --dbms_output.put_line('Número de registros que no cumplen con las reglas: '
  --  || num_registros);
end;
/
show errors