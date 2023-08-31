
-- Quantos pedidos foram realizados por cada cliente e qual foi o gasto total de suas compras?

SELECT IdClient, concat(Fname, ' ', Lname) as 'Cliente', count(IdOrderClient) as 'Quantidade de produtos Comprados', round(SUM(SendValue),2) as 'Valor Total Gasto'
FROM clients
INNER JOIN orders ON IdClient = IdOrderClient
GROUP BY Fname, Lname, IdClient
ORDER BY round(SUM(SendValue),2) desc;


-- Algum vendedor também é fornecedor?

SELECT seller.SocialName, seller.CNPJ, seller.location as Localização, seller.Contact as Contato
FROM seller 
INNER JOIN supplier on IdSupplier = IdSeller;


-- Relação de produtos fornecedores e estoques;

select * from productsupplier;
select * from storagelocation;

SELECT IdPsSupplier as IdFornecedor, Pname as 'Nome do produto', category as Categorias, quantity as Quantidade, Location as Localização
FROM product
INNER JOIN productsupplier on IdPsProduct = IdProduct
INNER JOIN storagelocation ON IdLproduct = IdProduct
ORDER BY IdFornecedor;


-- Relação de nomes dos fornecedores e nomes dos produtos

SELECT SocialName as 'Nome Social', Pname as 'Produto', category as 'Categoria', Avaliation 'Avaliação do produto'
FROM product
INNER JOIN productsupplier on IdPsProduct = IdProduct
INNER JOIN supplier on IdPsSupplier = IdSupplier;


-- Qual o status de cada pedido feito pelos cliente e como eles podem acompanha-los

SELECT concat(Fname, ' ', Lname) as 'Cliente', Pname as 'Produto',OrderStatus as 'Status do Pedido', TrackerCode as 'Código de Rastreio'
FROM clients
INNER JOIN orders ON IdClient = IdOrderClient
INNER JOIN productOrder ON IdPOorder = IdOrder 
INNER JOIN product ON IdPOproduct = IdProduct
INNER JOIN delivery ON IdDelivery = TrackerCode
ORDER BY Cliente;


-- Como foi realizado o pagamento de cada produto

SELECT concat(Fname, ' ', Lname) as 'Cliente', Pname as 'Produto Comprado', typePayment as 'Forma de pagamento', 
SecondTypePayment as 'Segundo Tipo de pagamento', OrderValue as 'Valor Gasto', limitAvailable as 'Limite de Gasto'
FROM clients
INNER JOIN payments ON IdPayerClient = IdClient
INNER JOIN orders ON IdClient = IdOrderClient
INNER JOIN productOrder ON IdPOorder = IdOrder 
INNER JOIN product ON IdPOproduct = IdProduct
ORDER BY Cliente; 


-- Quais foram os produtos mais comprados/bem avaliados e quais geraram um maior Rendimento

select * from product;
SELECT IdProduct, Pname as 'Produtos', SUM(POquantity) as 'Quantidades vendidas', 
round(Sum(SendValue)/SUM(POquantity),3) as 'Valor unitário' , round(Sum(SendValue),2) as 'Valor total das Vendas', 
Avaliation as 'Avaliação do publico'
FROM orders
INNER JOIN productOrder ON IdPOorder = IdOrder
INNER JOIN product ON IdPOproduct = IdProduct
GROUP BY Produtos, Avaliation, IdProduct
ORDER BY SUM(POquantity) desc;


-- Qual categoria mais trouxe rendimentos

SELECT category as Categorias, round(sum(SendValue),2) as 'Valor total das Vendas'
FROM product
INNER JOIN productOrder	ON IdPOproduct = IdProduct
INNER JOIN orders ON IdPOorder = IdOrder
GROUP BY Categorias
ORDER BY round(sum(SendValue),2) desc;
