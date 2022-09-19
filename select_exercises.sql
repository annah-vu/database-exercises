-- 1 Created New File called select_exercises.sql

-- 2 use albums_db
use albums_db;

-- 3 Explore the structure of the albums table
describe albums;


select * 
from albums;

-- 3a.) How many rows are in the albums table?
        -- there are 31 rows in the albums table (told with query above)

-- 3b.) how many unique artist names are in the albums table?
select distinct artist
from albums;

        --there are 23 unique artists

-- 3c.) What is the primary key for the albums table?

describe albums;

         -- the primary key is id 

-- 3d.) What is the oldest release date for any album in the albums table? What is the most recent release date?
select *
from albums
order by release_date asc;

        -- the oldest release date is 1967 and the newest is 2011

-- 4.) Write queries to find the following information:


-- 4a.) The name of all albums by Pink Floyd

select * from albums
where artist = 'Pink Floyd';

        -- Dark Side of the Moon and The Wall are made by Pink Floyd

-- 4b.) The year Sgt. Pepper's Lonely Hearts Club Band was released

select * from albums
where name = "Sgt. Pepper's Lonely Hearts Club Band";

select release_date
from albums
where name = "Sgt. Pepper's Lonely Hearts Club Band"

        -- Sgt. Pepper's Lonely Hearts Club Band was released in 1967

-- 4c.) The genre for the album Nevermind
select * from albums
where name = "Nevermind";

        -- is in the grunge, alternative rock genre 

-- 4d.) Which albums were released in the 1990s
select * from albums
where release_date between 1990 and 1999;

        --  there are 11 released in the 90s and the names are given from that code above us. The Bodyguard, Jagged Little Pill, Come on Over, Falling into You, Let's Talk About Love, Dangerous, the Immaculate Collection, Titanic: music from the motion picture, Metallica, Nevermind, and Supernatural

-- 4e.) Which albums had less than 20 million certified sales    

select * from albums
where sales < 20.00;

-- if you run the code above it will tell you the albums that had less than 20 million certified sales, there were 13 albums that didn't make this mark
-- Grease, Bad, Sgt Pepper's Lonely Hearts Club Band, Dirty Dancing, Let's Talk About Love, Dangerous, The Immaculate Collection, Abbey Road, Born in the USA, Brothers in Arms, Titanic, Nevermind, and the Wall


-- 4f.) f. All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?

select * from albums
where genre = 'Rock'

        -- It would not be included because the string has to be specifically identical and to a computer the string "rock" does not match "hard rock" or "progressive rock". Each string has a unique identifier.



