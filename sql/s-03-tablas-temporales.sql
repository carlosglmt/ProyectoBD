--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 02/06/2019
--@Descripción: Tablas temporales Virtual Travel

connect lm_proy_admin/admin

--Esta tabla funciona como buffer entre auto y ext_auto.
--Se creará una tabla externa con registros de autos que pueden o no cumplir
--con las reglas de negocio. Luego estos registros se insertán en la tabla
--temporal, activando el trigger s-11-tr-valida-auto.sql. Los registros que no
--cumplan con las reglas no serán insertados. Luego se copian todos los
--registros de temp_auto a auto.
create global temporary table temp_auto (
  auto_id number(10,0) not null, 
  placa varchar2(10) not null,
  anio number(4,0) not null,
  usuario_id number(10,0) not null,
  modelo_id number(10,0) not null, 
  ubicacion_id number(10,0)
) on commit delete rows;

--tabla contiene resultados estadisticos de los viajes de un usuario
create global temporary table temp_estadistica (
  usuario_id number(10,0) not null, 
  username varchar2(40) not null, 
  num_viajes number(3,0) not null,
  promedio_importe number(6,2) not null, 
  suma_importe number(8,2) not null
) on commit delete rows;