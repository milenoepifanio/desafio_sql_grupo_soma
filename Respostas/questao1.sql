/*
Questão 1:
O time de marketing da marca ‘MARIA FILO’ pediu a sua ajuda para avaliar a sua performance na Black Friday. Eles elaboraram uma nova campanha 
promocional e a marca gostaria de entender se a campanha entregou os resultados esperados. Calcule:
    a. receita gerada
    b. número de clientes únicos comprantes
    c. quantidade de peças vendidas da campanha nomeada ‘campanha_reloginho_bf’ no mês de novembro/2023.
*/

SELECT COUNT(DISTINCT v.id_cliente) AS clientes_unicos, -- Selecionando os clientes únicos pelo id presente na compra
	   COUNT(v.qtde_pecas) AS pecas_vendidas, -- Selecionando a quantidade de peças vendidas
	   ROUND(SUM(v.receita),2) AS receita -- Selecionando a receita com base na soma dos valores individuais
			FROM vendas v -- Buscando a tabela de vendas como tabela principal
			LEFT JOIN digital_analytics d ON d.id_pedido = v.id_pedido -- Left join com a tabela de informações do Google Analytics
			LEFT JOIN clientes c ON v.id_cliente = c.id_cliente -- Left join com a tabela de clientes -- Acho que dá pra retirar
	            WHERE d.campanha LIKE ("%campanha_reloginho_bf%") -- Filtrando somente vendas com a tag da campanha indicada
		            AND v.data_do_pedido >= DATE('2023-11-01') -- Data de início da campanha
		            AND v.data_do_pedido <= DATE('2023-11-30') -- Data de fim da campanha
		            AND v.marca = 'MARIA FILO' -- Garantindo que as vendas são da mesma marca indicada, nesse caso, a Maria Filó
	    GROUP BY 1 -- Agrupando com base nas colunas de clientes_unicos
