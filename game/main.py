import sys

from database import get_connection
import ascii_art


def main():
    save = intro()
    print('Save selecionado:', save)


def get_saves() -> list[str]:
    with get_connection() as db:
        cursor = db.cursor()
        cursor.execute('SELECT nome FROM save;')
        return [save for save, in cursor.fetchall()]


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
            actions[value]()
            break


def choose_save() -> str | None:
    saves = get_saves()

    print('Selecione um save para carregar o jogo salvo.')
    i = 0
    for i, name in enumerate(saves):
        print(f'[{i}] - {name}.')
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
        return value


if __name__ == '__main__':
    main()
