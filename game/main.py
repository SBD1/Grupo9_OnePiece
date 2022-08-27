import sys
from database import get_connection
import ascii_art


def main():
    save = intro()
    player = choose_player(save['nome'])
    run_game(player)

def checa_personagem_regiao(posicao_jogador):

    inimigos_regiao = select_to_dict('SELECT id_regiao,nome,ocupacao FROM inimigo where id_regiao = %s and vida > 0',posicao_jogador)
    npcs_regiao = select_to_dict('SELECT id_personagem,id_regiao,nome,ocupacao,is_vendedor,is_personagem_historia FROM personagem_nao_hostil where id_regiao = %s ',posicao_jogador)
    i=0
    for npc in npcs_regiao:
        print(f"{i} - {npc['nome']} é um {npc['ocupacao']} e está na mesma região que você.")
        i+=1
    print('\n')
    for npc in range(len(npcs_regiao)):
        print(f"{npc} - Falar com {npcs_regiao[npc]['nome']}")

    return npcs_regiao

def fala_com_npc(npc_num,npcs_dict,player):
    npc_num = int(npc_num)
    print(f"Olá sou {npcs_dict[npc_num]['nome']}\n")

    if(npcs_dict[npc_num]['is_vendedor']):
        print("Quer comprar ? ")
        
        print("Aqui está meu inventário :")
        #print(f'id : {player["id_personagem"]} \nnome: {player["nome_save"]}')
        inventario_npc = select_to_dict("SELECT id_item,qtd_item from inventario_personagem where id_jogador_save = %s and id_jogador_personagem = %s and id_personagem = %s",player["nome_save"],player["id_personagem"],npcs_dict[npc_num]['id_personagem'])
        #print(inventario_npc)

        id_itens = [item['id_item'] for item in inventario_npc]

        with get_connection() as db:
                with db:
                    cursor = db.cursor()
                    sql = "SELECT nome from item where id_item in (%s)"
                    data = [str(item) for item in id_itens]
                    cursor.execute(sql,data)

                nomes = cursor.fetchall()
                
        print(id_itens)
        print(nomes)

        for item in inventario_npc:
            print(f"id_item : {item['id_item']}   {item['qtd_item']}x")

        escolha = input("Você deseja comprar algo :\n1-Sim\n2-Não\n\n>")



def menu(player):
    nome_player = player["nome"]

    invalid = True

    while True:
        posicao_atual,regioes_to_go = regiao_player(player)

        print("##### One Piece ! 💀 - \U0001f480 ######\n\n")
        print(f"Jogador {nome_player} 🏴‍☠️\n"
            f"Você está em {posicao_atual}\n"
            "[[Objetivo atual --------- ]]\n")

        npcs_regiao = checa_personagem_regiao(posicao_atual)  

        print(
            "\n\nM - Mover personagem\n"
            "Q - Sair"
        )
            
        escolha = input("O que você deseja fazer ?\n\n> ").lower()
        
        if escolha == 'm':
            regiao = printa_regioes(nome_player,regioes_to_go)
            move_player(player,regiao)
        elif escolha == 'q':
            main()
        elif 0 <= int(escolha) <= len(npcs_regiao):
            print("-------Falando com NPC-------------\n\n")
            fala_com_npc(escolha,npcs_regiao,player)

def run_game(player: dict):
    print(f'Rodando o jogo com save [{player["nome_save"]}]'
          f' e player [{player["nome"]}]')
    game_loop = True

    while game_loop:
        if menu(player) == False:
            game_loop = False
        

def choose_player(save: str) -> list:
    players = get_players(save)
    assert len(players) > 0, 'Está faltando a StoredProcedure para criar um jogador automaticamente'
    if len(players) == 1:
        return players[0]
    print(f'Selecione um personagem para jogar.')
    for i, player in enumerate(players):
        print(f'[{i}] - {player["nome"]}')

    while True:
        value = input().strip()
        if not value.isdigit():
            print('Digite o número da opção desejada.\n\n> ')
        else:
            value = int(value)
            if 0 <= value <= i:
                return players[value]
            else:
                print('Opção inválida')


def get_players(save: str) -> list[list]:
    return select_to_dict('SELECT nome, id_personagem, nome_save FROM jogador WHERE nome_save = %s', save)



def select_to_dict(query: str, *args):
    import re

    fields = tuple(field.strip().lstrip('(').rstrip(')') for field in re.findall(r'SELECT (.*) FROM', query, re.IGNORECASE)[0].split(','))
    with get_connection() as conn:
        cursor = conn.cursor()
        cursor.execute(query, args or ...)
        return [dict(zip(fields, values)) for values in cursor.fetchall()]


def get_saves() -> list[str]:
    return select_to_dict('SELECT nome FROM save')


def intro():
    actions = {'1': choose_save,
               '2': create_new_save,
               'q': outro}

    op = r"""
   ___             ____  _               
  / _ \ _ __   ___|  _ \(_) ___  ___ ___ 
 | | | | '_ \ / _ \ |_) | |/ _ \/ __/ _ \
 | |_| | | | |  __/  __/| |  __/ (_|  __/
  \___/|_| |_|\___|_|   |_|\___|\___\___|
    """

    print('='*150)
    for s in op.split('\n'):
        print(f'{s:^150}')
    print('='*150)          
    print('[1] - Usar um save existente.')
    print('[2] - Criar um novo save.')
    print('[q] - Sair.')
    while True:
        value = input('Digite o número da sua opção: \n\n> ').strip()
        if value not in actions:
            print('Digite um número válido [1, 2, q].')
        else:
            return actions[value]()


def choose_save() -> str | None:
    saves = get_saves()

    print('Selecione um save para carregar o jogo salvo.')
    i = 0
    for i, save in enumerate(saves):
        print(f'[{i}] - {save["nome"]}.')
    print(f'\n[{i+1}] - Voltar')

    save = None
    while not save:
        value = input('Digite a opção escolhida: \n\n> ').strip()
        if value in saves:
            save = value
        elif value.isdigit():
            value = int(value)
            if value < len(saves):
                save = saves[value]
            elif value == i+1:
                intro()
        else:
            print('Save não encontrado.')

    return save


def outro():
    print(ascii_art.luffy_like)
    print('\n\nObrigado por jogar!!')
    sys.exit()


def save_save(name: str) -> None:
    with get_connection() as db:
        with db:
            cursor = db.cursor()
            cursor.execute('INSERT INTO save (nome) VALUES (%s);', [name])


def create_new_save() -> str:
    print('Criação de save. Caso queira voltar, aperte enter sem digitar nenhum nome.')
    save = None
    while not save:
        try:
            value = input('Digite seu nome: ').strip()
            if not value:
                return choose_save()
            save_save(value)
            return {'nome': value}
        except Exception as error:
            print('Nome com esse save já existe, por favor tente outro nome.')    

def move_player(player,escolha):
    with get_connection() as db:
        with db:
            cursor = db.cursor()
            cursor.execute('UPDATE jogador SET id_regiao = %s',escolha)

    #regiao_player(player)


def regiao_player(player):
    nome = player["nome"]
    nome_save = player["nome_save"]
    #print(player['nome'])
    regiao = select_to_dict('SELECT id_regiao FROM jogador WHERE nome_save = %s and id_personagem = %s',nome_save,player["id_personagem"])
    #print(regiao)

    current = regiao[0]['id_regiao']


    print(f"{nome} está em {current}")

    with get_connection() as db:
        cursor = db.cursor()
        cursor.execute('select id_regiao,descricao from regiao where id_regiao IN (' 
                        '(SELECT norte from regiao where id_regiao = %s) UNION'
                        '(SELECT sul from regiao where id_regiao = %s) UNION'
                        '(SELECT leste from regiao where id_regiao = %s) UNION'
                        '(SELECT oeste from regiao where id_regiao = %s))',[current]*4
                    )

        regioes_to_go = cursor.fetchall()
    

    #print(regioes_to_go)
    return current,regioes_to_go

def printa_regioes(nome,regioes_to_go):
    invalid = True 
    regioes_possiveis = [str(regiao_id) for regiao_id,descricao in regioes_to_go]

    while invalid:
        print(f"\n\n{nome} pode ir para :\n")
        
        for regiao_id,descricao in regioes_to_go:
            print(f"{regiao_id} - {descricao}")

        print('\n')
        
        escolha = input("Você deseja ir para : ")
        if escolha not in regioes_possiveis:
            print("Opção inválida.\n")
        else:
            invalid = False

    return escolha



if __name__ == '__main__':
    main()
