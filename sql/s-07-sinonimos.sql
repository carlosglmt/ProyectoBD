--@Autores:Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 03/06/2019
--@Descripción: Creación de sinónimos Virtual Travel

connect sys/system as sysdba


create or replace public synonym info_auto 
	for lm_proy_admin.status_viaje;
create or replace public synonym info_modelo 
	for lm_proy_admin.modelo;
create or replace public synonym info_marca
	for lm_proy_admin.marca;


grant select on lm_proy_admin.modelo to lm_proy_invitado;
grant select on lm_proy_admin.marca to lm_proy_invitado;
grant select on lm_proy_admin.status_viaje to lm_proy_invitado;
grant create synonym to lm_proy_invitado;

connect lm_proy_invitado/invitado

create or replace synonym cliente_inv
	for lm_proy_admin.modelo;
create or replace synonym conductor_inv
	for lm_proy_admin.marca;
create or replace synonym administrador_inv
	for lm_proy_admin.status_viaje;

connect lm_proy_admin/admin

set serveroutput on
declare 
cursor cur_tablas is 
	select table_name 
	from user_tables;

begin 
	for r in cur_tablas loop 
		execute immediate 'create or replace synonym XX_'
			|| r.table_name
			|| ' for lm_proy_admin.'
			|| r.table_name;
	end loop; 
end;
/
