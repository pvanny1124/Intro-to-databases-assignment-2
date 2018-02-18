/* Give the first and last names of all the authors who live in California (Ca). */

SELECT 'Give the first and last names of all the authors who live in California (Ca).' as 'Question 1';
SELECT au_fname, au_lname FROM authors WHERE state='CA'; 

/* List the store id, order number and title id from salesdetail where the quantity sold is between 2000 and
3000. */

SELECT 'List the store id, order number and title id from salesdetail where the quantity sold is between 2000 and
3000' as 'Question 2';

SELECT stor_id, ord_num, title_id FROM salesdetail WHERE qty>2000 AND qty<3000;

/* How many different stores appear in the salesdetail table? Identify the output with an "as" clause. */

SELECT 'How many different stores appear in the salesdetail table? Identify the output with an "as" clause.' AS 'Question 3';

SELECT COUNT(DISTINCT stor_id) AS num_of_stores FROM salesdetail;

/* What are the 5 oldest sales records in sales? Use order by desc, limit. */

SELECT 'What are the 5 oldest sales records in sales? Use order by desc, limit.' AS 'Question 4';

SELECT date FROM sales ORDER BY date LIMIT 5;

/* What book (title_id) is most ordered (qty) by bookstores in salesdetail? Identify the output with an "as"
clause */

SELECT 'What book (title_id) is most ordered (qty) by bookstores in salesdetail? Identify the output with an "as"
clause' AS 'Question 5';

SELECT title_id, max(qty) AS most_ordered FROM salesdetail;

/* Give the total number of each title id stocked by bookstores from most to least omitting negative
quantities. */

SELECT 'Give the total number of each title id stocked by bookstores from most to least omitting negative
quantities.' AS 'Question 6';

SELECT title_id, qty FROM salesdetail WHERE qty >= 0 ORDER BY qty DESC;

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
output with an "as" clause. Use a join' AS 'Question 9';

SELECT found_title.title, CONCAT(authors.au_fname, ' ', authors.au_lname) AS auth_name FROM authors 
    JOIN (SELECT title, title_id FROM titles WHERE total_sales=(    
            SELECT MAX(total_sales) FROM titles
            )) AS found_title 
    JOIN titleauthor 
    ON titleauthor.title_id = found_title.title_id AND titleauthor.au_id = authors.au_id;
    


