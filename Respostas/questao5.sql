/*
5) A marca ‘FABULA’ gostaria de entender melhor a sua base de clientes e por isso pediu a você que calculasse alguns indicadores de cada mês 
de 2023:
	a. Qtde de pedidos
	b. Categoria mais comprada
	c. Quantidade média de peças em cada pedido (PA [peças por atendimento])
	d. Ticket médio
*/


SELECT a.mes_ano, -- Selecionando o mês ano, calculado no from renomeado de a
       a.marca, -- Selecionando a marca, calculado no from renomeado de a
       a.categoria, -- Selecionando a categoria, calculado no from renomeado de a 
       a.qtd_pedidos, -- Selecionando a quantidade de pedidos, calculado no from renomeado de a
       b.qtd_media_por_pedido, -- Selecionando a quantidade media por pedido, calculado no left join renomeado de b
       b.ticket_medio, -- Selecionando o ticket medio, calculado no left join renomeado de b
       ROW_NUMBER() OVER (PARTITION BY a.mes_ano ORDER BY a.qtd_pedidos DESC) AS row_number -- Criando um row number para ver qual categoria teve mais quantidade de pedidos levando em consideração o mes_ano
        FROM (
            SELECT CONCAT(MONTH(v.data_do_pedido), '-', YEAR(v.data_do_pedido)) AS mes_ano, -- concatenando a informação de mês-ano
                   v.categoria, -- selecionando a categoria, vinda da tabela de vendas
                   COUNT(DISTINCT id_pedido) AS qtd_pedidos, -- contando os pedidos, de maneira distinta
                FROM vendas v -- Buscando a tabela de vendas como tabela principal
                    WHERE v.data_do_pedido >= date('2022-01-01') -- Data de início
			            AND v.data_do_pedido >= date('2022-12-31') -- Data de fim
			            AND v.marca = ‘FABULA’ -- Filtrando para aparecer somente a marca Fabula
                    GROUP BY 1, 2 -- Agrupando as sumarização com base no mes_ano e categoria
        ) a -- Renomeando a estrutura do from como 'a'
        LEFT JOIN (
            SELECT v.categoria, -- Selecionando a categoria
                   CONCAT(MONTH(v.data_do_pedido), '-', YEAR(data_do_pedido)) AS mes_ano, -- calculando mes-ano
                   ROUND(AVG(v.qtde_pecas_produto),0) AS qtd_media_por_pedido, -- Realizando a média de peças por produto
		           ROUND(v.receita / COUNT(DISTINCT v.categoria), 2) AS ticket_medio -- calculando o ticket médio com base na receita realizada na categoria específica
                    FROM vendas v -- Buscando a tabela de vendas como tabela principal
                        WHERE v.data_do_pedido >= date('2022-01-01') -- Data de início
			                AND v.data_do_pedido >= date('2022-12-31') -- Data de fim
			                AND v.marca = ‘FABULA’ -- Filtrando para aparecer somente a marca Fabula
        ) b ON a.categoria = b.categoria -- Realizando a união deste join por meio do campo de categoria
