begin;

INSERT INTO item (id_item,nome, descricao, preco, qtd_energia, qtd_vida, qtd_dano, is_equipavel)
VALUES
(1,'Bergamota', 'Recupera vida', 10, 0, 20, NULL, FALSE),
(2,'Melancia', 'Recupera vida', 10, 20, 0, NULL, FALSE),
(3,'Guarana', 'Recupera vida', 30, 10, 10, NULL, FALSE),
(4,'Abacaxi', 'Recupera vida', 50, 20, 20, NULL, FALSE),
(5,'Carne', 'Recupera vida', 50, 20, 20, NULL, FALSE),
(6,'Comida Especial', 'Recupera vida', 50, 20, 20, NULL, FALSE),
(7,'Carne Especial', 'Recupera vida', 50, 20, 20, NULL, FALSE),
(8,'Cachaça', 'Recupera vida', 50, 20, 20, NULL, FALSE),
(9,'Leite', 'Recupera vida', 50, 20, 20, NULL, FALSE),
(10,'Algodão doce', 'Recupera vida', 50, 20, 20, NULL, FALSE),
(11,'Hamburguer', 'Recupera vida', 50, 20, 20, NULL, FALSE),
(12,'Onigiri', 'Recupera vida', 50, 20, 20, NULL, FALSE),
(13,'Sakê', 'Recupera vida', 50, 20, 20, NULL, FALSE),
(14,'laminada', 'aumenta o dano do personagem quando equipado', 15, 60, 10, 15, TRUE),
(15,'rapidez', 'aumenta o dano do personagem quando equipado', 8, 90, 5, 12, TRUE);

INSERT INTO ilha (id_ilha,id_missao,nome,descricao) VALUES
(1,1,'Ilha do Capitão Morgan','Ilha com uma base da Marinha, comandada pelo Capitão Morgan. Um marinheiro temido tanto pela população quanto pela marinha.Zoro aparece capturado nessa ilha'),
(2,2,'Orange Town','Ilha tomada pelo Buggy, cujo prefeito se chama Boodle'),
(3,3,'Vila Syrup','Vila da ilhas Geecko, onde Usopp, um grande Guerreiro do mar com mais de 8 mil seguidores, vive'),
(4,4,'Baratie','Restaurante Marítmo comandado pelo chefe Zeff. Zeff tem um filho chamado Sanji, um cozinheiro romântico que ama mulheres.'),
(5,5,'Ilhas Conami','Arquipélogo de Ilhas onde Nami nasceu. Era um arquipélogo quieto, até Arlong e seus piratas chegarem.');

insert into regiao (id_regiao,descricao,tipo,norte,sul,leste,oeste,id_ilha)
values
-- Ilha Capitão Morgan
(1,'Porto onde você pode viajar para outras cidades','Porto',2,NULL,NULL,4,1), -- 1
(2,'Feira onde você pode comprar itens','Cidade',3,NULL,1,NULL,1), -- 2
(3,'Taverna onde você encontra variedades da cachaça, mas o Luffy só toma leite','Cidade',NULL,4,2,NULL,1), -- 3
(4,'Base da Marinha, parece que Zoro se encontra lá, Converse com Rika.','Cidade',NULL,1,NULL,3,1),  -- 4
--Ilha Buggy
(5,'Porto de Orange Town','Porto',6,NULL,7,NULL,2), -- 5
(6,'Loja Cachorro Xuxu','Cidade',NULL,7,5,NULL,2), -- 6
(7,'Base Buggy','Cidade',NULL,8,NULL,6,2), -- 7
(8,'Casa do Prefeito','Cidade',7,NULL,NULL,5,2),-- 8
-- Ilha Usopp
(9,'Porto saída Sul','Porto',10,NULL,NULL,NULL,3), -- 9
(10,'Centro da cidade','Cidade',NULL,9,11,NULL,3), -- 10
(11,'Casa da Kaya','Cidade',12,NULL,10,NULL,3), -- 11
(12,'Porto da Saída Norte','Porto',NULL,11,NULL,NULL,3), -- 12
-- Baratie
(13,'Porto','Porto',14,NULL,NULL,NULL,4), -- 13
(14,'Restaurante','Porto',NULL,11,NULL,NULL,3), -- 14
(15,'Deck','Porto',NULL,11,NULL,NULL,3), -- 15
(16,'Barco','Porto',NULL,11,NULL,NULL,3); -- 15


INSERT INTO personagem VALUES
(1,'P'),
(2,'P'),
(3,'P'),
(4,'P'),
(5,'B'),
(6,'B'),
(7,'B'),
(8,'B'),
(9,'B'),
(10,'I'),
(11,'I'),
(12,'I'),
(13,'I'),
(14,'I'),
(15,'I'),
(16,'I'),
(17,'I'),
(18,'I'),
(19,'I'),
(20,'I'),
(21,'N'),
(22,'N'),
(23,'N'),
(24,'N'),
(25,'N'),
(26,'N'),
(27,'N'),
(28,'N'),
(29,'I');

INSERT INTO personagem_principal (id_personagem, nome,id_regiao,ocupacao,grupo_ocupacao,berries,energia,energia_maxima,fraqueza,experiencia,vida,vida_maxima,capacidade_de_itens) VALUES
(1,'Monkey D. Luffy',1,'Pirata','Piratas do Chapéu de Palha',150,100,100,'Kairoseki',1,120,120,10),
(2,'Roronoa Zoro',2,'Pirata','Piratas do Chapéu de Palha',100,100,100,'Cortar Ferro',1,100,100,10),
(3,'Sanji',3,'Pirata','Piratas do Chapéu de Palha',1000,100,100,'',1,100,100,15),
(4,'Nami',1,'Pirata','Piratas do Chapéu de Palha',1000000,75,75,'Tritões',1,100,100,8);

INSERT INTO barco (id_barco,id_regiao,nome, ocupacao, grupo_ocupacao, capacidade_de_itens) VALUES
(5,1,'Thousand Sunny', 'Pirata', 'Piratas do Chapéu de Palha', 400),
(6,1,'Miss Love Duck', 'Pirata', 'Piratas do Bon Chan', 250),
(7,1,'Moby Dick', 'Pirata', 'Piratas do Barba Branca', 1000),
(8,1,'Going Merry', 'Pirata', 'Piratas do Chapéu de Palha', 200),
(9,1,'Oro Jackson', 'Pirata', 'Piratas do Roger', 1000);

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
-- ('Espadada especial de Ferro','Ferro', 1, 'Espadada Especial de Ferro', 50, 100),

-- Poderes especiais relacionadas a tritões
('Lança de água','Tritões', 1, 'Lança de água do mar lançada pelo tritão.', 200, 100),
('Mizu shot.','Tritões', 1, 'Tiro disparado pelo tritão de água', 80, 50),
('Mizu Rain Shot.','Tritões', 1, 'Rajada de tiro disparado pelo tritão de água', 150, 100),

-- Poderes especiais Luffy
('Gomu Gomu no Pistol','Akuma no mi',1,'Soco pistola do Luffy',80,50),
('Gomu Gomu no Gatling Gun','Akuma no mi',1,'Metralhadora de Soco pistola do Luffy',140,100),
('Gomu Gomu no Axe','Akuma no mi',1,'Luffy estica o pé lá no alto e desce de uma vez dando uma pézada da peste.',160,80),
('Gomu Gomu no Rocket','Akuma no mi',1,'Luffy se lança para atingir o alvo.',50,25),

-- Poderes especiais do Zoro
('Ittoryu Iai: Shishi Sonson','Ferro',2,'Zoro usa uma espada só dando um corte selvagemente forte.',100,100),
('Santoryuu Tatsumaki','Ferro',2,'Zoro cria um furacão rodando as suas 3 espadas.',50,25),
('Santoryuu Onigiri','Ferro',2,'Zoro corta o alvo com 3 cortes rápidos',50,25),
('Santoryuu Daisen Sekai','Ferro',2,'Zoro corta qualquer alvo com o corte mais forte.',50,25),
-- ('Santoryuu Onigiri','Ferro',2,'Zoro usa as 3 espadas dando 3 cortes simultâneos',50,25),

-- Espadadas
('Espadada especial de Ferro','Ferro', 1, 'Espadada Especial de Ferro', 50, 100);

--
--('','', 1, 'dá um soco como um Gomu Gomu no Pistol, mas ele pode redirecionar seu soco à um número indeterminado de vezes, sem perder o impulso, mantendo a sua força tremenda.', 1000, 500),
--('','Mulher', 1, 'Nesta forma, ele se assemelha a uma bola com proporções exageradas: enquanto seus braços e pernas são ligeiramente pequenos em relação ao corpo, seu torso com Busoshoku Haki-revestido torna-se muito maior e completamente redondo, embora ainda há músculos nos braços e no peitoral.', 900, 300),
--('','Ferro', 1, 'Em vez de vapor, essa forma produz uma substância gasosa que aparece como uma mistura de vapor e fogo e, como suas outras contrapartes, também parece ser colocada sobre seus ombros como um lenço, enquanto sob esta forma. Seus punhos também se flexionam diferentemente, com os primeiros nós dos dedos sendo estendidos, semelhante ao punho de leopardo.', 950, 350);


INSERT INTO inimigo (id_personagem,id_regiao,nome,ocupacao,grupo_ocupacao,berries,energia,energia_maxima,fraqueza,experiencia,vida,vida_maxima) VALUES
(10,1,'Marinheiro 1','Marinheiro','Marinha',150,100,100,'Akuma no mi',1,0,100),
(11,2,'Marinheiro 2','Marinheiro','Marinha',250,100,100,'Akuma no mi',2,0,100),
(12,8,'Marinheiro 3','Marinheiro','Marinha',500,100,100,'Raki',3,0,100),
(13,8,'Marinheiro 4','Marinheiro','Marinha',1000,100,100,'Raki do rei',4,0,100),
(14,16,'Akainu','Marinheiro','Almirante da Marinha',1000000,10000,10000,'Kairoseki',10,0,10000),
(15,16,'Alkiji','Marinheiro','Almirante da Marinha',900000,10000,10000,'Kairoseki',10,0,10000),
(16,16,'Kizaru','Marinheiro','Almirante da Marinha',1200000,10000,10000,'Kairoseki',10,0,10000),
(17,3,'Alvida','Pirata','Piratas da Alvida',1000,100,100,'Akuma no mi',1,0,100),
(18,4,'Morgan','Marinheiro','Capitão da Marinha',3000,150,150,'Akuma no mi',1,0,100),
(19,5,'Buggy','Pirata','Piratas do Buggy',1000,200,200,'Akuma no mi',2,0,150),
(20,5,'Arlong','Pirata','Piratas do Arlong',50000,250,250,'Akuma no mi',3,0,250);

INSERT INTO personagem_nao_hostil (id_personagem, id_regiao,nome, ocupacao, grupo_ocupacao, is_vendedor, is_personagem_historia)
VALUES
(21,1,'Coby', 'Cidadao', 'Marinha', false, true),
(22,2,'vendedor', 'Cidadao', 'Cidadão', true, false),
(23,3,'Mãe da Rika', 'Cidadao', 'Cidadão', false, true),
(24,3,'Rika', 'Cidadao', 'Cidadão', false, true),
(25,1,'Marinheiro', 'Marinheiro', 'Marinha', false, false),
(26,1,'Prefeito', 'Cidadao', 'Cidadão', false, false),
(27,1,'Comerciante', 'Cidadao', 'Cidadão', true, false),
(28,1,'Chuchu', 'Cidadao', 'Cidadão', false, true);


INSERT INTO inventario_personagem_default (id_item, qtd_item,id_personagem)
VALUES
--            iditem | qnditem
(  1,       1       ,5),
(2, 3,8),
(3, 2,6),
(4, 3,10),
(5, 2,23),


(5, 10,22),
(6, 10,22),
(7, 10,22),
(8, 10,22),
(9, 10,22),
(10, 10,22),
(11, 10,22),
(12, 10,22),
(13, 10,22),
(14, 10,22),


(6, 10,27),
(7, 10,27),
(8, 10,27),
(9, 10,27),
(10, 10,27),
(11, 10,27),
(12, 10,27),
(13, 10,27),
(14, 10,27),
(5, 2,27);

-- Missões

INSERT INTO conversa (id_personagem, id_conversa, id_missao, id_objetivo, id_missao_liberada)
VALUES
(21, 1, NULL, NULL, 1),
(21, 2, 1, 1, null);

INSERT INTO fala (id_personagem, id_conversa, id_fala, texto, nome_display)
VALUES
(21, 1, 1, 'Rápido, fuja daqui! Este navio está sendo invadido por Piratas!!', 'Coby'),
(21, 1, 2, 'Mas eu tô com fome', 'Luffy'),
(21, 1, 3, 'Como você pode estar tão calmo? Quando eles chegarem aqui eles vão te matar!!', 'Coby'),
(21, 1, 4, 'Hmm.. Cheirinho de comidaaa', 'Luffy'),
(21, 1, 5, 'Espera ai, pra onde você está indo?', 'Coby'),

(21, 2, 1, 'Agora sim!! Eu tava cagado de fome', 'Luffy'),
(21, 2, 2, 'Mas ae, esse é um navio pirata mesmo é?', 'Luffy'),
(21, 2, 3, 'Não não, este na verdade é um navio que está sendo saqueado pela capitã Alvida', 'Coby'),
(21, 2, 4, 'Me conta, você é do bando desses piratas?', 'Luffy'),
(21, 2, 5, 'Já faz 2 anos que eles me levaram e eu virei o faz tudo deles só pra sobreviver', 'Coby'),
(21, 2, 6, 'E por que você não foge?', 'Luffy'),
(21, 2, 7, 'Isso é impossível!! Se a capitã me pegar ela vai me deitar na porrada', 'Coby'),
(21, 2, 8, 'Você é muito covarde isso sim HAHAHA', 'Luffy'),
(21, 2, 9, 'Me diga, Luffy, por que está viajando?', 'Coby'),
(21, 2, 10, 'É que eu vou ser o rei dos piratas! :D', 'Luffy'),
(21, 2, 11, 'O QUEEE???', 'Coby'),
(21, 2, 12, 'Então quer dizer que você também é um pirata??', 'Coby'),
(21, 2, 13, 'Sou', 'Luffy'),
(21, 2, 14, 'E cade sua tripulação?', 'Coby'),
(21, 2, 15, 'Não tenho ainda. To atrás de uma', 'Luffy');

INSERT INTO missao (id_missao, nome, descricao, qtd_experiencia, dificuldade, id_nao_hostil) VALUES
(1,'Começo da jornada', 'Luffy derrota Alvida e segue sua viagem junto de Coby pra formar uma tripulação', 10, 0, 21),
(2,'O grande espadachim aparece', 'Luffy e Coby conhecem e libertam o Caçador de Piratas Roronoa Zoro, que foi preso pelo Capitão Morgan e seu filho Helmeppo', 10, 0, 21),
(3,'Morgan VS Luffy', 'Luffy e o mais novo membro de sua tripulação, Roronoa Zoro, lutam contra o Capitão Morgan', 10, 0, 21),
(4,'Palhaço-Pirata, Capitão Buggy', 'Luffy e Zoro se deparam o Capitão Buggy', 10, 0, 21),
(5,'Mohji, o domador VS Luffy', 'Luffy consegue se libertar da jaula em que estava preso e luta contra Mohji e Richie', 10, 0, 21);

INSERT INTO objetivo (id_missao,id_objetivo, descricao, tipo, id_item, id_inimigo, id_conversa_personagem, id_conversa) VALUES
(1, 1, 'Fale com Coby', 'FalarComNPC', NULL, null, 21, 2),
(1, 2, 'Derrote os piratas do bando da Alvida', 'DerrotarInimigo', NULL, 11, NULL, null),
(1, 3, 'Derrote com a Alvida', 'DerrotarInimigo', NULL, NULL, NULL, null),

(2, 1, 'Derrote os marinheiros que estão de guarda nas espadas de Roronoa Zoro', 'DerrotarInimigo', NULL, NULL, NULL, null),
(2, 2, 'Recupere as espadas de Roronoa Zoro', 'PegarItem', NULL, NULL, NULL, null),
(2, 3, 'Liberte Roronoa Zoro e devolva suas espadas', 'FalarComNPC', NULL, NULL, NULL, null),

(3, 1, 'Derrote os marinheiros que estam protegendo o Capitão Morgan', 'DerrotarInimigo', NULL, NULL, NULL, null),
(3, 2, 'Derrote o Capitão Morgan', 'DerrotarInimigo', NULL, NULL, NULL, null),
(3, 3, 'Fale com Coby', 'FalarComNPC', NULL, NULL, NULL, null),

(4, 1, 'Derrote os piratas do bando do Capitão Buggy', 'DerrotarInimigo', NULL, NULL, NULL, null),
(4, 2, 'Convença Nami a entrar para sua tripulação', 'FalarComNPC', NULL, NULL, NULL, null),
(4, 3, 'Derrote os piratas de Buggy', 'DerrotarInimigo', NULL, NULL, NULL, null), -- Nami engana Luffy e o entrega para buggy
(4, 4, 'Derrote Richie', 'DerrotarInimigo', NULL, NULL, NULL, null);


INSERT INTO save (nome) VALUES 
('jogador1'),
('jogador2'),
('jogador3');


-- Constraints para evitar dependências ciclicas.
ALTER TABLE ilha ADD CONSTRAINT fk_ilha_missao FOREIGN KEY (id_missao)
    REFERENCES missao(id_missao) ON DELETE RESTRICT;

ALTER TABLE conversa ADD CONSTRAINT fk_objetivo FOREIGN KEY (id_missao, id_objetivo)
    REFERENCES objetivo(id_missao, id_objetivo);

INSERT INTO missao_status VALUES
(1,'jogador1',1,'Liberada'),


commit;