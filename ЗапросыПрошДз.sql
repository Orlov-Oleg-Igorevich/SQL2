create table if not exists Albums(
id serial primary key,
title varchar(35) not null,
year_of_release date
);

create table if not exists Tracks(
id serial primary key,
title varchar(35) not null,
duration integer check(duration > 0),
album_id integer not null references Albums(id)
);

create table if not exists Artists(
id serial primary key,
nickname varchar(50) not null
);

create table if not exists Genres(
id serial primary key,
title varchar(35) not null
);

create table if not exists Compilations(
id serial primary key,
title varchar(35) not null,
year_of_releas date
);

create table if not exists Staffs(
id serial primary key,
nickname varchar(20) not null,
department varchar(30),
head_id integer not null references Staffs(id)
);

create table if not exists ArtistsGenres(
artist_id integer references Artists(id),
genre_id integer references Genres(id),
constraint pk primary key (artist_id, genre_id)
);

create table if not exists ArtistsAlbums(
artist_id integer references Artists(id),
album_id integer references Albums(id),
constraint aa primary key (artist_id, album_id)
);

create table if not exists CompilationsTracks(
compilation_id integer references Compilations(id),
track_id integer references Tracks(id),
constraint ct primary key (compilation_id, track_id)
);

alter table tracks alter column duration type numeric(3,2);