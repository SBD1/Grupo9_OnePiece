INSERT INTO item (id_item,nome, descricao, preco, qtd_energia, qtd_vida, qtd_dano, is_equipavel)
VALUES
(1,'bergamota', 'Recupera vida', 10, 0, 20, NULL, FALSE),
(2,'melancia', 'Recupera vida', 10, 20, 0, NULL, FALSE),
(3,'guarana', 'Recupera vida', 30, 10, 10, NULL, FALSE),
(4,'abacaxi', 'Recupera vida', 50, 20, 20, NULL, FALSE),
(5,'laminada', 'aumenta o dano do personagem quando equipado', 15, 60, 10, 15, TRUE),
(6,'rapidez', 'aumenta o dano do personagem quando equipado', 8, 90, 5, 12, TRUE);

INSERT INTO personagem_principal (id_personagem, nome,ocupacao,grupo_ocupacao,berries,energia,fraqueza,experiencia,vida,capacidade_de_itens) VALUES 
(1,'Monkey D. Luffy','Pirata','Piratas do Chapéu de Palha',150,100,'Kairoseki',1,120,10),
(2,'Roronoa Zoro','Pirata','Piratas do Chapéu de Palha',100,100,'Cortar Ferro',1,100,10),
(3,'Sanji','Pirata','Piratas do Chapéu de Palha',1000,100,'Cortar Ferro',1,100,15),
(4,'Nami','Pirata','Piratas do Chapéu de Palha',1000000,75,'Tritões',1,100,8);

INSERT INTO barco (id_barco,nome, ocupacao, grupo_ocupacao, capacidade_de_itens) VALUES 
(1,'Thousand Sunny', 'Pirata', 'Membro', 400),
(2,'Miss Love Duck', 'Pirata', 'Membro', 250),
(3,'Utan Sonar', 'Pirata', 'Membro', 300),
(4,'Moby Dick', 'Pirata', 'Membro', 350),
(5,'Holandês Voador', 'Pirata', 'Membro', 500);

INSERT INTO poder_especial (nome, id_personagem_principal, descricao, dano, energia) VALUES 
('Gomu gomu no Hammer', 1, 'cascudo com as duas mãos', 300, 400),
('Bounceman',1,' cobre seus braços com Busoshoku Haki antes de morder seu antebraço. Semelhante à forma como ele ativa o Gear Third, ele sopra uma incrível quantidade de ar em seu corpo, mas desta vez ele infla sua estrutura muscular antes de distribuir o ar em todo o seu corpo, com ênfase na sua metade superior.',800,250),
('Tankman', 1, 'Nesta forma, ele se assemelha a uma bola com proporções exageradas: enquanto seus braços e pernas são ligeiramente pequenos em relação ao corpo, seu torso com Busoshoku Haki-revestido torna-se muito maior e completamente redondo, embora ainda há músculos nos braços e no peitoral.', 900, 300),
('Snakeman', 1, 'Em vez de vapor, essa forma produz uma substância gasosa que aparece como uma mistura de vapor e fogo e, como suas outras contrapartes, também parece ser colocada sobre seus ombros como um lenço, enquanto sob esta forma. Seus punhos também se flexionam diferentemente, com os primeiros nós dos dedos sendo estendidos, semelhante ao punho de leopardo.', 950, 350),
('Kinniku Fusen', 1, 'dá um soco como um Gomu Gomu no Pistol, mas ele pode redirecionar seu soco à um número indeterminado de vezes, sem perder o impulso, mantendo a sua força tremenda.', 1000, 500);


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

INSERT INTO ilha (id_ilha,nome,descricao) VALUES 
(1,'Ilha do Capitão Morgan','Ilha com uma base da Marinha, comandada pelo Capitão Morgan. Um marinheiro temido tanto pela população quanto pela marinha.Zoro aparece capturado nessa ilha'),
(2,'Orange Town','Ilha tomada pelo Buggy, cujo prefeito se chama Boodle'),
(3,'Vila Syrup','Vila da ilhas Geecko, onde Usopp, um grande Guerreiro do mar com mais de 8 mil seguidores, vive'),
(4,'Baratie','Restaurante Marítmo comandado pelo chefe Zeff. Zeff tem um filho chamado Sanji, um cozinheiro romântico que ama mulheres.'),
(5,'Ilhas Conami','Arquipélogo de Ilhas onde Nami nasceu. Era um arquipélogo quieto, até Arlong e seus piratas chegarem.');

INSERT INTO personagem_nao_hostil (id_personagem, nome, ocupacao, grupo_ocupacao, is_vendedor, is_personagem_historia)
VALUES
(1,'Coby', 'Cidadao', 'Nenhum', false, true),
(2,'vendedor', 'Cidadao', 'Comercializar itens basicos', true, false),
(3,'Mãe da Rika', 'Cidadao', 'Dona de casa', false, true),
(4,'Rika', 'Cidadao', 'Brincar', false, true),
(5,'Marinheiro', 'Marinheiro', 'Patrulhar', false, false),
(6,'Prefeito', 'Cidadao', 'Gerir um ilha', false, false),
(7,'Comerciante', 'Cidadao', 'Vender e comprar itens de pessoas', true, false),
(8,'Chuchu', 'Cidadao', 'Ser um cachorro', false, true);

INSERT INTO inventario (id_personagem, id_item, qtd_item)
VALUES 
(1, 1, 1),
(1, 2, 3),
(1, 3, 2),
(1, 4, 3),
(1, 5, 2);

-- Missões

INSERT INTO missao (id_missao, nome, descricao, qtd_experiencia, dificuldade, id_personagem) VALUES 
(1,'Começo da jornada', 'Luffy derrota Alvida e segue sua viagem junto de Coby pra formar uma tripulação', 10, 0, 1),
(2,'O grande espadachim aparece', 'Luffy e Coby conhecem e libertam o Caçador de Piratas Roronoa Zoro, que foi preso pelo Capitão Morgan e seu filho Helmeppo', 10, 0, 1),
(3,'Morgan VS Luffy', 'Luffy e o mais novo membro de sua tripulação, Roronoa Zoro, lutam contra o Capitão Morgan', 10, 0, 1),
(4,'Palhaço-Pirata, Capitão Buggy', 'Luffy e Zoro se deparam o Capitão Buggy', 10, 0, 1),
(5,'Mohji, o domador VS Luffy', 'Luffy consegue se libertar da jaula em que estava preso e luta contra Mohji e Richie', 10, 0, 1);      
    
INSERT INTO objetivo (id_missao, nome, descricao, tipo, id_item, id_inimigo, id_nao_hostil) VALUES 
(1, '', 'Luffy derrota piratas do bando da Alvida', 'DerrotarInimigo', NULL, NULL, NULL),
(1, '', 'Luffy da o golpe final e manda Alvida pelos ares', 'DerrotarInimigo', NULL, NULL, NULL),
(2, '', 'Luffy derrota os marinheiros que estavam guardando as espadas de Roronoa Zoro', 'DerrotarInimigo', NULL, NULL, NULL),
(2, '', 'Luffy pega as espadas de Roronoa Zoro, que tinham sido confiscadas pela marinha', 'PegarItem', NULL, NULL, NULL),
(2, '', 'Luffy liberta Roronoa Zoro e devolve suas espadas', 'FalarComNPC', NULL, NULL, NULL),
(3, '', 'Luffy e Zoro derrotam os marinheiros que estavam protegendo o Capitão Morgan', 'DerrotarInimigo', NULL, NULL, NULL),
(3, '', 'Luffy e Zoro vencem o Capitão Morgan', 'DerrotarInimigo', NULL, NULL, NULL),
(3, '', 'Coby se dispede de Luffy para seguir sua ambição de se tornar um marinheiro.', 'FalarComNPC', NULL, NULL, NULL),
(4, '', 'Luffy derrota piratas do Capitão Buggy', 'DerrotarInimigo', NULL, NULL, NULL),
(4, '', 'Nami engana Luffy e o entrega para Buggy', 'DerrotarInimigo', NULL, NULL, NULL),
(4, '', 'Luffy enfrenta Richie', 'DerrotarInimigo', NULL, NULL, NULL);
    

insert into regiao (descricao,tipo,norte,sul,leste,oeste,id_ilha)
values 
('Porto onde você pode viajar para outras cidades','Cidade',2,NULL,NULL,4,1), -- 1
('Feira onde você pode comprar itens','Cidade',3,NULL,1,NULL,1), -- 2
('Taverna onde você encontra variedades da cachaça, mas o Luffy só toma leite','Cidade',NULL,3,2,NULL,1), -- 3
('Base da Marinha, parece que Zoro se encontra lá, Converse com Rika.','Cidade',NULL,1,NULL,3,1),  -- 4
('Porto de Orange Town','Cidade',6,NULL,7,NULL,2), -- 5
('Loja Cachorro Xuxu','Cidade',NULL,7,5,NULL,2), -- 6
('Base Buggy','Cidade',NULL,8,NULL,6,2), -- 7
('Casa do Prefeito','Cidade',7,NULL,NULL,5,2),-- 8
('Porto saída Sul','Cidade',10,NULL,12,NULL,3), -- 9
('Loja Cachorro Xuxu','Cidade',NULL,7,5,NULL,3), -- 10
('Base Buggy','Cidade',NULL,8,NULL,6,3), -- 11
('Casa do Prefeito','Cidade',7,NULL,NULL,5,3); -- 12
