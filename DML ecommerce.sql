CREATE DATABASE IF NOT EXISTS ecommerce;
use ecommerce;

CREATE TABLE clients (
  IdClient int NOT NULL AUTO_INCREMENT,
  Fname varchar(10) DEFAULT NULL,
  Minit varchar(3) DEFAULT NULL,
  Lname varchar(20) NOT NULL,
  CPF char(11) NOT NULL,
  Address varchar(40) DEFAULT NULL,
  Bdate date DEFAULT NULL,
  NumAccount varchar(13),
  PRIMARY KEY (IdClient),
  UNIQUE KEY unique_cpf_client (CPF),
  UNIQUE KEY unique_account_client (NumAccount)
);

alter table clients auto_increment=1;

CREATE TABLE clientAccount(
	IdClientAccount varchar(13) NOT NULL,
    AccountType ENUM('PF', 'PJ') NOT NULL,
    CONSTRAINT fk_account_client FOREIGN KEY (IdClientAccount) REFERENCES clients (NumAccount),
    UNIQUE KEY unique_account (IdClientAccount)
);

CREATE TABLE orders (
  IdOrder int NOT NULL AUTO_INCREMENT,
  IdOrderClient int DEFAULT NULL,
  OrderStatus enum('Preparando pedido','Confirmado','Cancelado') DEFAULT 'Preparando pedido',
  OrderDescription varchar(255) DEFAULT NULL,
  SendValue float NOT NULL,
  PRIMARY KEY (IdOrder),
  KEY fk_orders_client (IdOrderClient),
  KEY fk_value_order (SendValue),
  CONSTRAINT fk_orders_client FOREIGN KEY (IdOrderClient) REFERENCES clients (IdClient)
);

alter table orders auto_increment=1;

CREATE TABLE payments (
  IdPayerClient int NOT NULL,
  IdPayment int NOT NULL,
  typePayment enum('Boleto','Cartão','Dois cartões','Pix') NOT NULL,
  SecondTypePayment enum('Boleto','Cartão','Dois cartões','Pix') default null,
  OrderValue float NOT NULL,
  limitAvailable float DEFAULT NULL,   
  PRIMARY KEY (IdPayerClient, IdPayment),
  CONSTRAINT fk_payments_client FOREIGN KEY (IdPayerClient) REFERENCES clients (IdClient),
  CONSTRAINT fk_payments_order FOREIGN KEY (IdPayment) REFERENCES orders (IdOrder),
  CHECK (limitAvailable >= OrderValue)
);

alter table payments auto_increment=1;

 CREATE TABLE product (
  IdProduct int NOT NULL AUTO_INCREMENT,
  Pname varchar(45) DEFAULT NULL,
  classification_kids BOOLEAN DEFAULT '0',
  category enum('Eletrônicos','Vestimenta','Brinquedos','Alimentos','Móveis') NOT NULL,
  Avaliation float DEFAULT 0,
  size varchar(11) DEFAULT NULL,
  PRIMARY KEY (IdProduct)
);

alter table product auto_increment=1;

CREATE TABLE productOrder (
  IdPOproduct int NOT NULL,
  IdPOorder int NOT NULL,
  POquantity int DEFAULT (1),
  POstatus enum('Disponível','Sem estoque') DEFAULT 'Disponível',
  TrackerCode char(10) NOT NULL,
  PRIMARY KEY (IdPOproduct, IdPOorder),
  KEY fk_product_order_product (IdPOorder),
  CONSTRAINT fk_product_order_product FOREIGN KEY (IdPOorder) REFERENCES orders (IdOrder),
  CONSTRAINT fk_product_order_seller FOREIGN KEY (IdPOproduct) REFERENCES product (IdProduct),
  UNIQUE KEY unique_tracker_code (TrackerCode)
);

CREATE TABLE delivery(
	IdDelivery char(10) NOT NULL,
    DeliveryStatus enum('Aguardando coleta do pedido', 'Em trânsito', 'Entregue') DEFAULT 'Aguardando coleta do pedido',
    CONSTRAINT fk_tracking FOREIGN KEY (IdDelivery) REFERENCES productOrder (TrackerCode)
);

 CREATE TABLE seller (
  IdSeller int NOT NULL AUTO_INCREMENT,
  SocialName varchar(200) NOT NULL,
  FantasyName varchar(45) DEFAULT NULL,
  CNPJ char(14) NOT NULL,
  CPF char(11) NOT NULL,
  location varchar(255) DEFAULT NULL,
  Contact char(11) NOT NULL,
  PRIMARY KEY (IdSeller),
  UNIQUE KEY unique_cnpj_seller (CNPJ),
  UNIQUE KEY unique_cpf_client (CPF)
);

alter table seller auto_increment=1;

CREATE TABLE productseller (
  IdPseller int NOT NULL,
  IdPproduct int NOT NULL,
  ProdQuantity int DEFAULT 1,
  PRIMARY KEY (IdPseller,IdPproduct),
  KEY fk_product_product (IdPproduct),
  CONSTRAINT fk_product_product FOREIGN KEY (IdPproduct) REFERENCES product (IdProduct),
  CONSTRAINT fk_product_seller FOREIGN KEY (IdPseller) REFERENCES seller (IdSeller)
);

CREATE TABLE productstorage (
  IdProdStorage int NOT NULL AUTO_INCREMENT,
  StorageLocation varchar(225) DEFAULT NULL,
  Quantity int DEFAULT 0,
  PRIMARY KEY (IdProdStorage)
);

alter table productstorage auto_increment=1;

CREATE TABLE supplier (
  IdSupplier int NOT NULL AUTO_INCREMENT,
  SocialName varchar(255) NOT NULL,
  CNPJ char(14) NOT NULL,
  Contact char(11) NOT NULL,
  PRIMARY KEY (IdSupplier),
  UNIQUE KEY unique_supplier (CNPJ)
);

alter table supplier auto_increment=1;

CREATE TABLE productsupplier (
  IdPsSupplier int NOT NULL,
  IdPsProduct int NOT NULL,
  quantity int NOT NULL,
  PRIMARY KEY (IdPsSupplier, IdPsProduct),
  KEY fk_product_supplier_product (IdPsProduct),
  CONSTRAINT fk_product_supplier_product FOREIGN KEY (IdPsProduct) REFERENCES product (IdProduct),
  CONSTRAINT fk_product_supplier_supplier FOREIGN KEY (IdPsSupplier) REFERENCES supplier (IdSupplier)
);

CREATE TABLE storagelocation (
  IdLproduct int NOT NULL,
  IdLstorage int NOT NULL,
  Location varchar(255) NOT NULL,
  PRIMARY KEY (IdLproduct, IdLstorage),
  KEY fk_storage_location_product (IdLstorage),
  CONSTRAINT fk_storage_location_product FOREIGN KEY (IdLstorage) REFERENCES productstorage (IdProdStorage),
  CONSTRAINT fk_storage_location_seller FOREIGN KEY (IdLproduct) REFERENCES product (IdProduct)
);

show tables;
