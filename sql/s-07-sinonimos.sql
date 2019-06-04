--@Autores:Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 03/06/2019
--@Descripción: Creación de sinónimos Virtual Travel

connect sys/system as sysdba

create or replace public synonym info_auto 
	for lm_proy_admin.auto;
create or replace public synonym info_modelo 
	for lm_proy_admin.modelo;
create or replace public synonym info_marca
	for lm_proy_admin.marca;

connect lm_proy_admin/admin

grant select on cliente to lm_proy_invitado;
grant select on conductor to lm_proy_invitado;
grant select on administrador to lm_proy_invitado;

connect lm_proy_invitado/invitado

create or replace synonym cliente_inv
	for lm_proy_admin.cliente;
create or replace synonym conductor_inv
	for lm_proy_admin.conductor;
create or replace synonym administrador_inv
	for lm_proy_admin.administrador;

connect lm_proy_admin/admin

set serveroutput on

cursor cur_tablas is 
	select table_name 
	from user_tables;

begin 
	for r in cur_tablas loop 
		execute immediate "create or replace synonym XX_"
			|| r.table_name
			|| " for lm_proy_admin."
			|| r.table_name;
	end loop; 
end;
/
