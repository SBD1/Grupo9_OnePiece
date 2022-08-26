
--Vitor
    -- Cria jogador, Cria um personagem principal pro Jogador #cria instancia de Inimigo,principal,não-hostil 
    -- objetivo cumprido pra liberar o próximo - tabela

-- Bernardo
    -- check missão cumprida pra liberar outra missão
    -- dropa item 

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

CREATE OR REPLACE procedure compra2(preco INTEGER, nome_jog VARCHAR(30),persona INTEGER)
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

    --                                 preço do item
    UPDATE jogador SET berries = berries - preco WHERE nome_save = nome_jog and id_personagem = persona;

END;    

$compra2$ LANGUAGE plpgsql;

-- quando 



    -- Quando conclui missão, libera ilha
        -- conclui objetivo, marca ilha liberada

--call compra2(50,'jogador1',1);


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


