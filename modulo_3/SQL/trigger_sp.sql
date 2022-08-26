--Missão

CREATE trigger check_missao_cumprida after delete on contrato 
for each row execute procedure desativar_contrato();

-- Item

-- SP para para matar inimigo
CREATE FUNCTION matar_inimigo() RETURN trigger AS $matar_inimigo$
DECLARE

vida_inimigo integer;
experiencia_perso_principal integer;
exeperiencia_inimigo integer

BEGIN
 
    SELECT vida INTO vida_inimigo FROM inimigo WHERE id_personagem = OLD.id_personagem; -- pega a vida do inimigo
    SELECT experiencia INTO experiencia_perso_principal FROM personagem_principal;
    SELECT experiencia INTO exeperiencia_inimigo FROM inimigo;
    
    IF vida_inimigo <= 0 THEN UPDATE personagem_principal SET experiencia = experiencia_perso_principal + exeperiencia_inimigo
    WHERE  id_personagem = id_jogador_personagem;
    END IF;
END;


CREATE trigger matar_inimigo after update on inimigo
for each row execute procedure matar_inimigo();