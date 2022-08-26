begin;

-- Save
CREATE TABLE IF NOT EXISTS save (
    nome VARCHAR(30) NOT NULL,
    PRIMARY KEY(nome)
);

-- Personagens
CREATE TYPE personagem_ocupacao AS ENUM (
    'Pirata', 'Marinheiro', 'Cidadao'
);

CREATE TYPE personagem_grupo_ocupacao AS ENUM (
    'Marinha', 'Piratas do Chapéu de Palha','Piratas do Buggy',
    'Pirata','Piratas do Arlong','Piratas da Alvida','Piratas do Baratie',
    'Piratas do Crocodile','Piratas do Barba Branca','Piratas do Bon Chan','Almirante da Marinha',
    'Capitão da Marinha','Piratas do Roger','Cidadão'
);

CREATE TYPE personagem_tipo AS ENUM (
    -- Principal , Inimigo, Não hostil, Barco
    'P', 'I', 'N', 'B'
);

-- Região

CREATE TABLE IF NOT EXISTS ilha (
    id_ilha INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL,
    nome VARCHAR(30) NOT NULL,
    descricao TEXT NOT NULL DEFAULT '',

    PRIMARY KEY (id_ilha)
);

CREATE TYPE regiao_tipo AS ENUM (
    'Cidade', 'Floresta', 'Deserto', 'Montanha','Porto'
);

CREATE TABLE IF NOT EXISTS regiao (
    id_regiao INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL,
    descricao TEXT NOT NULL DEFAULT '',
    tipo regiao_tipo,
    norte INTEGER,
    sul INTEGER,
    leste INTEGER,
    oeste INTEGER,
    id_ilha INTEGER,

    CONSTRAINT pk_regiao PRIMARY KEY (id_regiao),
    CONSTRAINT fk_regiao_norte FOREIGN KEY (norte) 
        REFERENCES regiao(id_regiao) ON DELETE RESTRICT,
    CONSTRAINT fk_regiao_sul FOREIGN KEY (sul)
        REFERENCES regiao(id_regiao) ON DELETE RESTRICT,
    CONSTRAINT fk_regiao_leste FOREIGN KEY (leste)
        REFERENCES regiao(id_regiao) ON DELETE RESTRICT,
    CONSTRAINT fk_regiao_oeste FOREIGN KEY (oeste)
        REFERENCES regiao(id_regiao) ON DELETE RESTRICT,
    CONSTRAINT fk_regiao_ilha FOREIGN KEY (id_ilha)
        REFERENCES ilha(id_ilha) ON DELETE RESTRICT
);

CREATE TABLE personagem (
    id_personagem INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL,
    tipo personagem_tipo NOT NULL,
    PRIMARY KEY (id_personagem)
);

CREATE TABLE IF NOT EXISTS personagem_principal (
    id_personagem INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL,
    id_regiao INTEGER NOT NULL,
    nome VARCHAR(20) NOT NULL,
    ocupacao personagem_ocupacao NOT NULL,
    grupo_ocupacao personagem_grupo_ocupacao NOT NULL,
    berries INTEGER NOT NULL DEFAULT 0,
    CHECK(berries >= 0),
    energia INTEGER NOT NULL DEFAULT 0,
    CHECK(energia >= 0),
    energia_maxima INTEGER NOT NULL DEFAULT 0,
    CHECK(energia_maxima >= 0),
    fraqueza VARCHAR(20) NOT NULL,
    experiencia INTEGER NOT NULL,
    CHECK(experiencia >= 0),
    vida INTEGER NOT NULL,
    CHECK(vida >= 0),
    vida_maxima INTEGER NOT NULL,
    CHECK(vida_maxima >= 0),
    capacidade_de_itens INTEGER NOT NULL,
    CHECK(capacidade_de_itens > 0),

    CONSTRAINT fk_regiao FOREIGN KEY (id_regiao) 
        REFERENCES regiao(id_regiao) ON DELETE RESTRICT,
    CONSTRAINT fk_personagem FOREIGN KEY (id_personagem) 
        REFERENCES personagem(id_personagem) ON DELETE RESTRICT,
    PRIMARY KEY (id_personagem)
);

-- Instancia de jogador
CREATE TABLE IF NOT EXISTS jogador (
    nome_save VARCHAR(30) NOT NULL,
    id_personagem INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL,
    id_regiao INTEGER NOT NULL,
    nome VARCHAR(20) NOT NULL,
    ocupacao personagem_ocupacao NOT NULL,
    grupo_ocupacao personagem_grupo_ocupacao NOT NULL,
    berries INTEGER NOT NULL DEFAULT 0,
    CHECK(berries >= 0),
    energia INTEGER NOT NULL DEFAULT 0,
    CHECK(energia >= 0),
    energia_maxima INTEGER NOT NULL DEFAULT 0,
    CHECK(energia_maxima >= 0),
    fraqueza VARCHAR(20) NOT NULL,
    experiencia INTEGER NOT NULL,
    CHECK(experiencia >= 0),
    vida INTEGER NOT NULL,
    CHECK(vida >= 0),
    vida_maxima INTEGER NOT NULL,
    CHECK(vida_maxima >= 0),
    capacidade_de_itens INTEGER NOT NULL,
    CHECK(capacidade_de_itens > 0),

    CONSTRAINT fk_regiao FOREIGN KEY (id_regiao) 
        REFERENCES regiao(id_regiao) ON DELETE RESTRICT,

    CONSTRAINT fk_personagem FOREIGN KEY (id_personagem) 
        REFERENCES personagem(id_personagem) ON DELETE RESTRICT,

    CONSTRAINT fk_save FOREIGN KEY (nome_save) 
        REFERENCES save(nome) ON DELETE RESTRICT,
    
    PRIMARY KEY (nome_save, id_personagem)
);


CREATE TABLE IF NOT EXISTS inimigo (
    id_personagem INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL,
    id_regiao INTEGER NOT NULL,
    nome VARCHAR(20) NOT NULL,
    ocupacao personagem_ocupacao NOT NULL,
    grupo_ocupacao personagem_grupo_ocupacao NOT NULL,
    berries INTEGER NOT NULL DEFAULT 0,
    CHECK(berries >= 0),
    energia INTEGER NOT NULL DEFAULT 0,
    CHECK(energia >= 0),
    energia_maxima INTEGER NOT NULL DEFAULT 0,
    CHECK(energia_maxima >= 0),
    fraqueza VARCHAR(20) NOT NULL,
    experiencia INTEGER NOT NULL,
    CHECK(experiencia >= 0),
    vida INTEGER NOT NULL,
    CHECK(vida >= 0),
    vida_maxima INTEGER NOT NULL,
    CHECK(vida_maxima >= 0),
    respawn BOOLEAN NOT NULL DEFAULT FALSE,

    CONSTRAINT fk_regiao FOREIGN KEY (id_regiao) 
        REFERENCES regiao(id_regiao) ON DELETE RESTRICT,
    CONSTRAINT fk_personagem FOREIGN KEY (id_personagem) 
        REFERENCES personagem(id_personagem) ON DELETE RESTRICT,
    PRIMARY KEY (id_personagem)
);

CREATE TABLE IF NOT EXISTS personagem_nao_hostil (
    id_personagem INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL,
    id_regiao INTEGER NOT NULL,
    nome VARCHAR(20) NOT NULL,
    ocupacao personagem_ocupacao NOT NULL,
    grupo_ocupacao personagem_grupo_ocupacao NOT NULL,
    is_vendedor BOOLEAN NOT NULL DEFAULT FALSE,
    is_personagem_historia BOOLEAN NOT NULL DEFAULT FALSE,
    id_missao INTEGER DEFAULT NULL,

    CONSTRAINT fk_regiao FOREIGN KEY (id_regiao) 
        REFERENCES regiao(id_regiao) ON DELETE RESTRICT,
    CONSTRAINT fk_personagem FOREIGN KEY (id_personagem) 
        REFERENCES personagem(id_personagem) ON DELETE RESTRICT,
    PRIMARY KEY (id_personagem)
);

CREATE TABLE IF NOT EXISTS barco (
    id_barco INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL,
    id_regiao INTEGER NOT NULL,
    nome VARCHAR(30) NOT NULL,
    ocupacao personagem_ocupacao NOT NULL,
    grupo_ocupacao personagem_grupo_ocupacao NOT NULL,
    capacidade_de_itens INTEGER NOT NULL DEFAULT 0,
    CHECK(capacidade_de_itens >= 0),

    CONSTRAINT fk_regiao FOREIGN KEY (id_regiao) 
        REFERENCES regiao(id_regiao) ON DELETE RESTRICT,
    CONSTRAINT fk_personagem FOREIGN KEY (id_barco) 
        REFERENCES personagem(id_personagem) ON DELETE RESTRICT,
    PRIMARY KEY (id_barco)
);

CREATE TYPE tipo_poder_especial AS ENUM (
    'Kairoseki', 'Ferro', 'Mulher','Tritões','Água do Mar','Akuma no mi'
);


CREATE TABLE IF NOT EXISTS poder_especial (
    nome VARCHAR(40) NOT NULL,
    tipo_poder tipo_poder_especial NOT NULL,
    id_personagem INTEGER NOT NULL,
    descricao TEXT NOT NULL DEFAULT '',
    dano INTEGER NOT NULL,
    CHECK(dano >= 0),
    energia INTEGER NOT NULL,
    CHECK(energia >= 0),
    PRIMARY KEY (nome, id_personagem),
    CONSTRAINT fk_personagem FOREIGN KEY (id_personagem) 
        REFERENCES personagem(id_personagem) ON DELETE RESTRICT
);

-- Itens

CREATE TABLE IF NOT EXISTS item (
    id_item INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL,
    nome VARCHAR(20) NOT NULL,
    descricao TEXT NOT NULL DEFAULT '',
    preco INTEGER NOT NULL,
    CHECK(preco >= 0),
    qtd_energia INTEGER NOT NULL,
    CHECK(qtd_energia >= 0),
    qtd_vida INTEGER NOT NULL,
    CHECK(qtd_vida >= 0),
    qtd_dano INTEGER,
    CHECK(qtd_dano >= 0),
    is_equipavel BOOLEAN NOT NULL,

    PRIMARY KEY (id_item)
);

CREATE TABLE IF NOT EXISTS inventario (
    id_jogador_save VARCHAR(30) NOT NULL,
    id_jogador_personagem int not null,
    id_item INTEGER DEFAULT NULL,
    qtd_item INTEGER DEFAULT NULL,

    CONSTRAINT fk_jogador FOREIGN KEY (id_jogador_save,id_jogador_personagem) 
        REFERENCES jogador(nome_save,id_personagem) ON DELETE RESTRICT,
    CONSTRAINT fk_item FOREIGN KEY (id_item)
        REFERENCES item(id_item) ON DELETE RESTRICT,

    CONSTRAINT pk_inventario PRIMARY KEY (id_jogador_save,id_jogador_personagem, id_item)
);

-- Missão

CREATE TABLE IF NOT EXISTS missao (
    -- id personagem principal
    id_missao INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL,
    nome VARCHAR(35) NOT NULL,
    descricao TEXT NOT NULL DEFAULT '',
    qtd_experiencia INTEGER NOT NULL,
    CHECK(qtd_experiencia >= 0),
    dificuldade INTEGER NOT NULL,
    CHECK(dificuldade >= 0),
    id_nao_hostil INTEGER NOT NULL,

    CONSTRAINT fk_nao_hostil FOREIGN KEY (id_nao_hostil)
        REFERENCES personagem_nao_hostil(id_personagem) ON DELETE RESTRICT,
    PRIMARY KEY (id_missao)
);

CREATE TYPE objetivo_tipo AS ENUM (
    'PegarItem', 'DerrotarInimigo', 'FalarComNPC'
);

CREATE TABLE IF NOT EXISTS objetivo (
    id_missao INTEGER NOT NULL,
    id_objetivo INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL,
    nome VARCHAR(35) NOT NULL,
    descricao TEXT NOT NULL DEFAULT '',
    tipo objetivo_tipo NOT NULL,
    id_item INTEGER NULL,
    id_inimigo INTEGER NULL,
    id_nao_hostil INTEGER NULL,

    PRIMARY KEY (id_missao, id_objetivo),
    CONSTRAINT fk_missao FOREIGN KEY (id_missao) 
        REFERENCES missao(id_missao) ON DELETE RESTRICT,
    CONSTRAINT fk_item FOREIGN KEY (id_item)
        REFERENCES item(id_item) ON DELETE RESTRICT,
    CONSTRAINT fk_inimigo FOREIGN KEY (id_inimigo)
        REFERENCES inimigo(id_personagem) ON DELETE RESTRICT,
    CONSTRAINT fk_nao_hostil FOREIGN KEY (id_nao_hostil)
        REFERENCES personagem_nao_hostil(id_personagem) ON DELETE RESTRICT
);

CREATE TYPE objetivo_status_enum AS ENUM (
    'Bloqueado', 'Liberado', 'Concluido'
);

CREATE TABLE IF NOT EXISTS objetivo_status (
    id_missao INTEGER NOT NULL,
    id_objetivo INTEGER NOT NULL,
    id_jogador_save VARCHAR(30) NOT NULL,
    id_jogador_personagem int not null,
    status objetivo_status_enum NOT NULL,

    CONSTRAINT fk_objetivo FOREIGN KEY (id_missao, id_objetivo)
        REFERENCES objetivo(id_missao, id_objetivo),
    CONSTRAINT fk_jogador FOREIGN KEY (id_jogador_save,id_jogador_personagem)
        REFERENCES jogador(nome_save,id_personagem),

    PRIMARY KEY (id_objetivo, id_jogador_save,id_jogador_personagem)
);

commit;
