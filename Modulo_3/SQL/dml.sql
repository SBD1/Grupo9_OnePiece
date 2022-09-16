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
(1,1,'Barco da Marinha - O início de tudo.','Barco da Marinha onde Luffy foi resgatado quando estava dentro de um barril a deriva.'),
(2,2,'Ilha do Capitão Morgan','Ilha com uma base da Marinha, comandada pelo Capitão Morgan. Um marinheiro temido tanto pela população quanto pela marinha.Zoro aparece capturado nessa ilha'),
(3,3,'Orange Town','Ilha tomada pelo Buggy, cujo prefeito se chama Boodle'),
(4,4,'Vila Syrup','Vila da ilhas Geecko, onde Usopp, um grande Guerreiro do mar com mais de 8 mil seguidores, vive'),
(5,5,'Baratie','Restaurante Marítmo comandado pelo chefe Zeff. Zeff tem um filho chamado Sanji, um cozinheiro romântico que ama mulheres.'),
(6,6,'Ilhas Conami','Arquipélogo de Ilhas onde Nami nasceu. Era um arquipélogo quieto, até Arlong e seus piratas chegarem.');

insert into regiao (id_regiao,descricao,tipo,norte,sul,leste,oeste,id_ilha)
values
--Barco da marinha inicial
(1,'Sala repleta de barris','Cidade',NULL,NULL,2,NULL,1), -- 1
(2,'Porão onde fica a dispensa, Coby se encontra lá','Cidade',4,3,NULL,1,1), -- 1
(3,'Convés onde Alvida, da clava, se encontra. Tome Cuidado pois ela está furiosa.','Cidade',2,NULL,NULL,NULL,1), -- 1
(4,'Porto, onde você encontra um barco e pode viajar para outras ilhas.','Porto',NULL,2,NULL,NULL,1),

-- Ilha Capitão Morgan
(5,'Porto onde você pode viajar para outras cidades','Porto',NULL,NULL,6,NULL,2), -- 1
(6,'Praça onde você encontra NPCs','Cidade',7,8,9,5,2), -- 
(7,'Taverna da Mãe da Rika, onde você encontra itens para comprar.','Cidade',NULL,6,NULL,NULL,2), -- 
(8,'Feira onde você encontra uma grande variedade de itens para comprar.','Cidade',6,NULL,NULL,NULL,2), -- 
(9,'Campo de castigo da Marinha. Dizem que por lá tem um criminoso amarrado na cruz sem comer por quase 1 mês.','Cidade',NULL,NULL,10,6,2), -- 
(10,'Prédio da Marinha, onde a grande força do capitão Morgan se encontra.','Cidade',NULL,NULL,11,9,2), -- 
(11,'Base da Marinha, onde o capitão Morgan se encontra.','Cidade',NULL,NULL,NULL,10,2),

--Ilha Buggy
(12,'Porto de Orange Town, onde você pode ir para outras ilhas','Porto',NULL,NULL,13,NULL,3), -- 5
(13,'Praça ! Dizem que existem piratas por lá. Mas também uma moça de cabelo laranja.','Cidade',14,15,16,12,3), -- 6
(14,'Casa dos Pets. Existem um cão bravo por lá.','Cidade',NULL,13,NULL,NULL,3), -- 7
(15,'Casa do Prefeito','Cidade',13,NULL,NULL,NULL,3),-- 8
(16,'Base do pirata Buggy. Tome cuidado por lá, ele fez um estrago na cidade.','Cidade',NULL,NULL,NULL,13,3),-- 8

-- Ilha Usopp
(17,'Porto saída Sul','Porto',NULL,NULL,18,NULL,4), -- 9
(18,'Praça da cidade.','Cidade',19,20,17,21,4), -- 10
(19,'Restaurante','Cidade',NULL,18,NULL,NULL,4), -- 11
(20,'Feira onde você encontra uma variedade de itens','Cidade',19,NULL,NULL,NULL,4), -- 12
(21,'Floresta','Floresta',NULL,NULL,22,18,4), -- 12
(22,'Casa da Kaya onde você encontra a Kaya','Cidade',NULL,NULL,23,21,4), -- 12
(23,'Porto da Saída Norte','Porto',NULL,NULL,NULL,22,4), -- 12

-- Baratie
(24,'Porto','Porto',25,NULL,NULL,NULL,5), -- 13
(25,'Restaurante','Cidade',NULL,24,26,NULL,5), -- 14
(26,'Deck','Cidade',NULL,27,NULL,25,5), -- 15
(27,'Barco','Cidade',26,NULL,NULL,24,5),-- 15
(50,'Ilha oculta','Cidade',NULL,NULL,NULL,NULL,5);

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
(29,'N'),
(30,'N'),
(31,'I');

INSERT INTO personagem_principal (id_personagem, nome,id_regiao,ocupacao,grupo_ocupacao,berries,energia,energia_maxima,fraqueza,experiencia,vida,vida_maxima,capacidade_de_itens) VALUES
(1,'Monkey D. Luffy',1,'Pirata','Piratas do Chapéu de Palha',150,100,100,'Kairoseki',1,120,120,10),
(2,'Roronoa Zoro',2,'Pirata','Piratas do Chapéu de Palha',100,100,100,'Cortar Ferro',1,100,100,10),
(3,'Sanji',3,'Pirata','Piratas do Chapéu de Palha',1000,100,100,'',1,100,100,15),
(4,'Nami',1,'Pirata','Piratas do Chapéu de Palha',1000000,75,75,'Tritões',1,100,100,8);

INSERT INTO barco (id_barco,id_regiao,nome, ocupacao, grupo_ocupacao, capacidade_de_itens) VALUES
(5,1,'Barco', 'Pirata', 'Piratas do Chapéu de Palha', 50),
(6,1,'Miss Love Duck', 'Pirata', 'Piratas do Bon Chan', 250),
(7,1,'Moby Dick', 'Pirata', 'Piratas do Barba Branca', 1000),
--(8,1,'Going Merry', 'Pirata', 'Piratas do Chapéu de Palha', 200),
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
(10,9,'Marinheiro 1','Marinheiro','Marinha',150,100,100,'Akuma no mi',1,0,100),
(11,10,'Marinheiro 2','Marinheiro','Marinha',250,100,100,'Akuma no mi',2,0,100),
(12,11,'Marinheiro 3','Marinheiro','Marinha',500,100,100,'Raki',3,0,100),
(13,50,'Marinheiro 4','Marinheiro','Marinha',1000,100,100,'Raki do rei',4,0,100),
(14,50,'Akainu','Marinheiro','Almirante da Marinha',1000000,10000,10000,'Kairoseki',10,0,10000),
(15,50,'Alkiji','Marinheiro','Almirante da Marinha',900000,10000,10000,'Kairoseki',10,0,10000),
(16,50,'Kizaru','Marinheiro','Almirante da Marinha',1200000,10000,10000,'Kairoseki',10,0,10000),
(17,3,'Alvida','Pirata','Piratas da Alvida',1000,100,100,'Akuma no mi',1,0,100),
(18,11,'Morgan','Marinheiro','Capitão da Marinha',3000,150,150,'Akuma no mi',1,0,100),
(19,16,'Buggy','Pirata','Piratas do Buggy',1000,200,200,'Akuma no mi',2,0,150),
(20,50,'Arlong','Pirata','Piratas do Arlong',50000,250,250,'Akuma no mi',3,0,250),
(31,2,'Pirata do bando da Alvida.','Pirata','Piratas da Alvida',50,50,50,1,1,50,50);

INSERT INTO personagem_nao_hostil (id_personagem, id_regiao,nome, ocupacao, grupo_ocupacao, is_vendedor, is_personagem_historia)
VALUES
(21,1,'Coby', 'Cidadao', 'Marinha', false, true),
(29,9,'Coby', 'Cidadao', 'Marinha', false, true),
(30,9,'Zoro', 'Cidadao', 'Pirata', false, true),
(22,2,'vendedor', 'Cidadao', 'Cidadão', true, false),
(23,7,'Mãe da Rika', 'Cidadao', 'Cidadão', true, false),
(24,6,'Rika', 'Cidadao', 'Cidadão', false, true),
(25,1,'Marinheiro', 'Marinheiro', 'Marinha', false, false),
(26,1,'Prefeito', 'Cidadao', 'Cidadão', false, true),
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
(21, 2, 1, 1, null),
(24, 3, NULL, NULL, 2),
(29, 4, 2, 1, NULL),
(30, 5, 2, 2, NULL),
(24, 6, 2, 3, NULL),
(30, 7, 2, 4, NULL)


;

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
(21, 2, 10, 'É que eu vou ser o Rei dos Piratas! :D', 'Luffy'),
(21, 2, 11, 'O QUEEE???', 'Coby'),
(21, 2, 12, 'Então quer dizer que você também é um pirata??', 'Coby'),
(21, 2, 13, 'Sou', 'Luffy'),
(21, 2, 14, 'E cade sua tripulação?', 'Coby'),
(21, 2, 15, 'Não tenho ainda. Tô atrás de uma', 'Luffy'),

(24,3,1,'Eu vou dar esse Onigiri para ele . . .','Rika'),
(24,3,2,'Ele está lá sem comer tem quase 1 mês. . .','Rika'),
(24,3,3,'. . .','Luffy'),
(24,3,4,'Eii, Coby, vamos ver esse Zoro, você quer entrar na Marinha mesmo né ?','Luffy'),
(24,3,5,'Luffy . . . Não sei se é uma boa ideia ele na tua tripulação. . .','Coby'),

(29,4,1,'Você está com fome não está ?','Rika'),
(29,4,2,'Ei, vá embora daqui, você vai se machucar.','Zoro'),
(29,4,3,'Mas eu fiz esse Onigiri pra você . . .','Rika'),
(29,4,4,'Vá embora !!! ','Zoro'),
(29,4,5,'Ei Ei Ei . ..  Por que não para de incomodar as criancinhas ?','Homem de terno'),
(29,4,6,'Portão do campo de castigo se abre, e um homem de terno acompanhado de 2 marinheiros entra','Narrador'),
(29,4,7,'Você veio trazer comida para esse crimonoso ?','Homem de terno'),
(29,4,8,' . . . ','Rika'),
(29,4,9,'Me dá isso daqui !!! (Pisa pisa pisa pisa)','Homem de terno'),
(29,4,10,'Ei você marinheiro, arremesse essa criança por cima do muro !!! ','Homem de terno'),
(29,4,11,'Mas ela é apenas uma criança.','Marinheiro 1'),
(29,4,12,'Vá logo ou chamarei o capitão Morgan.','Homem de terno'),
(29,4,13,'(Sussura baixo no ouvido de Rika) - Desculpa criança.\nArremessa Rika pelos Ares !!!','Marinheiro 1'),
(29,4,14,'Luffy, pegue ela !!!','Coby'),
(29,4,15,'Luffy se estica, dá um salto e pegue Rika no ar !','Narrador'),

(30,5,1,'Ei Ei,sendo humilhado publicamente . . . você é forte mesmo ?','Luffy'),
(30,5,2,'Vá cuidar dos seus problemas. ','Zoro'),
(30,5,3,'Eu teria fugido em 3 dias . . .','Luffy'),
(30,5,4,'Esse não é meu objetivo, eu vou sobreviver 1 mês sem comer e mostrar a eles !!','Zoro'),
(30,5,5,'Você é mesmo teimoso ein ? ','Luffy'),
(30,5,6,'Luffy se vira, dá um sorriso e começa a ir embora  . . .','Narrador'),
(30,5,7,'Ei, pegue aquilo pra mim ! O bolinho que está no chão.','Zoro'),
(30,5,8,'Você quer mesmo isso ? virou uma bola de sujeira, o maluco lá pisou em cima!','Luffy'),
(30,5,9,'Cala a boca e me dá logo !!!','Zoro'),
(30,5,10,' . . . ','Luffy'),
(30,5,11,'Estava maravilhoso ! Obrigado pela comida !','Zoro'),
(30,5,12,'Luffy sorri e tem um olhar confiante','Narrador'),

(24,6,1,'Ele comeu tudinho ! Hihihi','Luffy'),
(24,6,2,'Sério ?','Rika'),
(24,6,3,'Sim !','Luffy'),
(24,6,4,'Ele é mesmo tão mau assim ? ','Coby'),
(24,6,5,'Não, ele tá na prisão por nossa causa.','Rika'),
(24,6,6,'O Helmeppo filho do capitão Morgan, aquele que estava de terno, apareceu com um lobo na cidade. . .','Rika'),
(24,6,7,'Falando que quem mexesse com o novo bichinho dele iria ser executado. Ele chegou com aquele bicho na taverna na minha mãe, eu fui bater nele com a vassoura e aquele lobo avançou em mim. . .','Rika'),
(24,6,8,'O Zoro jogou um banco na cabeça do lobo quando ele ia me morder !!!','Rika'),
(24,6,9,'E aí ele desarmou o Helmeppo e botou uma Katana bem na cabeça dele !','Rika'),
(24,6,10,'Helmeppo disse que se o pai dele descobrisse, iria executar todos da taverna, inclusive eu e minha mãe','Rika'),
(24,6,11,'Então Zoro fez um acordo com ele, se ele passasse um mês sem comer, a gente ficaria a salvo.','Rika'),
(24,6,12,'É por isso que ele está lá','Rika'),
(24,6,13,'Luffy, Rika e Coby vão para a taverna. . .','Narrador'),
(24,6,14,'Helmeppo chega na taverna com seus marinheiros e diz que irá executar o Zoro amanhã.','Rika'),
(24,6,15,'Luffy corre na direção de Helmeppo e dá um grande soco na sua cara !!!','Narrador'),
(24,6,16,'Você é um lixo !!!','Luffy'),
(24,6,17,'Helmeppo sai correndo para falar com seu pai, o grande capitão Morgan !','Narrador'),

(30,7,1,'Ei, decidi que você vai ser meu companheiro!','Luffy'),
(30,7,2,'E você por acaso é o quê ?','Zoro'),
(30,7,3,'Sou um pirata. E vou me tornar o Rei dos Piratas !','Luffy'),
(30,7,4,'Piratas são a escória, por que eu me juntaria a você ?','Zoro'),
(30,7,5,'Você já um caçador de piratas mesmo. Já decidi que você será meu companheiro. Você usa espadas não é?','Luffy'),
(30,7,6,'Sim, mas aquele filhinho de papai pegou.','Zoro'),
(30,7,7,'Vou trazê-las pra você !!','Luffy'),
(30,7,8,'Ei ei espera  . . . ','Zoro');    

INSERT INTO missao (id_missao, nome, descricao, qtd_experiencia, dificuldade, id_nao_hostil) VALUES
(1,'Começo da jornada', 'Luffy derrota Alvida e segue sua viagem junto de Coby pra formar uma tripulação', 10, 0, 21),
(2,'O grande espadachim aparece', 'Luffy e Coby conhecem e libertam o Caçador de Piratas Roronoa Zoro, que foi preso pelo Capitão Morgan e seu filho Helmeppo', 10, 0, 21),
(3,'Morgan VS Luffy', 'Luffy e o mais novo membro de sua tripulação, Roronoa Zoro, lutam contra o Capitão Morgan', 10, 0, 21),
(4,'Palhaço-Pirata, Capitão Buggy', 'Luffy e Zoro se deparam o Capitão Buggy', 10, 0, 21),
(5,'Mohji, o domador VS Luffy', 'Luffy consegue se libertar da jaula em que estava preso e luta contra Mohji e Richie', 10, 0, 21),
(6,'Luffy vc Buggy', 'Luffy luta com Buggy', 10, 0, 21);

INSERT INTO objetivo (id_missao,id_objetivo, descricao, tipo, id_item, id_inimigo, id_conversa_personagem, id_conversa) VALUES
(1, 1, 'Fale com Coby', 'FalarComNPC', NULL, null, 21, 2),
(1, 2, 'Derrote os piratas do bando da Alvida', 'DerrotarInimigo', NULL, 31, NULL, null),
(1, 3, 'Derrote a Capitã Alvida, ao derrotar o último inimigo de uma missão, uma nova ilha é liberada.', 'DerrotarInimigo', NULL, 17, NULL, null),

(2, 1, 'Fale com Coby no campo de castigo da Marinha','FalarComNPC',NULL,NULL,29,4),
(2, 2, 'Fale com Zoro','FalarComNPC',NULL,NULL,30,5),
(2, 3, 'Fale com Rika, ela está na praça','FalarComNPC',NULL,NULL,24,6),
(2, 4, 'Fale com Zoro','FalarComNPC',NULL,NULL,30,7),
(2, 5, 'Derrote os marinheiros que estão de guarda nas espadas de Roronoa Zoro', 'DerrotarInimigo', NULL, NULL, NULL, null),
(2, 6, 'Recupere as espadas de Roronoa Zoro', 'PegarItem', NULL, NULL, NULL, null),
(2, 7, 'Liberte Roronoa Zoro e devolva suas espadas', 'FalarComNPC', NULL, NULL, NULL, null),

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

commit;