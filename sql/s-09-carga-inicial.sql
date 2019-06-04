--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 03/06/2019
--@Descripción: Carga inicial.


--Usuario
insert into usuario(usuario_id,username,nombre,apellido_paterno,
	email,clave_acceso,es_administrador,es_conductor,es_cliente)
values(usuario_seq.nextval,'sindro86','Miguel','Pérez',
	'sindro86@email.com','sindrome',0,1,0);

insert into conductor(usuario_id,num_licencia,num_cedula,foto,descripcion)
values (usuario_seq.currval,'LP123456','123456789101112131',hextoraw('453d7a34'),
	'Es como un Toreto pero revolucionado, si quiere llegar 
	rápido es la mejor opción');

insert into tarjeta(tarjeta_id,num_tarjeta,anio_exp,mes_exp,usuario_id)
values (tarjeta_seq.nextval,1987654321234567,23,11,usuario_seq.currval);

insert into marca(marca_id,nombre,descripcion,categoria)
values(marca_seq.nextval,'Ford','Go Further',1);

insert into modelo(modelo_id,nombre,descripcion,marca_id)
values (modelo_seq.nextval,'Mustang','Buen auto',marca_seq.currval);

insert into ubicacion(ubicacion_id,longitud,latitud,disponible)
values (ubicacion_seq.nextval,18.1231231,18.3213212,1);

insert into auto(auto_id,placa,anio,modelo_id,usuario_id,ubicacion_id)
values (auto_seq.nextval,'PLACA-04',2019,modelo_seq.currval,usuario_seq.currval,
	ubicacion_seq.currval);

insert into usuario(usuario_id,username,nombre,apellido_paterno,
	apellido_materno,email,clave_acceso,es_administrador,es_conductor,
	es_cliente)
values(usuario_seq.nextval,'joa123','Joaquín','Ramírez',
	'García','joa123@email.com','clave123',1,0,1);

insert into administrador(usuario_id,codigo,certificado)
values(usuario_seq.currval,123456,hextoraw('453d7a34'));

insert into cliente(usuario_id,num_celular)
values (usuario_seq.currval,5512345678);

insert into tarjeta(tarjeta_id,num_tarjeta,anio_exp,mes_exp,usuario_id)
values (tarjeta_seq.nextval,9876543210123456,22,12,usuario_seq.currval);

insert into status_viaje(status_viaje_id,clave,descripcion)
values (status_viaje_seq.nextval,'PROGRAMADO','Se ha solicitado un viaje.');

insert into viaje (viaje_id,latitud_origen,latitud_destino,longitud_origen,
	longitud_destino,importe,usuario_id,auto_id,
	status_viaje_id)
values (viaje_seq.nextval,19.1234567,29.1234567,13.1234567,14.1234567,
	134,usuario_seq.currval,auto_seq.currval,status_viaje_seq.currval);

