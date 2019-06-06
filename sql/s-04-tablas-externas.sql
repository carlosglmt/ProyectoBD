--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 02/06/2019
--@Descripción: Tablas externa Virtual Travel

Prompt Conectando como usuario sys
connect sys/system as sysdba

Prompt Creando directorio tmp_dir
create or replace directory tmp_dir as '/tmp/bases';

Prompt Otorgando permisos a lm_proy_admin
grant read, write on directory tmp_dir to lm_proy_admin;

Prompt Conectando como usuario lm_proy_admin
connect lm_proy_admin/admin

Prompt Creando tabla externa
--tabla contiene datos obtenidos de un archivo de texto, que podría ser
--actualizado con frecuencia y es de interés para un conductor
create table auto_recomendado(
  marca varchar2(20),
  modelo varchar2(20),
  anio number(4,0),
  razon varchar2(256),
  precio number(8,2)
  )
organization external(
  type oracle_loader
  default directory tmp_dir
  access parameters(
    records delimited by newline
    badfile tmp_dir: 'auto_recomendado_bad.log'
    logfile tmp_dir: 'auto_recomendado.log'
    fields terminated by '#'
    lrtrim
    missing field values are null
    (
      marca, modelo, anio, razon, precio
    )
  )
  location ('auto_recomendado.txt')
)
reject limit unlimited;

--tabla que contendrá datos que pueden o no cumplir con las reglas de negocio,
--que serán validados antes de ser insertados en una tabla temporal
create table ext_auto(
  placa varchar2(10),
  anio number(4,0),
  usuario_id number(10,0),
  modelo_id number(10,0),
  ubicacion_id number(10,0)
  )
organization external(
  type oracle_loader
  default directory tmp_dir
  access parameters(
    records delimited by newline
    badfile tmp_dir: 'ext_auto_bad.log'
    logfile tmp_dir: 'ext_auto.log'
    fields terminated by ','
    lrtrim
    missing field values are null
    (
      placa, anio, usuario_id, modelo_id, ubicacion_id
    )
  )
  location ('ext_auto.csv')
)
reject limit unlimited;

Prompt Creando directorio /tmp/bases
!rm -rf /tmp/bases
!mkdir -p /tmp/bases
Prompt Cambiando permisos
!chmod 777 /tmp/bases

Prompt Copiando archivos csv a /tmp/bases
!cp ../dependencia_s04/auto_recomendado.txt /tmp/bases
!cp ../dependencia_s04/ext_auto.csv /tmp/bases

Prompt Mostrando los datos
col marca format a10
col modelo format a15
col razon format a50
select * from auto_recomendado;
Prompt _________________________________________________________
select * from ext_auto;