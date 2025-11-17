CREATE TABLE Usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    senha_hash VARCHAR(255) NOT NULL,
    tipo_usuario ENUM('Cliente','Tecnico','Administrador') NOT NULL,
    data_cadastro DATE NOT NULL DEFAULT (CURRENT_DATE)
);

CREATE TABLE EquipeTecnica (
    id_tecnico INT PRIMARY KEY,
    nome_tecnico VARCHAR(100) NOT NULL,
    especialidade VARCHAR(100),
    email_contato VARCHAR(120) UNIQUE,
    disponibilidade ENUM('Disponivel','Ocupado') DEFAULT 'Disponivel',

    CONSTRAINT fk_tecnico_usuario
        FOREIGN KEY (id_tecnico) REFERENCES Usuario(id_usuario)
        ON DELETE CASCADE
);

CREATE TABLE Categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome_categoria VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE StatusChamado (
    id_status INT AUTO_INCREMENT PRIMARY KEY,
    nome_status ENUM('Aberto','Em andamento','Fechado') NOT NULL
);

CREATE TABLE Chamado (
    id_chamado INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    descricao TEXT NOT NULL,

    id_status INT NOT NULL,
    id_categoria INT NOT NULL,
    prioridade ENUM('Baixa','Média','Alta','Crítica') NOT NULL,

    data_abertura DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    data_fechamento DATETIME NULL,

    id_usuario INT NOT NULL,
    id_tecnico INT NOT NULL,

    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_tecnico) REFERENCES EquipeTecnica(id_tecnico),
    FOREIGN KEY (id_status) REFERENCES StatusChamado(id_status),
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)
);

CREATE TABLE BaseConhecimento (
    id_artigo INT AUTO_INCREMENT PRIMARY KEY,
    titulo_artigo VARCHAR(150) NOT NULL,
    conteudo TEXT NOT NULL,
    autor INT NOT NULL,
    data_publicacao DATE NOT NULL,

    CONSTRAINT fk_artigo_tecnico
        FOREIGN KEY (autor) REFERENCES EquipeTecnica(id_tecnico)
);

CREATE TABLE Notificacao (
    id_notificacao INT AUTO_INCREMENT PRIMARY KEY,
    mensagem VARCHAR(255) NOT NULL,
    tipo ENUM('Alerta','Atualizacao','Atribuicao') NOT NULL,
    data_envio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_usuario INT NOT NULL,

    CONSTRAINT fk_notif_user
        FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

CREATE TABLE Relatorio (
    id_relatorio INT AUTO_INCREMENT PRIMARY KEY,
    tipo_relatorio ENUM('Chamados','Desempenho','Tecnicos','Geral') NOT NULL,
    data_geracao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    conteudo TEXT NOT NULL
);

CREATE TABLE Relatorio_Chamado (
    id_relatorio INT NOT NULL,
    id_chamado INT NOT NULL,

    PRIMARY KEY(id_relatorio, id_chamado),

    FOREIGN KEY (id_relatorio) REFERENCES Relatorio(id_relatorio) ON DELETE CASCADE,
    FOREIGN KEY (id_chamado) REFERENCES Chamado(id_chamado) ON DELETE CASCADE
);

CREATE TABLE HistoricoChamado (
    id_historico INT AUTO_INCREMENT PRIMARY KEY,
    id_chamado INT NOT NULL,
    id_usuario INT NOT NULL,
    descricao TEXT NOT NULL,
    data_acao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_chamado) REFERENCES Chamado(id_chamado),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);
