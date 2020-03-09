# Challenge 1
# Step 1
SELECT ta.au_id, ta.title_id, ROUND(titles.advance * ta.royaltyper / 100, 2) as Advance, ROUND(titles.price * s.qty * titles.royalty / 100 * ta.royaltyper / 100, 2) as salesRoyalty
FROM titleauthor ta
INNER JOIN sales as s
ON s.title_id = ta.title_id
INNER JOIN titles
ON titles.title_id = ta.title_id;


# Step 2
SELECT title_id , au_id, SUM(salesRoyalty) as summed_royalties, Advance FROM (
	SELECT ta.au_id, ta.title_id, ROUND(titles.advance * ta.royaltyper / 100, 2) as Advance, ROUND(titles.price * s.qty * titles.royalty / 100 * ta.royaltyper / 100, 2) as salesRoyalty
	FROM titleauthor ta
	INNER JOIN sales as s
	ON s.title_id = ta.title_id
	INNER JOIN titles
	ON titles.title_id = ta.title_id
) as author_royalties
GROUP BY au_id, title_id, Advance;


# Step 3
SELECT au_id, ROUND(SUM(Advance + summed_royalties), 2) as profits FROM (
	SELECT title_id , au_id, SUM(salesRoyalty) as summed_royalties, Advance FROM (
		SELECT ta.au_id, ta.title_id, ROUND(titles.advance * ta.royaltyper / 100, 2) as Advance, ROUND(titles.price * s.qty * titles.royalty / 100 * ta.royaltyper / 100, 2) as salesRoyalty
		FROM titleauthor ta
		INNER JOIN sales as s
		ON s.title_id = ta.title_id
		INNER JOIN titles
		ON titles.title_id = ta.title_id
	) as author_royalties
	GROUP BY au_id, title_id, Advance
) as author_profits
GROUP BY au_id
ORDER BY profits DESC
LIMIT 3;


# Challenge 2
CREATE TEMPORARY TABLE challenge2_step1
SELECT ta.au_id, ta.title_id, ROUND(titles.advance * ta.royaltyper / 100, 2) as Advance, ROUND(titles.price * s.qty * titles.royalty / 100 * ta.royaltyper / 100, 2) as salesRoyalty
FROM titleauthor ta
INNER JOIN sales as s
ON s.title_id = ta.title_id
INNER JOIN titles
ON titles.title_id = ta.title_id;

CREATE TEMPORARY TABLE challenge2_step2
SELECT title_id , au_id, SUM(salesRoyalty) as summed_royalties, Advance FROM challenge2_step1
GROUP BY au_id, title_id, Advance;

SELECT au_id, ROUND(SUM(Advance + summed_royalties), 2) as profits FROM challenge2_step2
GROUP BY au_id
ORDER BY profits DESC;


# Challenge 3
create table [if not exists] profits(
au_id int AUTO_INCREMENT,
profit varchar(255) NOT NULL,
PRIMARY KEY (task_id)
)  ENGINE=INNODB;