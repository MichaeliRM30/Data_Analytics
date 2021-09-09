use BestSuppliesDW;
show tables from BestSuppliesDW;

#Winthin Seafood category, what day of the week has the most orders?
select TimeDim.dayName as DayOfTheWeek, count(TimeDim.dayName) as NumberOfOrders, CategoryDim.categoryName as Category
from OrderedProductFact
left join TimeDim
on OrderedProductFact.timeDimIdOrder=TimeDim.timeDimId
left join CategoryDim
on OrderedProductFact.categoryIdDim=CategoryDim.categoryIdDim
where CategoryDim.categoryName = 'Seafood'
group by TimeDim.dayName
order by count(TimeDim.dayName) Desc;

#Who are our top customers by order value in the beverage and confections categories and what city do they live in?
select CustomerDim.custName as CustomerName, CustomerDim.custCity as CustomerCity, sum(orderValue) as TotalSales, CategoryDim.categoryName as Category
from OrderedProductFact
left join CustomerDim
on OrderedProductFact.customerIdDim=CustomerDim.customerIdDim
left join CategoryDim
on OrderedProductFact.categoryIdDim=CategoryDim.categoryIdDim
where CategoryDim.categoryName = 'Beverages' or CategoryDim.categoryName = 'Confections'
group by CustomerDim.custName, CategoryDim.categoryName
order by sum(orderValue) Desc;

#What country do most of our products come from, who are our top suppliers, and what are the contacts title and full name?
select sum(origPrice) as Purchases, SupplierDim.supplierCountry as Country, SupplierDim.supplierName as Name, SupplierDim.contactTitle as Title, SupplierDim.contactFullName as Contact
from OrderedProductFact
left join SupplierDim
on OrderedProductFact.supplierIdDim=SupplierDim.supplierIdDim
group by SupplierDim.supplierID, SupplierDim.supplierCountry
order by sum(origPrice) desc;

#Who was our most utilized shipper last quarter?
select ShipperDim.shipperId as ID, ShipperDim.shipperName as Name, count(orderValue) as Orders
from ShipperDim
left join OrderedProductFact
on ShipperDim.shipperId=OrderedProductFact.shipperIdDim

order by count(orderValue) desc;

select * from ShipperDim;
#What was our most popular product in the US in the last three years?
select ProductDim.productId as ID, ProductDim.prodName as Name, 

#Which Employee handled the most orders in 2017?
select EmployeeDim.empFullName as Name, EmployeeDim.homeCity as Location, count(orderValue) as OrderTotal, TimeDim.year as Year
from OrderedProductFact
left join EmployeeDim
on OrderedProductFact.empIdDim=EmployeeDim.empIdDim
left join TimeDim
on OrderedProductFact.timeDimIdOrder=TimeDim.timeDimId
where TimeDim.year = 2017
group by EmployeeDim.empFullName, TimeDim.year
order by count(orderValue) Desc;

#Who are out top customers by order value?
select CustomerDim.custName as Name, concat('$', format(sum(orderValue), 2)) as TotalPurchases
from OrderedProductFact
left join CustomerDim
on OrderedProductFact.customerIdDim=CustomerDim.customerIdDim
left join CategoryDim
on OrderedProductFact.categoryIdDim=CategoryDim.categoryIdDim
group by CustomerDim.custName
order by sum(orderValue) Desc;
