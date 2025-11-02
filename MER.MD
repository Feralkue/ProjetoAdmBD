# Modelo Entidade-Relacionamento (MER) — Sistema Help Desk

## Objetivo
O Modelo Entidade-Relacionamento (MER) define as entidades, atributos e relacionamentos do sistema de Help Desk.  
Ele serve como base para o projeto lógico do banco de dados, garantindo consistência, rastreabilidade e integridade das informações.

---

## Entidades e Atributos

### Usuário
- **id_usuario (PK)** — Identificador único do usuário  
- **nome** — Nome completo  
- **email** — E-mail de login  
- **senha_hash** — Senha criptografada  
- **tipo_usuario** — Cliente, Técnico ou Administrador  
- **data_cadastro** — Data de criação da conta  

### Chamado
- **id_chamado (PK)** — Identificador do chamado  
- **titulo** — Assunto principal  
- **descricao** — Descrição detalhada  
- **status** — Aberto / Em andamento / Fechado  
- **prioridade** — Baixa / Média / Alta / Crítica  
- **data_abertura** — Data de abertura  
- **data_fechamento** — Data de encerramento  
- **id_usuario (FK)** — Usuário que abriu o chamado  
- **id_tecnico (FK)** — Técnico responsável  

### EquipeTecnica
- **id_tecnico (PK)** — Identificador único do técnico  
- **nome_tecnico** — Nome do técnico  
- **especialidade** — Área de atuação (hardware, software etc.)  
- **email_contato** — E-mail profissional  
- **disponibilidade** — Disponível / Ocupado  

### BaseConhecimento
- **id_artigo (PK)** — Identificador do artigo  
- **titulo_artigo** — Título  
- **conteudo** — Texto com a solução  
- **autor (FK)** — Técnico que criou o artigo  
- **data_publicacao** — Data de publicação  

### Notificacao
- **id_notificacao (PK)** — Identificador único  
- **mensagem** — Conteúdo da notificação  
- **tipo** — Alerta, atualização, atribuição  
- **data_envio** — Data do envio  
- **id_usuario (FK)** — Usuário destinatário  

### Relatorio
- **id_relatorio (PK)** — Identificador  
- **tipo_relatorio** — Categoria (chamados, desempenho, etc.)  
- **data_geracao** — Data da geração  
- **conteudo** — Resumo consolidado  

---

## Tipos de Relacionamentos e Cardinalidades

| Relacionamento | Tipo | Cardinalidade | Descrição |
|----------------|------|----------------|------------|
| Usuário → Chamado | 1:N | Um usuário pode abrir vários chamados, mas cada chamado pertence a um único usuário. |
| Técnico → Chamado | 1:N | Um técnico pode atender vários chamados, mas cada chamado é atendido por um único técnico. |
| Técnico → BaseConhecimento | 1:N | Um técnico pode criar vários artigos. |
| Usuário → Notificação | 1:N | Um usuário pode receber várias notificações. |
| Chamado → Relatório | 1:N | Um relatório pode consolidar vários chamados. |

---

## Justificativas dos Relacionamentos

- O **Usuário** é quem cria os chamados, justificando o relacionamento 1:N.  
- Cada **Chamado** tem um **Técnico** designado para acompanhamento.  
- Técnicos alimentam a **Base de Conhecimento**, criando novos artigos.  
- **Notificações** mantêm usuários informados sobre mudanças em seus chamados.  
- Os **Relatórios** são gerados com base em dados de chamados e técnicos.

---

## Regras de Negócio

1. Somente usuários autenticados podem criar chamados.  
2. Cada chamado deve ter um técnico responsável atribuído.  
3. Chamados só podem ser encerrados se estiverem com status “Em andamento”.  
4. Apenas técnicos e administradores podem editar a base de conhecimento.  
5. Notificações são enviadas automaticamente em alterações de status.  
6. Relatórios são gerados sob demanda a partir de dados consolidados.

---

## Diagrama MER (Mermaid)

```mermaid
erDiagram
    USUARIO {
        int id_usuario PK
        string nome
        string email
        string senha_hash
        string tipo_usuario
        date data_cadastro
    }

    CHAMADO {
        int id_chamado PK
        string titulo
        string descricao
        string status
        string prioridade
        date data_abertura
        date data_fechamento
        int id_usuario FK
        int id_tecnico FK
    }

    EQUIPETECNICA {
        int id_tecnico PK
        string nome_tecnico
        string especialidade
        string email_contato
        string disponibilidade
    }

    BASECONHECIMENTO {
        int id_artigo PK
        string titulo_artigo
        string conteudo
        int autor FK
        date data_publicacao
    }

    NOTIFICACAO {
        int id_notificacao PK
        string mensagem
        string tipo
        date data_envio
        int id_usuario FK
    }

    RELATORIO {
        int id_relatorio PK
        string tipo_relatorio
        date data_geracao
        string conteudo
    }

    USUARIO ||--o{ CHAMADO : abre
    EQUIPETECNICA ||--o{ CHAMADO : atende
    EQUIPETECNICA ||--o{ BASECONHECIMENTO : cria
    USUARIO ||--o{ NOTIFICACAO : recebe
    CHAMADO ||--o{ RELATORIO : compoe
