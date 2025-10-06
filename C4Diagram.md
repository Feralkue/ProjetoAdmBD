'''mermaid
 C4Context
    title System Context Diagram for Help Desk Environment

    Enterprise_Boundary(boundary1, "Help Desk Environment") {
        Person(user, "Usuário", "Usuário que utilizará o sistema.")
        System(helpdesk, "Sistema de Help Desk", "Sistema de Help Desk para registro de ocorrências.")
        System(messaging, "Sistema de mensageria", "Sistema de mensageria eletrônica.")
        System(communication, "Sistema de comunicação da empresa", "Um sistema de comunicação interna da empresa.")
        SystemDb(database, "Banco de Dados", "Sistema de registro de chamados.")

        Rel(user, helpdesk, "Acessa o sistema para registrar uma ocorrência usando")
        Rel(helpdesk, database, "Registra o chamado em")
        Rel(helpdesk, communication, "Notifica a equipe de suporte usando")
        Rel(helpdesk, messaging, "Notifica o cliente a partir de")
        Rel(messaging, user, "Notifica o cliente")
    }

UpdateRelStyle(user, helpdesk, $textColor="Black", $lineColor="Black", $offsetY="15")
UpdateRelStyle(helpdesk, database, $textColor="Black", $lineColor="Black", $offsetY="115", $offsetX="-232")
UpdateRelStyle(helpdesk, messaging, $textColor="Black", $lineColor="Black", $offsetY="10", $offsetX="-156")
UpdateRelStyle(helpdesk, communication, $textColor="Black", $lineColor="Black", $offsetX="-27", $offsetY="10")
UpdateRelStyle(messaging, user, $textColor="Black", $lineColor="Black", $offsetX="-99")
UpdateLayoutConfig($c4ShapeInRow="2", $c4BoundaryInRow="1")
'''