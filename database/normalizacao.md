A normalização é um conjunto de técnicas de modelagem relacional cujo objetivo principal é reduzir redundância de
dados, evitar anomalias (inserção, atualização e exclusão) e melhorar a coerência e integridade do banco de dados. Para
sistemas transacionais e administrativos, aplicar as três primeiras formas normais (1FN, 2FN e 3FN) na modelagem
garante clareza sem sacrificar desnecessariamente desempenho. Abaixo descrevemos a aplicação das formas normais,
com exemplos práticos de transformação e cenários em que a normalização pode ser parcialmente relaxada por
motivos de performance ou simplicidade.

2.1 Primeira Forma Normal (1FN)
Requisito: cada atributo deve conter valores atômicos (não multivalorados) e cada registro deve ser único.
Problema comum: campos que armazenam listas (por ex. telefones = &#39;1111-1111;2222-2222&#39;) ou colunas
repetidas (produto1, produto2, produto3).
Exemplo inicial (violando 1FN):
Cliente(id_cliente, nome, telefones)
Registro exemplo:
(1, &#39;João&#39;, &#39;11-9999-1111;11-8888-2222&#39;)
Transformação (1FN): Separar telefones em linhas ou tabela associativa:
Cliente(id_cliente PK, nome);
Telefone(id_telefone PK, id_cliente FK, numero);

2.2 Segunda Forma Normal (2FN)
Requisito: estar em 1FN e todos os atributos não-chave devem depender da chave primária inteira (eliminar
dependências parciais em chaves compostas).
Problema comum: em tabelas com chave composta, atributos dependem só de parte da chave.
Exemplo inicial (violando 2FN):
VendaItem(pedido_id PK, produto_id PK, produto_nome, quantidade, preco_unitario)
Transformação (2FN):
Produto(produto_id PK, produto_nome, descricao, categoria_id);
VendaItem(pedido_id PK, produto_id PK, quantidade, preco_unitario, FK produto_id -&gt; Produto);

2.3 Terceira Forma Normal (3FN)
Requisito: estar em 2FN e não ter dependências transitivas — atributos não-chave não devem depender de outros
atributos não-chave.
Problema comum: coluna cidade e estado mantidas na tabela Cliente, enquanto estado_nome depende de estado.
Exemplo inicial (violando 3FN):
Estado(estado_codigo PK, estado_nome);
Endereco(id_endereco PK, cliente_id FK, rua, cidade, estado_codigo FK);

3. Exemplos práticos de eliminação de redundâncias
Caso 1: Antes:
Venda(id_venda, data, cliente_cpf, cliente_nome, cliente_email, total)
Depois:
Cliente(cliente_id PK, cpf UNIQUE, nome, email, telefone);
Venda(id_venda PK, data, cliente_id FK, total);
Caso 2: Antes:
PedidoItem inclui produto_descricao duplicado.
Depois:
Produto(produto_id PK, descricao);
PedidoItem(pedido_id PK, produto_id FK, quantidade);

4. Quando aplicar normalização parcial (denormalização)
1. Performance de leitura em relatórios pesados.
2. Integrações legadas que exigem layout simples.
3. Operações em lote offline.
4. Bancos distribuídos onde joins são caros.
Boas práticas: - Documentar a redundância. - Sincronizar dados com triggers ou jobs. - Aplicar apenas em áreas
específicas.

5. Exemplo de denormalização controlada
Tabela Venda armazena total_venda já calculado no momento da confirmação para evitar joins pesados.

6. Checklist
• ☒ 1FN aplicada
• ☒ 2FN aplicada
• ☒ 3FN aplicada
• ☒ Dependências transitivas removidas
• ☒ Casos de denormalização documentados

7. Conclusão
Aplicar até a 3FN garante integridade e evita anomalias. Em casos de performance, pode-se denormalizar de forma
controlada e justificada.


 
Estado(estado_codigo PK, estado_nome);
Endereco(id_endereco PK, cliente_id FK, rua, cidade, estado_codigo FK);
