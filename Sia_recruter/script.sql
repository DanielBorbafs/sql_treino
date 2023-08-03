

/* Criando as tabelas */ 

CREATE TABLE FUNCIONARIO (
	IDFUNCIONARIO INT PRIMARY KEY IDENTITY,
	NOME VARCHAR(60),
	IDADE VARCHAR(3),
	EMAIL VARCHAR(40),
	DATA_ADM DATE,
	IDCARGO INT,
	IDENDERECO INT,
	IDTELEFONE INT
)
GO

CREATE TABLE CARGO (
	IDCARGO INT PRIMARY KEY IDENTITY,
	NOMECARGO VARCHAR(30),
	SALARIO MONEY
)
GO

CREATE TABLE ENDERECO (
	IDENDERECO INT PRIMARY KEY IDENTITY,
	ESTADO CHAR(2),
	BAIRRO VARCHAR(30),
	RUA VARCHAR(40),
	NUMERO VARCHAR(5)
)
GO


CREATE TABLE TELEFONE(
	IDTELEFONE INT PRIMARY KEY IDENTITY,
	NUMERO VARCHAR(20),
	TIPO CHAR(3)
)
GO

-- ATRIBUINDO AS FK--
ALTER TABLE FUNCIONARIO
ADD CONSTRAINT FK_CARGO_FUNCIONARIO
FOREIGN KEY(IDCARGO)
REFERENCES CARGO(IDCARGO)
GO

ALTER TABLE FUNCIONARIO
ADD CONSTRAINT FK_ENDERECO_FUNCIONARIO
FOREIGN KEY(IDENDERECO)
REFERENCES ENDERECO(IDENDERECO)
GO

ALTER TABLE FUNCIONARIO
ADD CONSTRAINT FK_TELEFONE_FUNCIONARIO
FOREIGN KEY (IDTELEFONE)
REFERENCES TELEFONE(IDTELEFONE)
GO

-- CORRIGINDO ALGUNS CAMPOS
ALTER TABLE FUNCIONARIO
ALTER COLUMN IDADE INT
GO

-- !!ADICIONANDO RESTRICOES!! --

-- EMAIL SER UNICO E NAO PODER SE REPETIR
ALTER TABLE FUNCIONARIO
ADD CONSTRAINT UQ_EMAIL_UNIQUE
UNIQUE (EMAIL)
GO

-- TIPO DO TELEFONE (COMERCIAL) OU (RESIDENCIAL)
ALTER TABLE TELEFONE
ADD CONSTRAINT CHK_TIPO_TELEFONE
CHECK (TIPO IN ('COM', 'RES'));
GO

-- INSERINDO OS DADOS

INSERT INTO CARGO (NOMECARGO, SALARIO) VALUES ('Analista de Marketing', 2000.00);
INSERT INTO ENDERECO (ESTADO, BAIRRO, RUA, NUMERO) VALUES ('SP', 'Centro', 'Avenida Paulista', '100');
INSERT INTO TELEFONE (NUMERO, TIPO) VALUES ('(11) 98765-4321', 'COM');
INSERT INTO FUNCIONARIO (NOME, IDADE, EMAIL, DATA_ADM, IDCARGO, IDENDERECO, IDTELEFONE)
VALUES ('Maria Silva', 30, 'maria.silva@email.com', '2023-08-02', 1, 1, 1);
GO

/* ADICIONANDO TRIGGERS
TRIGGER 01 - QUANDO UM CARGO RECEBER UM AUMENTO SALARIAL , PRECISA FICAR REGISTRADO O HISTÓRICO. 
*/

CREATE TABLE HISTORICO_SALARIAL(
    IDHISTORICO INT PRIMARY KEY IDENTITY,
    IDCARGO INT,
    DATA_AUMENTO DATE,
    SALARIO_ANTERIOR MONEY,
    SALARIO_NOVO MONEY
)
GO

CREATE TRIGGER TR_AUMENTO_SALARIAL
ON CARGO
AFTER UPDATE
AS
BEGIN
    IF UPDATE(SALARIO)
    BEGIN
        DECLARE @DataAumento DATE, @SalarioAnterior MONEY, @SalarioNovo MONEY;

        SELECT @DataAumento = GETDATE();
        SELECT @SalarioAnterior = SALARIO FROM deleted;
        SELECT @SalarioNovo = SALARIO FROM inserted;

        INSERT INTO HISTORICO_SALARIAL (IDCARGO, DATA_AUMENTO, SALARIO_ANTERIOR, SALARIO_NOVO)
        SELECT IDCARGO, @DataAumento, @SalarioAnterior, @SalarioNovo
        FROM inserted;
    END;
END;
GO


-- TESTANDO
UPDATE CARGO
SET SALARIO = 5500.00
WHERE IDCARGO = 1
GO

