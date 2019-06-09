--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 03/06/2019
--@Descripción: Inicialización Virtual Travel

connect sys/system as sysdba

set serveroutput on

declare
  v_existe_admin number(1,0);
  v_existe_invitado number(1,0);

begin
  select count(*) into v_existe_admin
  from dba_users
  where username = 'LM_PROY_ADMIN';
  select count(*) into v_existe_invitado
  from dba_users
  where username = 'LM_PROY_INVITADO';
  if v_existe_admin = 1 then
    dbms_output.put_line('Se borra al usuario admin');
    execute immediate 'drop user lm_proy_admin cascade';
    execute immediate 'drop role rol_admin';
  end if;
  if v_existe_invitado = 1 then
    dbms_output.put_line('Se borra al usuario invitado');
    execute immediate 'drop user lm_proy_invitado cascade';
    execute immediate 'drop role rol_invitado';
  end if;
end;
/
show errors
Prompt inicializando

start s-01-usuarios.sql
connect lm_proy_admin/admin
start s-02-entidades.sql
start s-03-tablas-temporales.sql
start s-04-tablas-externas.sql
start s-05-secuencias.sql
start s-06-índices.sql
start s-07-sinonimos.sql
start s-08-vistas.sql
start s-11-tr-actualiza-historico.sql
start s-11-tr-log-ubicacion.sql
start s-11-tr-valida-auto.sql
start s-11-tr-valida-tarjeta.sql
start s-13-p-llena-temp-auto.sql
start s-13-p-llena-temp-estadistica.sql
start s-15-fx-bono.sql
start s-15-fx-descuento.sql
start s-15-fx-cifrado.sql
start s-09-carga-inicial.sql

connect lm_proy_admin/admin
set serveroutput on
exec sp_insertar_datos('marcas.txt','marca');
exec sp_insertar_datos('modelos.txt','modelo');
exec sp_insertar_datos('usuarios.txt','usuario');
exec sp_insertar_datos('pago.txt','pago');
exec sp_llena_temp_auto
exec sp_insertar_datos('ubicacion.txt','ubicacion');
exec sp_insertar_datos('status_viaje.txt','status_viaje');
exec sp_insertar_datos('viaje.txt','viaje');
exec sp_insertar_datos('tarjeta.txt','tarjeta');
exec sp_insertar_datos('tarjeta-viaje.txt','tarjeta_viaje');

Prompt Listo!
