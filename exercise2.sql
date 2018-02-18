/* Give the first and last names of all the authors who live in California (Ca). */
SELECT au_fname, au_lname FROM authors WHERE state='CA'; 

/* List the store id, order number and title id from salesdetail where the quantity sold is between 2000 and
3000. */

SELECT stor_id, ord_num, title_id FROM salesdetail WHERE qty>2000 AND qty<3000;

/* How many different stores appear in the salesdetail table? Identify the output with an "as" clause. */

SELECT COUNT(DISTINCT stor_id) FROM salesdetail;

/* What are the 5 oldest sales records in sales? Use order by desc, limit. */

SELECT date FROM sales ORDER BY date LIMIT 5;

/* What book (title_id) is most ordered (qty) by bookstores in salesdetail? Identify the output with an "as"
clause */

SELECT title_id, max(qty) AS most_ordered FROM salesdetail;

/* Give the total number of each title id stocked by bookstores from most to least omitting negative
quantities. */

SELECT title_id, qty FROM salesdetail WHERE qty >= 0 ORDER BY qty DESC;

/* What psychology book (actual title) is the most expensive of its type? Use max in subquery. Identify the
output with an "as" clause */

SELECT title AS most_expensive_psyc_title FROM titles WHERE type='psychology' AND price=(SELECT MAX(price) FROM titles WHERE type='psychology');

/* List the store's name and the order number in salesdetail for all stores that bought title including 'Fifty
Years'. Use a join */

SELECT stores.stor_name, storesb.ord_num FROM stores JOIN (SELECT stor_id, ord_num FROM salesdetail WHERE title_id=(SELECT title_id FROM titles WHERE title LIKE "%Fifty Years%")) AS stores_bought ON stores.stor_id = stores_bought.stor_id;

/* What book (actual title and author) is most ordered (qty) by bookstores in salesdetail? Identify the
output with an "as" clause. Use a join. */

SELECT found_title.title, CONCAT(authors.au_fname, ' ', authors.au_lname) AS auth_name FROM authors 
    JOIN (SELECT title, title_id FROM titles WHERE total_sales=(    
            SELECT MAX(total_sales) FROM titles
            )) AS found_title 
    JOIN titleauthor 
    ON titleauthor.title_id = found_title.title_id AND titleauthor.au_id = authors.au_id;
    


