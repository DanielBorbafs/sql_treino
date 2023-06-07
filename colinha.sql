/* Utilizando triggers  */ 
 
 CREATE TABLE USUARIO(
     IDUSUARIO INT PRIMARY KEY AUTO_INCREMENT,
     NOME VARCHAR(30), 
     SENHA VARCHAR(100)
  );
  
 /* toda vez que um usuario for apagado na tabela usuario fazer um backup automaticamente */
 
 DELIMITER $

CREATE TRIGGER BACKUP_USER
BEFORE DELETE ON USUARIO
FOR EACH ROW
BEGIN
	INSERT INTO BKP_USUARIO VALUES
	(NULL,OLD.IDUSUARIO,OLD.NOME,OLD.LOGIN);
END
$
INSERT INTO USUARIO VALUES(NULL,'DANIEL','DAN777', '123456');

DELETE FROM USUARIO WHERE IDUSUARIO = 1;

delimiter ;



/*Comunicacao entre bancos */

CREATE DATABASE LOJA;

USE LOJA;

CREATE TABLE PRODUTO (
	IDPRODUTO INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30),
	VALOR FLOAT (10,2)
);


CREATE DATABASE BACKUP;

USE BACKUP;


CREATE TABLE BKP_PRODUTO (
	IDBKP INT PRIMARY KEY AUTO_INCREMENT,
	IDPRODUTO INT,
	NOME VARCHAR(30),
	VALOR FLOAT (10,2)
);


USE LOJA;

INSERT INTO BACKUP.BKP_PRODUTO VALUES(NULL, 1000, 'TESTE', 0.2);

DELIMITER $ 

CREATE TRIGGER BACKUP_PRODUT
BEFORE INSERT ON PRODUTO
FOR EACH ROW 
BEGIN
	
	INSERT INTO BACKUP.BKP_PRODUTO VALUES(NULL,NEW.IDPRODUTO,
		NEW.NOME, NEW.VALOR);

END

$

DELIMITER ;

INSERT INTO PRODUTO VALUES(NULL,'LIVRO MODELAGEM',50.00);
INSERT INTO PRODUTO VALUES(NULL,'LIVRO sql',10.00);
INSERT INTO PRODUTO VALUES(NULL,'JAVASCRIPT MISTERY',80.10);

SELECT  * FROM BACKUP.BKP_PRODUTO;


/* TRIGGER PARA QUANDO DELETAR UM PRODUTO ELE TAMBÉM IR PARA O BANCO DE BACKUP */

USE LOJA;

DELIMITER $

CREATE TRIGGER BACKUP_PRODUTO_DEL
BEFORE DELETE ON PRODUTO
FOR EACH ROW 
BEGIN
	
	 INSERT INTO BACKUP.BKP_PRODUTO VALUES(NULL,OLD.IDPRODUTO,
		OLD.NOME, OLD.VALOR);

END

$

DELIMITER ;


DROP TRIGGER BACKUP_PRODUT;

/* CORREÇÃO DA TRIGGER, PORQUE A ANTERIOR NAO ESTAVA PUXANDO O IDPRODUTO, ESTAVA VINDO TODOS  COM '0' */

DELIMITER $ 

CREATE TRIGGER BACKUP_PRODUT
AFTER INSERT ON PRODUTO
FOR EACH ROW 
BEGIN
	
	INSERT INTO BACKUP.BKP_PRODUTO VALUES(NULL,NEW.IDPRODUTO,
		NEW.NOME, NEW.VALOR);

END

$

DELIMITER ;
