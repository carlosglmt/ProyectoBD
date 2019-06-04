--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 03/06/2019
--@Descripción: Indíces Virtual Travel

connect lm_proy_admin/admin

create unique index usuario_username_iuk 
  on usuario(username);
create unique index usuario_email_iuk 
  on usuario(email);
create unique index cliente_num_celular_iuk
  on cliente(num_celular);
create unique index conductor_num_cedula_iuk
  on conductor(num_cedula);
create unique index tarjeta_num_tarjeta_iuk
  on tarjeta(num_tarjeta);
create index usuario_username_ix
  on usuario(username);
create index usuario_email_ix
  on usuario(email);
create index conductor_num_licencia_ix
  on conductor(num_licencia);
create index auto_num_placas_ix
  on auto(num_placas);
create index tarjeta_num_tarjeta_ix
  on tarjeta(num_tarjeta);
create index viaje_usuario_id_ix
  on viaje(usuario_id);
create index viaje_auto_id_ix
  on viaje(auto_id);
create index auto_usuario_id_ix
  on auto(usuario_id);
create index auto_ubicacion_id_ix
  on auto(ubicacion_id);
create index tarjeta_usuario_id_ix
  on tarjeta(usuario_id);
create index usuario_lower_username_ix
  on usuario(lower(nombre));
create index cliente_fecha_ix
  on cliente(to_char(fecha_registro, 'dd/mm/yyyy')); 
create index pago_fecha_ix
  on pago(to_char(fecha, 'dd/mm/yyyy')); 
create index viaje_fecha_ix
  on viaje(to_char(fecha_status, 'dd/mm/yyyy')); 
create index factura_fecha_ix
  on factura(to_char(fecha, 'dd/mm/yyyy'));