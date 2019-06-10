--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 09/06/2019
--@Descripción: Prueba Procedimieno Virtual Travel

set serveroutput on

Prompt =======================================
Prompt Prueba 1.
prompt Insertando cálculos de cliente con id = 1.
Prompt ========================================

begin
  sp_llena_temp_estadistica(1, '01/01/2015', '11/06/2019');
exception
  when others then
    dbms_output.put_line('Error fatal. Se hace rollback.');
    rollback;
end;
/

select * from temp_estadistica;

Prompt Pruebas concluidas, se hace rollback
rollback;