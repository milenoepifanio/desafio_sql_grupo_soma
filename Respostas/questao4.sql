/*
4) O time do planejamento pediu a sua ajuda para avaliar a performance de certos produtos. Calcule para cada categoria de produto as seguintes informações:
	a. Premissas:
		i. Compras de 2022
		ii. Pedidos das marcas ‘FARM’ e ‘ANIMALE’
		iii. Base aberta por marca e por categoria de produto
	b. Informações necessárias:
		i. Receita Total obtida
		ii. Qtde de clientes únicos comprantes
		iii. Qtde de peças vendidas
		iv. Receita média da categoria 
*/

SELECT marca, -- Buscando os dados da marca da sub-consulta
       categoria,  -- Buscando os dados de categoria da sub-consulta
       qtd_clientes,  -- Buscando os dados da quantidade de clientes da sub-consulta
       receita_gerada, -- Buscando os dados de receita gerada da sub-consulta
       ROUND((receita_gerada / COUNT(DISTINCT categoria)), 2) AS receita_media_por_categoria -- Realizando o cálculo da receita por categoria, que é a divisão da receita total gerada pela contagem de ocorrencias naquela categoria específica
    FROM ( -- Buscando os dados da sub-consulta
        SELECT v.marca, -- Selecionando a marca, presente na tabela de vendas
           v.categoria,  -- Selecionando a marca, presente na tabela de categoria
           COUNT(DISTINCT v.id_cliente) AS qtd_clientes,  -- Realizando uma contagem distinta de clientes, vindos da tabela de vendas  
           ROUND(SUM(v.receita),2) AS receita_gerada, --  -- Realizando a soma da receita por marca e categoria, vindos da tabela de vendas
           SUM(qtde_pecas_vendidas) AS qtd_pecas_vendidas -- Realiando a soma de peças vendidas por categoria, vindos da tabela de vendas
    		FROM vendas v
    	        WHERE v.data_do_pedido >= DATE('2022-01-01') -- Data de início da campanha
       		        AND v.data_do_pedido <= DATE('2022-12-31') -- Data de fim da campanha
       		        AND v.marca IN ('FARM', 'ANIMALE') -- Filtrando somente as marcas FARM e ANIMALE
    	GROUP BY 1, 2 -- Agrupando por marca e categoria, ambos vindos da tabela de vendas
	)