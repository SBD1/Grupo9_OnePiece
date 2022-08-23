-- Missão

CREATE FUNCTION check_status_objetivo(id_missao INTEGER,id_objetivo INTEGER, id_jogador_save INTEGER,id_jogador_personagem INTEGER) RETURN trigger AS $check_status_objetivo$

BEGIN
    

    CASE (SELECT objetivo_status_enum FROM objetivo_status
    WHERE id_missao = id_missao AND
    WHERE id_objetivo = id_objetivo AND
    WHERE id_jogador_save = id_jogador_save AND
    WHERE id_jogador_personagem = id_jogador_personagem;)
        WHEN 'Bloqueado' THEN RETURN 'Esse objetivo esta bloqueado no momento'
        WHEN 'Concluido' THEN RETURN 'Esse objetivo já foi concluido'
        ELSE RETURN 'Esse objetivo está liberado.'
    END;
END;
$check_status_objetivo$ LANGUAGE plpgsql;

-- SP para verificar se a missão ja foi concluida
CREATE FUNCTION check_missao_cumprida(id_missao INTEGER, id_jogador_save INTEGER, id_jogador_personagem INTEGER) RETURN trigger AS $check_missao_cumprida$
BEGIN
    SELECT objetivo_status_enum FROM objetivo_status
    WHERE id_missao = id_missao AND
    WHERE id_jogador_save = id_jogador_save AND
    WHERE id_jogador_personagem = id_jogador_personagem;



END;

-- Item

-- SP para dropar item do inventário
CREATE FUNCTION drop_item(id_jogador_ INTEGER, id_jogador_personagem_ INTEGER, id_item_ INTEGER, qtd_item_dropado INTEGER) RETURN trigger AS $drop_item$

BEGIN
    
UPDATE inventario SET qtd_item = qtd_item - qtd_item_dropado 
WHERE id_jogador = id_jogador_ AND
id_item = id_item_ AND
id_jogador_personagem = id_jogador_personagem_

END;
