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
    -- check missão cumprida pra liberar outra missão

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


-- Thalisson
    -- respawn e spawn dos inimigos em determinada região qnd tu entra lá.
CREATE OR REPLACE FUNCTION spawn_inimigo() RETURNS trigger AS $spawn_inimigo$
BEGIN
    IF (NEW.id_regiao <> OLD.id_regiao) THEN
        PERFORM * FROM inimigo WHERE id_regiao = NEW.id_regiao AND respawn = true;
        IF FOUND THEN
            UPDATE inimigo SET vida = vida_maxima, energia = energia_maxima WHERE id_regiao = NEW.id_regiao;
        END IF;
    END IF;
    RETURN NULL;
END;
$spawn_inimigo$ LANGUAGE plpgsql;

CREATE TRIGGER spawn_inimigo_trigger
    AFTER UPDATE ON jogador
    FOR EACH ROW EXECUTE PROCEDURE spawn_inimigo();

    -- compra de itens  

-- Nicolas 
    -- Atualiza nível consequentemente atualiza poder especial
    -- Inventário lotado, não pode receber item.

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


CREATE or replace FUNCTION  check_missao() RETURNs trigger AS $check_missao$
DECLARE
    obj_count INTEGER;
    obj_comp_count  INTEGER;
    xp_missao INTEGER;
    xp_perso INTEGER;
BEGIN   
    SELECT COUNT(*) INTO obj_count FROM objetivo_status 
    WHERE id_missao = OLD.id_missao
    AND id_jogador_save = OLD.id_jogador_save
    AND id_jogador_personagem = OLD.id_jogador_personagem;

    SELECT COUNT(*) INTO obj_comp_count FROM objetivo_status
    WHERE status = 'Concluido'
    AND id_jogador_save = OLD.id_jogador_save
    and id_missao = OLD.id_missao
    AND id_jogador_personagem = OLD.id_jogador_personagem;

    --return obj_comp_count;

    SELECT qtd_experiencia INTO xp_missao FROM missao WHERE id_missao = OLD.id_missao;

    --RAISE EXCEPTION 'Olá mundo % % %',xp_missao,obj_count,obj_comp_count;


    IF obj_count = obj_comp_count THEN 
        UPDATE personagem_principal SET experiencia = experiencia + xp_missao WHERE id_personagem = old.id_jogador_personagem ;
        --RAISE EXCEPTION 'Olá mundo % % %',xp_missao,1000000000000000,10000000000000;
        return new;
    END IF;
    return new;


END;

$check_missao$ LANGUAGE plpgsql;

drop trigger rihana on objetivo_status;


CREATE trigger rihana after UPDATE on objetivo_status
for each ROW EXECUTE PROCEDURE check_missao();


