--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 06/06/2019
--@Descripción: Trigger Virtual Travel

set serveroutput on

create or replace trigger tr_actualizacion_ubicacion
  for update of latitud, longitud on ubicacion
  compound trigger

type ubicacion_actualizada_type is record (
  ubicacion_log_id ubicacion_log.ubicacion_log_id%type,
  ubicacion_id ubicacion_log.ubicacion_id%type,
  longitud_anterior ubicacion_log.longitud_anterior%type,
  latitud_anterior ubicacion_log.latitud_anterior%type,
  longitud_nueva ubicacion_log.longitud_nueva%type,
  latitud_nueva ubicacion_log.latitud_nueva%type,
  fecha_cambio ubicacion_log.fecha_cambio%type
);

type ubicacion_list_type is table of ubicacion_actualizada_type;

ubicacion_list ubicacion_list_type := ubicacion_list_type();

v_umbral number := 10;

procedure vacia_coleccion is
  v_num_rows integer;
begin
  v_num_rows := ubicacion_list.count();
  forall i in 1 .. v_num_rows
    insert into ubicacion_log(ubicacion_log_id,ubicacion_id,
      longitud_anterior,latitud_anterior,longitud_nueva,
      latitud_nueva, fecha_cambio)
    values(ubicacion_list(i).ubicacion_log_id, ubicacion_list(i).ubicacion_id,
      ubicacion_list(i).longitud_anterior,ubicacion_list(i).latitud_anterior,
      ubicacion_list(i).longitud_nueva, ubicacion_list(i).latitud_nueva,
      ubicacion_list(i).fecha_cambio
    );
  dbms_output.put_line('Se han vaciado '||v_num_rows||' registros');
  ubicacion_list.delete();
end vacia_coleccion;

before each row is
  v_index number;
  v_umbral number := 10;
begin
  ubicacion_list.extend;
  v_index := ubicacion_list.last;
  ubicacion_list(v_index).ubicacion_log_id := ubicacion_log_seq.nextval;
  ubicacion_list(v_index).ubicacion_id := :new.ubicacion_id;
  ubicacion_list(v_index).longitud_anterior := :old.longitud;
  ubicacion_list(v_index).latitud_anterior := :old.latitud;
  ubicacion_list(v_index).longitud_nueva:= :new.longitud;
  ubicacion_list(v_index).latitud_nueva := :new.latitud;
  ubicacion_list(v_index).fecha_cambio := sysdate;
  if v_index >= v_umbral then
    vacia_coleccion();
  end if;
end before each row;

after statement is
begin
  vacia_coleccion();
end after statement;
end;
/
show errors;