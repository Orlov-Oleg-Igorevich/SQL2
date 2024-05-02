--- 2 задание

-- Название и продолжительность самого длительного трека
select title, max(duration) from tracks
group by title
limit 1;

-- Название треков, продолжительность которых не менее 3,5 минут.
select title from tracks
where duration >= 3.5;

-- Названия сборников, вышедших в период с 2018 по 2020 год включительно.
select title from compilations
where date(year_of_releas) between '2018-01-01' and '2020-12-31';

-- Исполнители, чьё имя состоит из одного слова.
select nickname from artists
where nickname not like '% %'

-- Название треков, которые содержат слово «мой» или «my».
select title from tracks
where upper(title) like upper('%my%') or upper(title) like upper('%мой%');


--- 3 задание

-- Количество исполнителей в каждом жанре.
select g.title, count(artist_id) from artistsgenres a 
join genres g ON a.genre_id = g.id
group by g.title;

-- Количество треков, вошедших в альбомы 2019–2020 годов.
select count(t.album_id) from albums a
join tracks t  on a.id = t.album_id 
where date(a.year_of_release) between '2019-01-01' and '2020-12-31';

-- Средняя продолжительность треков по каждому альбому.
select a.title, avg(t.duration) from albums a 
join tracks t on a.id = t.album_id
group by a.title;

-- Все исполнители, которые не выпустили альбомы в 2020 году.
select a.nickname from artists a
join artistsalbums a2 on a.id = a2.artist_id
join albums a3 on a3.id = a2.album_id 
where EXTRACT(year FROM a3.year_of_release) <> '2020'

-- Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами)
select c.title from compilations c
join compilationstracks c2 on c.id = c2.compilation_id 
join tracks t on c2.track_id  = t.id
join albums a on t.album_id = a.id
join artistsalbums a2 on a.id = a2.album_id
join artists a3 on a2.artist_id = a3.id
where a3.nickname = 'Сергей Лазарев';

--- 4 задание

-- Названия альбомов, в которых присутствуют исполнители более чем одного жанра.
select a.title from albums a
join artistsalbums a2 on a.id = a2.album_id
join artists a3 on a2.artist_id = a3.id
join artistsgenres a4 on a3.id = a4.artist_id
group by a.title 
having count(a4.genre_id) > 1;

-- Наименования треков, которые не входят в сборники.
select title from tracks t
left join compilationstracks c on c.track_id = t.id
where c.compilation_id is NULL;

-- Исполнитель или исполнители, написавшие самый короткий по продолжительности трек,
-- (теоретически таких треков может быть несколько)
select nickname from artists a 
join artistsalbums a2 on a2.artist_id = a.id
join tracks t on t.album_id = a2.album_id
where t.duration = (select max(duration) from tracks t2 limit 1);

-- Названия альбомов, содержащих наименьшее количество треков.
select a.title from albums a 
join tracks t on t.album_id = a.id
group by a.title
having count(a.id) = (select count(a2.id)  from albums a2 join tracks t2 on t2.album_id = a2.id group by a2.title order by count(a2.id) limit 1);
