use ecommerce;

insert into clients (Fname, Minit, Lname, CPF, Bdate, Address, NumAccount)
					values ('Ingrid', 'B', 'Salvadora', 12242567855, '2005-01-19', 'Rua das Flores', '1202509-2'),
							('Rafael', 'D', 'Golçalvez', 22342267864, '1985-05-10', 'Barra da Tijuca', '60684352-2'),
                            ('Gabriel', 'M', 'Smith', 32312567832, '2000-08-09', 'Tijuca', '01860-4'),
                            ('João', 'B', 'Medeiros', 12345567832, '1998-01-22', 'Alto da Boa Vista', '0109589-7'),
                            ('Julia', 'F', 'Flores', 90056921039, '2001-05-05', 'Ipanema', '189062-X'),
                            ('Fernando', 'G', 'Madeira', 22860671048, '1955-08-28', 'Caxias', '02688-5'),
                            ('Carlos', 'L', 'Medeiras', 93902053011, '1950-08-10', 'Tijuca', '0504372-7');
                          
select * from clientaccount;
insert into clientaccount (IdClientAccount, AccountType)
					values ('1202509-2', 'PF'),
						   ('60684352-2', 'PF'),
                           ('01860-4', 'PJ'),
                           ('0109589-7', 'PF'),
                           ('189062-X', 'PJ'),
                           ('02688-5', 'PF'),
                           ('0504372-7', 'PF');

select * from orders;
insert into orders (IdOrderClient, OrderStatus, OrderDescription, SendValue) 
			values (1, default, 'compra via aplicativo', 2000),
				   (1, default, 'compra via aplicativo', 29.99),
                   (2, 'Confirmado', null, 59.99),
                   (2, default, 'compra via web site', 150),
                   (2, default, 'compra via aplicativo', 200),
				   (3, default, 'compra via aplicativo', 2999.99),
                   (4, 'Confirmado', null, 39.99),
                   (4, default, 'compra via web site', 119.99),
                   (4, default, 'compra via web site', 149.99),
                   (5, default, 'compra via aplicativo', 2),
				   (5, default, 'compra via aplicativo', 199.99),
                   (6, 'Confirmado', null, 79.99),
                   (6,  'Confirmado', 'compra via web site', 99.99),
                   (7,  'Confirmado', 'compra via aplicativo', 100);  
                   
                   
SET SQL_SAFE_UPDATES = 0;
update orders set SendValue = 
	case
		when IdOrder = 4 then SendValue - 141
        when IdOrder = 3 then SendValue + 200
        when IdOrder = 7 then SendValue + 200
        else SendValue + 0
    end;
    

select * from payments;
insert into payments (IdPayerClient, IdPayment, typePayment, SecondTypePayment, OrderValue, limitAvailable) 
			values (1, 1, 'Pix', null, 2000, default),
                   (1, 2, 'Pix', null, 29.99, default),
				   (2, 3, 'Boleto', 'Cartão', 59.99, default),
                   (7, 4, 'Boleto', 'Cartão', 150, default),
                   (7, 5, 'Boleto', 'Cartão', 200, default),
                   (3, 6, 'Cartão', null, 2999.99, 3000),
                   (4, 7, 'Cartão', null, 39.99, 5000),
                   (5, 8, 'Cartão', null, 119.99, 5000),
                   (6, 9, 'Cartão', null, 149.99, 5000);                 


update payments set OrderValue = 
	case
		when IdPayment = 4 then OrderValue - 141
        else OrderValue + 0
    end;



select * from product;
insert into product (Pname, Classification_kids, category, Avaliation, size) 
			values ('Fones de Ouvido', false, 'Eletrônicos', 3.2, null),
				   ('Armário', false, 'Móveis', 4 , null),
                   ('Estante', false, 'Móveis', 2 , null),
                   ('Fandangos', false, 'Alimentos', 3 ,null),
                   ('Max Steel', true, 'Brinquedos', 5 ,null); 
                   

select * from productOrder;
insert into productOrder (IdPOproduct, IdPOorder, POquantity, POstatus, TrackerCode) 
			values (1, 1, 2, default,  '67253S6G1'),
				   (2, 2, 5, 'Sem estoque', '3283L4D37'),
                   (3, 3, 4, default, '533199663'),
                   (4, 4, 1, default, '44G595817'),
                   (1, 5, 1, default, '37S54A548'),
                   (2, 6, 1, default, '57S85D196'),
                   (3, 7, 1, default, '25A394H74'),
                   (5, 8, 1, default, '783G81D28'),
                   (5, 9, 1, default, '1759X89A9'); 
	
insert into delivery (IdDelivery, DeliveryStatus) 
			values ('67253S6G1', default),
				   ('3283L4D37', 'Em trânsito'),
                   ('533199663', default),
                   ('44G595817', default),
                   ('37S54A548', default),
                   ('57S85D196', 'Em trânsito'),
                   ('25A394H74', 'Em trânsito'),
                   ('783G81D28', 'Entregue'),
                   ('1759X89A9', default); 
                   
insert into productStorage (StorageLocation, Quantity)
			values ('Rio de Janeiro', 1000),
				   ('Rio de Janeiro', 500),
                   ('Rio de Janeiro', 2500),
                   ('São Paulo', 200),
                   ('São Paulo', 400);

insert into storageLocation (IdLproduct, IdLstorage, location)
			values (1, 1, 'RJ'),
				   (2, 1, 'RJ'),
                   (3, 1, 'RJ'),
                   (4, 2, 'SP'),
                   (5, 2, 'SP');

select * from supplier;
insert into supplier (SocialName, CNPJ, Contact)
			values ('Almeida e filhos',51169823000186, 21999999999),
				   ('Eletrônicos Vila',65236585000199, 21888888888),
                   ('Maniacos por celular',60353389000180, 21777777777),
                   ('Dona zezita',09786362000124, 21666666666);
              
select * from productSupplier;
insert into productSupplier (IdPsSupplier, IdPsProduct, Quantity)
			values (1, 1, 500),
				   (1, 2, 1500),
                   (3, 4, 132),
                   (2, 3, 349),
                   (1, 5, 664),
                   (4, 5, 100);

select * from seller;
insert into seller (SocialName, FantasyName, CNPJ, CPF, location, Contact)
					values ('UsadasRoupa', 'Salvadora da pátria', 68359579000117, 89778833001, 'Rio de Janeiro', 21999999999),
							('RoupasLivres', 'Golçalvez do bom', 40826517000159 , 81733972013, 'São Paulo', 21888888888),
                            ('Kids worlds', 'Fernandinho', 58757439000143 , 76204529072, 'Rio de Janeiro', 21777777777),
                            ('Techmatter', null, 85822030000136 , 55143165059, 'Rio de Janeiro', 21666666666),
                            ('Tecnologicos', null, 59489682000190 , 46466388000, 'São Paulo', 21555555555),
                            ('Mobiliaria', 'Chama na mobilia', 57545827000106 , 87947328099, 'Rio de Janeiro', 21444444444),
                            ('Tech eletronics', 'Silvinha', 12065324000197 , 30797388028, 'Rio de Janeiro', 21333333333);


                   
select * from productSeller;
insert into productSeller (IdPseller, IdPproduct, ProdQuantity)
			values (1, 1, 500),
				   (1, 2, 1500),
                   (3, 4, 132),
                   (2, 3, 349),
                   (2, 5, 664);


