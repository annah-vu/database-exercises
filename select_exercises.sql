-- 1 Created New File called select_exercises.sql

-- 2 use albums_db
use albums_db;

-- 3 Explore the structure of the albums table
describe albums;


select * 
from albums;

-- 3a there are 31 rows in the albums table

select distinct artist
from albums;

-- 3b there are 23 unique artists

describe albums;

-- 3c the primary key is id 

select *
from albums
order by release_date asc;

-- 3d the oldest release date is 1967 and the newest is 2011

-- 4

select * from albums
where artist = 'Pink Floyd';

-- 4a Dark Side of the Moon and The Wall are made by Pink Floyd

select * from albums
where name = "Sgt. Pepper's Lonely Hearts Club Band";

-- 4b Sgt. Pepper's Lonely Hearts Club Band was released in 1967

select * from albums
where name = "Nevermind";

-- 4c is in the grunge, alternative rock genre 

select * from albums
where release_date between 1990 and 1999;

-- 4d there are 11 released in the 90s and the names are given from that code above us 
-- The Bodyguard, Jagged Little Pill, Come on Over, Falling into You, Let's Talk About Love, Dangerous, the Immaculate Collection, Titanic: music from the motion picture, Metallica, Nevermind, and Supernatural
select * from albums
where sales < 20.00;

-- 4e if you run the code above it will tell you the albums that had less than 20 million certified sales, there were 13 albums that didn't make this mark
-- Grease, Bad, Sgt Pepper's Lonely Hearts Club Band, Dirty Dancing, Let's Talk About Love, Dangerous, The Immaculate Collection, Abbey Road, Born in the USA, Brothers in Arms, Titanic, Nevermind, and the Wall


-- 4f It would not be included because the string has to be specifically identical and to a computer the string "rock" does not match "hard rock" or "progressive rock". Each string has a unique identifier.

select * from albums
where genre = 'Rock'



