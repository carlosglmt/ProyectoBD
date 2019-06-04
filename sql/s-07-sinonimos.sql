--@Autores:Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 03/06/2019
--@Descripción: Creación de sinónimos Virtual Travel

connect sys/system as sysdba
grant create synonym to lm_proy_invitado

connect lm_proy_admin/admin


create or replace public synonym info_status_viaje 
	for status_viaje;
create or replace public synonym info_modelo 
	for modelo;
create or replace public synonym info_marca
	for marca;


grant select on lm_proy_admin.modelo to lm_proy_invitado;
grant select on lm_proy_admin.marca to lm_proy_invitado;
grant select on lm_proy_admin.status_viaje to lm_proy_invitado;


connect lm_proy_invitado/invitado

create or replace synonym modelo_inv
	for lm_proy_admin.modelo;
create or replace synonym marca_inv
	for lm_proy_admin.marca;
create or replace synonym status_viaje_inv
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
