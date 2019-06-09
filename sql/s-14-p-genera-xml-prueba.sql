--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 08/06/2019
--@Descripción: Prueba del generador de xml

declare 
	v_usuario_id number(10,0);

begin 
	--ADVERTENCIA: Antes de realizar esta prueba, asegurarse de haber ejecutado 
	--la carga inicial primero. 

	dbms_output.put_line('Enviando datos válidos');
	sp_genera_xml(1,to_date('08/09/2016','dd/mm/yyyy'),sysdate);
	sp_genera_xml(2,to_date('08/09/2016','dd/mm/yyyy'),sysdate);
	dbms_output.put_line('Enviando datos con usuario_id inexistente');
	sp_genera_xml(100,to_date('08/09/2016','dd/mm/yyyy'),sysdate);
	dbms_output.put_line('Enviando fechas al revés');
	sp_genera_xml(2,sysdate,to_date('08/09/2016','dd/mm/yyyy'));

end;
/