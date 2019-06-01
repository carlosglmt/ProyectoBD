--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 31/05/2019

whenever sqlerror exit;

prompt Conectando como usuario sys
connect sys as sysdba

prompt Creando al usuario lm_proy_invitado
create user lm_proy_invitado
	identified by invitado
	quota unlimited 
	on users;

prompt Creando al usuario lm_proy_admin
create user lm_proy_admin	
	identified by admin
	quota unlimited
	on users;

prompt Creando roles
create role rol_admin;
create role rol_invitado;

grant create session,create table,
	create view,create synonym,
	create trigger,create sequence,
	create procedure 
	to rol_admin;
grant rol_admin to lm_proy_admin;

grant create session
	to rol_invitado;
grant rol_invitado to lm_proy_invitado;
