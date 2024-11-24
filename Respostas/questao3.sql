/*
3) Calcule o NPS da marca ‘ANIMALE’ de janeiro/2023. Qual vai ser o tipo de dado do seu resultado?
a. OBS. Calculo de NPS = (Qtde_pedidos_promotores - Qtde_pedidos_detratores) / Qtde_total_pedidos_avaliados
b. Tipo de avaliação:
	i. Detrator = notas entre 1-6
	ii. Neutro = notas entre 7-8
	iii. Promotor = notas entre 9-10
*/

SELECT a.marca, -- Selecionando a marca, presente na sub-consulta renomeada como (a)
		((a.promotores - b.detratores)/c.total_pedidos) * 100 AS NPS -- Realizando o cálculo do NPS com os dados presentes na sub-consultas renomeadas como a, b e c.
    FROM 
		(SELECT DISTINCT v.marca, -- Selecionando a marca, informação vinda da tabela de vendas
                COUNT(n.nota) AS promotores -- Contando o quantidade de ocorrências no campo n.nota, da tabela nps, para saber a quantidade de promotores na base
				    FROM nps n -- Buscando a tabela de nps como tabela principal
				    LEFT JOIN vendas v ON v.id_pedido = n.id_pedido  -- Buscando informações da tabela de vendas, utilizando a coluna de id_pedido como chave de acesso
					    WHERE n.nota >= 9 AND n.nota <= 10 AND v.id_pedido = n.id_pedido
						    AND v.marca = 'ANIMALE' -- Marca desejada, garantindo que somente retornarão resultados da Animale
						    AND v.data_do_pedido >= DATE('2023-01-01') -- Data de início da campanha
						    AND v.data_do_pedido <= DATE('2023-01-31') -- Data de fim da campanha
		) a -- Realizado o apelido de "a" para a subconsulta acima
    LEFT JOIN 
		(SELECT DISTINCT v.marca,  -- Selecionando a marca, informação vinda da tabela de vendas
                COUNT(n.nota) AS detratores  -- Contando o quantidade de ocorrências no campo n.nota, da tabela nps, para saber a quantidade de detratores na base
				    FROM nps n -- Buscando a tabela de nps como tabela principal
				    LEFT JOIN vendas v ON v.id_pedido = n.id_pedido
					    WHERE n.nota >= 1 AND n.nota <= 6 AND v.id_pedido = n.id_pedido  -- Buscando informações da tabela de vendas, utilizando a coluna de id_pedido como chave de acesso
						    AND v.marca = 'ANIMALE' -- Marca desejada, garantindo que somente retornarão resultados da Animale
						    AND v.data_do_pedido >= DATE('2023-01-01') -- Data de início da campanha
						    AND v.data_do_pedido <= DATE('2023-01-31') -- Data de fim da campanha
		) b ON a.marca = b.marca -- realizando a ligação por meio do nome da marca, para conectar os campos
    LEFT JOIN 
		(SELECT DISTINCT v.marca,  -- Selecionando a marca, informação vinda da tabela de vendas
                COUNT(n.nota) as todos_pedidos -- Contando a quantidade de pedidos que existem nessa tabela
				    FROM nps n -- Buscando a tabela de nps como tabela principal
				    LEFT JOIN vendas v ON v.id_pedido = n.id_pedido -- Buscando informações da tabela de vendas, utilizando a coluna de id_pedido como chave de acesso
					    WHERE v.marca = 'ANIMALE' -- Marca desejada, garantindo que somente retornarão resultados da Animale
						    AND v.data_do_pedido >= DATE('2023-01-01') -- Data de início da campanha
						    AND v.data_do_pedido <= DATE('2023-01-31') -- Data de fim da campanha
		) c ON a.marca = c.marca -- realizando a ligação por meio do nome da marca, para conectar os campos