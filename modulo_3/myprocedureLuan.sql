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

