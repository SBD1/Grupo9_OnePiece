INSERT INTO barco (id_barco, nome, ocupacao, grupo_ocupacao, capacidade_de_itens) VALUES 
(default, 'Thousand Sunny', 'value3', 'value4', 400),
(default, 'Miss Love Duck', 'value3', 'value4', 250),
(default, 'Utan Sonar', 'value3', 'value4', 300),
(default, 'Moby Dick', 'value3', 'value4', 350),
(default, 'Holandês Voador', 'value3', 'value4', 500);

INSERT INTO poder_especial (nome, id_personagem_principal, descricao, dano, energia) VALUES 
('Gomu gomu no Hammer', auto, 'cascudo com as duas mãos', 300, 400),
('Bounceman',auto,' cobre seus braços com Busoshoku Haki antes de morder seu antebraço. Semelhante à forma como ele ativa o Gear Third, ele sopra uma incrível quantidade de ar em seu corpo, mas desta vez ele infla sua estrutura muscular antes de distribuir o ar em todo o seu corpo, com ênfase na sua metade superior.',800,250),
('Tankman', auto, 'Nesta forma, ele se assemelha a uma bola com proporções exageradas: enquanto seus braços e pernas são ligeiramente pequenos em relação ao corpo, seu torso com Busoshoku Haki-revestido torna-se muito maior e completamente redondo, embora ainda há músculos nos braços e no peitoral.', 900, 300),
('Snakeman', auto, 'Em vez de vapor, essa forma produz uma substância gasosa que aparece como uma mistura de vapor e fogo e, como suas outras contrapartes, também parece ser colocada sobre seus ombros como um lenço, enquanto sob esta forma. Seus punhos também se flexionam diferentemente, com os primeiros nós dos dedos sendo estendidos, semelhante ao punho de leopardo.', 950, 350),
('Kinniku Fusen', auto, 'dá um soco como um Gomu Gomu no Pistol, mas ele pode redirecionar seu soco à um número indeterminado de vezes, sem perder o impulso, mantendo a sua força tremenda.', 1000, 500);

-- https://onepiece.fandom.com/pt/wiki/Navios

INSERT INTO personagem_principal (nome,ocupacao,grupo_ocupacao,berries,energia,fraqueza,experiencia,vida,capacidade_de_itens) VALUES 
('Monkey D. Luffy','Pirata','Piratas do Chapéu de Palha',150,100,'Kairoseki',1,100,10)

INSERT INTO inimigo (nome,ocupacao,grupo_ocupacao,berries,energia,fraqueza,experiencia,vida) VALUES 
('Marinheiro 1','Marinheiro','Marinha',150,100,'Akuma no mi',1,100),
('Marinheiro 2','Marinheiro','Marinha',250,100,'Akuma no mi',2,100),
('Marinheiro 3','Marinheiro','Marinha',500,100,'Raki',3,100),
('Marinheiro 4','Marinheiro','Marinha',1000,100,'Raki do rei',4,100),
('Akainu','Marinheiro','Almirante da Marinha',1000000,10000,'Kairoseki',10,10000),
('Alkiji','Marinheiro','Almirante da Marinha',900000,10000,'Kairoseki',10,10000),
('Kizaru','Marinheiro','Almirante da Marinha',1200000,10000,'Kairoseki',10,10000),
('Alvida','Pirata','Piratas Alvida',1000,100,'Akuma no mi',1,100),
('Morgan','Marinheiro','Capitão da Marinha',3000,150,'Akuma no mi',1,100),
('Buggy','Pirata','Capitão dos Piratas Buggy',1000,200,'Akuma no mi',2,150),
('Arlong','Pirata','Capitão dos Piratas do Arlong',50000,250,'Akuma no mi',3,250);

INSERT INTO ilha (nome,descricao) VALUES 
('Ilha do Capitão Morgan','Ilha com uma base da Marinha, comandada pelo Capitão Morgan. Um marinheiro temido tanto pela população quanto pela marinha.Zoro aparece capturado nessa ilha'),
('Orange Town','Ilha tomada pelo Buggy, cujo prefeito se chama Boodle'),
('Vila Syrup','Vila da ilhas Geecko, onde Usopp, um grande Guerreiro do mar com mais de 8 mil seguidores, vive'),
('Baratie','Restaurante Marítmo comandado pelo chefe Zeff. Zeff tem um filho chamado Sanji, um cozinheiro romântico que ama mulheres.'),
('Ilhas Conami','Arquipélogo de Ilhas onde Nami nasceu. Era um arquipélogo quieto, até Arlong e seus piratas chegarem.');

INSERT INTO personagem_nao_hostil (nome, ocupacao, grupo_ocupacao, is_vendedor, is_personagem_historia)
VALUES
('Coby', 'Cidadao', 'Nenhum', false, true);
('vendedor', 'Cidadao', 'Comercializar itens basicos', true, false);
('Mãe da Rika', 'Cidadao', 'Dona de casa', false, true);
('Rika', 'Cidadao', 'Brincar', false, true);
('Marinheiro', 'Marinheiro', 'Patrulhar', false, false);
('Prefeito', 'Cidadao', 'Gerir um ilha', false, false);
('Comerciante', 'Cidadao', 'Vender e comprar itens de pessoas', true, false);
('Chuchu', 'Cidadao', 'Ser um cachorro', false, true);

INSERT INTO inventario (id_personagem, id_item, qtd_item)
VALUES 
(1, 1, 1);
(1, 2, 3);
(2, 3, 2);
(2, 4, 3);
(1, 5, 2);

-- Missões
INSERT INTO missao (nome, descricao, qtd_experiencia, dificuldade, id_personagem)
VALUES ('Começo da jornada', 'Luffy derrota Alvida e segue sua viagem junto de Coby pra formar uma tripulação', 10, 0, NULL);

    INSERT INTO objetivo (id_missao, nome, descricao, tipo, id_item, id_inimigo, id_nao_hostil)
    VALUES (1, '', 'Luffy derrota piratas do bando da Alvida', 'DerrotarInimigo', NULL, NULL, NULL);

    INSERT INTO objetivo (id_missao, nome, descricao, tipo, id_item, id_inimigo, id_nao_hostil)
    VALUES (1, '', 'Luffy da o golpe final e manda Alvida pelos ares', 'DerrotarInimigo', NULL, NULL, NULL);

INSERT INTO missao (nome, descricao, qtd_experiencia, dificuldade, id_personagem)
VALUES ('O grande espadachim aparece', 'Luffy e Coby conhecem e libertam o Caçador de Piratas Roronoa Zoro, que foi preso pelo Capitão Morgan e seu filho Helmeppo', 10, 0, NULL);

    INSERT INTO objetivo (id_missao, nome, descricao, tipo, id_item, id_inimigo, id_nao_hostil)
    VALUES (2, '', 'Luffy derrota os marinheiros que estavam guardando as espadas de Roronoa Zoro', 'DerrotarInimigo', NULL, NULL, NULL);

    INSERT INTO objetivo (id_missao, nome, descricao, tipo, id_item, id_inimigo, id_nao_hostil)
    VALUES (2, '', 'Luffy pega as espadas de Roronoa Zoro, que tinham sido confiscadas pela marinha', 'PegarItem', NULL, NULL, NULL);

    INSERT INTO objetivo (id_missao, nome, descricao, tipo, id_item, id_inimigo, id_nao_hostil)
    VALUES (2, '', 'Luffy liberta Roronoa Zoro e devolve suas espadas', 'FalarComNPC', NULL, NULL, NULL);

INSERT INTO missao (nome, descricao, qtd_experiencia, dificuldade, id_personagem)
VALUES ('Morgan VS Luffy', 'Luffy e o mais novo membro de sua tripulação, Roronoa Zoro, lutam contra o Capitão Morgan', 10, 0, NULL);

    INSERT INTO objetivo (id_missao, nome, descricao, tipo, id_item, id_inimigo, id_nao_hostil)
    VALUES (3, '', 'Luffy e Zoro derrotam os marinheiros que estavam protegendo o Capitão Morgan', 'DerrotarInimigo', NULL, NULL, NULL);

    INSERT INTO objetivo (id_missao, nome, descricao, tipo, id_item, id_inimigo, id_nao_hostil)
    VALUES (3, '', 'Luffy e Zoro vencem o Capitão Morgan', 'DerrotarInimigo', NULL, NULL, NULL);

    INSERT INTO objetivo (id_missao, nome, descricao, tipo, id_item, id_inimigo, id_nao_hostil)
    VALUES (3, '', 'Coby se dispede de Luffy para seguir sua ambição de se tornar um marinheiro.', 'FalarComNPC', NULL, NULL, NULL);

INSERT INTO missao (nome, descricao, qtd_experiencia, dificuldade, id_personagem)
VALUES ('Palhaço-Pirata, Capitão Buggy', 'Luffy e Zoro se deparam o Capitão Buggy', 10, 0, NULL);

    INSERT INTO objetivo (id_missao, nome, descricao, tipo, id_item, id_inimigo, id_nao_hostil)
    VALUES (4, '', 'Luffy derrota piratas do Capitão Buggy', 'DerrotarInimigo', NULL, NULL, NULL);

    INSERT INTO objetivo (id_missao, nome, descricao, tipo, id_item, id_inimigo, id_nao_hostil)
    VALUES (4, '', 'Nami engana Luffy e o entrega para Buggy', 'DerrotarInimigo', NULL, NULL, NULL);

INSERT INTO missao (nome, descricao, qtd_experiencia, dificuldade, id_personagem)
VALUES ('Mohji, o domador VS Luffy', 'Luffy consegue se libertar da jaula em que estava preso e luta contra Mohji e Richie', 10, 0, NULL);

    INSERT INTO objetivo (id_missao, nome, descricao, tipo, id_item, id_inimigo, id_nao_hostil)
    VALUES (4, '', 'Luffy enfrenta Richie', 'DerrotarInimigo', NULL, NULL, NULL);


-- Itens
INSERT INTO item (nome, descricao, preco, qtd_energia, qtd_vida, qtd_dano, is_equipavel)
VALUES
('bergamota', 'Recupera vida', 10, 0, 20, 0, FALSE),
('melancia', 'Recupera vida', 10, 20, 0, 0, FALSE),
('guarana', 'Recupera vida', 30, 10, 10, 0, FALSE),
('abacaxi', 'Recupera vida', 50, 20, 20, 0, FALSE);
('laminada', 'aumenta o dano do personagem quando equipado', 15, 60, 10, 15, TRUE),
('rapidez', 'aumenta o dano do personagem quando equipado', 8, 90, 5, 12, TRUE);
