SELECT * FROM vine_table;

-- separate vine (paid) from non-vine (unpaid) -> https://www.amazon.com/gp/vine/help
CREATE TABLE paid_reviews AS
SELECT review_id, star_rating, helpful_votes, total_votes, vine
FROM vine_table
WHERE vine = 'Y';

CREATE TABLE unpaid_reviews AS
SELECT review_id, star_rating, helpful_votes, total_votes, vine
FROM vine_table
WHERE vine = 'N';

-- review newly created tables
SELECT * FROM paid_reviews;
SELECT * FROM unpaid_reviews;

-- total number of reviews
SELECT COUNT(star_rating) AS "Total # of Paid Reviews"
FROM paid_reviews;

SELECT COUNT(star_rating) AS "Total # of Unpaid Reviews"
FROM unpaid_reviews;

-- total number of helpful votes
SELECT SUM(helpful_votes) AS "Total # of Paid Helpful Votes"
FROM paid_reviews;

SELECT SUM(helpful_votes) AS "Total # of Unpaid Helpful Votes"
FROM unpaid_reviews;

-- total average votes
SELECT sum(star_rating)/count(star_rating) AS "Total Average Vote for Paid Reviews"
FROM paid_reviews;

SELECT sum(star_rating)/count(star_rating) AS "Total Average Vote for Unpaid Reviews"
FROM unpaid_reviews;

-- total number of 5-star reviews
SELECT COUNT(star_rating) AS "Total # of 5-Star Paid Reviews"
FROM paid_reviews
WHERE star_rating = 5;

SELECT COUNT(star_rating) AS "Total # of 5-Star Unpaid Reviews"
FROM unpaid_reviews
WHERE star_rating = 5;

-- count by star rating
CREATE TABLE paid_star_rating_count AS
SELECT star_rating, COUNT(star_rating) AS "rating_count"
FROM paid_reviews
GROUP BY star_rating;

CREATE TABLE unpaid_star_rating_count AS
SELECT star_rating, COUNT(star_rating) AS "rating_count"
FROM unpaid_reviews
GROUP BY star_rating;

SELECT star_rating AS "Star Rating", rating_count AS "# of Paid Ratings", ROUND((rating_count/sum(rating_count) OVER()*100),0) AS "% of Total"
FROM paid_star_rating_count
GROUP BY rating_count, star_rating
ORDER BY star_rating;

SELECT star_rating AS "Star Rating", rating_count AS "# of Unpaid Ratings", ROUND((rating_count/sum(rating_count) OVER()*100),0) AS "% of Total"
FROM unpaid_star_rating_count
GROUP BY rating_count, star_rating
ORDER BY star_rating;
