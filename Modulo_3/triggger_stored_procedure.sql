BEGIN;

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
BEGIN
    -- Cria o primeiro jogador para o novo save
    INSERT INTO jogador (nome_save, id_personagem, id_regiao, nome, ocupacao, grupo_ocupacao, berries, energia, energia_maxima, fraqueza, experiencia, vida, vida_maxima, capacidade_de_itens) 
        SELECT NEW.nome, 1, id_regiao, nome, ocupacao, grupo_ocupacao, berries, energia, energia_maxima, fraqueza, experiencia, vida, vida_maxima, capacidade_de_itens 
            FROM personagem_principal WHERE id_personagem = 1;

    -- Popula o inventario dos NPCs para o novo save baseado nos valores default
    INSERT INTO inventario_personagem (id_jogador_save, id_jogador_personagem, id_personagem, id_item, qtd_item)
        SELECT NEW.nome, 1, id_personagem, id_item, qtd_item FROM inventario_personagem_default;

    RETURN NEW;
END;
$create_save_jogador$ LANGUAGE plpgsql;

CREATE TRIGGER create_save_jogador
AFTER INSERT ON save
FOR EACH ROW EXECUTE PROCEDURE create_save_jogador();

    -- objetivo cumprido pra liberar o próximo - tabela

-- Bernardo
    -- trigger para missão cumprida
CREATE FUNCTION check_missao_cumprida() RETURNS trigger AS $check_missao_cumprida$
DECLARE
    obj_count INTEGER;
    obj_comc_count INTEGER;
    xp_missao INTEGER;
    xp_perso INTEGER;
BEGIN
    SELECT COUNT(*) INTO obj_count FROM objetivo_status WHERE NEW.id_missao = OLD.id_missao
    AND NEW.id_jogador_save = OLD.id_jogador_save
    AND NEW.id_jogador_personagem = OLD.id_jogador_personagem;

    SELECT COUNT(*) INTO obj_comc_count FROM objetivo_status
    WHERE NEW.objetivo_status_enum = 'Concluido'
    AND NEW.id_jogador_save = OLD.id_jogador_save;

    SELECT qtd_experiencia INTO xp_missao FROM missao WHERE NEW.id_missao = OLD.id_missao;
    SELECT experiencia INTO xp_perso FROM personagem_principal WHERE NEW.id_jogador_personagem = OLD.id_jogador_personagem;

    IF obj_count = obj_comp_count THEN UPDATE personagem_principal SET experiencia = xp_perso + xp_missao WHERE id_personagem = id_jogador_personagem;
    END IF;
    
END;
$check_missao_cumprida$ LANGUAGE plpgsql;

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

CREATE TRIGGER spawn_inimigo_trigger
    BEFORE UPDATE ON jogador
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

CREATE OR REPLACE procedure compra2(id_item_param INTEGER, qtd_item_param INTEGER, nome_jog VARCHAR(30),persona INTEGER,seller INTEGER)
AS $compra2$
declare 
    berry INTEGER;
    preco_compra INTEGER;
    preco_item INTEGER;
BEGIN
    Select berries into berry from jogador 
    WHERE nome_save = nome_jog and id_personagem = persona;

    select preco into preco_item from item where id_item = id_item_param;

    preco_compra = preco_item * qtd_item_param;

    -- if vc não tem grana, não compra.
    if berry < preco_compra  THEN 
        RAISE EXCEPTION 'Você não tem Berries suficiente para comprar.';
    end if;

    -- procura esse item no inventário, se já existir, atualiza
    perform * from inventario_jogador where id_jogador_save = nome_jog and
                                            id_jogador_personagem = persona and 
                                            id_item = id_item_param;
    IF FOUND THEN
        UPDATE inventario_jogador set qtd_item = qtd_item + qtd_item_param 
        where   id_jogador_save = nome_jog and
                id_jogador_personagem = persona and 
                id_item = id_item_param;
    -- se não insere
    ELSE 
        INSERT INTO inventario_jogador (id_jogador_save, id_jogador_personagem, id_item, qtd_item) 
        VALUES (nome_jog, persona, id_item_param, qtd_item_param);

    END IF;

    --                                 preço da compra
    UPDATE jogador SET berries = berries - preco_compra WHERE nome_save = nome_jog and id_personagem = persona;
    
    -- diminui o item do inventario do personagem vendedor
    update inventario_personagem SET qtd_item = qtd_item - qtd_item_param 
            where id_jogador_save = nome_jog
            and id_jogador_personagem = persona
            and id_item = id_item_param
            and id_personagem = seller;

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


CREATE trigger rihana after UPDATE on objetivo_status
for each ROW EXECUTE PROCEDURE check_missao();

CREATE OR REPLACE procedure libera_ilha(ilha_id INTEGER)
AS $libera_ilha$
declare 
    missao integer;

BEGIN

    select id_missao into missao from ilha 
    where id_ilha = ilha_id;

    update missao_status set status = 'Concluida' where id_missao = missao;

END;    

$libera_ilha$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION keep_regiao_anterior() RETURNS trigger AS $keep_regiao_anterior$

BEGIN
    IF (NEW.id_regiao <> OLD.id_regiao) THEN
        UPDATE jogador SET id_regiao_anterior = OLD.id_regiao WHERE nome_save = OLD.nome_save and id_personagem = OLD.id_personagem;
    END IF;

    return new;
END;
$keep_regiao_anterior$ LANGUAGE plpgsql;


CREATE TRIGGER keep_regiao_anterior_trigger
AFTER UPDATE ON jogador
FOR EACH ROW EXECUTE PROCEDURE keep_regiao_anterior();


CREATE OR REPLACE procedure consumo_item(vida_param INTEGER,energia_param INTEGER,id_item_param INTEGER,qntd_item_param INTEGER,nome_jog VARCHAR(30),id_persona INTEGER)
AS $consumo_item$
BEGIN
    update jogador set vida = vida + vida_param,energia=energia+energia_param where nome_save = nome_jog and id_personagem = id_persona;
    update inventario_jogador set qtd_item = qtd_item - qntd_item_param where id_jogador_save = nome_jog and id_jogador_personagem = id_persona and id_item = id_item_param;
END;
$consumo_item$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION verifica_vida_energia() RETURNS trigger AS $verifica_vida_energia$
BEGIN
    IF (NEW.vida <> OLD.vida) THEN
        IF(NEW.vida > OLD.vida_maxima) THEN 
            update jogador set vida = vida_maxima where nome_save = OLD.nome_save and id_personagem = OLD.id_personagem;
        END IF;
    END IF;

    IF (NEW.energia <> OLD.energia) THEN
        IF(NEW.energia > OLD.energia_maxima) THEN 
            update jogador set energia = energia_maxima where nome_save = OLD.nome_save and id_personagem = OLD.id_personagem;
        END IF;
    END IF;

    RETURN NEW;
END;
$verifica_vida_energia$ LANGUAGE plpgsql;


CREATE TRIGGER verifica_vida_energia_trigger
AFTER UPDATE ON jogador
FOR EACH ROW EXECUTE PROCEDURE verifica_vida_energia();


COMMIT;