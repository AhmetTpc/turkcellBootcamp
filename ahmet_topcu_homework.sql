    --10.Fiyatı 30 dan büyük kaç ürün var?
	
	Select count(*) from products 
	WHERE unit_price >30
	
	
    --11. Ürünlerin adını tamamen küçültüp fiyat sırasına göre tersten listele
	
	SELECT LOWER(product_name) AS new_name ,(unit_price) 
	FROM products ORDER BY unit_price DESC
	
	
    --12. Çalışanların ad ve soyadlarını yanyana gelecek şekilde yazdır 
   
   SELECT CONCAT(first_name,' ',last_name)
	as full_name  FROM employees
	
	
	--13. Region alanı NULL olan kaç tedarikçim var?
	
	SELECT count(*) FROM employees 
	WHERE region IS NULL
	
	
    --14. a.Null olmayanlar?
	
	SELECT count(*) FROM employees 
	WHERE region  IS NOT NULL
	
	
    --15. Ürün adlarının hepsinin soluna TR koy ve büyültüp olarak ekrana yazdır.
   
   SELECT CONCAT('TR',UPPER(product_name))
	as new_productname FROM products
	
	
    --16. a.Fiyatı 20den küçük ürünlerin adının başına TR ekle
	
	SELECT CONCAT('TR',product_name) as new_name
	FROM products WHERE unit_price<20


    --17. En pahalı ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.
    
	SELECT  product_name, unit_price FROM Products 
	ORDER BY unit_price DESC
	
	
    --18. En pahalı 10 ürünün Ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.
	
	SELECT  product_name, unit_price FROM Products
	ORDER BY unit_price DESC limit 10
	
	
    --19. Ürünlerin ortalama fiyatının üzerindeki Ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.
	
	SELECT product_name,unit_price FROM products
	WHERE unit_price > ( SELECT AVG(unit_price) FROM products )
	
	
    --20. Stokta olan ürünler satıldığında elde edilen miktar ne kadardır.
	
	SELECT SUM(unit_price*units_in_stock) FROM products
	
	
    --21. Mevcut ve Durdurulan ürünlerin sayılarını almak için bir sorgu yazın.
	
	SELECT COUNT(*) FILTER (WHERE discontinued = 0) AS active,
    COUNT(*) FILTER (WHERE discontinued = 1) AS discontinued
    FROM products
	
	
    --22. Ürünleri kategori isimleriyle birlikte almak için bir sorgu yazın
	
	SELECT product_name,category_name  FROM products
	inner join categories 
	on products.category_id=categories.category_id
	
	
    --23. Ürünlerin kategorilerine göre fiyat ortalamasını almak için bir sorgu yazın.
	
	SELECT DISTINCT category_name, AVG(unit_price) as average FROM products 
	inner join categories 
	on categories.category_id=products.category_id
	GROUP BY category_name
	
	
	--24. En pahalı ürünümün adı, fiyatı ve kategorisin adı nedir?
	
	SELECT product_name,category_name,unit_price  FROM products  
	inner join categories 
	on categories.category_id=products.category_id
	WHERE unit_price=(SELECT MAX(unit_price) FROM products)
	
	
    --25. En çok satılan ürününün adı, kategorisinin adı ve tedarikçisinin adı 
	
	SELECT category_name,contact_name,product_name FROM products  
	inner join suppliers 
	on suppliers.supplier_id=products.supplier_id
	inner join categories  on products.category_id=categories.category_id
	WHERE units_on_order=(SELECT MAX(units_on_order) FROM products)


    --26. Stokta bulunmayan ürünlerin ürün listesiyle birlikte tedarikçilerin ismi ve iletişim numarasını (`ProductID`, `ProductName`, `CompanyName`, `Phone`) almak için bir sorgu yazın.
	
	SELECT product_id, product_name, company_name,phone
    FROM products 
    inner join suppliers  on products.supplier_id = suppliers.supplier_id
    WHERE products.units_in_stock = 0
	
	
    --27. 1998 yılı mart ayındaki siparişlerimin adresi, siparişi alan çalışanın adı, çalışanın soyadı
	
	SELECT ship_address, first_name, last_name
    FROM orders 
    inner join employees  on orders.employee_id = employees.employee_id
    WHERE EXTRACT(YEAR FROM order_date) = 1998 
	and EXTRACT(MONTH FROM order_date) = 3
	
	
    --28. 1997 yılı şubat ayında kaç siparişim var?
	
	SELECT COUNT(*) FROM orders 
	WHERE EXTRACT(YEAR FROM order_date) = 1997 and EXTRACT(MONTH FROM order_date) = 2

    --29. London şehrinden 1998 yılında kaç siparişim var?
	
	SELECT COUNT(*) FROM orders 
    inner join customers  on orders.customer_id = customers.customer_id
    WHERE City = 'London' and EXTRACT(YEAR FROM order_date) = 1998
	
	
    --30. 1997 yılında sipariş veren müşterilerimin contactname ve telefon numarası
	
	SELECT contact_name, phone
    FROM customers 
    inner join orders  on customers.customer_id = orders.customer_id
    WHERE EXTRACT(YEAR FROM order_date) = 1997


    --31. Taşıma ücreti 40 üzeri olan siparişlerim 
	
	SELECT *FROM orders
    WHERE freight > 40
	
	
    --32. Taşıma ücreti 40 ve üzeri olan siparişlerimin şehri, müşterisinin adı
	
	SELECT ship_city, contact_name
    FROM orders
    inner join customers on orders.customer_id = customers.customer_id
    WHERE freight >= 40
	
	
    --33. 1997 yılında verilen siparişlerin tarihi, şehri, çalışan adı -soyadı ( ad soyad birleşik olacak ve büyük harf),
	
	SELECT order_date, ship_city, CONCAT(UPPER(first_name), ' ', UPPER(last_name)) AS full_name
    FROM orders 
    inner join employees  on orders.employee_id = employees.employee_id
    WHERE EXTRACT(YEAR FROM order_date) = 1997
	
	
    --34. 1997 yılında sipariş veren müşterilerin contactname i, ve telefon numaraları ( telefon formatı 2223322 gibi olmalı )
	
	
    --35. Sipariş tarihi, müşteri contact name, çalışan ad, çalışan soyad 
	
	SELECT first_name, last_name,contact_name,order_date
    FROM orders 
    inner join customers
	on orders.customer_id = customers.customer_id
    inner join employees  
	on orders.employee_id = employees.employee_id
	
	
    --36. Geciken siparişlerim?
	
	SELECT * FROM orders
    WHERE shipped_date > required_date
	
	
    --37. Geciken siparişlerimin tarihi, müşterisinin adı
	
	SELECT contact_name,shipped_date
    FROM orders 
    inner join customers  
	on orders.customer_id = customers.customer_id
    WHERE shipped_date > required_date
	
	
    --38. 10248 nolu siparişte satılan ürünlerin adı, kategorisinin adı, adedi 
	
	SELECT product_name, category_name, quantity
    FROM order_details 
    inner join products  
	on order_details.product_id =products.product_id
    inner join categories 
	on products.category_id = categories.category_id
    WHERE order_id = 10248
	
	
    --39. 10248 nolu siparişin ürünlerinin adı , tedarikçi adı 
	
	SELECT product_name,company_name
    FROM order_details 
    inner join products 
	ON order_details.product_id = products.product_id
    inner join suppliers 
	on pproducts.supplier_id = suppliers.supplier_id
    WHERE order_id = 10248
	
	
    --40. 3 numaralı ID ye sahip çalışanın 1997 yılında sattığı ürünlerin adı ve adeti
	
	SELECT product_name,quantity
    FROM order_details
    inner join products 
	on order_details.product_id = products.product_id
    inner join orders 
	on order_details.order_id = orders.order_id
    WHERE employee_id = 3 and EXTRACT(YEAR FROM order_date) = 1997
	
	
    --41. 1997 yılında bir defasinda en çok satış yapan çalışanımın ID,Ad soyad  
	
	
	
		
    --42. 1997 yılında en çok satış yapan çalışanımın ID,Ad soyad ****
	
	
	
    --43. En pahalı ürünümün adı,fiyatı ve kategorisin adı nedir?
	
	SELECT product_name,unit_price, category_name
    FROM products 
    inner join categories  
	on products.category_id = categories.category_id
    WHERE unit_price = ( SELECT MAX(unit_price) FROM products )
	
	
    --44. Siparişi alan personelin adı,soyadı, sipariş tarihi, sipariş ID. Sıralama sipariş tarihine göre
	
	SELECT first_name, last_name , order_date, order_id
    FROM orders
    inner join employees
	on orders.employee_id = employees.employee_id
    ORDER BY order_date
	
	
    --45. SON 5 siparişimin ortalama fiyatı ve orderid nedir?

	
    --46. Ocak ayında satılan ürünlerimin adı ve kategorisinin adı ve toplam satış miktarı nedir?
	
	SELECT product_name, category_name, SUM(quantity)
    FROM order_details 
    inner join orders  
	on order_details.order_id = orders.order_id
    inner join products 
	on order_details.product_id = products.product_id
    inner join categories  ON products.category_id = categories.category_id
    WHERE EXTRACT(MONTH FROM order_date) = 1
    GROUP BY product_name, category_name
	
	
    --47. Ortalama satış miktarımın üzerindeki satışlarım nelerdir? 
	
	SELECT *FROM order_details 
    WHERE quantity>(select AVG(quantity) from order_details)
    ORDER BY order_details.quantity DESC
	
	
    --48. En çok satılan ürünümün(adet bazında) adı, kategorisinin adı ve tedarikçisinin adı 
	
	SELECT products.product_name, categories.category_name, suppliers.company_name
    FROM 
	(SELECT order_details.product_id, SUM(od.quantity) AS Total
    FROM order_details 
    GROUP BY od.product_id
    ORDER BY Total DESC
    LIMIT 1) AS top
    INNER JOIN products 
	on top.product_id = products.product_id
    inner join categories 
	on products.category_id = categories.category_id
    inner join suppliers 
	on products.supplier_id = suppliers.supplier_id
	
	
    --49. Kaç ülkeden müşterim var
	
	SELECT COUNT(DISTINCT Country) FROM Customers
	
	
    --50. 3 numaralı ID ye sahip çalışan (employee) son Ocak ayından BUGÜNE toplamda ne kadarlık ürün sattı?
	
	SELECT employees.employee_id, SUM(order_details.quantity * order_details.unit_price) AS Total
    FROM order_details 
    inner join orders 
	on order_details.order_id = orders.order_id
    inner join employees  
	on orders.employee_id = employees.employee_id
    WHERE employees.employee_id = 3 AND orders.order_date >= '1997-01-01'
    GROUP BY employees.employee_id
	
	
    --51. 10248 nolu siparişte satılan ürünlerin adı, kategorisinin adı, adedi 
	
	SELECT product_name, category_name, quantity
    FROM order_details
    inner join products 
    on order_details.product_id = products.product_id
    inner join categories 
	on products.category_id = categories.category_id
    WHERE order_details.order_id = 10248
	
	
    --52. 10248 nolu siparişin ürünlerinin adı , tedarikçi adı 
	
	SELECT product_name, company_name
    FROM order_details
    inner join products
	on order_details.product_id = products.product_id
    inner join suppliers
	on products.supplier_id = suppliers.supplier_id
    WHERE order_details.order_id = 10248
	
	
    --53. 3 numaralı ID ye sahip çalışanın 1997 yılında sattığı ürünlerin adı ve adeti
	
	SELECT product_name, quantity
    FROM order_details
    inner join products
	on order_details.product_id = products.product_id
    inner join orders
	on order_details.order_id = orders.order_id
    WHERE orders.employee_id = 3 AND EXTRACT(YEAR FROM orders.order_date) = 1997
	
	
    --54. 1997 yılında bir defasinda en çok satış yapan çalışanımın ID,Ad soyad
	
	SELECT first_name, last_name ,orders.employee_id
    FROM orders
    inner join employees  
	on orders.employee_id = employees.employee_id
    WHERE EXTRACT(YEAR FROM orders.order_date) = 1997
    GROUP BY orders.employee_id, employees.first_name, employees.last_name
    ORDER BY COUNT(*) DESC
    LIMIT 1
	
	
    --55. 1997 yılında en çok satış yapan çalışanımın ID,Ad soyad ****
	
	SELECT first_name, last_name , employee_sales.employee_id
    FROM 
	(SELECT orders.employee_id, COUNT(*) AS Total
    FROM orders
    WHERE EXTRACT(YEAR FROM o.order_date) = 1997
    GROUP BY orders.employee_id
    ORDER BY Total DESC
    LIMIT 1) 
	AS employee_sales
    inner join employees 
	on employee_sales.employee_id = employees.employee_id
	
	
    --56. En pahalı ürünümün adı,fiyatı ve kategorisin adı nedir?
	
	SELECT product_name, unit_price, category_name
    FROM products 
    inner join categories 
	on products.category_id = categories.category_id
    ORDER BY products.unit_price DESC
    LIMIT 1
	
	
    --57. Siparişi alan personelin adı,soyadı, sipariş tarihi, sipariş ID. Sıralama sipariş tarihine göre
	
	SELECT first_name,last_name , order_date, order_id
    FROM orders 
    inner join employees  
	on orders.employee_id = employees.employee_id
    ORDER BY order_date
	
	
    --58. SON 5 siparişimin ortalama fiyatı ve orderid nedir?
	
	SELECT AVG(order_details.unit_price) AS Average, orders.order_id
    FROM order_details 
    inner join orders 
	on order_details.order_id = orders.order_id
    GROUP BY orders.order_id
    ORDER BY orders.order_id DESC
    LIMIT 5
	
	
    --59. Ocak ayında satılan ürünlerimin adı ve kategorisinin adı ve toplam satış miktarı nedir?
	
	SELECT product_name, category_name, SUM(quantity) 
    FROM order_details 
    inner join orders 
	on order_details.order_id = orders.order_id
    inner join products 
	on order_details.product_id = products.product_id
    inner join categories 
	on products.category_id = categories.category_id
    WHERE EXTRACT(MONTH FROM order_date) = 1
    GROUP BY product_name, category_name
	
	
	--60. Ortalama satış miktarımın üzerindeki satışlarım nelerdir? 
	
	SELECT *FROM order_details
    WHERE quantity>(select AVG(quantity) from order_details)
    ORDER BY order_details.quantity DESC --aynısı 47
	
	
    --61. En çok satılan ürünümün(adet bazında) adı, kategorisinin adı ve tedarikçisinin adı 
	
	SELECT product_name, MAX(units_on_order) as adet 
	FROM products GROUP BY product_name 
	ORDER BY product_name
	
	
    --62. Kaç ülkeden müşterim var
	
	SELECT COUNT(DISTINCT Country) FROM Customers
	
	
    --63. Hangi ülkeden kaç müşterimiz var
	
	SELECT country,count(*) as Number FROM
	customers GROUP BY country 
	
	
	--64. 3 numaralı ID ye sahip çalışan (employee) son Ocak ayından BUGÜNE toplamda ne kadarlık ürün sattı?
	
	SELECT e.employee_id, SUM(od.quantity * od.unit_price) AS TotalSales
    FROM order_details 
    inner join orders 
	on order_details.order_id= orders.order_id
    inner join employees 
	ON orders.employee_id = employees.employee_id
    WHERE employees.employee_id = 3 AND orders.order_date >= '01-01-2020'
    GROUP BY employees.employee_id;
	
	
    --65. 10 numaralı ID ye sahip ürünümden son 3 ayda ne kadarlık ciro sağladım?
	
	SELECT SUM(quantity * unit_price) AS TotalRevenue
    FROM order_details 
    INNER JOIN orders  on order_details.order_id = orders.order_id
    WHERE product_id = 10 and order_date >= CURRENT_DATE 
	
	
    --66. Hangi çalışan şimdiye kadar  toplam kaç sipariş almış..?
	
	SELECT employee_id,first_name,last_name,
    (SELECT COUNT(order_id) FROM orders WHERE employee_id= employees.employee_id)
    FROM employees 
	
	
    --67. 91 müşterim var. Sadece 89’u sipariş vermiş. Sipariş vermeyen 2 kişiyi bulun
	
	SELECT company_name,address,order_id FROM customers 
    LEFT JOIN orders 
    on customers.customer_id=orders.customer_id
    WHERE order_id is null
	
	
    --68. Brazil’de bulunan müşterilerin Şirket Adı, TemsilciAdi, Adres, Şehir, Ülke bilgileri
	
	SELECT  company_name, contact_name,city,address,country
    FROM customers
    WHERE country='Brazil'
	
	
    --69. Brezilya’da olmayan müşteriler
	
	SELECT  company_name, contact_name,city,address,country
    FROM customers
    WHERE country!='Brazil'
   
   
	--70. Ülkesi (Country) YA Spain, Ya France, Ya da Germany olan müşteriler
	
	SELECT country, company_name
    FROM customers
    WHERE Country='Spain' OR Country='France' OR Country='Germany'
    ORDER BY Country
	
	
    --71. Faks numarasını bilmediğim müşteriler
	
	SELECT  company_name
    FROM customers
    WHERE fax IS NULL
    ORDER BY company_name
	
	
    --72. Londra’da ya da Paris’de bulunan müşterilerim
	
	SELECT  company_name, contact_name,city,address,country
    FROM customers
    WHERE city='London' OR city='Paris'
	
	
    --73. Hem Mexico D.F’da ikamet eden HEM DE ContactTitle bilgisi ‘owner’ olan müşteriler
	
	SELECT  company_name, contact_name,city, address, country
    FROM customers
    WHERE city='México D.F.' AND contact_title='Owner'
	
	
    --74. C ile başlayan ürünlerimin isimleri ve fiyatları
	
	SELECT  product_name, unit_price
    FROM products
    WHERE product_name LIKE 'C%'
	
	
    --75. Adı (FirstName) ‘A’ harfiyle başlayan çalışanların (Employees); Ad, Soyad ve Doğum Tarihleri
	
	SELECT  first_name, last_name, birth_date
    FROM Employees
    WHERE first_name LIKE 'A%'
	
	
    --76. İsminde ‘RESTAURANT’ geçen müşterilerimin şirket adları
	
	SELECT  company_name
    FROM customers
    WHERE company_name LIKE '%restaurant%'
	
	
    --77. 50$ ile 100$ arasında bulunan tüm ürünlerin adları ve fiyatları
	
	SELECT  product_name, unit_price
    FROM products
    WHERE unit_price BETWEEN 50 AND 100
	
	
    --78. 1 temmuz 1996 ile 31 Aralık 1996 tarihleri arasındaki siparişlerin (Orders), SiparişID (OrderID) ve SiparişTarihi (OrderDate) bilgileri
	
	SELECT  order_id, order_date
    FROM orders
    WHERE order_date BETWEEN '1996-07-01' AND '1996-12-31' 
	
	
    --79. Ülkesi (Country) YA Spain, Ya France, Ya da Germany olan müşteriler
	
	SELECT country, company_name
    FROM customers
    WHERE Country='Spain' OR Country='France' OR Country='Germany'
    ORDER BY Country
	
	
    --80. Faks numarasını bilmediğim müşteriler 
	SELECT  company_name
    FROM customers
    WHERE fax IS NULL
    ORDER BY company_name
	

	