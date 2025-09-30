CREATE DATABASE SPRINT2;
USE SPRINT2;

/* TIPO DE ATRIBUTOS 
MONOVALORADOS: 
	Um valor.
MULTIVALORADOS: 
	Um registro que possui dois valores de mesma natureza deve salvá-los em colunas diferentes.
		Exemplo: 
			Se meu usuário possuir telefone celular e telefone fixo, eles devem ser salvos em colunas diferente.
            O correto é haver colunas telefoneCel e telefoneFixo, onde cada um armazena um valor.
            É INCORRETO salvar em uma mesma coluna algo como '11989878785, 11995566332'.
            A partir do momento que isso ultrapassa o número de 3 colunas, deve virar uma nova tabela.
SIMPLES:
    Atributo simples seria segregar o endereço em colunas de rua, bairro, cep etc.
COMPOSTO:
	Endereço é um atributo composto, pois contém nome de rua, bairro, cidade, estado, país e etc.
DERIVADO:
	Idade é derivado pois é a subtração da data atual pela data de nascimento.
*/

-- ENTIDADE FORTE: NÃO DEPENDE DE NINGUÉM
CREATE TABLE FUNCIONARIO (
	ID_FUNCIONARIO INT PRIMARY KEY AUTO_INCREMENT,
    FK_SUPERVISOR INT,
    NOME VARCHAR(45) NOT NULL,
    SOBRENOME VARCHAR(45),
    BAIRRO VARCHAR(45),
    CEP CHAR(9),
    SALARIO DECIMAL(6,2),
    CONSTRAINT FUNCIONARIO_SUPERVISOR 
		FOREIGN KEY (FK_SUPERVISOR) REFERENCES FUNCIONARIO(ID_FUNCIONARIO)
);

INSERT INTO FUNCIONARIO (NOME, FK_SUPERVISOR) VALUES 
	('Tio Patinhas', null),
	('Huguinho', 1),
	('Zezinho', 1),
	('Luizinho', 1);

SELECT * FROM FUNCIONARIO;

SELECT 
    FUNC.NOME AS 'Funcionário', SUP.NOME AS 'Supervisor'
FROM
    FUNCIONARIO FUNC
        JOIN
    FUNCIONARIO SUP ON FUNC.FK_SUPERVISOR = SUP.ID_FUNCIONARIO;

-- ENTIDADE FRACA: DEPENDE DE OUTRA TABELA PARA EXISTIR
CREATE TABLE DEPENDENTE (
	CONSTRAINT PK_DEPENDENTE_FUNCIONARIO PRIMARY KEY (ID_DEPENDENTE, FK_FUNCIONARIO),
	ID_DEPENDENTE INT NOT NULL,
    FK_FUNCIONARIO INT NOT NULL,
    NOME VARCHAR(45) NOT NULL,
    DT_NASC DATE,
    PARENTESCO VARCHAR(45),
    TELEFONE_CELULAR CHAR(11),
    TELEFONE_FIXO CHAR(10),
    CONSTRAINT FK_DEPENDENTE_FUNCIONARIO 
		FOREIGN KEY (FK_FUNCIONARIO) REFERENCES FUNCIONARIO(ID_FUNCIONARIO)
);

INSERT INTO DEPENDENTE (NOME, PARENTESCO, ID_DEPENDENTE, FK_FUNCIONARIO) VALUES 
	('Tia Patinhas', 'Esposa', 1, 1),
	('Prima Patinhas', 'Prima', 2, 1),
	('Zezinha', 'Irmã', 1, 3),
	('Luizinha', 'Irmã', 1, 4);
    
SELECT 
    F.NOME AS 'Funcionário',
    S.NOME AS 'Supervisor',
    D.NOME AS 'Dependente',
    D.PARENTESCO AS 'Parentesco'
FROM
    FUNCIONARIO F
        LEFT JOIN
    FUNCIONARIO S ON F.FK_SUPERVISOR = S.ID_FUNCIONARIO
        LEFT JOIN
    DEPENDENTE D ON F.ID_FUNCIONARIO = D.FK_FUNCIONARIO

