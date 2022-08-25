--Missão

-- SP para verificar se a missão ja foi concluida e adicionar xp para personagem
CREATE FUNCTION check_missao_cumprida(id_missao_ INTEGER, id_jogador_save_ INTEGER, id_jogador_personagem_ INTEGER) RETURN trigger AS $check_missao_cumprida$
DECLARE
    obj_count INTEGER  
    obj_comp_count  INTEGER
    xp_missao INTEGER
    xp_perso INTEGER
BEGIN
    SELECT COUNT(*) INTO obj_count FROM objetivo_status WHERE id_missao = id_missao_
    AND id_jogador_save = id_jogador_save_
    AND id_jogador_personagem = id_jogador_personagem_;

    SELECT COUNT(*) INTO obj_comp_count FROM objetivo_status
    WHERE objetivo_status_enum = 'Concluido'
    AND id_jogador_save = id_jogador_save_
    AND id_jogador_personagem = id_jogador_personagem_;

    SELECT qtd_experiencia INTO xp_missao FROM missao WHERE id_missao = id_missao_;
    SELECT experiencia INTO xp_perso FROM personagem_principal WHERE id_jogador_personagem = id_jogador_personagem_;

    IF obj_count = obj_comp_count THEN UPDATE personagem_principal SET experiencia = xp_perso + xp_missao WHERE id_personagem = id_jogador_personagem;
    ELSE return 'Missao nao foi cumprida'

END;
$check_missao_cumprida$ LANGUAGE plpgsql;

CREATE trigger check_missao_cumprida after delete on contrato 
for each row execute procedure desativar_contrato();

-- Item

-- SP para dropar item do inventário
CREATE FUNCTION drop_item(id_jogador_ INTEGER, id_jogador_personagem_ INTEGER, id_item_ INTEGER, qtd_item_dropado INTEGER) RETURN trigger AS $drop_item$

BEGIN
    
UPDATE inventario SET qtd_item = qtd_item - qtd_item_dropado 
WHERE id_jogador = id_jogador_ AND
id_item = id_item_ AND
id_jogador_personagem = id_jogador_personagem_

END;
