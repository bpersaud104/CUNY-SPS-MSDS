# Create a table for movies
Drop Table if Exists Movies;
Create Table Movies
(
  Movie_id int Primary Key,
  Title varchar(50) Not Null,
  Length int Not Null # in minutes
);
Insert into Movies(movie_id, title, length) Values(100, 'IT Chapter 2', '169');
Insert into Movies(movie_id, title, length) Values(200, 'Godzilla: King of the Monsters', 132);
Insert into Movies(movie_id, title, length) Values(300, 'Avengers: Endgame', 181);
Insert into Movies(movie_id, title, length) Values(400, 'John Wick: Chapter 3 - Parabellum', 131);
Insert into Movies(movie_id, title, length) Values(500, 'Once Upon a Time...in Hollywood', 161);
Insert into Movies(movie_id, title, length) Values(600, 'Toy Story 4', 100);
Select *
From Movies;

# Create a table for ratings
Drop Table If Exists Ratings;
Create Table Ratings
(
  Rating_id int Primary Key,
  Movie_id int Not Null References Movies,
  Users_name varchar(20) Not Null,
  Rating int, # Ratings are from 1 to 5
  Text_review varchar(40) Not null
);
Insert Into Ratings(rating_id, movie_id, users_name, rating, text_review) Values(1, 100, 'Alexis', 4, 'Exciting and Suspenseful');
Insert Into Ratings(rating_id, movie_id, users_name, rating, text_review) Values(2, 200, 'Alexis', 3, 'It was okay');
Insert Into Ratings(rating_id, movie_id, users_name, rating, text_review) Values(3, 300, 'Alexis', 5, 'Left me on the edge of my seat');
Insert Into Ratings(rating_id, movie_id, users_name, rating, text_review) Values(4, 400, 'Alexis', 4, 'Action packed');
Insert Into Ratings(rating_id, movie_id, users_name, rating, text_review) Values(5, 500, 'Alexis', 1, 'Was not good');
Insert Into Ratings(rating_id, movie_id, users_name, rating, text_review) Values(6, 600, 'Alexis', 5, 'A masterpiece');
Insert Into Ratings(rating_id, movie_id, users_name, rating, text_review) Values(7, 100, 'Joseph', 2, 'Was not even that scary');
Insert Into Ratings(rating_id, movie_id, users_name, rating, text_review) Values(8, 200, 'Joseph', 5, 'Love seeing monster fights');
Insert Into Ratings(rating_id, movie_id, users_name, rating, text_review) Values(9, 300, 'Joseph', 4, 'Good but was too long for me');
Insert Into Ratings(rating_id, movie_id, users_name, rating, text_review) Values(10, 400, 'Joseph', 5, 'Love seeing John Wick fight');
Insert Into Ratings(rating_id, movie_id, users_name, rating, text_review) Values(11, 500, 'Joseph', 4, 'Great storyline');
Insert Into Ratings(rating_id, movie_id, users_name, rating, text_review) Values(12, 600, 'Joseph', 1, 'Hopefully this is the last one');
Insert Into Ratings(rating_id, movie_id, users_name, rating, text_review) Values(13, 100, 'Jack', 4, 'Great sequel');
Insert Into Ratings(rating_id, movie_id, users_name, rating, text_review) Values(14, 200, 'Jack', 4, 'Nice action');
Insert Into Ratings(rating_id, movie_id, users_name, rating, text_review) Values(15, 300, 'Jack', 2, 'Kind of boring');
Insert Into Ratings(rating_id, movie_id, users_name, rating, text_review) Values(16, 400, 'Jack', 3, 'It was okay');
Insert Into Ratings(rating_id, movie_id, users_name, rating, text_review) Values(17, 500, 'Jack', 5, 'Best movie of 2019');
Insert Into Ratings(rating_id, movie_id, users_name, rating, text_review) Values(18, 600, 'Jack', 5, 'Walked out crying');
Insert Into Ratings(rating_id, movie_id, users_name, rating, text_review) Values(19, 100, 'Kimberly', 5, 'So scary');
Insert Into Ratings(rating_id, movie_id, users_name, rating, text_review) Values(20, 200, 'Kimberly', 5, 'Love seeing Godzilla');
Insert Into Ratings(rating_id, movie_id, users_name, rating, text_review) Values(21, 300, 'Kimberly', 5, 'Best.Movie.Ever');
Insert Into Ratings(rating_id, movie_id, users_name, rating, text_review) Values(22, 400, 'Kimberly', 3, 'Not that good');
Insert Into Ratings(rating_id, movie_id, users_name, rating, text_review) Values(23, 500, 'Kimberly', 1, 'Walked out half way through');
Insert Into Ratings(rating_id, movie_id, users_name, rating, text_review) Values(24, 600, 'Kimberly', 4, 'Can not believe it ended that way');
Insert Into Ratings(rating_id, movie_id, users_name, rating, text_review) Values(25, 100, 'Rosa', 4, 'So good');
Insert Into Ratings(rating_id, movie_id, users_name, rating, text_review) Values(26, 200, 'Kimberly', 4, 'Great fight scenes');
Insert Into Ratings(rating_id, movie_id, users_name, rating, text_review) Values(27, 300, 'Kimberly', 3, 'So bad');
Insert Into Ratings(rating_id, movie_id, users_name, rating, text_review) Values(28, 400, 'Kimberly', 5, 'Left me hyped for the next one');
Insert Into Ratings(rating_id, movie_id, users_name, rating, text_review) Values(29, 500, 'Kimberly', 3, 'Not that interesting');
Insert Into Ratings(rating_id, movie_id, users_name, rating, text_review) Values(30, 600, 'Kimberly', 5, 'My new favorite movie');
Select *
From Ratings;

# Join the two tables
Select *
From Movies 
Join Ratings
Using(movie_id) 