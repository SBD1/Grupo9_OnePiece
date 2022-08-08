
INSERT INTO item (id_item,nome, descricao, preco, qtd_energia, qtd_vida, qtd_dano, is_equipavel)
VALUES
(1,'bergamota', 'Recupera vida', 10, 0, 20, NULL, FALSE),
(2,'melancia', 'Recupera vida', 10, 20, 0, NULL, FALSE),
(3,'guarana', 'Recupera vida', 30, 10, 10, NULL, FALSE),
(4,'abacaxi', 'Recupera vida', 50, 20, 20, NULL, FALSE),
(5,'laminada', 'aumenta o dano do personagem quando equipado', 15, 60, 10, 15, TRUE),
(6,'rapidez', 'aumenta o dano do personagem quando equipado', 8, 90, 5, 12, TRUE);

INSERT INTO ilha (id_ilha,nome,descricao) VALUES 
(1,'Ilha do Capitão Morgan','Ilha com uma base da Marinha, comandada pelo Capitão Morgan. Um marinheiro temido tanto pela população quanto pela marinha.Zoro aparece capturado nessa ilha'),
(2,'Orange Town','Ilha tomada pelo Buggy, cujo prefeito se chama Boodle'),
(3,'Vila Syrup','Vila da ilhas Geecko, onde Usopp, um grande Guerreiro do mar com mais de 8 mil seguidores, vive'),
(4,'Baratie','Restaurante Marítmo comandado pelo chefe Zeff. Zeff tem um filho chamado Sanji, um cozinheiro romântico que ama mulheres.'),
(5,'Ilhas Conami','Arquipélogo de Ilhas onde Nami nasceu. Era um arquipélogo quieto, até Arlong e seus piratas chegarem.');

insert into regiao (descricao,tipo,norte,sul,leste,oeste,id_ilha)
values 
-- Ilha Capitão Morgan
('Porto onde você pode viajar para outras cidades','Porto',2,NULL,NULL,4,1), -- 1
('Feira onde você pode comprar itens','Cidade',3,NULL,1,NULL,1), -- 2
('Taverna onde você encontra variedades da cachaça, mas o Luffy só toma leite','Cidade',NULL,3,2,NULL,1), -- 3
('Base da Marinha, parece que Zoro se encontra lá, Converse com Rika.','Cidade',NULL,1,NULL,3,1),  -- 4
--Ilha Buggy
('Porto de Orange Town','Porto',6,NULL,7,NULL,2), -- 5
('Loja Cachorro Xuxu','Cidade',NULL,7,5,NULL,2), -- 6
('Base Buggy','Cidade',NULL,8,NULL,6,2), -- 7
('Casa do Prefeito','Cidade',7,NULL,NULL,5,2),-- 8
-- Ilha Usopp
('Porto saída Sul','Porto',10,NULL,NULL,NULL,3), -- 9
('Centro da cidade','Cidade',NULL,9,11,NULL,3), -- 10
('Casa da Kaya','Cidade',12,NULL,10,NULL,3), -- 11
('Porto da Saída Norte','Porto',NULL,11,NULL,NULL,3), -- 12
-- Baratie
('Porto','Porto',14,NULL,NULL,NULL,4), -- 13
('Restaurante','Porto',NULL,11,NULL,NULL,3), -- 14
('Deck','Porto',NULL,11,NULL,NULL,3), -- 15
('Barco','Porto',NULL,11,NULL,NULL,3); -- 15

INSERT INTO personagem_principal (id_personagem, nome,id_regiao,ocupacao,grupo_ocupacao,berries,energia,fraqueza,experiencia,vida,capacidade_de_itens) VALUES 
(1,'Monkey D. Luffy',1,'Pirata','Piratas do Chapéu de Palha',150,100,'Kairoseki',1,120,10),
(2,'Roronoa Zoro',2,'Pirata','Piratas do Chapéu de Palha',100,100,'Cortar Ferro',1,100,10),
(3,'Sanji','Pirata',3,'Piratas do Chapéu de Palha',1000,100,'',1,100,15),
(4,'Nami','Pirata',1,'Piratas do Chapéu de Palha',1000000,75,'Tritões',1,100,8);

INSERT INTO barco (id_barco,id_regiao,nome, ocupacao, grupo_ocupacao, capacidade_de_itens) VALUES 
(1,1,'Thousand Sunny', 'Pirata', 'Piratas do Chapéu de Palha', 400),
(2,1,'Miss Love Duck', 'Pirata', 'Piratas do Bon Chan', 250),
(3,1,'Moby Dick', 'Pirata', 'Piratas do Barba Branca', 1000),
(4,1,'Going Merry', 'Pirata', 'Piratas do Chapéu de Palha', 200),
(5,1,'Oro Jackson', 'Pirata', 'Piratas do Roger', 1000);

-- poderia criar um tipo para poder especial e a fraqueza seria um tipo
INSERT INTO poder_especial (nome,tipo_poder ,id_personagem, descricao, dano, energia) VALUES 
-- Fraqueza de todos os usuários de akuma no mi.
('Pistola de Kairoseki','Kairoseki', 1, 'Pistola com tiro de Kairoseki', 25, 10),
('Fuzil de Kairoseki','Kairoseki',1,'Fuzil forte com tiro de Kairoseki',100,50),
('Canhão de Kairoseki','Kairoseki',1,'Canhão de tiro de Kairoseki',200,100),
('Balde de Água do Mar','Água do Mar',1,'Um balde de água do mar para atingir  usuários de Akuma no Mi.',50,10),

-- Fraqueza do Sanji, mas não só dele especificamente
('Mulher Feia','Mulher', 1, 'Mulher feia que impede que Sanji a ataque', 100, 0),
('Mulher Bonita','Mulher', 1, 'Mullher bonita que além de impedir que Sanji a ataque, tira sua energia', 150, 0),

-- Poderes especiais de espadachins que não cortam ferro.
('Espadada especial de Ferro','Ferro', 1, 'Espadada Especial de Ferro', 50, 100),

-- Poderes especiais relacionadas a tritões
('Lança de água','Tritões', 1, 'Lança de água do mar lançada pelo tritão.', 200, 100),
('Mizu shot.','Tritões', 1, 'Tiro disparado pelo tritão de água', 80, 50),
('Mizu Rain Shot.','Tritões', 1, 'Rajada de tiro disparado pelo tritão de água', 150, 100),

-- Poderes especiais Luffy
('Gomu Gomu no Pistol','Akuma no mi','Soco pistola do Luffy',80,50),
('Gomu Gomu no Gatling Gun','Akuma no mi','Metralhadora de Soco pistola do Luffy',140,100),
('Gomu Gomu no Axe','Akuma no mi','Luffy estica o pé lá no alto e desce de uma vez dando uma pézada da peste.',160,80),
('Gomu Gomu no Rocket','Akuma no mi','Luffy se lança para atingir o alvo.',50,25),

-- Poderes especiais do Zoro
('Ittoryu Iai: Shishi Sonson','Ferro','Zoro usa uma espada só dando um corte selvagemente forte.',100,100),
('Santoryuu Tatsumaki','Ferro','Zoro cria um furacão rodando as suas 3 espadas.',50,25),
('Santoryuu Onigiri','Ferro','Zoro corta o alvo com 3 cortes rápidos',50,25),
('Santoryuu Daisen Sekai','Ferro','Zoro corta qualquer alvo com o corte mais forte.',50,25),
('Santoryuu Onigiri','Ferro','Zoro usa as 3 espadas dando 3 cortes simultâneos',50,25),

-- Espadadas
('Espadada especial de Ferro','Ferro', 1, 'Espadada Especial de Ferro', 50, 100),

-- 
('','', 1, 'dá um soco como um Gomu Gomu no Pistol, mas ele pode redirecionar seu soco à um número indeterminado de vezes, sem perder o impulso, mantendo a sua força tremenda.', 1000, 500),
('','Mulher', 1, 'Nesta forma, ele se assemelha a uma bola com proporções exageradas: enquanto seus braços e pernas são ligeiramente pequenos em relação ao corpo, seu torso com Busoshoku Haki-revestido torna-se muito maior e completamente redondo, embora ainda há músculos nos braços e no peitoral.', 900, 300),
('','Ferro', 1, 'Em vez de vapor, essa forma produz uma substância gasosa que aparece como uma mistura de vapor e fogo e, como suas outras contrapartes, também parece ser colocada sobre seus ombros como um lenço, enquanto sob esta forma. Seus punhos também se flexionam diferentemente, com os primeiros nós dos dedos sendo estendidos, semelhante ao punho de leopardo.', 950, 350);


INSERT INTO inimigo (id_regiao,nome,ocupacao,grupo_ocupacao,berries,energia,fraqueza,experiencia,vida) VALUES 
(1,'Marinheiro 1','Marinheiro','Marinha',150,100,'Akuma no mi',1,100),
(1,'Marinheiro 2','Marinheiro','Marinha',250,100,'Akuma no mi',2,100),
(1,'Marinheiro 3','Marinheiro','Marinha',500,100,'Raki',3,100),
(1,'Marinheiro 4','Marinheiro','Marinha',1000,100,'Raki do rei',4,100),
(1,'Akainu','Marinheiro','Almirante da Marinha',1000000,10000,'Kairoseki',10,10000),
(1,'Alkiji','Marinheiro','Almirante da Marinha',900000,10000,'Kairoseki',10,10000),
(1,'Kizaru','Marinheiro','Almirante da Marinha',1200000,10000,'Kairoseki',10,10000),
(1,'Alvida','Pirata','Piratas da Alvida',1000,100,'Akuma no mi',1,100),
(1,'Morgan','Marinheiro','Capitão da Marinha',3000,150,'Akuma no mi',1,100),
(1,'Buggy','Pirata','Piratas do Buggy',1000,200,'Akuma no mi',2,150),
(1,'Arlong','Pirata','Piratas do Arlong',50000,250,'Akuma no mi',3,250);


INSERT INTO personagem_nao_hostil (id_personagem, id_regiao,nome, ocupacao, grupo_ocupacao, is_vendedor, is_personagem_historia)
VALUES
(1,1,'Coby', 'Cidadao', 'Nenhum', false, true),
(2,1,'vendedor', 'Cidadao', 'Comercializar itens basicos', true, false),
(3,1,'Mãe da Rika', 'Cidadao', 'Dona de casa', false, true),
(4,1,'Rika', 'Cidadao', 'Brincar', false, true),
(5,1,'Marinheiro', 'Marinheiro', 'Patrulhar', false, false),
(6,1,'Prefeito', 'Cidadao', 'Gerir um ilha', false, false),
(7,1,'Comerciante', 'Cidadao', 'Vender e comprar itens de pessoas', true, false),
(8,1,'Chuchu', 'Cidadao', 'Ser um cachorro', false, true);

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




