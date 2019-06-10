--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 09/06/2019
--@Descripción: Prueba Trigger Virtual Travel

set serveroutput on

Prompt =======================================
Prompt Prueba 1.
prompt Insertando tarjeta válida.
Prompt ========================================

insert into tarjeta(tarjeta_id, num_tarjeta, anio_exp, mes_exp, usuario_id)
values(tarjeta_seq.nextval, 1234567890147258, 23, 2, 2);

var auto number
exec :auto := auto_seq.currval
select * from auto where auto_id = :auto;

Prompt OK, prueba 1 exitosa.

Prompt =======================================
Prompt Prueba 2.
prompt Insertando tarjeta expirada.
Prompt ========================================

declare
  v_codigo number;
  v_mensaje varchar2(1000);

begin
  insert into tarjeta(tarjeta_id, num_tarjeta, anio_exp, mes_exp, usuario_id)
  values(tarjeta_seq.nextval, 1234568090147258, 15, 2, 3);
  -- Si se llega a este punto, significa que el trigger no está funcionando, se lanza
  --excepcion
  raise_application_error(-20021, 'Trigger programado incorrectamente');
exception
  when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    if v_codigo = -20030 then
      dbms_output.put_line('OK, prueba 2 exitosa.');
    else
      dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
      raise;
    end if;
end;
/

Prompt =======================================
Prompt Prueba 3.
prompt Insertando 4 tarjetas
Prompt ========================================

declare
  v_codigo number;
  v_mensaje varchar2(1000);

begin
  insert into tarjeta(tarjeta_id, num_tarjeta, anio_exp, mes_exp, usuario_id)
  values(tarjeta_seq.nextval, 1234567890507258, 24, 2, 1);
  -- Si se llega a este punto, significa que el trigger no está funcionando, se lanza
  --excepcion
  raise_application_error(-20021, 'Trigger programado incorrectamente');
exception
  when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    if v_codigo = -20003 then
      dbms_output.put_line('OK, prueba 3 exitosa.');
    else
      dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
      raise;
    end if;
end;
/

Prompt Pruebas concluidas, se hace rollback
rollback;