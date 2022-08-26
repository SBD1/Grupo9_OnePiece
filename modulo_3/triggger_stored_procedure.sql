
--Vitor
    -- Cria jogador, Cria um personagem principal pro Jogador #cria instancia de Inimigo,principal,não-hostil 
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
    -- compra de itens

-- Nicolas 
    -- Atualiza nível consequentemente atualiza poder especial
    -- Inventário lotado, não pode receber item.

-- Luan Vasco
    -- compra um item tem que diminuir o dinheiro
    -- Quando conclui missão, libera ilha
        -- conclui objetivo, marca ilha liberada
