--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 31/05/2019
--@Descripción: DDL Virtual Travel

connect lm_proy_admin/admin

create table usuario(
	usuario_id number(10,0) not null, 
	username varchar2(40) not null, 
	nombre varchar2(40) not null,
	apellido_paterno varchar2(40) not null, 
	apellido_materno varchar2(40),
	email varchar2(40) not null, 
	clave_acceso varchar2(40) not null, 
	es_administrador number(1,0) not null, 
	es_conductor number(1,0) not null, 
	es_cliente number(1,0) not null, 
	descuento number(6,2) default 0,
	usuario_existente number(10,0),
	constraint usuario_pk primary key (usuario_id),
	constraint usuario_username_uk unique (username),
	constraint u_usuario_existente_fk foreign key (usuario_existente)
	references usuario(usuario_id),
  constraint usuario_tipo_chk check(
    (es_administrador = 0 or es_conductor = 0) and
    (es_administrador = 1 or es_conductor = 1 or es_cliente = 1)
  )
);

create table administrador(
	usuario_id number(10,0) not null,
	codigo number(6,0) not null,
	certificado blob not null,
	constraint admin_usuario_id_fk foreign key (usuario_id)
	references usuario(usuario_id),
	constraint administrador_pk primary key (usuario_id)
);

create table conductor(
	usuario_id number(10,0) not null,
	num_licencia varchar2(8) not null, 
	num_cedula varchar2(18) not null,
	foto blob not null,
	descripcion varchar2(3000) not null,
	constraint conductor_usuario_id_fk foreign key (usuario_id) 
	references usuario(usuario_id),
	constraint conductor_pk primary key (usuario_id)
);


create table cliente (
	usuario_id number(10,0) not null,
	fecha_registro date default sysdate not null, 
	num_celular number(13,0) not null,
	constraint cliente_usuario_id_fk foreign key (usuario_id) 
	references usuario(usuario_id),
	constraint cliente_pk primary key (usuario_id)
);

create table marca (
	marca_id number(10,0) not null, 
	nombre varchar2(40) not null,
	descripcion varchar2(200) not null,
	categoria number(1,0) not null,
	constraint marca_pk primary key (marca_id),
  constraint marca_categoria_chk check(categoria in (1,2,3))
);

create table modelo (
	modelo_id number(10,0) not null,
	nombre varchar2(40) not null,	
	descripcion varchar2(200) not null,
	marca_id number(10,0) not null,
	constraint modelo_pk primary key (modelo_id),
	constraint modelo_marca_id_fk foreign key (marca_id)
  references marca(marca_id)
);

create table ubicacion (
	ubicacion_id number(10,0) not null, 
	longitud number(10,7) not null,
	latitud number(10,7) not null, 
	disponible number(1,0) default 1 not null,
	constraint ubicacion_pk primary key (ubicacion_id),
  constraint ubicacion_disponible_chk check(disponible in (0,1))
);

create table auto (
	auto_id number(10,0) not null, 
	placa varchar2(10) not null,
	anio number(4,0) not null,
	modelo_id number(10,0) not null, 
	usuario_id number(10,0) not null,
	ubicacion_id number(10,0), 
	constraint auto_pk primary key (auto_id),
	constraint auto_modelo_id_fk foreign key (modelo_id)
	references modelo (modelo_id),
	constraint auto_usuario_id_fk foreign key (usuario_id)
  references usuario (usuario_id),
	constraint auto_ubicacion_id foreign key (ubicacion_id)
  references ubicacion (ubicacion_id)
);

create table factura (
	factura_id number(10,0) not null, 
	fecha date default sysdate not null, 
	importe number(7,2) not null, 
	xml blob not null, 
	constraint factura_pk primary key (factura_id)
);

create table status_viaje (
	status_viaje_id number(10,0) not null,
	clave varchar2(40) not null,
	descripcion varchar2(200) not null,
	constraint status_viaje_pk primary key (status_viaje_id)
);

create table viaje (
	viaje_id number(10,0) not null,
	latitud_origen number(10,7) not null,
	latitud_destino number(10,7) not null,
	longitud_origen number(10,7) not null,
	longitud_destino number(10,7) not null,
	importe number(6,2) not null,
  impuesto as (importe*0.16) virtual,
	hora_inicio date default sysdate not null,
	hora_fin date,
	propina number(6,2),
	comentario varchar2(500),
	calificacion number(1,0),
	fecha_status date default sysdate not null, 
	usuario_id number(10,0) not null, 
	auto_id number(10,0) not null, 
	factura_id number(10,0), 
	status_viaje_id number(10,0) not null, 
	constraint viaje_pk primary key (viaje_id),
	constraint viaje_usuario_id_fk	foreign key (usuario_id)
	references usuario(usuario_id),
	constraint viaje_auto_id_fk foreign key (auto_id)
	references auto(auto_id),
	constraint viaje_factura_id_fk foreign key (factura_id)
	references factura(factura_id),
	constraint viaje_status_viaje_id_fk foreign key (status_viaje_id)
	references status_viaje(status_viaje_id),
  constraint viaje_calificacion_chk check(calificacion between 1 and 5)
);

create table historico_status_viaje (
	historico_status_viaje_id number(10,0) not null,
	fecha_status date default sysdate not null,
	viaje_id number(10,0) not null,
	status_viaje_id number(10,0) not null,
	constraint historico_status_viaje_pk primary key (historico_status_viaje_id),
	constraint hsv_viaje_id_fk foreign key (viaje_id) 
	references viaje(viaje_id),
	constraint hsv_status_viaje_id_fk foreign key (status_viaje_id)
	references status_viaje(status_viaje_id)
);

create table tarjeta (
	tarjeta_id number(10,0) not null, 
	num_tarjeta number(16,0) not null, 
	anio_exp number(2,0) not null, 
	mes_exp number(2,0) not null, 
	usuario_id number(10,0) not null, 
	constraint tarjeta_pk primary key (tarjeta_id),
	constraint tarjeta_usuario_id_fk foreign key (usuario_id)
	references usuario(usuario_id)
);

create table tarjeta_viaje(
	tarjeta_viaje_id number(10,0) not null, 
	porcentaje number(3,2) not null, 
	viaje_id number(10,0) not null, 
	tarjeta_id number(10,0) not null,
	constraint tv_viaje_id_fk foreign key (viaje_id)
	references viaje(viaje_id),
	constraint tv_tarjeta_id_fk foreign key (tarjeta_id)
	references tarjeta(tarjeta_id),
	constraint tv_porcentaje_chk check (porcentaje <= 1.00)
);

create table pago (
	usuario_id number(10,0)	not null,
	folio number(8,0) not null, 
	monto number(8,2) not null, 
	fecha date default sysdate not null, 
	constraint pago_usuario_id_fk foreign key (usuario_id)
	references conductor(usuario_id),
	constraint pago_pk primary key (usuario_id,folio)
);

create table ubicacion_log(
	ubicacion_log_id number(10,0) not null,
	ubicacion_id number(10,0) not null, 
	longitud_anterior number(10,7) not null,
	latitud_anterior number(10,7) not null,
	longitud_nueva number(10,7) not null,
	latitud_nueva number(10,7) not null,  
	fecha_cambio date not null,
	constraint ubicacion_log_pk primary key (ubicacion_log_id)
);
