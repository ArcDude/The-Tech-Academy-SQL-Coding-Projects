USE master -- For some reason this is the only database the queries work in, I'm not sure when or how, but the data
			-- from db_library3 (the original database) was messed up at some point

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES)
	DROP TABLE library_Branch, publisher, books, borrower, book_Copies, book_Loans, book_Authors
;

/*Build the tables*/
CREATE TABLE library_Branch (
	branch_id INT PRIMARY KEY NOT NULL IDENTITY (1,1),
	branch_name VARCHAR(50) NOT NULL,
	branch_address VARCHAR(60) NOT NULL
);

CREATE TABLE publisher (
	publisher_name VARCHAR(50) PRIMARY KEY  NOT NULL,
	publisher_address VARCHAR(60) NOT NULL,
	publisher_phone VARCHAR(50) NOT NULL
);

CREATE TABLE books (
	book_id INT PRIMARY KEY NOT NULL IDENTITY (100,1),
	book_title VARCHAR(70)  NOT NULL,
	book_publisher VARCHAR(50) NOT NULL CONSTRAINT fk_publisher_name FOREIGN KEY REFERENCES publisher(publisher_name)
);
ALTER TABLE books 
ALTER COLUMN book_title VARCHAR(70) NOT NULL;

CREATE TABLE borrower (
	card_no INT PRIMARY KEY NOT NULL IDENTITY (1000,1),
	borrower_name VARCHAR(50) NOT NULL,
	borrower_address VARCHAR(60) NOT NULL,
	borrower_phone VARCHAR(50) NOT NULL
);

CREATE TABLE book_Copies (
	copies_book_id INT NOT NULL CONSTRAINT fk_book_id FOREIGN KEY REFERENCES books(book_id),
	copies_branch_id INT NOT NULL CONSTRAINT fk_branch_id FOREIGN KEY REFERENCES library_Branch(branch_id),
	number_of_copies INT NOT NULL 
);

CREATE TABLE book_Loans (
	loans_book_id INT  NOT NULL CONSTRAINT fk_book_id2 FOREIGN KEY REFERENCES books(book_id),
	loans_branch_id INT NOT NULL CONSTRAINT fk_branch_id2 FOREIGN KEY REFERENCES library_Branch(branch_id),
	loans_card_no INT NOT NULL CONSTRAINT fk_card_no FOREIGN KEY REFERENCES borrower(card_no),
	date_out VARCHAR(50) NOT NULL,
	date_due VARCHAR(50) NOT NULL
);


CREATE TABLE book_Authors (
	author_book_id INT NOT NULL CONSTRAINT fk_book_id3 FOREIGN KEY REFERENCES books(book_id),
	author_name VARCHAR(50) NOT NULL
);

/* Put content in the tables */


INSERT INTO library_Branch
	(branch_name, branch_address)
	VALUES
	('Sharpstown', '7892 Sharpstown St, Houston, TX'),
	('Central', '932 Central Blvd, Austin, TX'),
	('Westlake', '213 Westlake Rd, Roundrock, TX'),
	('Somewhere', '1234 Some Address Ln, Aplace, CA')
;
SELECT * FROM library_Branch

INSERT INTO publisher
	(publisher_name, publisher_address, publisher_phone)
	VALUES
	('Tribe INC', '238 Tribe Rd, Portland, OR', '435-789-4253'),
	('Stephen and Co', '9253 Stephen Blvd, Mexico City, NM', '920-531-1241'),
	('Good Ideas INC', '9876 Creative Ln, Smart, OH', '012-345-6789'),
	('Kinney and Co', '892 Kinney Cv, New York City, NY', '934-653-5242'),
	('Riordan and Co', '3411 Riordan Ln, Boston, MA', '241-031-9218'),
	('Tolkien and Co', '829 Tolkien Rd, Austin, TX', '901-452-4523'),
	('Faber and Faber', '8293 Faber Ln, San Antonio, TX', '093-144-8125'),
	('Scholastic Corporation', '976 Scholastic Rd, San Fransisco, CA', '345-892-0294'),
	('Rowling INC', '876 Rowling Cv, Dallas, TX', '892-090-2834'),
	('Lewis INC', '9203 Lewis Blvd, Oakland, CA', '239-305-0392')
;
SELECT * FROM publisher

INSERT INTO books
	(book_title, book_publisher)
	VALUES
	('The Lost Tribe', 'Tribe INC'),
	('The Dark Tower', 'Stephen and Co'),
	('It', 'Stephen and Co'),
	('The Stand', 'Stephen and Co'),
	('The Shining', 'Stephen and Co'),
	('A Book', 'Good Ideas INC'),
	('A Good Book', 'Good Ideas INC'),
	('A Better Book', 'Good Ideas INC'),
	('The Best Book', 'Good Ideas INC'),
	('Diary of A Wimpy Kid', 'Kinney and Co'),
	('Percy Jackson and the Olympians: The Lightning Thief', 'Riordan and Co'),
	('The Lord of the Rings', 'Tolkien and Co'),
	('Lord of the Flies', 'Faber and Faber'),
	('The Hunger Games', 'Scholastic Corporation'),
	('Fantastic Beast and Where to Find Them', 'Rowling INC'),
	('Harry Potter and the Sorcerer''s Stone ', 'Rowling INC'),
	('Harry Potter and the Deathly Hallows', 'Rowling INC'),
	('Harry Potter and the Prisoner of Azkaban', 'Rowling INC'),
	('Harry Potter and the Goblet of Fire', 'Rowling INC'),
	('The Chronicles of Narnia: The Lion, the Witch and the Wardrobe', 'Lewis INC'),
	('The Chronicles of Narnia: Prince Caspian', 'Lewis INC')
;
SELECT * FROM books

INSERT INTO borrower
	(borrower_name, borrower_address, borrower_phone)
	VALUES
	('Alex Ray', '7385 Ray Cv, San Fransisco, CA', '935-231-3916'),
	('Barry Green', '821 Green Ln, Roundrock, TX', '029-241-9203'),
	('Lyra Blaze', '8392 Blaze Blvd, Aplace, CA', '925-923-0918'),
	('Terra Peterson', '8399 Peterson Rd, Austin, TX', '273-902-3092'),
	('Barry Smith', '923 Smith Ln, Houston, TX', '879-346-0848'),
	('Ricardo Rico', '9306 Rico Cv, San Jose, CA', '394-353-5939'),
	('Hiku Matsune', '8394 Idol Rd, San Antonio, TX', '849-292-2930'),
	('Guy Dude', '4352 Place Rd, Aplace, CA', '456-223-2341')
;
SELECT * FROM borrower

INSERT INTO book_Copies
		/* Refer to Table: library_Branch for branch_id
		Refer to Table: books for book_id*/
	(copies_book_id, copies_branch_id, number_of_copies)
	VALUES
	(101, 1, 2), --1,1 First number = branch_id, Second number = number of books in that branch
	(110, 1, 2), --1,2
	(111, 1, 2), --1,3
	(112, 1, 2), --1,4
	(113, 1, 2), --1,5
	(114, 1, 2), --1,6
	(115, 1, 2), --1,7
	(116, 1, 2), --1,8
	(117, 1, 2), --1,9
	(118, 1, 2), --1,10
	(102, 2, 2), --2,1
	(103, 2, 2), --2,2
	(104, 2, 2), --2,3
	(105, 2, 2), --2,4
	(119, 2, 2), --2,5
	(120, 2, 2), --2,6
	(121, 2, 2), --2,7
	(101, 2, 2), --2,8
	(110, 2, 2), --2,9
	(111, 2, 2), --2,10
	(106, 3, 2), --3,1
	(107, 3, 2), --3,2
	(108, 3, 2), --3,3
	(109, 3, 2), --3,4
	(120, 3, 2), --3,5
	(121, 3, 2), --3,6
	(101, 3, 2), --3,7
	(103, 3, 2), --3,8
	(104, 3, 2), --3,9
	(105, 3, 2), --3,10
	(106, 4, 2), --4,1
	(107, 4, 2), --4,2
	(108, 4, 2), --4,3
	(109, 4, 2), --4,4
	(102, 4, 2), --4,5
	(103, 4, 2), --4,6
	(110, 4, 2), --4,7
	(111, 4, 2), --4,8
	(112, 4, 2), --4,9
	(113, 4, 2) --4,10
;

SELECT * FROM book_Copies

INSERT INTO book_Loans
	(loans_book_id, loans_branch_id, loans_card_no, date_out, date_due)-- (book_id, branch-id, borrower card_no, when they got it, when it was/is due)
	VALUES
	(101, 1, 1000, '3/05/2019', '3/19/2019'),--1 Number of books out in the past 2 months
	(102, 2, 1003, '2/01/2019', '2/15/2019'),--2
	(103, 2, 1003, '2/15/2019', '3/01/2019'),--3
	(104, 2, 1003, '2/17/2019', '3/03/2019'),--4
	(105, 2, 1003, '3/03/2019', '3/16/2019'),--5
	(112, 1, 1003, '3/03/2019', '3/16/2019'),--6
	(113, 1, 1003, '3/04/2019', '3/17/2019'),--7
	(106, 4, 1007, '2/01/2019', '2/15/2019'),--8
	(107, 4, 1007, '2/15/2019', '3/01/2019'),--9
	(108, 4, 1007, '3/01/2019', '3/14/2019'),--10
	(109, 4, 1007, '3/14/2019', '3/28/2019'),--11
	(110, 4, 1007, '3/14/2019', '3/28/2019'),--12
	(111, 4, 1007, '3/15/2019', '3/29/2019'),--13
	(116, 1, 1002, '3/04/2019', '3/17/2019'),--14
	(120, 3, 1004, '3/01/2019', '3/14/2019'),--15
	(120, 3, 1005, '3/03/2019', '3/16/2019'),--16
	(121, 3, 1004, '3/16/2019', '3/30/2019'),--17
	(121, 3, 1005, '3/16/2019', '3/30/2019'),--18
	(101, 1, 1006, '3/02/2019', '3/15/2019'),--19
	(102, 2, 1001, '2/01/2019', '2/15/2019'),--20
	(103, 2, 1001, '2/15/2019', '3/01/2019'),--21
	(104, 2, 1001, '2/17/2019', '3/03/2019'),--22
	(105, 2, 1001, '3/03/2019', '3/16/2019'),--23
	(112, 1, 1001, '3/03/2019', '3/16/2019'),--24
	(113, 1, 1001, '3/04/2019', '3/17/2019'),--25
	(106, 4, 1002, '2/01/2019', '2/15/2019'),--26
	(107, 4, 1002, '2/15/2019', '3/01/2019'),--27
	(108, 4, 1002, '3/01/2019', '3/14/2019'),--28
	(109, 4, 1002, '3/14/2019', '3/28/2019'),--29
	(110, 4, 1002, '3/14/2019', '3/28/2019'),--30
	(111, 4, 1002, '3/15/2019', '3/29/2019'),--31
	(101, 1, 1004, '3/05/2019', '3/18/2019'),--32
	(106, 3, 1005, '2/01/2019', '2/15/2019'),--33
	(107, 3, 1005, '2/15/2019', '3/01/2019'),--34
	(108, 3, 1005, '3/01/2019', '3/14/2019'),--35
	(109, 3, 1005, '3/14/2019', '3/28/2019'),--36
	(110, 3, 1005, '3/14/2019', '3/28/2019'),--37
	(111, 3, 1005, '3/15/2019', '3/29/2019'),--38
	(106, 3, 1000, '2/01/2019', '2/15/2019'),--39
	(107, 3, 1000, '2/15/2019', '3/01/2019'),--40
	(108, 3, 1000, '3/01/2019', '3/14/2019'),--41
	(109, 3, 1000, '3/14/2019', '3/28/2019'),--42
	(110, 3, 1000, '3/14/2019', '3/28/2019'),--43
	(111, 3, 1000, '3/15/2019', '3/29/2019'),--44
	(120, 2, 1007, '3/01/2019', '3/14/2019'),--45
	(121, 2, 1007, '3/14/2019', '3/27/2019'),--46
	(120, 2, 1001, '3/01/2019', '3/14/2019'),--47
	(121, 2, 1001, '3/14/2019', '3/27/2019'),--48
	(110, 1, 1001, '3/02/2019', '3/15/2019'),--49
	(111, 1, 1001, '3/15/2019', '3/28/2019')--50
;
SELECT * FROM book_Loans

INSERT INTO book_Authors
	(author_book_id, author_name)
	VALUES
	(101, 'Mark W. Lee'),
	(102, 'Stephen King'),
	(103, 'Stephen King'),
	(104, 'Stephen King'),
	(105, 'Stephen King'),
	(106, 'Clever Writer'),
	(107, 'Clever Writer'),
	(108, 'Clever Writer'),
	(109, 'Clever Writer'),
	(110, 'Jeff Kinney'),
	(111, 'Rick Riordan'),
	(112, 'J.R.R. Tolkien'),
	(113, 'William Golding'),
	(114, 'Suzanne Collins'),
	(115, 'J.K. Rowling'),
	(116, 'J.K. Rowling'),
	(117, 'J.K. Rowling'),
	(118, 'J.K. Rowling'),
	(119, 'J.K. Rowling'),
	(120, 'C.S. Lewis'),
	(121, 'C.S. Lewis')
;
SELECT * FROM book_Authors

SELECT -- Query #1 Number of copies of "The Lost Tribe" in Sharpstown
	a1.branch_name, a2.book_title, a3.number_of_copies
	FROM book_Copies a3
	INNER JOIN books a2 ON a2.book_id = a3.copies_book_id
	INNER JOIN library_Branch a1 ON a1.branch_id = a3.copies_branch_id
	WHERE branch_name = 'Sharpstown' AND book_title = 'The Lost Tribe'
;

SELECT -- Query #2 Number of copies of "The Lost Tribe" in all Branches
	a1.branch_name, a2.book_title, a3.number_of_copies
	FROM book_Copies a3
	INNER JOIN books a2 ON a2.book_id = a3.copies_book_id
	INNER JOIN library_Branch a1 ON a1.branch_id = a3.copies_branch_id
	WHERE book_title = 'The Lost Tribe'
;


SELECT -- Query #3 Get all names of borrowers who do not have any books checked out
	a1.borrower_name, a2.loans_card_no
	FROM book_Loans a2
	INNER JOIN borrower a1 ON a1.card_no = a2.loans_card_no
	WHERE loans_card_no IN
	(SELECT loans_card_no FROM book_Loans
	GROUP BY loans_card_no HAVING COUNT (loans_card_no) = 0)
; 



SELECT -- Query #4 Each book that is due today (3/19/2019 when this was written) 
		-- and the name and address of the person who borrowered it 
	a1.branch_name, a2.date_due, a3.book_title, a4.borrower_name, a4.borrower_address
	FROM book_Loans a2
	INNER JOIN library_Branch a1 ON a1.branch_id = a2.loans_branch_id
	INNER JOIN books a3 ON a3.book_id = a2.loans_book_id
	INNER JOIN borrower a4 ON a4.card_no = a2.loans_card_no
	WHERE branch_name = 'Sharpstown' AND date_due = '3/19/2019'
;

SELECT -- Query #5 Get total number of books loaned from each branch
	a1.branch_name, a2.loans_branch_id, a3.book_id, a4.number_of_copies
	FROM book_Loans a2
	INNER JOIN books a3 ON a3.book_id = a2.loans_book_id
	INNER JOIN book_Copies a4 ON a4.copies_book_id = a3.book_id
	INNER JOIN library_Branch a1 ON a1.branch_id = a2.loans_branch_id
;


SELECT -- Query #6 Get names and addresses of everyone who has more that 5 books checked out
	a1.borrower_name, a1.borrower_address, a2.number_of_copies, a3.loans_card_no
	FROM book_Copies a2
	INNER JOIN book_Loans a3 ON a3.loans_branch_id = a2.copies_branch_id
	INNER JOIN borrower a1 ON a1.card_no = a3.loans_card_no
	WHERE loans_card_no IN
	(SELECT loans_card_no FROM book_Loans
	GROUP BY loans_card_no HAVING COUNT (loans_card_no) > 5)
; 

SELECT --Query #7 Get number of copies of all books by Stephen King in the Central branch
	a1.author_name, a2.book_title, a3.number_of_copies, a4.branch_name
	FROM book_Copies a3
	INNER JOIN books a2 ON a2.book_id = a3.copies_book_id
	INNER JOIN book_Authors a1 ON a1.author_book_id = a2.book_id
	INNER JOIN library_Branch a4 ON a4.branch_id = a3.copies_branch_id
	WHERE author_name = 'Stephen King' AND branch_name = 'Central'
;