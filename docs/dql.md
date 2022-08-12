## Versão Atual

```sql92
-- Poder especial
SELECT nome, id_personagem_principal, descricao, dano, energia
FROM poder_especial;

SELECT nome, descricao 
FROM poder_especial 
WHERE dano > 900 AND energia >= 300;

SELECT * FROM poder_especial WHERE nome='Tankman';

-- Objetivo
SELECT * FROM objetivo WHERE is_active = true;

SELECT * FROM objetivo WHERE id_missao = %d;

SELECT * FROM objetivo WHERE is_completed = true;

SELECT * FROM objetivo WHERE id_missao = %d AND id_objetivo = %d;

-- Missao
SELECT * FROM missao WHERE id_missao = %d;

SELECT qtd_experiencia 
FROM missao 
WHERE id_missao = 1;

UPDATE personagem_principal 
SET experiencia = experiencia + 10 
WHERE id_personagem = 1;

-- Inventario

SELECT inventario.id_personagem, item.nome,item.descricao, item.preco, item.qtd_energia, item.qtd_vida,item.qtd_dano, personagem_principal.nome
from inventario 
INNER JOIN item on inventario.id_item = item.id_item
JOIN personagem_principal on inventario.id_personagem = personagem_principal.id_personagem;

-- Barco

SELECT id_barco, nome, ocupacao, grupo_ocupacao, capacidade_de_itens
FROM barco;

SELECT * FROM barco WHERE nome='Moby Dick';

-- Item
SELECT * FROM item WHERE is_equipavel= 'TRUE';
SELECT * FROM item where is_equipavel = 'FALSE';

SELECT nome, descricao, preco, qtd_energia, qtd_vida FROM item where nome = 'bergamota';
SELECT nome, descricao, preco, qtd_energia, qtd_vida FROM item where nome = 'melancia';
SELECT nome, descricao, preco, qtd_energia, qtd_vida FROM item where nome = 'guarana';
SELECT nome, descricao, preco, qtd_energia, qtd_vida FROM item where nome = 'abacaxi';
SELECT nome, descricao, preco, qtd_energia, qtd_vida FROM item where nome = 'bergamota';
SELECT nome, descricao, preco, qtd_energia, qtd_vida, qtd_dano FROM item where nome = 'laminada';
SELECT nome, descricao, preco, qtd_energia, qtd_vida, qtd_dano FROM item where nome = 'rapidez';

-- Personagem não hostil

SELECT nome, ocupacao, grupo_ocupacao, is_vendedor
FROM personagem_nao_hostil 
WHERE id_personagem=%d

-- Personagem principal

SELECT * from personagem_principal;


-- inimigo 

select * from inimigo;

select * from inimigo where vida > 100;

select * from inimigo where ocupacao = 'Marinheiro';

SELECT * FROM inimigo where ocupacao = 'Pirata';

-- Ilha

SELECT * FROM ilha;

-- Região 

SELECT * FROM regiao;

SELECT * from regiao where id_ilha = 1;

WITH
    current_reg AS (VALUES (1))
    
select * from regiao where id_regiao IN (
    (SELECT norte from regiao where id_regiao = (table current_reg)) UNION 
    (SELECT sul from regiao where id_regiao = (table current_reg)) UNION
    (SELECT leste from regiao where id_regiao = (table current_reg)) UNION
    (SELECT oeste from regiao where id_regiao = (table current_reg))
);
```
## Versões Anteriores