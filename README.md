1. Descrição do Ambiente Operacional
O Ambiente Operacional idealizado representa um esquema de banco de dados paraum sistema que gerencia uma rede de postos de combustíveis. Com o objetivo de tornar
mais simples a compreensão do banco operacional, foi definido um escopo que compreendeum único processo de negócio: a venda de combustíveis e lubrificantes. Oobjetivodoesquema de dados é armazenar informações sobre as lojas das redes de postos, os produtoscomercializados e as vendas efetuadas. As lojas são caracterizadas por umcódigo, nomeelocalização (cidade e estado). Os produtos possuem um código, um nome, umvalor unitárioe uma categoria. As vendas de um produto armazenam informações sobre a loja, o produto, a data da venda, o volume vendido, o valor total, e o tipo de pagamento. AFigura1apresenta o esquema do banco de dados operacional. Figura 1: Esquema do banco de dados do Ambiente Operacional.
2. Indicadores
Os seguintes indicadores foram utilizados como base para a modelagemdoEsquema dimensional:
a) Qual o total vendido (litros) de combustível por loja, por período?
b) Qual o total vendido (litros) de lubrificante por loja, por período?
c) Qual o total vendido (litros) de combustível por categoria, por período?
d) Qual o valor total (faturamento) com a venda de combustível, por período?
e) Qual o valor total (faturamento) com a venda de lubrificante, por período?
f) Qual o valor total (faturamento) por tipo de pagamento?
g) Qual o número de transações (vendas) por tipo de pagamento?
h) Qual a variação de faturamento na venda de combustível entre o mês atual e omês anterior?
3. Esquema Dimensional
Com base nos indicadores apresentados na seção 2, foi projetado umEsquemaEstrela (Figura 2) seguindo os passos definidos em Kimball (2008):
1) Definição do Processo;
2) Identificação da Tabela de Fato;
3) Definição da Granularidade;
4) Identificação dos Fatos;
5) Identificação das Dimensões. 1) Definição do Processo
O processo a ser modelado é o processo de venda de combustíveis e lubrificantesque ocorre em uma rede de postos de combustível. 2) Identificação da Tabela de Fato
Foi identificado que uma única tabela de fatos (fato venda) seria suficiente pararesponder aos indicadores.
3) Definição da Granularidade
A seguinte granularidade foi identificada: “Uma linha da tabela de fato vendarepresenta uma venda de combustível ou lubrificante em uma determinada loja, comdeterminado tipo de pagamento em um determinado dia”. 4) Identificação dos Fatos
Após a identificação da granularidade, foram identificados os fatos (medidas)
necessárias: a) quantidade - para representar a quantidade de vendas; b) volume - paraidentificar o volume de combustível ou lubrificante vendido; c) valor - para identificar ovalor pago na venda. 5) Identificação das Dimensões. Com base na granularidade, também foram definidas as dimensões (contextos) quecaracterizam a venda: a) dimensão tempo com granularidade dia; b) dimensão produto; c)
dimensão loja; d) dimensão tipo de pagamento. A Figura 2 apresenta o Esquema Estrela criado ao final do processo de modelagem. Figura 2: Esquema do banco de dados do Ambiente Dimensional.
4. Área de Staging
Uma vez finalizada a modelagem do Ambiente Dimensional, foi projetadooesquema da Área de Staging, área intermediária entre o Ambiente Operacional eoAmbiente Dimensional. O esquema da Área de Staging reflete as informações que sãonecessárias no Ambiente Dimensional. Com o objetivo de servir como umbackupdasinformações que serão transferidas do Ambiente Operacional para o Ambiente Dimensional, toda tabela da Área de Staging apresentará um atributo do tipo datetime (data_carga) queinformará a “carga” à qual as informações sendo transferidas pertencem. AFigura3apresenta o esquema de dados da Área de Staging.
