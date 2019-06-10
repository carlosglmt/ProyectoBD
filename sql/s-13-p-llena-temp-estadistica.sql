--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 04/06/2019
--@Descripción: Procedimiento Virtual Travel

set serveroutput on
create or replace procedure sp_llena_temp_estadistica(
    p_usuario_id in number, p_fecha_min in varchar2,
    p_fecha_max in varchar2
  ) is

v_usuario_id temp_estadistica.usuario_id%type;
v_username temp_estadistica.username%type;
v_num_viajes temp_estadistica.num_viajes%type;
v_promedio_importe temp_estadistica.promedio_importe%type;
v_suma_importe temp_estadistica.suma_importe%type;

begin
  select u.usuario_id, u.username, count(*), avg(v.importe), sum(v.importe)
  into v_usuario_id, v_username, v_num_viajes, v_promedio_importe, v_suma_importe
  from usuario u, cliente c, viaje v
  where u.usuario_id = c.usuario_id
  and c.usuario_id = v.usuario_id
  and c.usuario_id = p_usuario_id
  and v.hora_inicio between to_date(p_fecha_min,'dd/mm/yyyy') and
    to_date(p_fecha_max,'dd/mm/yyyy')
  group by u.usuario_id, u.username;

  insert into temp_estadistica (usuario_id, username, num_viajes, 
    promedio_importe, suma_importe)
  values(v_usuario_id, v_username, v_num_viajes, v_promedio_importe, v_suma_importe);
end;
/
show errors;