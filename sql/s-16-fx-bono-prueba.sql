--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 09/06/2019
--@Descripción: Prueba Funcion Virtual Travel

set serveroutput on

Prompt =======================================
Prompt Prueba 1.
prompt Obteniendo bono de conductor con id = 1
Prompt ========================================

declare
  v_bono number;

begin
  v_bono := fx_obten_bono(1);
  dbms_output.put_line('Bono calculado: ' || v_bono);
exception
  when others then
    dbms_output.put_line('Error fatal.');
end;
/

Prompt Prueba concluida.