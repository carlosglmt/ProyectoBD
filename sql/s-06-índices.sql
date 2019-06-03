--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 03/06/2019
--@Descripción: Indíces

create unique index usuario_username_iuk 
    on usuario(username);
create unique index usuario_email_iuk 
    on usuario(email);
create unique index cliente_num_celular_iuk
    on cliente(num_celular);
create unique index auto_placa_iuk 
    on auto(placa);

