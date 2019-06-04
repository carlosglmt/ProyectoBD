--@Autores:Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 03/06/2019
--@Descripción: Creación de sinónimos Virtual Travel

<<<<<<< HEAD
connect sys as sysdba
=======
connect sys/system as sysdba
>>>>>>> 8938ab61a645f31c971c145a9a9c115ba0fe8b0f

create or replace public synonym info_auto 
	for lm_proy_admin.auto;
create or replace public synonym info_modelo 
	for lm_proy_admin.modelo;
create or replace public synonym info_marca
	for lm_proy_admin.marca;


grant select on lm_proy_admin.cliente to lm_proy_invitado;
grant select on lm_proy_admin.conductor to lm_proy_invitado;
grant select on lm_proy_admin.administrador to lm_proy_invitado;
grant create synonym to lm_proy_invitado;

connect lm_proy_invitado/invitado

create or replace synonym cliente_inv
	for lm_proy_admin.cliente;
create or replace synonym conductor_inv
	for lm_proy_admin.conductor;
create or replace synonym administrador_inv
	for lm_proy_admin.administrador;

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
