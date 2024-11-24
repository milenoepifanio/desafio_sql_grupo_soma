/*
2) A marca ‘CRIS BARROS’ deseja fazer uma ação para seus clientes e pediu que fosse gerado uma base de clientes com as seguintes premissas: 
	a. fizeram pelo menos uma compra no canal do ‘ECOMMERCE’ entre o intervalo de 01/jan/2023 até 30/nov/2023
	b. moram no estado do RJ
	c. A base deve conter as seguintes informações:
		i. ID_CLIENTE
		ii. NOME DO CLIENTE
		iii. ENDERECO
		iv. RECEITA TOTAL GASTA NO PERÍODO
		v. QTDE DE PEÇAS COMPRADAS NO PERÍODO
		vi. DATA DA PRIMEIRA COMPRA
		vii. QTDE DE DIAS DESDE A ULTIMA COMPRA
*/

SELECT c.id_cliente, -- Selecionando o id do cliente, vindo da tabela de clientes
	   c.nome AS nome_cliente, -- Selecionando o nome do cliente, vindo da tabela de clientes
	   c.endereco AS endereco_cliente, -- Selecionando o endereço do cliente, vindo da tabela de clientes
	   ROUND(SUM(v.receita), 2) AS receita_gasta, -- Selecionando o valor da receira, vindo da tabela de vendas
	   COUNT(v.qtde_pecas) AS qtd_pecas, -- Selecionando a quantidade de peças vendidas ao cliente, informações vindos da tabela de vendas
	   MIN(v.data_do_pedido) AS primeira_compra, -- Selecionando o primeira data que esse cliente tem pedido
	   DATEDIFF(DAY, MAX(v.data_do_pedido), CURRENT_DATE()) AS dias_desde_ultima_compra -- Calculando os dias da última compra, sendo considerado a diferença entre o dia de hoje em relação a data de última compra do cliente
			FROM vendas v -- Buscando a tabela de vendas como tabela principal
			LEFT JOIN clientes c ON v.id_cliente = c.id_cliente -- Left join com a tabela de clientes 
		        WHERE v.data_do_pedido >= DATE('2023-01-01') -- Data de início da campanha
			        AND v.data_do_pedido <= DATE('2023-11-30') -- Data de fim da campanha
			        AND v.marca = ‘CRIS BARROS’ -- Adicionando o filtro de marca para a empresa Cris Barros, garantindo que as vendas são somente dessa empresa
			        AND v.canal = ‘ECOMMERCE’ -- Adicionando filtro do canal
			        AND c.UF = 'RJ' -- Filtrando somente clientes do estado do Rio de Janeiro
		GROUP BY 1, 2, 3 -- Agrupando com base no id do cliente
