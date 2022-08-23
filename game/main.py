import sys

from database import get_connection
import ascii_art


def main():
    save = intro()
    player = choose_player(save['nome'])
    run_game(save, player)


def run_game(save: dict, player: dict):
    print(f'Rodando o jogo com save [{save["nome"]}]'
          f' e player [{player["nome"]}]')


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
            print('Digite o número da opção desejada.')
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

    fields = tuple(field.strip() for field in re.findall(r'SELECT (.*) FROM', query)[0].split(','))
    with get_connection() as conn:
        cursor = conn.cursor()
        cursor.execute(query, args or ...)
        return [dict(zip(fields, values)) for values in cursor.fetchall()]


def get_saves() -> list[str]:
    return select_to_dict('SELECT nome FROM save')


def intro():
    actions = {1: choose_save,
               2: create_new_save,
               3: outro}
    print('[1] - Usar um save existente.')
    print('[2] - Criar um novo save.')
    print('[3] - Sair.')
    while True:
        value = input('Digite o número da sua opção: ').strip()
        if not value.isdigit():
            print('Opção inválida. A opção deve ser um numero.')
            continue
        value = int(value)
        if 1 > value > 3:
            print('Digite um número válido [1, 2, 3].')
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
        value = input('Digite a opção escolhida: ').strip()
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
        value = input('Digite seu nome: ').strip()
        if not value:
            return choose_save()
        save_save(value)
        return {'nome': value}


if __name__ == '__main__':
    main()
