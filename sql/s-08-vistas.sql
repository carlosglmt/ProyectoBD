--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 03/06/2019
--@Descripción: Vistas Virtual Travel

create or replace view v_usuario (
  usuario_id, username, nombre, apellido_paterno, email, descuento
) as
select usuario_id, username, nombre, apellido_paterno, email, descuento
from usuario;

grant select on v_usuario to lm_proy_invitado;

create or replace view v_conductor_pago (
  usuario_id, nombre, apellido_paterno, apellido_materno, num_licencia,
  num_cedula, descripcion, folio, fecha, monto
) as
select c.usuario_id, u.nombre, u.apellido_paterno, u.apellido_materno,
  c.num_licencia, c.num_cedula, c.descripcion, p.folio, p.fecha, p.monto
from conductor c, pago p, usuario u
where c.usuario_id = p.usuario_id
and u.usuario_id = c.usuario_id;

create or replace view v_factura (
  factura_id, importe_factura, fecha, viaje_id, hora_inicio, hora_fin,
  importe_viaje, tarjeta_id, porcentaje_tarjeta, num_tarjeta, usuario_id,
  nombre, apellido_paterno, apellido_materno, email
) as
select f.factura_id, f.importe, f.fecha, v.viaje_id, v.hora_inicio, v.hora_fin,
  v.importe, tv.tarjeta_id, tv.porcentaje, t.num_tarjeta, c.usuario_id,
  u.nombre, u.apellido_paterno, u.apellido_materno, u.email
from factura f join viaje v
on f.factura_id = v.factura_id
join tarjeta_viaje tv
on v.viaje_id = tv.viaje_id
join tarjeta t
on tv.tarjeta_id = t.tarjeta_id
join cliente c
on t.usuario_id = c.usuario_id
join usuario u
on c.usuario_id = u.usuario_id;