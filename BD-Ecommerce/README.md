# Projeto de banco de dados para E-commerce

## Objetivo:

Nesse projeto passaremos desde a ideia inicial com uma visão de alto nível, ou seja, a implementação de um **Modelo de Dados Conceitual**, onde aplicaremos o método de **Modelagem EER** para fazer a modelagem do diagrama do banco de dados e posteriormente a implementação do **Modelo Representacional**, no qual, utilizando o aprendizado em linguagem **SQL**, implementaremos o modelo lógico utilizando o SGBD **MySQL** para estruturar e abrigar o nosso banco de dados.

## Proposta:

Uma empresa está se lançando no mercado online de vendas com venda de roupas e assesórios e precisa desenvolver um um banco de dados para o seu e-commerce que atenda às suas necessidades, para isso foi passado pelo contratante que no banco de dados criado, devemos seguir obrigatoriamente os requisitos listados abaixo:

#### Narrativa - Produtos:

- Os produtos são vendidos por uma única plataforma online;
- Os produtos podem ter vendedores distintos (terceiros);
- Cada produto possui um fornecedor;
- Um ou mais produtos podem compor um pedido.

#### Narrativa - Clientes:

- O cliente pode se cadastrar no site com o seu CPF ou com seu CNPJ;
- O endereço do cliente irá determinar o frete a ser cobrado;
- Um cliente pode comprar mais de um pedido. Este, tem um período de carência para devolução do produto;
- O cliente pode ter mais de uma forma de pagamento

#### Narrativa - Pedido:

- Os pedidos são realizados pelos clientes e possuem informações de compra, endereço e status da entrega;
- Um produto ou mais compoem o pedido;
- O pedido pode ser cancelado.

#### Narrativa - Fornecedor e Estoque:

- Um fornecedor pode nos oferecer mais de um produto;
- O estoque é separado por categorias.


Além das informações que foram solicitadas pelo cliente, chegamos aos seguintes questionamentos que precisamos responder para atender ao objetivo:

 - O cliente pode ter mais de uma forma de pagamento, isso o torna um atributo de cliente ou uma nova entidade "pagamento"?
 - Vale a pena colocar a entrega como uma entidade a mais ou como um atributo?
 - Um cliente pode ser PJ e PF mas não pode ter as duas informações, como resolver?
 - A entrega deve possuir status e código dee ratreio, ela vai estar atrelada ao pedido ou criar um entidade para isso?


A partir dai foi realizado o estudo do case, onde eu analizei todos os dados fornecidos e cheguei a primeira versão do esquema de alto nível, o primeiro **modelo de dados conceitual**.

Você consegue acessar esse modelo em dois formatos, um em .pdf, para facilitar a visualização, que você tem acesso [clicando aqui](https://github.com/AndersonGabrielCalasans/Projetos-DataBaseExperienceBootcamp-DIO/blob/main/BD-Ecommerce/ecommerce_diagrama.pdf) e outro em formato .mwb, que você pode fazer o download [clicando aqui](https://github.com/AndersonGabrielCalasans/Projetos-DataBaseExperienceBootcamp-DIO/blob/main/BD-Ecommerce/ecommerce_diagrama.mwb), ambos foram gerados com o MySQL Workbench 8.0 CE.

## Modelo lógico:

Na segunda etapa do projeto, criei a lógica das tabelas em linguagem SQL, seguindo o modelo relacional já estabelecido atribuindo alguns ajustes conforme achei necessário. A maior parte dos ajustes realizados foi na questão de tratamento da variável, na maiooria das vezes, trocando o tipo de informação que a varável irá receber, no mais, a principio o modelo de banco de dados criado atende ao objetivo imposto.

O resultado do código que escrevi para persistir o banco de dados proposto você pode observar [clicando aqui]().

## Persistindo e recuperando dados a partir de Consultas SQL no Banco de Dados:

A fim de testar se o banco de dados encontra-se funcional e útil, persisti alguns dados fictícios e realizei algumas queries para testá-lo.

O arquivo onde pode ser encontrado os dados persistidos é [esse aqui](https://github.com/AndersonGabrielCalasans/Projetos-DataBaseExperienceBootcamp-DIO/blob/main/BD-Ecommerce/scriptSQL-BD-Ecommerce.sql), já o arquivo que encontram-se as queries [está aqui](https://github.com/AndersonGabrielCalasans/Projetos-DataBaseExperienceBootcamp-DIO/blob/main/BD-Ecommerce/data_insertion_ecommerce.sql).

A partir dos dados persistidos, realizamos queries para atender aos requisitos impostos no desafio, como forma de aprendizado a fazer consultas à bancos de dados com o MySQL. As queries tem que apresentar:

 - Recuperações simples com SELECT Statement
 - Filtros com WHERE Statement
 - Crie expressões para gerar atributos derivados
 - Defina ordenações dos dados com ORDER BY
 - Condições de filtros aos grupos – HAVING Statement
 - Crie junções entre tabelas para fornecer uma perspectiva mais complexa dos dados

<<<<<<< HEAD
=======
 
>>>>>>> 18aec4ea64deb38d7e7c09c93749ac83d45690bc
