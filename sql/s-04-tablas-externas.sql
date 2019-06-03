--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 02/06/2019
--@Descripción: Tabla externa Virtual Travel

Prompt Conectando como usuario sys
connect sys/system as sysdba

Prompt Creando directorio tmp_dir
create or replace directory tmp_dir as '/tmp/bases';

Prompt Otorgando permisos a lm_proy_admin
grant read, write on directory tmp_dir to lm_proy_admin;

Prompt Conectando como usuario lm_proy_admin
connect lm_proy_admin/admin

Prompt Creando tabla externa
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

Prompt Creando directorio /tmp/bases
!rm -rf /tmp/bases
!mkdir -p /tmp/bases
Prompt Cambiando permisos
!chmod 777 /tmp/bases

Prompt Copiando archivo csv a /tmp/bases
!cp auto_recomendado.txt /tmp/bases

Prompt Mostrando los datos
col marca format a10
col modelo format a15
col razon format a50
select * from auto_recomendado;