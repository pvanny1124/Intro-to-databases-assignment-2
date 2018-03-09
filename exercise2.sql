/* Give the first and last names of all the authors who live in California (Ca). */

SELECT 'Give the first and last names of all the authors who live in California (Ca).' as 'Question 1';
SELECT 'SELECT au_fname, au_lname FROM authors WHERE state=\'CA\';' AS 'Query';
SELECT au_fname, au_lname FROM authors WHERE state='CA'; 

/* List the store id, order number and title id from salesdetail where the quantity sold is between 2000 and
3000. */

SELECT 'List the store id, order number and title id from salesdetail where the quantity sold is between 2000 and
3000' as 'Question 2';
SELECT 'SELECT stor_id, ord_num, title_id FROM salesdetail WHERE qty BETWEEN 2000 and 3000;' AS 'Query';
SELECT stor_id, ord_num, title_id FROM salesdetail WHERE qty BETWEEN 2000 and 3000;

/* How many different stores appear in the salesdetail table? Identify the output with an "as" clause. */

SELECT 'How many different stores appear in the salesdetail table? Identify the output with an "as" clause.' AS 'Question 3';
SELECT 'SELECT COUNT(DISTINCT stor_id) AS num_of_stores FROM salesdetail;' AS 'Query';
SELECT COUNT(DISTINCT stor_id) AS num_of_stores FROM salesdetail;

/* What are the 5 oldest sales records in sales? Use order by desc, limit. */

SELECT 'What are the 5 oldest sales records in sales? Use order by desc, limit.' AS 'Question 4';
SELECT 'SELECT date FROM sales ORDER BY date LIMIT 5;' AS 'Query';
SELECT date FROM sales ORDER BY date LIMIT 5;

/* What book (title_id) is most ordered (qty) by bookstores in salesdetail? Identify the output with an "as"
clause */

SELECT 'What book (title_id) is most ordered (qty) by bookstores in salesdetail? Identify the output with an "as"
clause' AS 'Question 5';
SELECT 'SELECT title_id FROM salesdetail GROUP BY title_id ORDER BY SUM(qty) DESC LIMIT 1;' AS 'Query';
SELECT title_id FROM salesdetail GROUP BY title_id ORDER BY SUM(qty) DESC LIMIT 1;
/* redundant code used previously: */
/*SELECT found_titles.title_id, MAX(found_titles.qty) AS most_ordered FROM (SELECT title_id, SUM(qty) AS qty FROM salesdetail GROUP BY title_id) AS found_titles WHERE found_titles.qty = (SELECT MAX(qty) as qty FROM (SELECT title_id, SUM(qty) AS qty FROM salesdetail GROUP BY title_id) AS found_title); 
*/


/* Give the total number of each title id stocked by bookstores from most to least omitting negative
quantities. */

SELECT 'Give the total number of each title id stocked by bookstores from most to least omitting negative
quantities.' AS 'Question 6';

SELECT title_id, SUM(qty) as total FROM salesdetail GROUP BY title_id ORDER BY total DESC;

/* What psychology book (actual title) is the most expensive of its type? Use max in subquery. Identify the
output with an "as" clause */

SELECT 'What psychology book (actual title) is the most expensive of its type? Use max in subquery. Identify the
output with an "as" clause' AS 'Question 7';

SELECT title AS most_expensive_psyc_title FROM titles WHERE type='psychology' AND price=(SELECT MAX(price) FROM titles WHERE type='psychology');

/* List the store's name and the order number in salesdetail for all stores that bought title including 'Fifty
Years'. Use a join */

SELECT 'List the store\'s name and the order number in salesdetail for all stores that bought title including "Fifty
Years". Use a join' AS 'Question 8';

SELECT stores.stor_name, stores_bought.ord_num FROM stores JOIN (SELECT stor_id, ord_num FROM salesdetail WHERE title_id=(SELECT title_id FROM titles WHERE title LIKE "%Fifty Years%")) AS stores_bought ON stores.stor_id = stores_bought.stor_id;

/* What book (actual title and author) is most ordered (qty) by bookstores in salesdetail? Identify the
output with an "as" clause. Use a join. */

SELECT 'What book (actual title and author) is most ordered (qty) by bookstores in salesdetail? Identify the
output with an "as" clause. Use a join' AS 'Question';


SELECT titles.title, CONCAT(authors.au_fname, ' ', authors.au_lname) AS au_name FROM authors 
JOIN titles 
JOIN (SELECT found_titles.title_id, MAX(found_titles.qty) AS most_ordered FROM 
      (SELECT title_id, SUM(qty) AS qty FROM salesdetail GROUP BY title_id) AS found_titles 
      WHERE found_titles.qty = 
        (SELECT MAX(qty) AS qty FROM (SELECT title_id, SUM(qty) AS qty FROM salesdetail GROUP BY title_id) AS found_title)) AS most_ordered 
JOIN titleauthor 
WHERE most_ordered.title_id = titleauthor.title_id AND 
      titleauthor.au_id = authors.au_id AND 
      titles.title_id = most_ordered.title_id; 
