/*
6) A marca ‘ANIMALE’ gostaria de entender quais são as suas melhores clientes de 2023. Será feito uma ação onde elas serão convidadas para um 
evento da marca. Calcule quem são as 10 melhores clientes da marca (informações necessárias: NOME e ID_CLIENTE) e calcule as seguintes informações de cada uma dessas clientes:
	a. Categoria mais comprada
	b. Linha mais comprada
	c. Nome do produto mais caro comprado em 2023
*/


SELECT 
    a.id_cliente, -- Selecionando o id_cliente, presente no from renomeado como 'a'
    a.nome_cliente,  -- Selecionando o nome_cliente, presente no from renomeado como 'a'
    b.categoria, --  -- Selecionando a categoria, presente no from renomeado como 'b'
    c.linha,  -- Selecionando a linha, presente no from renomeado como 'b'
    c.valor_produto,  -- Selecionando o valor do produto, presente no from renomeado como 'c'
    a.rownumber --  -- Selecionando o row_number, presente no from renomeado como 'a'
        FROM(
            SELECT c.id_cliente, -- Selecionando o id_cliente, vindo da tabela de cliente
                c.nome AS nome_cliente, -- Selecionando o nome do cliente, vindo da tabela de cliente
                ROUND(SUM(v.vendas),2) as vendas -- Calculando a soma das vendas para cada cliente, com base no campo de vendas
                ROW_NUMBER() OVER (PARTITION BY c.id_cliente ORDER BY SUM(v.vendas) DESC) AS row_number -- calculando o row_number, para ver quem são os top 10 clientes
                    FROM vendas -- Buscando a tabela de vendas como tabela principal
                    LEFT JOIN cliente c ON c.id_cliente = v.id_cliente -- Criando a união com tabela de clientes (c), por meio dos campos de id-cliente
                        WHERE v.marca = 'ANIMALE' -- Filtrando somente a marca ANIMALE
      		                AND v.data_do_pedido >= DATE('2023-01-01') -- Data de início
      		                AND v.data_do_pedido <= DATE('2023-12-31') -- Data de fim
        ) a
        LEFT JOIN (
              SELECT c.id_cliente, -- Selecionando o id do cliente, presente na tabela de clientes
                p.categoria, -- Selecionando a categoria, presente na tabela de produto
                COUNT(p.categoria) AS qtd_compras, -- Realizando a contagem da quantidade de peças vendidas na categoria
                ROW_NUMBER() OVER (PARTITION BY c.id_cliente ORDER BY COUNT(p.categoria) DESC) AS row_number -- calculando o row_number, para ver quem a ordenação das categorias
                    FROM vendas v -- Buscando a tabela de vendas como tabela principal
                    LEFT JOIN venda_produto vp ON vp.id_pedido = v.id_pedido -- Unificando a tabela de vendas com venda_produto (vp) por meio do campo de id_pedido
                    LEFT JOIN produto p ON p.id_produto = vp.id_produto -- Unificando com a tabela de produto, com base nos campos de id_produto
                        WHERE v.marca = 'ANIMALE' -- Filtrando somente a marca ANIMALE
      		                AND v.data_do_pedido >= DATE('2023-01-01') -- Data de início
      		                AND v.data_do_pedido <= DATE('2023-12-31') -- Data de fim
                            AND ROW_NUMBER() OVER (PARTITION BY c.id_cliente ORDER BY COUNT(p.categoria) DESC) = 1 -- Filtrando somente o row_number = 1, garantindo que somente a categoria com maior quantidade de compras seja retornada
                    GROUP BY 1, 2, 4 -- Agrupando com base nos campos que não estão sumarizados.
        ) b ON a.id_cliente = b.id_cliente -- Unificando esse left join com base no campo id_cliente e renomeando ele como 'b', e também presente no from, denominado como 'a'
        LEFT JOIN (
                  SELECT c.id_cliente, -- Selecionando o id do cliente, presente na tabela de clientes
                  p.linha,  -- Selecionando a linha, presente na tabela de produto
                  COUNT(p.linha) AS qtd_compras_linha, -- Realizando a contagem da quantidade de peças vendidas nessa linha
                  ROW_NUMBER() OVER (PARTITION BY c.id_cliente ORDER BY COUNT(p.linha) DESC) AS row_number  -- calculando o row_number, para ver quem a ordenação da linhas mais vendidas
                    FROM vendas v -- Buscando a tabela de vendas como tabela principal
                    LEFT JOIN produto p ON p.id_produto = vp.id_produto -- Unificando a tabela de vendas com venda_produto (vp), por meio do campo de id_pedido
                    LEFT JOIN cliente c ON c.id_cliente = v.id_cliente -- Unificando a tabela de vendas com a de clientes (c), por meio do campo de id_cliente
                        WHERE v.marca = 'ANIMALE' -- Filtrando somente a marca ANIMALE
      		                AND v.data_do_pedido >= DATE('2023-01-01') -- Data de início
      		                AND v.data_do_pedido <= DATE('2023-12-31') -- Data de fim
                            AND ROW_NUMBER() OVER (PARTITION BY c.id_cliente ORDER BY COUNT(p.linha) DESC) = 1 -- Filtrando somente o row_number = 1, garantindo que somente a linha com maior quantidade de compras seja retornada
        ) c ON a.id_cliente = c.id_cliente -- Unificando esse left join com base no campo id_cliente e renomeando ele como 'c', e também presente no from, denominado como 'a'
        LEFT JOIN (
                SELECT c.id_cliente, -- Selecionando o id do cliente, presente na tabela de clientes
                       p.nome_produto AS produto, -- Selecionando o nome_produto, presente na tabela de produto
                       ROUND(MAX(v.receita), 2) AS valor_produto,  -- Selecionando a receita do produto presente na tabela de vendas, e atribuindo "valor_produto" a essa coluna
                       ROW_NUMBER() OVER (PARTITION BY c.id_cliente ORDER BY MAX(v.receita) DESC) AS row_number -- calculando o row_number, para ver quem a ordenação do valor mais caro vendido
                        FROM vendas v -- Buscando a tabela de vendas como tabela principal
                        LEFT JOIN venda_produto vp ON vp.id_pedido = v.id_pedido -- Unificando a tabela de vendas com venda_produto (vp) por meio do campo de id_pedido
                        LEFT JOIN produto p ON p.id_produto = vp.id_produto -- Unificando a tabela de vendas com venda_produto (vp), por meio do campo de id_pedido
    			        LEFT JOIN cliente c ON c.id_cliente = v.id_cliente -- Unificando a tabela de vendas com a de clientes (c), por meio do campo de id_cliente
                            WHERE v.marca = 'ANIMALE' -- Filtrando somente a marca ANIMALE
      		                    AND v.data_do_pedido >= DATE('2023-01-01') -- Data de início
      		                    AND v.data_do_pedido <= DATE('2023-12-31') -- Data de fim
                                AND ROW_NUMBER() OVER (PARTITION BY c.id_cliente ORDER BY MAX(v.receita) DESC) = 1 -- Filtrando somente o row_number = 1, garantindo que somente a linha com maior valor comprado pelo cliente seja retornada
                    GROUP BY 1, 2, 3 -- Agrupando pelos campos não sumarizados
        ) d ON a.id_cliente = d.id_cliente -- -- Unificando esse left join com base no campo id_cliente e renomeando ele como 'd', e também presente no from, denominado como 'a'
WHERE a.row_number <= 10 -- Filtrando somente o top 10 cientes com base no row-number