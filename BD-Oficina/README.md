# Projeto de banco de dados para uma Oficina Mecânica

## Objetivo:

 - Criar o esquema conceitual para o contexto de oficina com base na narrativa fornecida
 - para atender o objetivo, passaremos desde a ideia inicial com uma visão de alto nível, ou seja, a implementação de um **Modelo de Dados Conceitual**, onde aplicaremos o método de **Modelagem EER** para fazer a modelagem do diagrama do banco de dados e posteriormente a implementação do **Modelo Representacional**, no qual, utilizando o aprendizado em linguagem **SQL**, implementaremos o modelo lógico utilizando o SGBD **MySQL** para estruturar e abrigar o nosso banco de dados.

## Proposta:

### Narrativa:

 - Sistema de controle e gerenciamento de execução de ordens de serviço em uma oficina mecânica;
 - Clientes levam veículos à oficina mecânica para serem consertados ou para passarem por revisões  periódicas;
 - Cada veículo é designado a uma equipe de mecânicos que identifica os serviços a serem executados e preenche uma OS com data de entrega;
 - A partir da OS, calcula-se o valor de cada serviço, consultando-se uma tabela de referência de mão-de-obra;
 - O valor de cada peça também irá compor a OSO cliente autoriza a execução dos serviços;
 - A mesma equipe avalia e executa os serviços;
 - Os mecânicos possuem código, nome, endereço e especialidade;
 - Cada OS possui: n°, data de emissão, um valor, status e uma data para conclusão dos trabalho;


### Construção do raciocício:

Para atender o desafio, realizei uma análise prelimitar para definir as primeiras entidades e as instancias obrigatórias propostas no desafio. Nessa primeira análise cheguei às seguintes conclusões:

 - **Estrutura pré-modelada:**

    - **Ordem de Serviço**
        - n° da OS
        - Data de emissão
        - Valor
        - Status
        - Data de Conclusão
    - **Cliente**
    - **Veículo**
    - **Triagem**
        - Orçamento
        - Concerto
        - Revisão
    - **Funcionários**
        - Mecanicos
            - código
            - nome
            - endereço
            - especialidade
        - Financeiro

A partir dai foi realizado o estudo do case, onde eu analizei todos os dados fornecidos e cheguei ao esquema de alto nível, o primeiro **modelo de dados conceitual**.

Durante a modelagem foi pensado nas seguintes informações que decidi como sendo importantes:

 - Já em **clientes**, tanto funcionários, quanto fornecedores também podem ser clientes, para isso, foi criado a entidade **pessoas**, para que viabilize a conversão de um perfil em outro;
 - Em relação ao **veículo**, vi a necessidade de criar uma entidade que faça a **classificação** do veículo;
 - A **triagem** será feita pela entidade **serviço** e direcionada à um ordem de serviço, que por sua vez, pode conter mais de um serviço;
 - Para os funcionários, criei uma entidade que classifica os mesmos por seu setor, função e especialidade, pois um mesmo funcionário pode ser do setor "oficina", pode ter a função de "mecanico", mas ser especialista em "hidraulica" e gerenciar essa área, por exemplo.
 - Uma oficina mecânica realiza além de orçamentos, manutenções e serviços, a **venda de produtos** automotivos;
 - Para atender essa necessidade foi criado conexões que permitem tanto a **compra/venda direta dos produtos**, como a **utilização** dos mesmos **nas ordens de serviços**;

Com isso cheguei em um escopo de projeto, utilizando a ferramenta **MySQL Workbench 8.0 CE** para tal, e o resultado encontra-se nos arquivos abaixo:

 - [Arquivo em pdf](https://github.com/AndersonGabrielCalasans/Projetos-DataBaseExperienceBootcamp-DIO/blob/main/BD-Oficina/Diagrama-Oficina-Mecanica.pdf) para visualização do Diagrama entidade relacionamento estendido, sem precisar baixar o modelo;

 - [Diagrama versão para download aqui.](https://github.com/AndersonGabrielCalasans/Projetos-DataBaseExperienceBootcamp-DIO/blob/main/BD-Oficina/Diagrama-Oficina-Mecanica.mwb)

Posteriormente estarei realizando a implementação do banco de dados em lógica de programação em SQL e testando o mesmo para realizar ajustes e correções caso seja necessário.

## Modelo lógico:

Na segunda etapa do projeto, criei a lógica das tabelas em linguagem SQL, seguindo o modelo relacional já estabelecido atribuindo alguns ajustes conforme achei necessário. A maior parte dos ajustes realizados foi na questão de tratamento da variável, na maiooria das vezes, trocando o tipo de informação que a varável irá receber, no mais, a principio o modelo de banco de dados criado atende ao objetivo imposto.

O resultado do código que escrevi para persistir o banco de dados proposto você pode observar [clicando aqui]().

## Persistindo e recuperando dados a partir de Consultas SQL no Banco de Dados:

A fim de testar se o banco de dados encontra-se funcional e útil, persisti alguns dados fictícios e realizei algumas queries para testá-lo.

O arquivo onde pode ser encontrado os dados persistidos é [esse aqui](), já o arquivo que encontram-se as queries [está aqui]().

A partir dos dados persistidos, realizamos queries para atender aos requisitos impostos no desafio, como forma de aprendizado a fazer consultas à bancos de dados com o MySQL. As queries tem que apresentar:

 - Recuperações simples com SELECT Statement
 - Filtros com WHERE Statement
 - Crie expressões para gerar atributos derivados
 - Defina ordenações dos dados com ORDER BY
 - Condições de filtros aos grupos – HAVING Statement
 - Crie junções entre tabelas para fornecer uma perspectiva mais complexa dos dados

 