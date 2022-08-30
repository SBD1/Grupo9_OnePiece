--- TRIGGERS PARA MANTER AS REGRAS DE GENERALIZAÇÃO E ESPECIALIZAÇÃO

CREATE OR REPLACE FUNCTION check_personagem_nao_hostil() RETURNS TRIGGER AS $check_personagem_nao_hostil$
BEGIN
    PERFORM * FROM personagem_principal WHERE id_personagem = NEW.id_personagem;
    IF FOUND THEN 
			RAISE EXCEPTION 'Este personagem já se encontra na tabela personagem principal';
    END IF;
    RETURN NEW;

END;
$check_personagem_nao_hostil$ LANGUAGE plpgsql;

CREATE TRIGGER check_personagem_nao_hostil
BEFORE UPDATE OR INSERT ON personagem_nao_hostil
FOR EACH ROW EXECUTE PROCEDURE check_personagem_nao_hostil();

CREATE OR REPLACE FUNCTION check_personagem() RETURNS trigger as $check_personagem$
BEGIN

    PERFORM * FROM personagem_principal WHERE id_personagem = NEW.id_personagem;
    IF FOUND THEN 
			RAISE EXCEPTION 'Este personagem já se encontra na tabela personagem principal';
    END IF;
    RETURN NEW;            

END;
$check_personagem$ LANGUAGE plpgsql;

CREATE TRIGGER check_personagem
BEFORE UPDATE OR INSERT ON inimigo
FOR EACH ROW EXECUTE PROCEDURE check_personagem();

CREATE OR REPLACE FUNCTION check_barco() RETURNS trigger as $check_barco$
BEGIN

    PERFORM * FROM personagem_principal WHERE id_personagem = NEW.id_barco;
    IF FOUND THEN 
			RAISE EXCEPTION 'Este personagem já se encontra na tabela personagem principal';
    END IF;
    RETURN NEW;            

END;
$check_barco$ LANGUAGE plpgsql;

CREATE TRIGGER check_barco
BEFORE UPDATE OR INSERT on barco
FOR EACH ROW EXECUTE PROCEDURE check_barco();


--Vitor
    -- Cria jogador, Cria um personagem principal pro Jogador
CREATE OR REPLACE FUNCTION create_save_jogador() RETURNS TRIGGER as $create_save_jogador$
DECLARE
save_player VARCHAR(30);

BEGIN
    SELECT nome into save_player from save
    WHERE nome = NEW.nome;
    
    INSERT INTO jogador VALUES(save_player,1,1,'Monkey D. Luffy','Pirata','Piratas do Chapéu de Palha',150,100,100,'Kairoseki',1,100,120,10);
    RETURN NEW;
END;
$create_save_jogador$ LANGUAGE plpgsql;

CREATE TRIGGER create_save_jogador
AFTER INSERT ON save
FOR EACH ROW EXECUTE PROCEDURE create_save_jogador();

    -- objetivo cumprido pra liberar o próximo - tabela

-- Bernardo
    -- trigger para missão cumprida
CREATE FUNCTION check_missao_cumprida() RETURN trigger AS $check_missao_cumprida$
DECLARE
    obj_count INTEGER,  
    obj_comc_count  INTEGER,
    xp_missao INTEGER,
    xp_perso INTEGER
BEGIN
    SELECT COUNT(*) INTO obj_count FROM objetivo_status WHERE NEW.id_missao = OLD.id_missao
    AND NEW.id_jogador_save = OLD.id_jogador_save
    AND NEW.id_jogador_personagem = OLD.id_jogador_personagem;

    SELECT COUNT(*) INTO obj_comc_count FROM objetivo_status
    WHERE NEW.objetivo_status_enum = 'Concluido'
    AND NEW.id_jogador_save = OLD.id_jogador_save

    SELECT qtd_experiencia INTO xp_missao FROM missao WHERE NEW.id_missao = OLD.id_missao;
    SELECT experiencia INTO xp_perso FROM personagem_principal WHERE NEW.id_jogador_personagem = OLD.id_jogador_personagem;

    IF obj_count = obj_comp_count THEN UPDATE personagem_principal SET experiencia = xp_perso + xp_missao WHERE id_personagem = id_jogador_personagem;
    END IF;
    
END;


CREATE trigger check_missao_cumprida AFTER UPDATE ON objetivo_status
for each ROW EXECUTE PROCEDURE check_missao_cumprida();

    -- Procedure para quando o jogador mata um inimigo
CREATE OR REPLACE PROCEDURE inimigo_morre(id_jogador_param INTEGER, id_inimigo_param INTEGER, nome_save_param VARCHAR(30) ) AS $inimigo_morre$
DECLARE

vida_inimigo INTEGER;
experiencia_jogador INTEGER;
exeperiencia_inimigo INTEGER;

BEGIN
 
    SELECT vida INTO vida_inimigo FROM inimigo WHERE id_personagem = OLD.id_personagem; -- pega a vida do inimigo
    SELECT experiencia INTO experiencia_jogador FROM jogador WHERE id_jogador = id_jogador_param; -- pega a experiencia do jogador
    SELECT experiencia INTO exeperiencia_inimigo FROM inimigo WHERE id_inimigo = id_inimigo_param; -- pega a experiencia do inimigo
    
    IF vida_inimigo <= 0 THEN UPDATE jogador SET experiencia = experiencia_jogador + exeperiencia_inimigo
    WHERE  id_personagem = id_jogador_param
    AND nome_save = nome_save_param;
    END IF;
END;
$inimigo_morre$ LANGUAGE plpgsql;

-- Thalisson
    -- respawn e spawn dos inimigos em determinada região qnd tu entra lá.
CREATE OR REPLACE FUNCTION spawn_inimigo() RETURNS trigger AS $spawn_inimigo$
BEGIN
    IF (NEW.id_regiao <> OLD.id_regiao) THEN
        -- Respawna inimigos de missões
        UPDATE inimigo SET vida = vida_maxima, energia = energia_maxima 
            WHERE id_regiao = NEW.id_regiao AND (id_missao, id_objetivo) IN (SELECT id_missao,id_objetivo FROM objetivo_status WHERE status='Em andamento' AND id_jogador_save = NEW.nome_save AND id_jogador_personagem = NEW.id_personagem);
        -- Respawan inimigos comuns
        UPDATE inimigo SET vida = vida_maxima, energia = energia_maxima 
            WHERE id_regiao = NEW.id_regiao;
    END IF;
    RETURN NEW;
END;
$spawn_inimigo$ LANGUAGE plpgsql;

DROP TRIGGER spawn_inimigo_trigger ON jogador;
CREATE TRIGGER spawn_inimigo_trigger
    BEFORE UPDATE ON jogador
    FOR EACH ROW EXECUTE PROCEDURE spawn_inimigo();

    -- compra de itens  

-- Nicolas (Tenho que revisar)
    -- Atualiza nível consequentemente atualiza poder especial
CREATE OR REPLACE FUNCTION level_up() 
RETURNS trigger
AS $level_up$

DECLARE
    xp_atual INTEGER;

BEGIN
    SELECT experiencia INTO xp_atual FROM personagem_principal WHERE id_personagem = NEW.id_personagem;

    IF(xp_atual >= 20) THEN

        PERFORM * FROM poder_especial WHERE nome = 'Gomu Gomu no Pistol';
        IF NOT FOUND THEN 
            INSERT INTO poder_especial (nome,tipo_poder ,id_personagem, descricao, dano, energia) VALUES
            ('Gomu Gomu no Pistol','Akuma no mi',1,'Soco pistola do Luffy',80,50);
        END IF;

    END IF;
    IF(xp_atual >= 40) THEN
        PERFORM * FROM poder_especial WHERE nome = 'Gomu Gomu no Gatling Gun';
        IF NOT FOUND THEN 
            INSERT INTO poder_especial (nome,tipo_poder ,id_personagem, descricao, dano, energia) VALUES
            ('Gomu Gomu no Gatling Gun','Akuma no mi',1,'Metralhadora de Soco pistola do Luffy',140,100);    
        END IF;
    END IF;
    IF(xp_atual >= 100) THEN
        PERFORM * FROM poder_especial WHERE nome = 'Gomu Gomu no Axe';
        IF NOT FOUND THEN 
            INSERT INTO poder_especial (nome,tipo_poder ,id_personagem, descricao, dano, energia) VALUES
            ('Gomu Gomu no Axe','Akuma no mi',1,'Luffy estica o pé lá no alto e desce de uma vez dando uma pézada da peste.',160,80);    
        END IF;
    END IF;
    IF(xp_atual >= 200 ) THEN
        PERFORM * FROM poder_especial WHERE nome = 'Gomu Gomu no Rocket';
        IF NOT FOUND THEN 
            INSERT INTO poder_especial (nome,tipo_poder ,id_personagem, descricao, dano, energia) VALUES
            ('Gomu Gomu no Rocket','Akuma no mi',1,'Luffy se lança para atingir o alvo.',50,25);    
        END IF;
    END IF;
    return new;
END;

$level_up$ LANGUAGE plpgsql;

CREATE trigger level_up AFTER UPDATE ON personagem_principal
FOR EACH ROW EXECUTE PROCEDURE level_up();

    -- Inventário lotado, não pode receber item.
CREATE OR REPLACE FUNCTION check_inventario() 
RETURNS trigger
AS $check_inventario$

DECLARE
    itens_total INTEGER;
    max_itens INTEGER;
    new_itens INTEGER;

BEGIN
    -- pega o total de itens que o personagem carrega e sua capacidade maxiam
    SELECT SUM(qtd_item) INTO itens_total FROM inventario_personagem WHERE id_personagem = NEW.id_personagem;
    SELECT capacidade_de_itens INTO max_itens FROM personagem_principal WHERE id_personagem = NEW.id_personagem;
    
    -- verifica se o novo total de itens cabe no inventario 
    IF( itens_total > max_itens ) THEN
        RAISE EXCEPTION 'Inventário Cheio!';
    END IF;
    return new;
END;

$check_inventario$ LANGUAGE plpgsql;

CREATE trigger check_inventario AFTER UPDATE ON inventario_personagem
FOR EACH ROW EXECUTE PROCEDURE check_inventario();
    

-- check_missao Vasco
    -- compra um item tem que diminuir o dinheiro

-- antes do insert ================== tem que checar se está vazio o inventário
-- tirar dinheiro do personagem principal && jogador
-- preço do item
-- como funciona a compra ? 
--      vc fala com um npc e o npc te oferece itens do inventário dele
--      se aceitar a compra, tem que tirar a grana do jogador e incrementar no npc 

CREATE OR REPLACE procedure compra2(id_item INTEGER, qtd_item INTEGER, nome_jog VARCHAR(30),persona INTEGER)
AS $compra2$
declare 
    berry INTEGER;
BEGIN
    Select berries into berry from jogador 
    WHERE nome_save = nome_jog and id_personagem = persona;

    -- if vc não tem grana, não compra.
    if berry < preco  THEN 
        RAISE EXCEPTION 'Você não tem Berries suficiente para comprar.';
    end if;

    INSERT INTO inventario_jogador (id_jogador_save, id_jogador_personagem, id_item, qtd_item) 
        VALUES (nome_jog, persona, id_item, qtd_item);

    --                                 preço do item
    UPDATE jogador SET berries = berries - preco WHERE nome_save = nome_jog and id_personagem = persona;
END;

$compra2$ LANGUAGE plpgsql;


CREATE or replace FUNCTION check_missao() RETURNs trigger AS $check_missao$
DECLARE
    obj_count INTEGER;
    obj_comp_count  INTEGER;
    xp_missao INTEGER;
    xp_perso INTEGER;
BEGIN
    IF OLD.status = NEW.status THEN
        RETURN NEW;
    END IF;

    SELECT COUNT(*) INTO obj_count FROM objetivo 
    WHERE id_missao = OLD.id_missao;

    SELECT COUNT(*) INTO obj_comp_count FROM objetivo_status
    WHERE status = 'Concluido'
    AND id_jogador_save = OLD.id_jogador_save
    and id_missao = OLD.id_missao
    AND id_jogador_personagem = OLD.id_jogador_personagem;

    IF obj_count <> obj_comp_count THEN
        RETURN NEW;
    END IF;

    SELECT qtd_experiencia INTO xp_missao FROM missao WHERE id_missao = OLD.id_missao;

    UPDATE jogador SET experiencia = experiencia + xp_missao WHERE id_personagem = old.id_jogador_personagem AND nome_save = old.id_jogador_save;
    return new;
END;
$check_missao$ LANGUAGE plpgsql;

drop trigger rihana on objetivo_status;


CREATE trigger rihana after UPDATE on objetivo_status
for each ROW EXECUTE PROCEDURE check_missao();








