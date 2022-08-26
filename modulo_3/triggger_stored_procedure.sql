
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

-- Luan Vasco
    -- compra um item tem que diminuir o dinheiro
    -- Quando conclui missão, libera ilha
        -- conclui objetivo, marca ilha liberada
