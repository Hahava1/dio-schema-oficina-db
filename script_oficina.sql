-- Criação de Tabelas

CREATE TABLE Cliente (
    idCliente INT PRIMARY KEY,
    nome VARCHAR(100),
    telefone VARCHAR(20),
    endereco VARCHAR(150)
);

CREATE TABLE Veiculo (
    idVeiculo INT PRIMARY KEY,
    placa VARCHAR(10) UNIQUE,
    modelo VARCHAR(50),
    marca VARCHAR(50),
    ano INT,
    idCliente INT,
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

CREATE TABLE Equipe (
    idEquipe INT PRIMARY KEY,
    nomeEquipe VARCHAR(100)
);

CREATE TABLE Mecanico (
    idMecanico INT PRIMARY KEY,
    nome VARCHAR(100),
    endereco VARCHAR(150),
    especialidade VARCHAR(100),
    idEquipe INT,
    FOREIGN KEY (idEquipe) REFERENCES Equipe(idEquipe)
);

CREATE TABLE OrdemServico (
    idOrdemServico INT PRIMARY KEY,
    data_emissao DATE,
    data_conclusao DATE,
    status VARCHAR(50),
    valor_total DECIMAL(10,2),
    idVeiculo INT,
    idEquipe INT,
    FOREIGN KEY (idVeiculo) REFERENCES Veiculo(idVeiculo),
    FOREIGN KEY (idEquipe) REFERENCES Equipe(idEquipe)
);

CREATE TABLE Servico (
    idServico INT PRIMARY KEY,
    descricao VARCHAR(150),
    valor_mao_obra DECIMAL(10,2)
);

CREATE TABLE Peca (
    idPeca INT PRIMARY KEY,
    nome VARCHAR(100),
    valor DECIMAL(10,2)
);

CREATE TABLE ServicoExecutado (
    idOrdemServico INT,
    idServico INT,
    quantidade INT,
    PRIMARY KEY (idOrdemServico, idServico),
    FOREIGN KEY (idOrdemServico) REFERENCES OrdemServico(idOrdemServico),
    FOREIGN KEY (idServico) REFERENCES Servico(idServico)
);

CREATE TABLE PecaUtilizada (
    idOrdemServico INT,
    idPeca INT,
    quantidade INT,
    PRIMARY KEY (idOrdemServico, idPeca),
    FOREIGN KEY (idOrdemServico) REFERENCES OrdemServico(idOrdemServico),
    FOREIGN KEY (idPeca) REFERENCES Peca(idPeca)
);

-- Inserção de dados para testes

INSERT INTO Cliente VALUES (1, 'João Silva', '1199999999', 'Rua A, 123');

INSERT INTO Veiculo VALUES (1, 'ABC1234', 'Gol', 'Volkswagen', 2015, 1);

INSERT INTO Equipe VALUES (1, 'Equipe Alpha');

INSERT INTO Mecanico VALUES (1, 'Carlos Souza', 'Rua B, 456', 'Suspensão', 1);

INSERT INTO Servico VALUES (1, 'Troca de óleo', 80.00);
INSERT INTO Servico VALUES (2, 'Alinhamento', 120.00);

INSERT INTO Peca VALUES (1, 'Filtro de óleo', 30.00);
INSERT INTO Peca VALUES (2, 'Parafuso', 5.00);

INSERT INTO OrdemServico VALUES (1, '2025-04-10', '2025-04-12', 'Concluído', 235.00, 1, 1);

INSERT INTO ServicoExecutado VALUES (1, 1, 1);
INSERT INTO PecaUtilizada VALUES (1, 1, 1);
INSERT INTO PecaUtilizada VALUES (1, 2, 3);

-- Consultas SQL

-- 1. Select simples
-- Quem são os clientes cadastrados na oficina e seus respectivos contatos?
SELECT nome, telefone FROM Cliente;

-- 2. WHERE
-- Quais ordens de serviço já foram concluídas?
SELECT * FROM OrdemServico WHERE status = 'Concluído';

-- 3. Atributo derivado
-- Qual o valor total de mão de obra aplicada em cada ordem de serviço?
SELECT 
    se.idOrdemServico,
    s.descricao,
    se.quantidade,
    s.valor_mao_obra,
    (se.quantidade * s.valor_mao_obra) AS total_servico
FROM ServicoExecutado se
JOIN Servico s ON se.idServico = s.idServico;

-- 4. ORDER BY
-- Quais são as ordens de serviço mais recentes?
SELECT * FROM OrdemServico ORDER BY data_emissao DESC;

-- 5. HAVING
-- Quais ordens de serviço possuem custo de mão de obra superior a R$ 100,00?
SELECT 
    os.idOrdemServico,
    SUM(se.quantidade * s.valor_mao_obra) AS total_mao_obra
FROM OrdemServico os
JOIN ServicoExecutado se ON os.idOrdemServico = se.idOrdemServico
JOIN Servico s ON se.idServico = s.idServico
GROUP BY os.idOrdemServico
HAVING SUM(se.quantidade * s.valor_mao_obra) > 100;

-- 6. JOINs complexos
-- Quais clientes fizeram ordens de serviço, qual veículo levaram, e qual equipe executou os serviços?
SELECT 
    c.nome AS cliente,
    v.modelo AS veiculo,
    os.idOrdemServico,
    e.nomeEquipe,
    os.status,
    os.valor_total
FROM Cliente c
JOIN Veiculo v ON c.idCliente = v.idCliente
JOIN OrdemServico os ON os.idVeiculo = v.idVeiculo
JOIN Equipe e ON e.idEquipe = os.idEquipe;