--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 09/06/2019
--@Descripción: Prueba Trigger Virtual Travel

set serveroutput on

Prompt =======================================
Prompt Prueba 1.
prompt Insertando auto con valores correctos
Prompt ========================================

insert into auto(auto_id, placa, anio, modelo_id, usuario_id)
values(auto_seq.nextval, 'abc123', 2017, 1, 1);

var auto number
exec :auto := auto_seq.currval
select * from auto where auto_id = :auto;

Prompt OK, prueba 1 exitosa.

Prompt =======================================
Prompt Prueba 2.
prompt Insertando auto con año inválido
Prompt ========================================

declare
  v_codigo number;
  v_mensaje varchar2(1000);
begin

  insert into estudiante_extraordinario(estudiante_id,num_examen,calificacion,asignatura_id)
    values(1,1,null,1);
  -- Si se llega a este punto, significa que el trigger no está funcionando, se lanza
  --excepcion
  raise_application_error(-20001,
    ' ERROR: Extraordinario con asignatura aprobada.'||
    ' El trigger no está funcionando correctamente');
exception
  when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    if v_codigo = -20010 then
      dbms_output.put_line('OK, prueba 2 Exitosa.');
    else
      dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
      raise;
    end if;
end;
/

Prompt OK, prueba 2 exitosa

Prompt =======================================
Prompt Prueba 2.
prompt Insertando 3 autos de un solo conductor
Prompt ========================================

Prompt Pruebas concluidas, se hace rollback
rollback;