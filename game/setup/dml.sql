INSERT INTO item_consumivel (id_item_consumivel, nome, descricao, peso, preco, qtd_energia, qtd_vida)
VALUES
(1, 'bergamota', 'Recupera vida', 5, 10, 0, 20),
(2, 'melancia', 'Recupera vida', 20, 10, 20, 0),
(3, 'guarana', 'Recupera vida', 5, 30, 10, 10),
(4, 'abacaxi', 'Recupera vida', 10, 50, 20, 20);

INSERT INTO item_equipavel (id_item, nome, descricao, peso, preco, tipo, qtd_dano)
VALUES
(1, 'laminada', 'aumenta o dano do personagem quando equipado', 15, 60, Espada, 15),
(2, 'rapidez', 'aumenta o dano do personagem quando equipado', 8, 90, revolver, 12);