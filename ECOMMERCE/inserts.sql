-- INSERTS NA TABELA JOGOS 
INSERT INTO JOGOS VALUES('Gof of War: Ragnarok', 'Ação', 150, 44)
GO

-- INSERTS NA TABELA CLIENTES
INSERT INTO CLIENTES (CLIENTE_LOGIN, CLIENTE_SENHA, CLIENTE_NOME, EMAIL, DATA_ANIVERSARIO, SEXO)
VALUES ('DAN_BORBA027', HASHBYTES('SHA2_256', 'CODERUNNER1578'), 'DANIEL BORBA', 'DANIEL@GMAIL.COM', '2000-01-28', 'M')
GO

--INSERTS NA TABELA ENDERECO
INSERT INTO ENDERECO VALUES('ES', 'SERRA', 'AV.BRASILIO', '782', '28751123', 1)
GO

-- INSERTS NA TABELA ORDEM
INSERT INTO ORDEM (ORDEM_DATE, QUANTIDADE, VALOR_TOTAL, CLIENTE_ID, ID_JOGO)
VALUES ('2024-07-13', 1, 150, 1, 1);
GO

-- INSERTS NA TABELA PAGAMENTO
INSERT INTO PAGAMENTO VALUES('CREDITO', '2024/07/13', 2)
GO

--INSERTS NA TABELA AVALIACAO
INSERT INTO AVALIACAO VALUES ('O JOGO É MUITO BOM, UM DOS MELHORES QUE JA JOGUEI', '2024/07/16', 1,1)
GO
