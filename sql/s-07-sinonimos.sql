--@Autores:Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 03/06/2019
--@Descripción: Creación de sinónimos

create or replace public synonym info_auto 
	for lm_proy_admin.auto;
create or replace public synonym info_modelo 
	for lm_proy_admin.modelo;
create or replace public synonym info_marca
	for lm_proy_admin.marca;

grant select on cliente to lm_invitado_proy;
grant select on conductor to lm_invitado_proy;
grant select on administrador to lm_invitado_proy;

create or replace private synonym cliente_inv
	for lm_proy_invitado.cliente;
create or replace private synonym conductor_inv
	for lm_proy_invitado.conductor;
create or replace private synonym administrador_inv
	for lm_proy_invitado.administrador;


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
