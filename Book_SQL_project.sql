create table book (
  book_id int primary key generated always as identity, 
  title varchar(50), 
  author varchar(30), 
  price decimal(8, 2), 
  amount int
);

  
insert into book(title, author, price, amount)
values
('Anna Karenina', 'Leo Tolstoy', 650.00, 15),
('War and Peace', 'Leo Tolstoy', 350.00, 18),
('To Kill a Mockingbird', 'Harper Lee', 460.00, 10),
('The Great Gatsby', 'F. Scott Fitzgerald', 540.50, 5),
('One Hundred Years of Solitude', 'Gabriel García Márquez', 799.01, 2),
('Don Quixote', 'Miguel de Cervantes', 780.50, 10),
('Jane Eyre', 'Charlotte Brontë', 650.01, 4),
('Shirley', 'Charlotte Brontë', 200.00, 6);

select * from book b

select author, title, price
from book;

select author as name
from book b 

/* To pack each book, 1 sheet of paper is required, the price of which is 1 dollar 65 cents. 
 Calculate the cost of packaging for each book (how much money it will take to pack all copies of the book). 
 In the request, display the title of the book, its quantity and cost of packaging, name the last column as packaging. */

select title, amount, amount*1.65 as pack
from book b 

/* Data sample, computed columns, math functions 

ceiling(4.2)=5 
ceiling(-5.8)=-5 
round(4.197)=4 
round(5.87392,1)=5.9
floor(4.2)=4 
floor(-5.8)=-6
power(3,4)=81.0
sqrt(4)=2.0 
sqrt(2)=1.41
degrees(3)=171.8...
abs(-1)=1
**/

/* At the end of the year, the price of all books in the warehouse is recalculated - it is reduced by 30%. 
 * Write a SQL query that selects titles, authors, quantities from the book table and calculates new book prices. 
 * Name the new price column new_price, round up the price to 2 decimal places.*/

select title, author, amount, round(price * 0.7, 2) as new_price
from book b 

/* Fetching data, computed columns, boolean functions
 * Let's complicate the calculation of the discount depending on the number of books. 
 * If the number of books is less than 4 - then the discount is 50%, less than 11 - 30%, in other cases - 10%. 
 * And we will also indicate what kind of discount for each book.*/
select title, amount, price,
    round(if(amount < 4, price * 0.5, if(amount < 11, price * 0.7, price * 0.9)), 2) as sale,
    if(amount < 4, 'discount 50%', if(amount < 11, 'discount 30%', 'discount 10%')) as Your_discount
from book;

/*Display all information about the books, as well as calculate its value for each item (product of price by quantity).
 *Name the calculated column total.*/
select title, author, price, amount, 
    price * amount as total 
from book;

/*conditions*/
select title, price 
from book
where price < 600;

/*Display the title, author and cost (price multiplied by the number) of those books, the cost of which is more than 4000.*/
select title, author, price * amount as total
from book
where price * amount > 4000;

/*Display the title, price of those books written by Charlotte Brontë or Leo Tolstoy, costing more than 600.*/
select title, author, price 
from book
where (author = 'Charlotte Brontë' OR author = 'Leo Tolstoy') AND price > 600;

/*Display information about books, the number of copies of which differs from the average number of books in the warehouse by more than 3.*/
select title, author, amount 
from book
where abs(amount - (select AVG(amount) from book)) > 3;

/*Display information about the books of those authors whose total number of copies of books is at least 12.*/
select title, author, amount, price
from book
where author in (
        select author 
        from book 
        group by author 
       having sum(amount) >= 12
      );

/*Display information about those books, the number of which is less than the smallest average number of books by each author.*/
select title, author, amount, price
from book
where amount < all (
        select avg(amount) 
        from book 
        group by author 
      );

/*Display the most expensive book information.*/
select * from book
where price = (select max(price) from book)