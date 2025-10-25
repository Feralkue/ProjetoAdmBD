Tabelas:
- Usuario
- Chamado
- Tecnico
- Departamento
- SLA
- Comentario/Feedback
- Categoria
- Status
- Prioridade
- Historico_Chamadas

Relacionamentos:
Usuario      abre        Chamado        1:N
Tecnico      atende      Chamado        1:N
Tecnico      pertence    Departamento   N:1
Chamado      possui      Categoria      N:1
Chamado      possui      Status         N:1
Chamado      possui      Prioridade     N:1 
Historico    possui      Chamado        1:N
SLA          pertence    Chamado        1:N
Usuario      faz         Feedback       1:N
Chamado      recebe      Feedback       1:1
