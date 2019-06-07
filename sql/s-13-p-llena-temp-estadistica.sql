--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 04/06/2019
--@Descripción: Procedimiento Virtual Travel

set serveroutput on
create or replace procedure sp_llena_temp_estadistica(
    p_usuario_id in number, p_fecha_min in varchar2,
    p_fecha_max in varchar2
  ) is

v_num_registros number;

cursor cur_estadistica is 
  select u.usuario_id as usuario_id, u.username as username,
  count(*) as numero_viajes, avg(v.importe) as promedio, sum(v.importe) as total
  from usuario u, cliente c, viaje v
  where u.usuario_id = c.usuario_id
  and c.usuario_id = v.usuario_id
  and c.usuario_id = p_usuario_id
  and v.hora_inicio between to_date(p_fecha_min,'dd/mm/yyyy') and
    to_date(p_fecha_max,'dd/mm/yyyy')
  group by u.usuario_id, u.username;

begin
  for fila in cur_estadistica loop
    insert into temp_estadistica (usuario_id, username, num_viajes, 
      promedio_importe, suma_importe)
    values(fila.usuario_id, fila.username, fila.numero_viajes, fila.promedio,
      fila.total);
    v_num_registros := v_num_registros + 1;
  end loop;
  dbms_output.put_line('Registros insertados: ' || v_num_registros);
end;
/
show errors;