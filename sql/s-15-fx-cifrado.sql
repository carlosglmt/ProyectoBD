--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez 
--@Fecha creación: 07/06/2019
--@Descripción: Generador de cifrado para contraseñas

set serveroutput on
create or replace function fx_cifrar_descifrar_clave(
	p_clave_acceso varchar2, p_opcion varchar2
) return varchar2 is


v_llave raw(32);
v_longitud number := 256/8; --256 es la longitud de la llave en bits. Se debe representar en bytes
v_clave_c raw(2000);
v_clave_d raw(2000);
v_tipo_cifrado pls_integer :=  DBMS_CRYPTO.ENCRYPT_AES256
                          + DBMS_CRYPTO.CHAIN_CBC
                          + DBMS_CRYPTO.PAD_PKCS5;

v_salida varchar2(200);
v_entrada varchar2(200);


begin 
	--v_llave := dbms_crypto.randombytes(v_longitud);
	--Pongo una llave fija para que sea posible descifrar sin hacer consultas.
	v_llave := hextoraw('EE3C9132879CC6D1C19A4F760A9DE7E2EE3C9132879CC6D1C19A4F760A9DE7E2');
	if p_opcion = 'c' then
		v_clave_c := dbms_crypto.encrypt (
			src => UTL_I18N.string_to_raw(p_clave_acceso,'AL32UTF8'),
			typ => v_tipo_cifrado,
			key => v_llave
		);
		v_salida := v_clave_c;
	elsif p_opcion = 'd' then
		v_clave_d := dbms_crypto.decrypt (
			src => p_clave_acceso,
			typ => v_tipo_cifrado,
			key => v_llave
		);
		v_salida := UTL_I18N.raw_to_char(v_clave_d,'AL32UTF8');
	end if;
	--v_entrada := UTL_I18N.raw_to_char(v_clave_d,'AL32UTF8');
	--v_salida := v_clave_c;
	--dbms_output.put_line('Clave: '||  v_entrada);
	--dbms_output.put_line('Clave cifrada: ' || v_salida);

	return v_salida;
	
end;
/
show errors

--select fx_cifrar_descifrar_clave('Hola, mundo','c') from dual;
--select fx_cifrar_descifrar_clave('A661C672912AF44AB3D180FDDFA09583','d') from dual;



