create database Pakflix
use Pakflix
CREATE TABLE `User` (
    username VARCHAR(255) PRIMARY KEY,
    fname VARCHAR(255),
    lname VARCHAR(255),
    `password` VARCHAR(255),
    email VARCHAR(255),
    contact_no VARCHAR(15),
    date_of_birth DATE,
    account_type VARCHAR(50),
    credit_info_valid_to DATE,
    credit_info_cvv INT,
    credit_info_card_no VARCHAR(16)
);
CREATE TABLE Movie (
    title VARCHAR(255) PRIMARY KEY,
    image_url VARCHAR(255),
    bio TEXT,
    parental_guidance_age INT,
    warning_guidance VARCHAR(255),
    rating FLOAT,
    releaseDate DATE,
    director_name VARCHAR(255),
    duration int,
	video_url VARCHAR(255),
    accType VARCHAR(255)
);
CREATE TABLE MovieGenre(
	movieGenre varchar(255),
    movieTitle VARCHAR(255),
    PRIMARY KEY(movieGenre, movieTitle),
    FOREIGN KEY (movieTitle) REFERENCES Movie(title),
    FOREIGN KEY (movieGenre) REFERENCES Genres(genre)
);
CREATE TABLE Genres(
	genre varchar(255) PRIMARY KEY
);

CREATE TABLE WatchHistory (
    history_id INT AUTO_INCREMENT,
    username varchar(255),
    movie_title varchar(255),
    PRIMARY KEY (history_id, username, movie_title),
    FOREIGN KEY (username) REFERENCES `User`(username),
    FOREIGN KEY (movie_title) REFERENCES Movie(title)
);
CREATE TABLE Favourites (
    user_name VARCHAR(255),
    movie_name VARCHAR(255),
    PRIMARY KEY (user_name, movie_name),
    FOREIGN KEY (user_name) REFERENCES `User`(username),
    FOREIGN KEY (movie_name) REFERENCES Movie(title)
);
INSERT INTO Movie (title, image_url, bio, parental_guidance_age, warning_guidance, rating, releaseDate, director_name, duration, video_url, accType) VALUES
('Interstellar', 'interstellar.jpg', 'A team of astronauts embarks on a mission through a wormhole near Saturn in search of a new home for humanity as Earth faces environmental collapse.', 13, 'Some intense scenes', 8.6, '2014-11-07', 'Christopher Nolan', 169, 'https://www.example.com/interstellar_video', 'Executive'),
('Lord of the Rings', 'lord_of_the_rings.jpg', 'Frodo Baggins and a fellowship set out to destroy the One Ring and defeat the Dark Lord Sauron in this epic fantasy adventure.', 12, 'Fantasy violence', 8.9, '2001-12-19', 'Peter Jackson', 178, 'https://www.example.com/lotr_video', 'Executive'),
('Twelve Angry Men', 'twelve_angry_men.jpg', 'A jury deliberates over a murder trial, with one juror challenging the others to reconsider their initial guilty verdict.', 12, 'None', 8.9, '1957-04-10', 'Sidney Lumet', 96, 'https://www.example.com/twelve_angry_men_video', 'Executive'),
('Inception', 'inception.jpg', 'A thief with the ability to enter people''s dreams is tasked with planting an idea in a target''s mind, leading to a complex journey through multiple dream layers.', 13, 'Mind-bending sequences', 8.8, '2010-07-16', 'Christopher Nolan', 148, 'https://www.example.com/inception_video', 'Executive'),
('Gladiator', 'gladiator.jpg', 'A betrayed Roman general seeks revenge against the corrupt emperor who murdered his family and sent him into slavery as a gladiator.', 15, 'Violence and gore', 8.5, '2000-05-05', 'Ridley Scott', 155, 'https://www.example.com/gladiator_video', 'Executive'),
('The Sixth Sense', 'the_sixth_sense.jpg', 'A child psychologist works with a young boy who claims to see ghosts, leading to a chilling revelation about the psychologist himself.', 13, 'Some frightening scenes', 8.1, '1999-08-06', 'M. Night Shyamalan', 107, 'https://www.example.com/sixth_sense_video', 'Executive'),
('The Prestige', 'the_prestige.jpg', 'Two rival magicians engage in a deadly feud to create the ultimate illusion, leading to deception, sacrifice, and unexpected twists.', 14, 'Violence and disturbing images', 8.5, '2006-10-20', 'Christopher Nolan', 130, 'https://www.example.com/prestige_video', 'Executive'),
('Thirteen Lives', 'thirteen_lives.jpg', 'Based on a true story, a group of divers and volunteers work together to rescue a soccer team trapped in a flooded cave in Thailand.', 13, 'Some intense scenes', 7.8, '2022-09-08', 'Ron Howard', 147, 'https://www.example.com/thirteen_lives_video', 'Executive'),
('The Crimson Tide', 'the_crimson_tide.jpg', 'A tense standoff ensues aboard a nuclear submarine as conflicting orders lead to a power struggle between the captain and his executive officer.', 15, 'Violence and language', 7.3, '1995-05-12', 'Tony Scott', 116, 'https://www.example.com/crimson_tide_video', 'Executive'),
('Inglorious Basterds', 'inglorious_basterds.jpg', 'In Nazi-occupied France, a group of Jewish-American soldiers plots to assassinate high-ranking Nazis, leading to a plan that could change the course of the war.', 18, 'Strong violence and language', 8.3, '2009-08-21', 'Quentin Tarantino', 153, 'https://www.example.com/inglorious_basterds_video', 'Premium'),
('Shutter Island', 'shutter_island.jpg', 'A U.S. Marshal investigates the disappearance of a patient from a psychiatric facility on an isolated island, uncovering disturbing truths about the institution.', 16, 'Disturbing content', 8.2, '2010-02-19', 'Martin Scorsese', 138, 'https://www.example.com/shutter_island_video', 'Premium'),
('The Dark Knight', 'the_dark_knight.jpg', 'Batman faces off against the Joker, a deranged criminal mastermind, in a battle of ideologies and morals that pushes Gotham City to its limits.', 15, 'Intense sequences and violence', 9.0, '2008-07-18', 'Christopher Nolan', 152, 'https://www.example.com/dark_knight_video', 'Premium'),
('The Dark Knight Rises', 'the_dark_knight_rises.jpg', 'Eight years after the events of The Dark Knight, Batman returns to face the masked terrorist Bane, who plans to destroy Gotham City.', 15, 'Violence and intense sequences', 8.4, '2012-07-20', 'Christopher Nolan', 164, 'https://www.example.com/dark_knight_rises_video', 'Premium'),
('The Last Samurai', 'the_last_samurai.jpg', 'An American military officer embraces the samurai culture while leading a rebellion against the modernization of Japan in the late 19th century.', 16, 'Violence and battle scenes', 7.7, '2003-12-05', 'Edward Zwick', 154, 'https://www.example.com/last_samurai_video', 'Premium'),
('3 Idiots', '3_idiots.jpg', 'Three friends navigate the pressures of college life and societal expectations, challenging the education system with their unconventional approach to learning.', 10, 'Mild language and comedic violence', 8.4, '2009-12-25', 'Rajkumar Hirani', 170, 'https://www.example.com/3_idiots_video', 'Premium'),
('The Green Mile', 'the_green_mile.jpg', 'A death row supervisor witnesses supernatural events and discovers the innocence of a convicted man with extraordinary abilities.', 15, 'Disturbing content and language', 8.6, '1999-12-10', 'Frank Darabont',189,'https://www.example.com/green_mile_video','Premium'),
('Up', 'up.jpg', 'An elderly widower fulfills his dream of adventure by tying thousands of balloons to his house and embarking on a journey to South America, accompanied by an unexpected stowaway.', 7, 'Family-friendly', 8.2, '2009-05-29', 'Pete Docter', 96, 'https://www.example.com/up_video', 'Premium'),
('The Revenant', 'the_revenant.jpg', 'A frontiersman seeks vengeance against those who abandoned him and left him for dead after a brutal bear attack in the wilderness.', 18, 'Graphic violence and language', 8.0, '2015-12-25', 'Alejandro González Iñárritu', 156, 'https://www.example.com/revenant_video', 'Standard'),
('The Martian', 'the_martian.jpg', 'After being stranded on Mars, an astronaut uses his ingenuity to survive while NASA and his crewmates work to bring him home.', 13, 'Some strong language', 8.0, '2015-10-02', 'Ridley Scott', 144, 'https://www.example.com/martian_video', 'Standard'),
('The Legend of Maula Jutt', 'the_legend_of_maula_jutt.jpg', 'In a fictional Pakistani village, two rival families clash in a tale of love, revenge, and honor, blending traditional storytelling with modern action.', 18, 'Violence and mature themes', 8.7, '2023-12-22', 'Bilal Lashari', 148, 'https://www.example.com/maula_jutt_video', 'Standard'),
('Top Gun: Maverick', 'top_gun_maverick.jpg', 'Maverick returns as a flight instructor, training a new generation of elite fighter pilots while confronting ghosts from his past.', 13, 'Intense aerial sequences', 8.2, '2022-05-27', 'Joseph Kosinski', 130, 'https://www.example.com/top_gun_maverick_video', 'Standard');

INSERT INTO Genres (genre)
VALUES 
    ('Sci-Fi'),
    ('Adventure'),
    ('Drama'),
    ('Fantasy'),
    ('Action'),
    ('Crime'),
    ('Mystery'),
    ('Thriller'),
    ('Comedy'),
    ('Romance'),
    ('Animation');

INSERT INTO MovieGenre (movieGenre, movieTitle) VALUES
('Sci-Fi', 'Interstellar'),
('Adventure', 'Interstellar'),
('Drama', 'Interstellar'),
('Fantasy', 'Lord of the Rings'),
('Action', 'Lord of the Rings'),
('Adventure', 'Lord of the Rings'),
('Drama', 'Lord of the Rings'),
('Crime', 'Twelve Angry Men'),
('Drama', 'Twelve Angry Men'),
('Mystery', 'Twelve Angry Men'),
('Action', 'Inception'),
('Adventure', 'Inception'),
('Sci-Fi', 'Inception'),
('Adventure', 'Gladiator'),
('Action', 'Gladiator'),
('Drama', 'Gladiator'),
('Mystery', 'The Sixth Sense'),
('Drama', 'The Sixth Sense'),
('Thriller', 'The Sixth Sense'),
('Drama', 'The Prestige'),
('Mystery', 'The Prestige'),
('Sci-Fi', 'The Prestige'),
('Drama', 'Thirteen Lives'),
('Action', 'Thirteen Lives'),
('Adventure', 'Thirteen Lives'),
('Action', 'The Crimson Tide'),
('Drama', 'The Crimson Tide'),
('Thriller', 'The Crimson Tide'),
('Action', 'Inglorious Basterds'),
('Adventure', 'Inglorious Basterds'),
('Drama', 'Inglorious Basterds'),
('Mystery', 'Shutter Island'),
('Thriller', 'Shutter Island'),
('Action', 'The Dark Knight'),
('Crime', 'The Dark Knight'),
('Drama', 'The Dark Knight'),
('Action', 'The Dark Knight Rises'),
('Adventure', 'The Dark Knight Rises'),
('Drama', 'The Dark Knight Rises'),
('Action', 'The Last Samurai'),
('Adventure', 'The Last Samurai'),
('Drama', 'The Last Samurai'),
('Comedy', '3 Idiots'),
('Drama', '3 Idiots'),
('Romance', '3 Idiots'),
('Crime', 'The Green Mile'),
('Drama', 'The Green Mile'),
('Fantasy', 'The Green Mile'),
('Adventure', 'Up'),
('Animation', 'Up'),
('Comedy', 'Up'),
('Adventure', 'The Revenant'),
('Drama', 'The Revenant'),
('Thriller', 'The Revenant'),
('Adventure', 'The Martian'),
('Drama', 'The Martian'),
('Sci-Fi', 'The Martian'),
('Action', 'The Legend of Maula Jutt'),
('Adventure', 'The Legend of Maula Jutt'),
('Drama', 'The Legend of Maula Jutt'),
('Action', 'Top Gun: Maverick'),
('Drama', 'Top Gun: Maverick'),
('Thriller', 'Top Gun: Maverick');

DELIMITER //

CREATE PROCEDURE get_genre_movies(IN Inputgenre VARCHAR(255), IN username VARCHAR(255))
BEGIN
    DECLARE acc VARCHAR(255);

    -- Fetch the account type for the given username
    SELECT `User`.account_type INTO acc
    FROM `User`
    WHERE `User`.username = username;

    IF (acc = 'Executive') THEN
        SELECT M.title, M.image_url, M.rating
        FROM Movie M
        INNER JOIN MovieGenre MG ON M.title = MG.movieTitle
        WHERE MG.movieGenre = Inputgenre;
    
    ELSEIF (acc = 'Premium') THEN
        SELECT M.title, M.image_url, M.rating
        FROM Movie M
        INNER JOIN MovieGenre MG ON M.title = MG.movieTitle
        WHERE MG.movieGenre = Inputgenre AND M.accType != 'Executive';
    
    ELSE
        SELECT M.title, M.image_url, M.rating
        FROM Movie M
        INNER JOIN MovieGenre MG ON M.title = MG.movieTitle
        WHERE MG.movieGenre = Inputgenre AND M.accType = 'Standard';
    
    END IF;
END//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE prompt_result(IN prompt varchar(255),IN username varchar(255))
BEGIN
	
    DECLARE acc VARCHAR(255);

    -- Fetch the account type for the given username
    SELECT `User`.account_type INTO acc
    FROM `User`
    WHERE `User`.username = username;

    IF (acc = 'Executive') THEN
        SELECT title, image_url, rating FROM Movie 
		Where title like CONCAT('%',prompt,'%');
    
    ELSEIF (acc = 'Premium') THEN
       SELECT title, image_url, rating FROM Movie 
		Where title like CONCAT('%',prompt,'%') AND accType != 'Executive';
    
    ELSE
        SELECT title, image_url, rating FROM Movie 
    Where title like CONCAT('%',prompt,'%') AND accType = 'Standard';
    
    END IF;
    
END//

DELIMITER //

CREATE PROCEDURE genre_result(IN prompt varchar(255),IN username varchar(255))
BEGIN
    
     DECLARE acc VARCHAR(255);

    -- Fetch the account type for the given username
    SELECT `User`.account_type INTO acc
    FROM `User`
    WHERE `User`.username = username;

    IF (acc = 'Executive') THEN
       SELECT M.title, M.image_url, M.rating FROM Movie M
    join MovieGenre MG on MG.movieTitle = M.title
    Where MG.movieGenre like prompt;
    
    ELSEIF (acc = 'Premium') THEN
        SELECT M.title, M.image_url, M.rating FROM Movie M
    join MovieGenre MG on MG.movieTitle = M.title
    Where MG.movieGenre like prompt AND M.accType != 'Executive';
    
    ELSE
        SELECT M.title, M.image_url, M.rating FROM Movie M
		join MovieGenre MG on MG.movieTitle = M.title
		Where MG.movieGenre like prompt AND M.accType = 'Standard';
    
    END IF;
    
END//

DELIMITER ;


DELIMITER //

CREATE PROCEDURE get_favorites(IN username varchar(255),IN currentUser varchar(255))
BEGIN
     DECLARE acc VARCHAR(255);

    -- Fetch the account type for the given username
    SELECT `User`.account_type INTO acc
    FROM `User`
    WHERE `User`.username = currentUser;

    IF (acc = 'Executive') THEN
       SELECT M.title, M.image_url, M.rating FROM Movie M
	   join Favourites F on F.movie_name = M.title
	   Where F.user_name = username;
    
    ELSEIF (acc = 'Premium') THEN
        SELECT M.title, M.image_url, M.rating FROM Movie M
		join Favourites F on F.movie_name = M.title
		Where F.user_name = username AND M.accType != 'Executive';
    
    ELSE
       SELECT M.title, M.image_url, M.rating FROM Movie M
		join Favourites F on F.movie_name = M.title
		Where F.user_name = username AND M.accType = 'Standard';
    
    END IF;
    
END//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE get_watchHistory(IN username varchar(255))
BEGIN
     SELECT M.title, M.image_url, M.rating FROM 
     WatchHistory WH join Movie M on M.title = WH.movie_title
	 WHERE WH.username = username
     ORDER BY WH.history_id desc;
    
END//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE insert_watchHistory(IN username varchar(255), IN movie_title varchar(255))
BEGIN
	 if exists(select * from WatchHistory where WatchHistory.username = username AND WatchHistory.movie_title = movie_title) then
		delete from WatchHistory where WatchHistory.username = username AND WatchHistory.movie_title = movie_title;
	end if;
    insert into WatchHistory(username, movie_title)
    values(username, movie_title);
    
END//

DELIMITER ;


UPDATE Movie
SET video_url ='https://www.youtube.com/embed/zSWdZVtXT7E'
WHERE title = 'Interstellar';

UPDATE Movie
SET video_url ='https://www.youtube.com/embed/V75dMMIW2B4'
WHERE title = 'Lord of the Rings';

UPDATE Movie
SET video_url ='https://www.youtube.com/embed/TEN-2uTi2c0'
WHERE title = 'Twelve Angry Men';

UPDATE Movie
SET video_url ='https://www.youtube.com/embed/YoHD9XEInc0'
WHERE title = 'Inception';

UPDATE Movie
SET video_url ='https://www.youtube.com/embed/P5ieIbInFpg'
WHERE title = 'Gladiator';

UPDATE Movie
SET video_url ='https://www.youtube.com/embed/3-ZP95NF_Wk'
WHERE title = 'The Sixth Sense';

UPDATE Movie
SET video_url ='https://www.youtube.com/embed/ELq7V8vkekI'
WHERE title = 'The Prestige';

UPDATE Movie
SET video_url ='https://www.youtube.com/embed/R068Si4eb3Y'
WHERE title = 'Thirteen Lives';

UPDATE Movie
SET video_url ='https://www.youtube.com/embed/UMjcOLGReBU'
WHERE title = 'The Crimson Tide';

UPDATE Movie
SET video_url ='https://www.youtube.com/embed/KnrRy6kSFF0'
WHERE title = 'Inglorious Basterds';

UPDATE Movie
SET video_url ='https://www.youtube.com/embed/v8yrZSkKxTA'
WHERE title = 'Shutter Island';

UPDATE Movie
SET video_url ='https://www.youtube.com/embed/EXeTwQWrcwY'
WHERE title = 'The Dark Knight';

UPDATE Movie
SET video_url ='https://www.youtube.com/embed/g8evyE9TuYk'
WHERE title = 'The Dark Knight Rises';

UPDATE Movie
SET video_url ='https://www.youtube.com/embed/T50_qHEOahQ'
WHERE title = 'The Last Samurai';

UPDATE Movie
SET video_url = 'https://www.youtube.com/embed/CEnMff3fWXQ'
WHERE title = '3 Idiots';

UPDATE Movie
SET video_url ='https://www.youtube.com/embed/Ki4haFrqSrw'
WHERE title = 'The Green Mile';

UPDATE Movie
SET video_url ='https://www.youtube.com/embed/HWEW_qTLSEE'
WHERE title = 'Up';

UPDATE Movie
SET video_url ='https://www.youtube.com/embed/LoebZZ8K5N0'
WHERE title = 'The Revenant';

UPDATE Movie
SET video_url ='https://www.youtube.com/embed/ej3ioOneTy8'
WHERE title = 'The Martian';

UPDATE Movie
SET video_url ='https://www.youtube.com/embed/pEWqOAcYgpQ'
WHERE title = 'The Legend of Maula Jutt';

UPDATE Movie
SET video_url ='https://www.youtube.com/embed/qSqVVswa420'
WHERE title = 'Top Gun: Maverick';


select * from Favourites;
select * from `User`;
select * from MovieGenre;
select * from Privacy;
select * from Movie;
select * from WatchHistory;
