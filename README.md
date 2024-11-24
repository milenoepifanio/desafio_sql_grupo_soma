# Desafio de SQL - Projeto fictício de estruturação de consultas para o Grupo Soma

# 📊 **Case SQL - Análise de Vendas do Grupo Soma**

## 📝 **Descrição do Projeto**
Este projeto é uma solução para um case de SQL encontrado no LinkedIn, voltado à análise de dados de uma loja de roupas do Grupo Soma. O objetivo é responder perguntas estratégicas relacionadas às vendas, clientes e campanhas de marketing usando consultas SQL bem estruturadas e comentadas.

O case abrange desde a análise de performance de campanhas publicitárias até a identificação de melhores clientes para ações de relacionamento.  

---

## 🛠️ **Ferramentas Utilizadas**
- **SQL:** Criação e execução de consultas para análise de dados.
- **Git/GitHub:** Versionamento de código e compartilhamento do projeto.
- **Modelagem de Dados:** Construção de um diagrama conceitual para facilitar o entendimento das relações entre as tabelas.
- **Entendimento de Negócio:** Interpretação do enunciado e tradução das necessidades do negócio em consultas SQL eficientes.

---

## 📂 **Estrutura do Banco de Dados**
### Tabelas:
1. **Vendas**: Dados de vendas por pedido, canal e marca.
2. **Produto**: Informações detalhadas de produtos (linha, categoria, tamanho, cor etc.).
3. **Venda_Produto**: Associação entre pedidos e produtos vendidos.
4. **NPS**: Avaliação de satisfação dos clientes (Net Promoter Score).
5. **Cliente**: Informações cadastrais dos clientes.
6. **Digital Analytics**: Dados de campanhas e canais digitais.

---

## 🔍 **Perguntas Respondidas**

Os scripts SQL que solucionam as perguntas estão organizados na pasta `Respostas/`, com cada arquivo detalhado e comentado para facilitar o entendimento.

O enunciado em arquivo pdf está disponível na pasta `Descricao/`, que é o arquivo encontrado no LinkedIn.

Além disso, o repositório inclui os seguintes arquivos de suporte, disponíveis na pasta `Arquivos auxiliares/`:
- **Avaliação SQL.pdf:** Apresentação visual da distribuição das tabelas, assim como as perguntas.
- **Diagrama Conceitual.pdf:** Esquema das relações entre as tabelas, visando uma representação visual das ligações.

1. **Performance da Black Friday da marca Maria Filó:**
   - Receita gerada.
   - Número de clientes únicos.
   - Quantidade de peças vendidas.

2. **Base de clientes para ação da marca Cris Barros:**
   - Compras no canal e-commerce (01/jan a 30/nov/2023) no RJ.
   - Dados como receita total, quantidade de peças e datas de compras.

3. **Cálculo do NPS da marca Animale (jan/2023):**
   - Fórmula de NPS e categorização de notas (Promotor, Neutro, Detrator).

4. **Performance de produtos por categoria em 2022:**
   - Base aberta por marca (Farm e Animale).
   - Receita total, clientes únicos, peças vendidas e receita média.

5. **Indicadores mensais da marca Fábula (2023):**
   - Quantidade de pedidos.
   - Categoria mais comprada.
   - Quantidade média de peças por pedido.
   - Ticket médio.

6. **Top 10 melhores clientes da marca Animale (2023):**
   - Categoria, linha e produto mais caro por cliente.

---

## 📋 **Como Usar o Projeto**
1. Clone o repositório:
   ```bash
   git clone https://github.com/seuusuario/loja-grupo-soma.git

2. Abra as consultas SQL no seu editor ou ambiente de banco de dados.

3. Execute cada consulta conforme o enunciado.

## 📊 Resultados
Os resultados das consultas estão detalhados nos scripts SQL e foram construídos seguindo boas práticas, como o uso de **CTEs** (Common Table Expressions), comentários para legibilidade e otimizações para performance.

---

## 💡 Insights e Conclusões
- Identificação de campanhas mais lucrativas e clientes estratégicos.
- Categorização de produtos com maior desempenho por marca.

## 🚀 Contribuições e feedbacks são bem-vindos!
