--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 03/06/2019
--@Descripción: Carga inicial.

connect sys/system as sysdba

create or replace directory DIR_TEMP AS '/tmp/bases'; 
grant read,write on directory DIR_TEMP to lm_proy_admin;

connect lm_proy_admin/admin
set serveroutput on
create or replace procedure sp_insertar_datos(
	p_nombre_archivo in varchar2, p_nombre_tabla in varchar2
) is
v_archivo UTL_FILE.FILE_TYPE;
v_linea varchar2(10000);
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
    	v_posicion := instr(v_linea,'#',1,1);
			v_contador := 0;
			while (v_posicion != 0) loop
				v_contador := v_contador + 1;
				a_datos(v_contador) := substr(v_linea,1,v_posicion-1);
				v_linea := substr(v_linea,v_posicion+1,length(v_linea));
				v_posicion := instr(v_linea,'#',1,1);
			
				if v_posicion = 0 then
					v_contador := v_contador + 1;
					a_datos(v_contador) := v_linea;
				
				end if;
			end loop;

			--INSERT
			if p_nombre_tabla = 'marca' then
				insert into marca(marca_id,nombre,descripcion,categoria)
				values (marca_seq.nextval,a_datos(1),a_datos(2),a_datos(3));
			elsif p_nombre_tabla = 'modelo' then
				insert into modelo(modelo_id,nombre,descripcion,marca_id)
				values (modelo_seq.nextval,a_datos(1),a_datos(2),a_datos(3));	
			elsif p_nombre_tabla = 'auto' then
				insert into auto(auto_id,placa,anio,modelo_id,usuario_id,ubicacion_id)
				values (auto_seq.nextval,a_datos(1),to_number(a_datos(2)),to_number(a_datos(3)),to_number(a_datos(4)),to_number(a_datos(5)));
			
			elsif p_nombre_tabla = 'usuario' then
				insert into usuario(usuario_id,username,nombre,apellido_paterno,apellido_materno,email,clave_acceso,es_administrador,es_conductor,es_cliente,descuento,usuario_existente)
				values (usuario_seq.nextval,a_datos(1),a_datos(2),a_datos(3),a_datos(4),a_datos(5),a_datos(6),a_datos(7),a_datos(8),a_datos(9),to_number(a_datos(10)),to_number(a_datos(11)));
				--Si es cliente y administrador, entonces inserta en la tabla cliente y administrador
				if a_datos(7) = 1 and a_datos(9) = 1 then
					dbms_output.put_line('CyA');
					insert into cliente(usuario_id,fecha_registro,num_celular)
					values(usuario_seq.currval,nvl(a_datos(12),sysdate),a_datos(13));
					insert into administrador(usuario_id,codigo,certificado)
					values(usuario_seq.currval,a_datos(14),hextoraw(a_datos(15)));
				
				--Si es conductor y es cliente, entonces inserta en la tabla conductor y cliente
				elsif a_datos(8) = 1 and a_datos(9) = 1 then
					dbms_output.put_line('CyC');
					insert into cliente(usuario_id,fecha_registro,num_celular)
					values(usuario_seq.currval,nvl(a_datos(12),sysdate),to_number(a_datos(13)));
					insert into conductor(usuario_id,num_licencia,num_cedula,foto,descripcion)
					values(usuario_seq.currval,a_datos(14),a_datos(15),hextoraw(a_datos(16)),a_datos(17));
				
				--Si sólo es administrador, entonces inserta en la tabla administrador
				elsif a_datos(7) = 1 then 
					dbms_output.put_line('A');
					insert into administrador(usuario_id,codigo,certificado)
					values(usuario_seq.currval,to_number(a_datos(12)),hextoraw(a_datos(13)));
				
				--Si sólo es conductor, entonces inserta en la tabla conductor. 
				elsif a_datos(8) = 1 then
					dbms_output.put_line('C');
					insert into conductor(usuario_id,num_licencia,num_cedula,foto,descripcion)
					values(usuario_seq.currval,a_datos(12),a_datos(13),hextoraw(a_datos(14)),a_datos(15));
				

				--Si sólo es cliente, entonces inserta en la tabla cliente. 
				elsif a_datos(9) = 1 then
					dbms_output.put_line('Cliente');
					insert into cliente(usuario_id,fecha_registro,num_celular)
					values(usuario_seq.currval,nvl(a_datos(12),sysdate),to_number(a_datos(14)));
				end if;


			--elsif p_nombre_tabla = 'ubicacion' then
				--insert into ubicacion()
				--values();

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
    		when others then
    			--raise;
    			continue;
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

exec sp_insertar_datos('marcas.txt','usuario');
