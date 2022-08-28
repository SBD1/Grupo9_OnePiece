--Missão

CREATE trigger check_missao_cumprida after delete on contrato 
for each row execute procedure desativar_contrato();

-- Item

-- SP para quando o inimigo for morto
CREATE PROCEDURE inimigo_morre(id_jogador_param INTEGER, id_inimigo_param INTEGER, nome_save_param VARCHAR(30) ) AS $matar_inimigo$
DECLARE

vida_inimigo INTEGER;
experiencia_perso_principal INTEGER;
exeperiencia_inimigo INTEGER

BEGIN
 
    SELECT vida INTO vida_inimigo FROM inimigo WHERE id_personagem = OLD.id_personagem; -- pega a vida do inimigo
    SELECT experiencia INTO experiencia_perso_principal FROM jogador WHERE id_jogador = id_jogador_param; -- pega a experiencia do personagem principal
    SELECT experiencia INTO exeperiencia_inimigo FROM inimigo WHERE id_inimigo = id_inimigo_param; -- pega a experiencia do inimigo
    
    IF vida_inimigo <= 0 THEN UPDATE jogador SET experiencia = experiencia_perso_principal + exeperiencia_inimigo
    WHERE  id_personagem = id_jogador_personagem
    AND nome_save = nome_save_param;
    END IF;
END;


CREATE trigger inimigo_morto after update on inimigo
for each row execute procedure inimigo_morto();