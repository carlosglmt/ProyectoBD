--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 03/06/2019
--@Descripción: Carga inicial.

connect sys/system as sysdba

create or replace directory DIR_TEMP AS '/tmp/bases'; 
grant read,write on directory DIR_TEMP to lm_proy_admin;

connect lm_proy_admin/admin
set serveroutput on
create or replace procedure ps_insertar_marcas(
	p_nombre_archivo in varchar2, p_nombre_tabla in varchar2
) is
v_archivo UTL_FILE.FILE_TYPE;
v_linea varchar2(200);
v_contador number := 0;
v_posicion number := 0;

TYPE t_array IS TABLE OF VARCHAR2(3900)
   INDEX BY BINARY_INTEGER;

a_datos t_array;

begin 
	v_archivo := UTL_FILE.fopen('DIR_TEMP',p_nombre_archivo,'R');
	
	loop
    begin
    	UTL_FILE.GET_LINE(v_archivo,v_linea); 
    	dbms_output.put_line(v_linea);
    	v_posicion := instr(v_linea,'#',1,1);
			v_contador := 0;
			while (v_posicion != 0) loop
				v_contador := v_contador + 1;
				a_datos(v_contador) := substr(v_linea,1,v_posicion-1);
				v_linea := substr(v_linea,v_posicion+1,length(v_linea));
				v_posicion := instr(v_linea,'#',1,1);
				dbms_output.put_line(a_datos(v_contador));
				
				if v_posicion = 0 then
					v_contador := v_contador + 1;
					a_datos(v_contador) := v_linea;
					dbms_output.put_line(a_datos(v_contador));
				end if;
			end loop;

			--INSERT
			if p_nombre_tabla = 'marca' then
				insert into marca(marca_id,nombre,descripcion,categoria)
				values (marca_seq.nextval,a_datos(1),a_datos(2),a_datos(3));
			--elsif p_nombre_tabla = 'modelo' then
			
			--elsif p_nombre_tabla = 'auto' then

			--elsif p_nombre_tabla = 'usuario' then

			--elsif p_nombre_tabla = 'cliente' then

			--elsif p_nombre_tabla = 'administrador' then

			--elsif p_nombre_tabla = 'conductor' then

			--elsif p_nombre_tabla = 'ubicacion' then

			--elsif p_nombre_tabla = 'factura' then

			--elsif p_nombre_tabla = 'status_viaje' then

			--elsif p_nombre_tabla = 'viaje' then

			--elsif p_nombre_tabla = 'historico_status_viaje' then

			--elsif p_nombre_tabla = 'tarjeta' then

			--elsif p_nombre_tabla = 'tarjeta_viaje' then

			--elsif p_nombre_tabla = 'pago' then

			end if;

    	exception
    		when No_Data_Found then  
    			exit; 
    end;
  end loop;

end;
/
show errors


Prompt Creando directorio /tmp/bases
!rm -rf /tmp/bases 
!mkdir -p /tmp/bases 
Prompt Cambiando permisos
!chmod 777 /tmp/bases 

!chmod 777 marcas.txt 

Prompt Copiando archivo csv a /tmp/bases 
!cp marcas.txt /tmp/bases 

exec ps_insertar_marcas('marcas.txt','marca');
