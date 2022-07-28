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
('Monkey D. Luffy','Pirata','Piratas do Chapéu de Palha',150,100,'Kairoseki',1,100,10),
('Marinheiro 1','Marinheiro','Marinha',150,100,'Akuma no mi',1,100),

INSERT INTO inimigo (nome,ocupacao,grupo_ocupacao,berries,energia,fraqueza,experiencia,vida) VALUES 
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

INSERT INTO regiao (descricao,tipo,norte,sul,leste,oeste,id_ilha)
VALUES ('Porto','Cidade',1,-1,-1,3,0);

