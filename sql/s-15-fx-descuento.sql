--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 07/06/2019
--@Descripción: Funcion Virtual Travel

set serveroutput on
--funcion que recibe a un usuario, y otorga un descuento segun el número de
--recomendaciones que hizo ese usuario
create or replace function fx_obten_descuento(
  f_usuario_id number
) return number is

v_recomendaciones number;

cursor cur_usuario is
select usuario_existente, usuario_id
from usuario
where usuario_existente = f_usuario_id;

begin
  select count(*) into v_recomendaciones
  from usuario
  where usuario_existente = f_usuario_id;
  if v_recomendaciones = 0 then --no recomendo a nadie
    return 0;
  else --si recomendo minimo a 1
    update usuario set descuento = descuento + (50*v_recomendaciones) --50 por recomendacion
    where usuario_id = f_usuario_id;
    execute immediate 'commit';
    for fila in cur_usuario loop --se elimina recomendacion
      update usuario set usuario_existente = null
      where usuario_id = fila.usuario_id;
    end loop;
    return 50*v_recomendaciones;  --para ser aplicado en un viaje
  end if;
end;
/
show errors