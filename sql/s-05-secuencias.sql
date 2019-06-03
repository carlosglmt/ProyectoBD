--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 02/06/2019
--@Descripción: Secuencias Virtual Travel

connect lm_proy_admin/admin

Prompt Creando secuencia seq_visa
create sequence seq_usuario
  start with 1
  increment by 1
  nomaxvalue
  nocycle
  cache 10;

create sequence seq_auto
  start with 1
  increment by 1
  nomaxvalue
  nocycle
  cache 10;

create sequence seq_modelo
  start with 1
  increment by 1
  nomaxvalue
  nocycle
  cache 10;

create sequence seq_ubicacion
  start with 1
  increment by 1
  nomaxvalue
  nocycle
  cache 10;

create sequence seq_marca
  start with 1
  increment by 1
  nomaxvalue
  nocycle
  cache 10;

create sequence seq_viaje
  start with 1
  increment by 1
  nomaxvalue
  nocycle
  cache 10;

create sequence seq_factura
  start with 1
  increment by 1
  nomaxvalue
  nocycle
  cache 10;

create sequence seq_status_viaje
  start with 1
  increment by 1
  nomaxvalue
  nocycle
  cache 10;

create sequence seq_historico_status_viaje
  start with 1
  increment by 1
  nomaxvalue
  nocycle
  cache 10;

create sequence seq_tarjeta
  start with 1
  increment by 1
  nomaxvalue
  nocycle
  cache 10;

create sequence seq_tarjeta_viaje
  start with 1
  increment by 1
  nomaxvalue
  nocycle
  cache 10;