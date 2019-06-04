--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 02/06/2019
--@Descripción: Secuencias Virtual Travel

connect lm_proy_admin/admin

Prompt Creando secuencia seq_visa
create sequence usuario_seq
  start with 1
  increment by 1
  nomaxvalue
  nocycle
  cache 10;

create sequence auto_seq
  start with 1
  increment by 1
  nomaxvalue
  nocycle
  cache 10;

create sequence modelo_seq
  start with 1
  increment by 1
  nomaxvalue
  nocycle
  cache 10;

create sequence ubicacion_seq
  start with 1
  increment by 1
  nomaxvalue
  nocycle
  cache 10;

create sequence marca_seq
  start with 1
  increment by 1
  nomaxvalue
  nocycle
  cache 10;

create sequence viaje_seq
  start with 1
  increment by 1
  nomaxvalue
  nocycle
  cache 10;

create sequence factura_seq
  start with 1
  increment by 1
  nomaxvalue
  nocycle
  cache 10;

create sequence status_viaje_seq
  start with 1
  increment by 1
  nomaxvalue
  nocycle
  cache 10;

create sequence historico_status_viaje_seq
  start with 1
  increment by 1
  nomaxvalue
  nocycle
  cache 10;

create sequence tarjeta_seq
  start with 1
  increment by 1
  nomaxvalue
  nocycle
  cache 10;

create sequence tarjeta_viaje_seq
  start with 1
  increment by 1
  nomaxvalue
  nocycle
  cache 10;
