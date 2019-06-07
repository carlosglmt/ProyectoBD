--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 06/06/2019
--@Descripción: Funcion Virtual Travel

connect lm_proy_admin/admin

set serveroutput on
--funcion que recibe a un conductor, y regresa un bono basado en lo que el
--conductor gano en el ultimo mes, solo si tiene buena calificacion
create or replace function obten_bono(
  f_usuario_id number
) return number is

v_importe_total number;
v_promedio_calificacion number;

begin
  select sum(importe), avg(calificacion)
  into v_importe_total, v_promedio_calificacion
  from usuario u join conductor c
  on u.usuario_id = c.usuario_id
  join auto a
  on c.usuario_id = a.usuario_id
  join viaje v
  on a.auto_id = v.auto_id
  where u.usuario_id = f_usuario_id
  and v.hora_inicio between sysdate - 30 and sysdate;
  if v_promedio_calificacion >= 4.5 then
    dbms_output.put_line('Bono aceptado.');
    return v_importe_total * 0.075;  
    --la empresa se queda con 25%, el bono es el 10% de lo que resta
  else
    dbms_output.put_line('Bono denegado.');
    return 0;
  end if;
end;
/
show errors