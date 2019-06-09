--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 06/06/2019
--@Descripción: Consultas Virtual Travel

--Consulta para llenar temp_estadistica, sera utilizada en un procedimiento
select u.usuario_id, u.username, count(*) as numero_viajes,
  avg(v.importe) as promedio, sum(v.importe) as total
from usuario u, cliente c, viaje v
where u.usuario_id = c.usuario_id
and c.usuario_id = v.usuario_id
and c.usuario_id = 1 --aqui va una variable
and v.hora_inicio between to_date('08/09/2016','dd/mm/yyyy') and
  to_date('06/06/2019','dd/mm/yyyy') --las fechas son variables
group by u.usuario_id, u.username;

--Consulta que obtiene los diez mejores conductores, es decir, los conductores
--que tienen mas viajes registrados y ordenados por promedio de calificacion
select u.usuario_id, u.username, u.nombre, u.apellido_paterno, u.apellido_materno,
  c.descripcion, q1.numero_viajes, q1.promedio_calificacion
from usuario u join conductor c
on u.usuario_id = c.usuario_id
join (
  select u.usuario_id as usuario_id, count(*) as numero_viajes,
    avg(calificacion) as promedio_calificacion
  from usuario u join conductor c
  on u.usuario_id = c.usuario_id
  join auto a
  on c.usuario_id = a.usuario_id
  join viaje v
  on a.auto_id = v.auto_id
  group by u.usuario_id
  order by numero_viajes, promedio_calificacion desc
  fetch first 10 rows only) q1
on q1.usuario_id = c.usuario_id
order by q1.promedio_calificacion;

--consulta que obtiene a los usuarios existentes y usuarios que recomendaron, 
--tambien los que no han recomendado a nadie
select ue.usuario_id, ue.username, ur.usuario_id, ur.username
from usuario ue left join usuario ur
on ur.usuario_existente = ue.usuario_id
where ue.descuento is null
intersect
select ue.usuario_id, ue.username, ur.usuario_id, ur.username
from usuario ue left join usuario ur
on ur.usuario_existente = ue.usuario_id
where ue.es_cliente = 1;

--Consulta para generar el xml

select  c.usuario_id, v.viaje_id, v.fecha_status,v.importe,
  t.NUM_TARJETA, tv.PORCENTAJE,v.PROPINA,sum(v.importe) as total_importes,
  sum(v.PROPINA) as total_propinas
from viaje v
join tarjeta_viaje tv
on v.viaje_id = tv.viaje_id
join tarjeta t
on tv.tarjeta_id = t.TARJETA_ID
join cliente c
on t.USUARIO_ID = c.USUARIO_ID
where c.USUARIO_ID=1
and v.FECHA_STATUS between to_date('08/09/2016','dd/mm/yyyy') and
  to_date('06/07/2019','dd/mm/yyyy')
 group by c.usuario_id, v.viaje_id, v.fecha_status,v.importe,
  t.NUM_TARJETA, tv.PORCENTAJE,v.PROPINA;

select xmlagg(
      xmlelement("viaje",
          xmlforest(
            v.viaje_id as "id",
            v.importe as "importe",
            (v.importe+nvl(v.propina,0)) as "cobro"
          )
        )
    ) as viaje
  from viaje v
  join cliente c
  on v.USUARIO_ID = c.USUARIO_ID
  where c.USUARIO_ID=1
  and v.FECHA_STATUS 
    between to_date('08/09/2016','dd/mm/yyyy') and
  to_date('06/07/2019','dd/mm/yyyy');
