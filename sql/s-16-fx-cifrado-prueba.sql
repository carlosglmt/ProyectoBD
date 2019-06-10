--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez

declare 

cursor cur_claves is
	select fx_cifrar_descifrar_clave(clave_acceso,'c') as cifrada,
		fx_cifrar_descifrar_clave(
			fx_cifrar_descifrar_clave(clave_acceso,'c'),'d') as original
	from usuario;

begin 
	for r in cur_claves loop
		dbms_output.put_line('Original: ' || r.original);
		dbms_output.put_line('Cifrada: ' || r.cifrada);
	end loop;
end;
/
show errors