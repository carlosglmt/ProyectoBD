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

