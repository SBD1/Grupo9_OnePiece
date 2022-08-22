import sys
from database import get_connection


def main():
    save = choose_save()
    print(save)


def get_saves() -> list[str]:
    with get_connection() as db:
        cursor = db.cursor()
        cursor.execute('SELECT nome FROM jogador;')
        return [save for save,  in cursor.fetchall()]


def choose_save() -> str | None:
    saves = get_saves()
    if not saves:
        print('Nenhum save encontrado. Indo para criação de saves')
        return create_new_save()

    print('Selecione um save para carregar o jogo salvo.')
    for i, name in enumerate(saves):
        print(f'[{i}] - {name}.')
    print(f'\n[{i+1}] - Criar novo save.')
    print(f'[{i+2}] - Sair')

    save = None
    while not save:
        value = input('Digite o save selecionado: ').strip()
        if value in saves:
            save = value
        elif value.isdigit():
            value = int(value)
            if value < len(saves):
                save = saves[value]
            elif value == i+1:
                return create_new_save()
            elif value == i+2:
                outro()
        else:
            print('Save não encontrado.')

    return save


def outro():
    print('Obrigado por jogar')
    sys.exit()


def save_save(name: str) -> None:
    with get_connection() as db:
        with db:
            cursor = db.cursor()
            cursor.execute('INSERT INTO jogador (nome) VALUES (%s);', [name])


def create_new_save() -> str:
    print('Criação de save. Caso queira voltar, aperte enter sem digitar nenhum nome.')
    save = None
    while not save:
        value = input('Digite seu nome: ').strip()
        if not value:
            return choose_save()
        save_save(value)
        return value


if __name__ == '__main__':
    main()
