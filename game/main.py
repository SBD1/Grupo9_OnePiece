from curses.ascii import isdigit
from database import Database


def main():
    player = choose_player()
    ...


def choose_player() -> str | None:
    db = Database()
    db.cursor.execute('SELECT nome FROM jogador;')
    players = db.cursor.fetchall()
    if not players:
        return create_new_player()

    print('Selecione um jogador para carregar o jogo salvo.')
    print(f'[-1] - Criar novo jogador.\n')
    for i, (name,) in enumerate(players):
        print(f'[{i}] - {name}.')

    player = None
    while not player:
        value = input('Digite o jogador selecionado: ').strip()
        if value in players:
            player = value
        elif value.isdigit():
            value = int(value)
            if value < len(players):
                player = players[value]
            elif value == -1:
                return create_new_player()
        else:
            print('Jogador não encontrado.')

    return player


def create_new_player() -> str:
    ...


if __name__ == '__main__':
    main()
