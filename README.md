# Projeto de Banco de Dados - Oficina Mecânica

Este projeto modela o banco de dados para um sistema de controle e gerenciamento de ordens de serviço (OS) em uma oficina mecânica.

## Objetivo

- Controlar clientes, veículos e ordens de serviço.
- Associar ordens a equipes e mecânicos.
- Registrar peças utilizadas e serviços executados.
- Permitir consultas analíticas e operacionais sobre os dados da oficina.

## Estrutura do Banco de Dados

- **Cliente**: Dados dos proprietários dos veículos.
- **Veiculo**: Cada veículo pertence a um cliente.
- **OrdemServico**: Ordem emitida para manutenção/revisão do veículo.
- **Equipe**: Responsável por executar a OS.
- **Mecanico**: Trabalha em uma equipe e tem especialidade.
- **Servico**: Cadastro de tipos de serviços e seus valores.
- **Peca**: Cadastro de peças e seus valores.
- **ServicoExecutado**: Serviços aplicados a uma OS.
- **PecaUtilizada**: Peças utilizadas em uma OS.

## Queries SQL Demonstrativas

- Filtros com WHERE
- Atributos derivados com expressões
- Ordenação com ORDER BY
- Agrupamento com GROUP BY e HAVING
- Junções entre múltiplas tabelas


## Perguntas respondidas pelas consultas SQL

1. **Quem são os clientes cadastrados na oficina e seus respectivos contatos?**  
2. **Quais ordens de serviço já foram concluídas?**  
3. **Qual o valor total de mão de obra aplicada em cada ordem de serviço?**  
4. **Quais são as ordens de serviço mais recentes?**  
5. **Quais ordens de serviço possuem custo de mão de obra superior a R$ 100,00?**  
6. **Quais clientes fizeram ordens de serviço, qual veículo levaram, e qual equipe executou os serviços?**  
