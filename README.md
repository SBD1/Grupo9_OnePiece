# Grupo9-OnePiece

<div align="center"><img src="docs/images/one-piece.jpg" height="230" width="auto"/></div>


## Alunos

| Nome                               | Matrícula  | 
|------------------------------------|------------| 
| Bernardo Chaves Pissutti           | 190103302  |
| Luan Vasco Cavalcante              | 190111836  | 
| Nicolas Roberto de Queiroz         | 200042360  | 
| Thalisson Alves Goncalves de Jesus | 190117401  | 
| Victor Rayan Adriano Ferreira      | 190044390  |              

# Game :skull_and_crossbones:

Ajude Monkey D. Luffy, um pirata que sonha em ser o Rei Dos Piratas e adora carne e festas, em sua jornada rumo ao seu sonho.
O jogo acontece no mundo de One Piece, um anime impressionantemente surpreendente que conta a melhor história já contada.
Luffy começa sua jornada pirata no mar East Blue e começa a juntar uma tripulação cheia de ambições individuais que ganham um motivo especial para seguir seu capitão.

Você jogará com o Luffy e espero que a história emocionante do jogo e do anime te inspire a ser uma pessoa melhor !!!

Autor do anime : Eiichiro Oda

### "Kaizoku ou ni ore wa naru!" - Monkey D. Luffy
### "Eu serei o Rei dos Piratas!" - Monkey D. Luffy

Este repositório é destinado ao projeto desenvolvido na disciplina de Sistemas de Bancos de Dados 1 na Universidade de Brasília.

## Uso Docker para postgres

Na raiz do projeto, dê o comando : 
```bash
sudo docker-compose up
```

Para o pgAdmin4 abra seu navegador de preferência e vá até a URL abaixo. Quando solicitado preencha o campo e-mail com `postgres@email.com` e o campo senho com `postgres`: 
```
localhost:8080

```

Ou para abrir o postgres no terminal, vá para a raiz do projeto e rode o comando abaixo. Quando solicitado utilize a senha `postgres` :
```bash
sudo docker-compose exec db psql -U postgres -W

```

### Para rodar o jogo Crie um database no seu postgresql com o nome "one_piece"

#### Abrir o arquivo game/database.py e colocar o usuário de senha do seu postgresql em conexão com o localhost em `user"` e `password=`
#### Certifique-se de estar com o python 3.10 e rode o comando:
```
pip install requirements.txt
```

####  Se estiver com dúvidas leia a documentação:

`https://www.postgresql.org/docs/8.0/sql-createuser.html`

### Certifique-se de estar dentro da pasta game:

```
$ cd game
$ python main.py
```

### ou

```
cd game
$ python3 main.py
```

## Apresentações
[Apresentação Módulo 1](https://youtu.be/J68yiBu_BsI)

[Apresentação Módulo 2](https://unbbr-my.sharepoint.com/:v:/g/personal/190044390_aluno_unb_br/ERhQ-uQnj4xMlyZzKPtsRfMByD-a0qVkOub4UhZg8k5WpQ?e=nuOk8Q)

