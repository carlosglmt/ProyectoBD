--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 02/06/2019
--@Descripción: Tablas temporales Virtual Travel

connect lm_proy_admin/admin

create global temporary table temp_auto (
  auto_id number(10,0) not null, 
  placa varchar2(10) not null,
  anio number(4,0) not null,
  nombre_modelo varchar2(40) not null, 
  nombre_marca varchar2(40) not null,
  categoria_marca number(1,0) not null
) on commit delete rows;

create global temporary table temp_conductor (
  usuario_id number(10,0) not null, 
  username varchar2(40) not null, 
  nombre varchar2(40) not null,
  apellido_paterno varchar2(40) not null, 
  email varchar2(40) not null, 
  num_licencia varchar2(8) not null, 
  placa varchar2(10) not null,
  viaje_id number(10,0) not null,
  propina number(6,2),
  comentario varchar2(500),
  calificacion number(1,0)
) on commit delete rows;

create global temporary table temp_ganancia(
  usuario_id number(10,0) not null,
  nombre varchar2(40) not null, 
  apellido_paterno varchar2(40) not null, 
  num_licencia varchar2(8) not null, 
  num_cedula varchar2(18) not null,
  foto blob not null, 
  ganancia number(10,2) not null
) on commit delete rows;
