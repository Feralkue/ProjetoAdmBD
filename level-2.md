# Nível 2 - Diagrama de Contêineres

Este diagrama representa os contêineres do sistema de Help Desk, incluindo o aplicativo web principal, o banco de dados, e sistemas externos como mensageria e comunicação corporativa. Os usuários interagem com o sistema para registrar chamados, e são notificados por diferentes canais.

```mermaid
graph TD
  U[Usuário<br><i>Utiliza o sistema</i>]

  subgraph Help_Desk_Environment
    HD[Sistema de Help Desk<br><i>Registro de ocorrências</i>]
    DB[(Banco de Dados<br><i>Registro de chamados</i>])]
    MSG[Sistema de Mensageria<br><i>Notifica o cliente</i>]
    COM[Sistema de Comunicação Interna<br><i>Notifica equipe de suporte</i>]
  end

  U -->|Acessa o sistema| HD
  HD -->|Registra chamado| DB
  HD -->|Notifica equipe| COM
  HD -->|Envia notificação| MSG
  MSG -->|Notifica cliente| U
