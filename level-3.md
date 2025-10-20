# Nível 3 – Diagrama de Componentes

Este diagrama detalha os principais **componentes internos do sistema Help Desk**, dentro do contêiner **API Backend**.  
Ele mostra como os módulos se conectam para oferecer funcionalidades de atendimento, registro de chamados, gestão de usuários e relatórios.

---

## Descrição Geral

O sistema Help Desk é composto por diversos componentes que trabalham juntos para registrar, gerenciar e acompanhar tickets de suporte técnico.  
Cada módulo possui responsabilidades específicas, garantindo escalabilidade, segurança e fácil manutenção.

Principais componentes:

- **Gestão de Usuários** → controle de autenticação, perfis e permissões.  
- **Gestão de Chamados (Tickets)** → criação, atualização e fechamento de tickets de suporte.  
- **Base de Conhecimento** → artigos e soluções para autoatendimento.  
- **Gestão de Equipe Técnica** → controle de atendentes, filas e prioridades.  
- **Notificações e Alertas** → envio de e-mails ou mensagens automáticas para usuários e técnicos.  
- **Relatórios e Métricas** → geração de dashboards com indicadores de desempenho.  
- **Integração com ERP/CRM** → comunicação com outros módulos corporativos (clientes, contratos, faturamento).  

---

## Diagrama de Componentes (Mermaid)

```mermaid
graph LR
    subgraph API_Backend["API Backend - Help Desk"]
        UMG["Gestao de Usuarios"]
        TKMG["Gestao de Chamados"]
        KB["Base de Conhecimento"]
        TEAM["Gestao de Equipe Tecnica"]
        NOTIF["Servico de Notificacoes"]
        REPORT["Relatorios e Metricas"]
        INTEG["Integracao com ERP e CRM"]
    end

    U["Usuario Final"] -->|Cria e acompanha chamados| TKMG
    TKMG --> TEAM
    TEAM --> NOTIF
    TKMG --> KB
    TKMG --> REPORT
    TKMG --> INTEG
    UMG --> TKMG
