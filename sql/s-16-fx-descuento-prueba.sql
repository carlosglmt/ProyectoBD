--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 09/06/2019
--@Descripción: Prueba Funcion Virtual Travel

set serveroutput on

Prompt =======================================
Prompt Prueba 1.
prompt Obteniendo descuento de usuario con id = 1
Prompt ========================================

declare
  v_descuento number;

begin
  v_descuento := fx_obten_descuento(1);
  dbms_output.put_line('Descuento calculado: ' || v_descuento);
exception
  when others then
    dbms_output.put_line('Error fatal.');
end;
/

Prompt Prueba concluida, se hace rollback.
rollback;