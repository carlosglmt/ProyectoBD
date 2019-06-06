--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 04/06/2019
--@Descripción: Procedimiento Virtual Travel

set serveroutput on
create or replace procedure sp_llena_temporales is

cursor cur_ext_auto is 
  select num_placas, anio, usuario_id, modelo_id, ubicacion_id
  from ext_auto;

begin
  --se llena temp_auto
  for fila in cur_ext_auto loop
    insert into temp_auto values(auto_seq.nextval, fila.num_placas, fila.anio,
      fila.usuario_id, fila.modelo_id, fila.ubicacion_id);
  end loop;
  --se llena auto
  --insert into auto (select * from temp_auto);
  --se llena estadistica

end;
/
show errors;