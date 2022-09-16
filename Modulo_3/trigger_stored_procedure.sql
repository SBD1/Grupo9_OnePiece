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
    INSERT INTO jogador (nome_save, id_personagem, id_regiao, id_regiao_anterior, nome, ocupacao, grupo_ocupacao, berries, energia, energia_maxima, fraqueza, experiencia, vida, vida_maxima, capacidade_de_itens) 
        SELECT NEW.nome, 1, id_regiao, id_regiao_anterior, nome, ocupacao, grupo_ocupacao, berries, energia, energia_maxima, fraqueza, experiencia, vida, vida_maxima, capacidade_de_itens 
            FROM personagem_principal WHERE id_personagem = 1;

    -- Popula o inventario dos NPCs para o novo save baseado nos valores default
    INSERT INTO inventario_personagem (id_jogador_save, id_jogador_personagem, id_personagem, id_item, qtd_item)
        SELECT NEW.nome, 1, id_personagem, id_item, qtd_item FROM inventario_personagem_default;

    -- Libera a missao pro personagem
    INSERT INTO missao_status(id_missao, id_jogador_save, id_jogador_personagem, status) values
    ('1',new.nome, 1, 'Liberada');

    RETURN NEW;
END;
$create_save_jogador$ LANGUAGE plpgsql;

CREATE TRIGGER create_save_jogador
AFTER INSERT ON save
FOR EACH ROW EXECUTE PROCEDURE create_save_jogador();

    -- objetivo cumprido pra liberar o próximo - tabela

-- Bernardo
    -- trigger para missão cumprida
CREATE OR REPLACE FUNCTION check_missao_cumprida() RETURNS trigger AS $check_missao_cumprida$
BEGIN
    if new.status = 'Concluido' and old.status <> 'Concluido' and new.id_objetivo = (select max(id_objetivo) from objetivo where id_missao = new.id_missao) then
        UPDATE jogador j SET experiencia = experiencia + m.qtd_experiencia FROM missao m
        WHERE j.nome_save = new.id_jogador_save and j.id_personagem = new.id_jogador_personagem and m.id_missao = new.id_missao;
    end if;
    return new;
END;
$check_missao_cumprida$ LANGUAGE plpgsql;

CREATE trigger check_missao_cumprida BEFORE UPDATE ON objetivo_status
EXECUTE PROCEDURE check_missao_cumprida();

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
            WHERE id_regiao = NEW.id_regiao AND id_personagem = (SELECT id_inimigo FROM objetivo_atual(NEW.nome_save, NEW.id_personagem));
        -- Respawan inimigos comuns
        UPDATE inimigo SET vida = vida_maxima, energia = energia_maxima 
            WHERE id_regiao = NEW.id_regiao AND id_personagem NOT IN (SELECT DISTINCT(id_inimigo) FROM objetivo);
    END IF;
    RETURN NEW;
END;
$spawn_inimigo$ LANGUAGE plpgsql;

CREATE TRIGGER spawn_inimigo_trigger
    BEFORE UPDATE ON jogador
    FOR EACH ROW EXECUTE PROCEDURE spawn_inimigo();

    -- Pega próxima fala de um personagem
CREATE OR REPLACE FUNCTION proxima_fala(_id_personagem int, jog_save varchar(30), jog_persona int)
RETURNS TABLE (id_missao_liberada int, id_personagem int, id_conversa int, texto text, nome_display varchar(30)) AS $proxima_fala$
declare
    _missao int;
    _objetivo int;
    _conversa int;
    _missao_liberada int;
BEGIN
    select id_missao, id_objetivo into _missao, _objetivo from objetivo_atual(jog_save, jog_persona);

    if _missao is null then
        select c.id_conversa, c.id_missao_liberada into _conversa, _missao_liberada from conversa c left join conversa_concluida s on 
            c.id_personagem = s.id_personagem and c.id_conversa = s.id_conversa
            and (s.id_jogador_save is null or s.id_jogador_save <> jog_save) and (s.id_jogador_personagem is null or s.id_jogador_personagem <> jog_persona)
        where s is null and c.id_personagem=_id_personagem and c.id_missao is null and c.id_objetivo is null 
        order by id_conversa limit 1;
    else
        select c.id_conversa, c.id_missao_liberada into _conversa, _missao_liberada from conversa c left join conversa_concluida s on 
            c.id_personagem = s.id_personagem and c.id_conversa = s.id_conversa
            and (s.id_jogador_save is null or s.id_jogador_save <> jog_save) and (s.id_jogador_personagem is null or s.id_jogador_personagem <> jog_persona)
        where s is null and c.id_personagem=_id_personagem and c.id_missao=_missao and c.id_objetivo=_objetivo 
        order by id_conversa limit 1;
    end if;

    return query select _missao_liberada as id_missao_liberada, f.id_personagem, f.id_conversa, f.texto, f.nome_display
        from fala f where f.id_conversa=_conversa and f.id_personagem=_id_personagem order by id_fala;
END;
$proxima_fala$ LANGUAGE plpgsql;

    -- Concluir conversa
CREATE OR REPLACE FUNCTION concluir_objetivo_conversa() RETURNS trigger AS $concluir_objetivo_conversa$
declare
    _id_missao int;
BEGIN
    -- Conclui o objetivo da conversa
    UPDATE objetivo_status os SET status = 'Concluido' 
        FROM objetivo o
        WHERE o.id_missao = os.id_missao AND o.id_objetivo = os.id_objetivo AND 
            status = 'Em andamento' AND o.id_conversa_personagem = NEW.id_personagem AND o.id_conversa = NEW.id_conversa AND NEW.id_jogador_save = os.id_jogador_save AND NEW.id_jogador_personagem = os.id_jogador_personagem;

    -- Libera a missão da conversa
    select id_missao_liberada into _id_missao from conversa where id_personagem = new.id_personagem and id_conversa = new.id_conversa;
    if _id_missao is not null then
        insert into objetivo_status (id_missao, id_objetivo, id_jogador_save, id_jogador_personagem, status)
            values (_id_missao, 1, new.id_jogador_save, new.id_jogador_personagem, 'Em andamento')
            on conflict (id_objetivo, id_missao, id_jogador_save, id_jogador_personagem)
            do update set status = excluded.status;
    end if;    

    RETURN NEW;
END;
$concluir_objetivo_conversa$ LANGUAGE plpgsql;

CREATE TRIGGER concluir_objetivo_conversa
    AFTER INSERT ON conversa_concluida
    FOR EACH ROW EXECUTE PROCEDURE concluir_objetivo_conversa();

    -- Pega objetivo atual
CREATE OR REPLACE FUNCTION objetivo_atual(jog_save varchar(30), jog_persona int) 
RETURNS table(id_missao int, id_objetivo int, nome varchar(35), descricao text, id_item integer, id_inimigo integer, id_conversa_personagem integer, id_conversa integer) AS $objetivo_atual$
    select o.id_missao, o.id_objetivo, m.nome, o.descricao, o.id_item, o.id_inimigo, o.id_conversa_personagem, o.id_conversa
        from objetivo o INNER JOIN objetivo_status os ON 
            o.id_missao = os.id_missao AND o.id_objetivo = os.id_objetivo AND 
                os.id_jogador_save = jog_save AND os.id_jogador_personagem = jog_persona 
        INNER JOIN missao m ON o.id_missao = m.id_missao WHERE os.status = 'Em andamento';
$objetivo_atual$ LANGUAGE sql;

    -- Vai para o próximo objetivo caso ele seja concluido
CREATE OR REPLACE FUNCTION proximo_objetivo() RETURNS trigger AS $proximo_objetivo$
BEGIN
    IF (new.status = 'Concluido' and old.status <> 'Concluido') THEN
        perform * from objetivo where id_missao = new.id_missao and id_objetivo = new.id_objetivo + 1;
        if found then
            insert into objetivo_status (id_missao, id_objetivo, id_jogador_save, id_jogador_personagem, status)
            values (new.id_missao, new.id_objetivo + 1, new.id_jogador_save, new.id_jogador_personagem, 'Em andamento')
            on conflict (id_objetivo,id_missao, id_jogador_save, id_jogador_personagem)
            do update set status = excluded.status;
        end if;
    END IF;

    RETURN NEW;
END;
$proximo_objetivo$ LANGUAGE plpgsql;

CREATE TRIGGER proximo_objetivo
    AFTER UPDATE ON objetivo_status
    FOR EACH ROW EXECUTE PROCEDURE proximo_objetivo();

    -- Atacar e Concluir objetivo de derrotar inimigo
CREATE OR REPLACE procedure derrotar_inimigo(jog_save varchar(30), jog_persona int, _id_inimigo int) AS $derrotar_inimigo$
BEGIN
    update inimigo set vida = 0 where id_personagem = _id_inimigo;

    update objetivo_status os SET status = 'Concluido' 
        from objetivo o 
    WHERE os.status = 'Em andamento' and o.id_missao = os.id_missao AND o.id_objetivo = os.id_objetivo
        and os.id_jogador_save = jog_save and os.id_jogador_personagem = jog_persona and o.id_inimigo = _id_inimigo;
END;
$derrotar_inimigo$ LANGUAGE plpgsql;

    -- Concluir objetivo de pegar item
CREATE OR REPLACE FUNCTION concluir_objetivo_item() RETURNS trigger AS $concluir_objetivo_item$
BEGIN
    UPDATE objetivo_status os SET status = 'Concluido' 
        FROM objetivo o
        WHERE o.id_missao = os.id_missao AND o.id_objetivo = os.id_objetivo AND 
            status = 'Em andamento' AND o.id_item = NEW.id_item AND NEW.id_jogador_save = os.id_jogador_save AND NEW.id_jogador_personagem = os.id_jogador_personagem;
    RETURN NEW;
END;
$concluir_objetivo_item$ LANGUAGE plpgsql;

CREATE TRIGGER concluir_objetivo_item
    AFTER INSERT ON inventario_jogador
    FOR EACH ROW EXECUTE PROCEDURE concluir_objetivo_item();

    -- Transferir item do inventário de um personagem para o jogador
CREATE OR REPLACE procedure transferir_item(jog_save varchar(30), jog_persona int, _id_personagem int, _id_item int, _qtd_item int) AS $transferir_item$
BEGIN
    if _qtd_item <= 0 then
        raise exception 'qtd_item deve ser um inteiro positivo';
    end if;

    if _qtd_item > (select coalesce(qtd_item, 0) from inventario_personagem where id_personagem = _id_personagem and id_item = _id_item and id_jogador_save = jog_save and id_jogador_personagem = jog_persona) then
        raise exception 'O personagem não possui itens suficientes';
    end if;

    update inventario_personagem set qtd_item = qtd_item - _qtd_item where id_personagem = _id_personagem and id_item = _id_item and id_jogador_save = jog_save and id_jogador_personagem = jog_persona;

    insert into inventario_jogador 
        (id_jogador_save, id_jogador_personagem, id_item, qtd_item) values 
        (jog_save, jog_persona, _id_item, _qtd_item)
    on conflict (id_jogador_save, id_jogador_personagem, id_item)
    do update set qtd_item = excluded.qtd_item + _qtd_item;
END;
$transferir_item$ LANGUAGE plpgsql;

    -- Remove item do inventário jogador
CREATE OR REPLACE FUNCTION remover_item_inv_jogador() RETURNS trigger AS $remover_item_inv_jogador$
BEGIN
    if new.qtd_item = 0 then
        delete from inventario_jogador where id_jogador_save = new.id_jogador_save and id_jogador_personagem = new.id_jogador_personagem and id_item = new.id_item;
    end if;
    return new;
END;
$remover_item_inv_jogador$ LANGUAGE plpgsql;

CREATE TRIGGER remover_item_inv_jogador
    AFTER UPDATE ON inventario_jogador
    FOR EACH ROW EXECUTE PROCEDURE remover_item_inv_jogador();

    -- Remove item do inventário personagem
CREATE OR REPLACE FUNCTION remover_item_inv_personagem() RETURNS trigger AS $remover_item_inv_personagem$
BEGIN
    if new.qtd_item = 0 then
        delete from inventario_personagem where id_jogador_save = new.id_jogador_save and id_jogador_personagem = new.id_jogador_personagem and id_item = new.id_item and id_personagem = new.id_personagem;
    end if;
    return new;
END;
$remover_item_inv_personagem$ LANGUAGE plpgsql;

CREATE TRIGGER remover_item_inv_personagem
    AFTER UPDATE ON inventario_personagem
    FOR EACH ROW EXECUTE PROCEDURE remover_item_inv_personagem();


    -- Inventário lotado, não pode receber item.
CREATE OR REPLACE FUNCTION check_inventario() 
RETURNS trigger
AS $check_inventario$

DECLARE
    itens_total INTEGER;
    max_itens INTEGER;
    new_itens INTEGER;

BEGIN
    -- pega o total de itens que o personagem carrega e sua capacidade maxiam
    SELECT SUM(qtd_item) INTO itens_total FROM inventario_personagem WHERE id_personagem = NEW.id_personagem;
    SELECT capacidade_de_itens INTO max_itens FROM personagem_principal WHERE id_personagem = NEW.id_personagem;
    
    -- verifica se o novo total de itens cabe no inventario 
    IF( itens_total > max_itens ) THEN
        RAISE EXCEPTION 'Espaço insuficiente!';
    END IF;
    return new;
END;

$check_inventario$ LANGUAGE plpgsql;

CREATE trigger check_inventario AFTER UPDATE ON inventario_personagem
FOR EACH ROW EXECUTE PROCEDURE check_inventario();

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
declare
    _qtd_item int;
BEGIN
    select qtd_item into _qtd_item from inventario_jogador where id_jogador_save = nome_jog and id_jogador_personagem = id_persona and id_item = id_item_param;
    if _qtd_item is null then
        raise exception 'Você não possui este item';
    end if;

    if _qtd_item <= 0 then
        raise exception 'Não é possível comprar uma quantidade negativa';
    end if;

    if _qtd_item - qntd_item_param < 0 then
        raise exception 'Você não tem item suficiente';
    end if;

    update jogador set vida = vida + vida_param*qntd_item_param ,energia=energia+energia_param*qntd_item_param where nome_save = nome_jog and id_personagem = id_persona;
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


CREATE OR REPLACE FUNCTION missaoconcluida() RETURNS trigger AS $missaoconcluida$
BEGIN
    if new.status = 'Concluido' and old.status <> 'Concluido' and new.id_objetivo = (select max(id_objetivo) from objetivo where id_missao = new.id_missao) then
		update missao_status set status = 'Concluida' 
		where id_jogador_save = new.id_jogador_save and id_jogador_personagem = new.id_jogador_personagem and id_missao = new.id_missao;
		INSERT INTO missao_status(id_missao, id_jogador_save, id_jogador_personagem, status) values
        (new.id_missao+1,new.id_jogador_save, new.id_jogador_personagem, 'Liberada');

        -- dá mais um poder especial pro jogador
        insert into poder_jogador values (new.id_jogador_save,new.id_jogador_personagem,new.id_missao);

        -- dá grana pro cara
        update jogador set berries = berries + 300 where nome_save = new.id_jogador_save and id_personagem = new.id_jogador_personagem;
        
        -- atualiza experiencia
    end if;
    return new;
END;
$missaoconcluida$ LANGUAGE plpgsql;

CREATE trigger missaoconcluida after UPDATE ON objetivo_status
for each row execute PROCEDURE missaoconcluida();

commit;
