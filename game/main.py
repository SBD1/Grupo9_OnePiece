import sys
from database import get_connection,AS_DICT
import ascii_art
import random
import time


def main():
    save = intro()
    player = choose_player(save['nome'])
    run_game(player)

def muda_de_ilha(player):

    ## list of dict com os ids das ilhas que estao liberadas
    ilhas_completadas = select_to_dict("SELECT id_ilha,descricao from ilha inner join missao_status on ilha.id_missao = missao_status.id_missao where status = 'Concluida' or status = 'Liberada' and id_jogador_save = %s and id_jogador_personagem = %s",player['nome_save'],player['id_personagem'])
    ilha_jogador = select_to_dict('SELECT id_ilha,tipo,descricao from regiao inner join jogador on regiao.id_regiao = jogador.id_regiao where nome_save = %s and id_personagem = %s',player['nome_save'],player['id_personagem'])
    # ignorar ilha que o personagem se encontra, mostrar apenas as ilhas que ele pode ir
    ilhas_possiveis = [i for i in ilhas_completadas if not (i['id_ilha'] == ilha_jogador[0]['id_ilha'])]
    
    print(f"Você está na ilha {ilha_jogador[0]['descricao']} do tipo {ilha_jogador[0]['tipo']}")

    print(f"Para qual ilha você deseja ir?")
    if ilha_jogador[0]['tipo'] == 'Porto':
        if len(ilhas_possiveis) <= 0:
            return
        else:
            print('Ilhas disponíveis para navegar:\n')
            for itens in ilhas_possiveis:
                print(f"{itens['id_ilha']} - {itens['descricao']}")

            escolha = input("\n\nSelecione a ilha que deseja ir:\n>")
            # falta fazer validação para a escolha
            ilha_para_ir = select_to_dict("SELECT id_regiao, id_ilha from regiao where tipo = 'Porto' and id_ilha = %s",escolha)
            with get_connection() as db:
                with db:
                    cursor = db.cursor()
                    sql = ('UPDATE jogador SET id_regiao = %s where nome_save = %s and id_personagem = %s')
                    data = [ilha_para_ir[0]['id_regiao'],player['nome_save'],player['id_personagem']]
                    cursor.execute(sql,data)

            print('\nNavegando pelo Mar Aberto\n')
            print(r"""
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣤⣶⣶⣶⣶⣶⣦⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⡿⠛⣯⣷⣷⣿⣿⣷⣯⣿⡿⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⡟⣋⣶⢟⣙⣥⣾⡿⢿⣿⣿⣮⡙⣯⣿⡆⠸⣿⢿⣟⠿⣶⣦⣀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⢛⣵⠿⣵⣾⡿⢹⣿⣦⣿⣿⣧⣍⡙⢦⡹⣿⡀⠻⢿⡻⣿⣿⣯⡻⣷⣄⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡾⢏⣿⡟⣆⣾⣟⠤⣢⡿⡟⢼⣫⣧⣇⡈⠻⣆⠣⢸⡇⢨⣿⢷⠿⠾⣧⣟⣿⢿⣦⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣿⣁⡾⢃⣶⠟⡅⢀⣶⠿⠂⣼⣿⠟⠋⠙⢿⣦⠈⠆⣸⡇⢐⣌⣮⣧⣀⣀⣉⠻⣄⠹⣇⠀
⠀⠀⠀⠀⠀⠀⠀⠀⣼⠏⣰⡿⠬⣴⣿⣠⣁⣿⠿⢄⣾⡟⠁⣴⣏⣣⡀⢻⡇⠀⣿⠀⣰⣿⣿⣯⣥⣀⡉⠳⣮⡂⢻⡄
⠀⠀⠀⠀⠀⠀⢀⣾⣟⣸⣿⠠⣽⠟⣾⣵⣹⣿⣏⡼⣿⠁⡼⡟⡏⠃⢡⠈⣿⣸⠇⢰⠯⣽⡿⠋⠉⠙⠻⣶⣌⢳⠸⣧
⠀⠀⠀⠀⠀⢀⣾⠿⢿⣿⠫⢸⣿⡿⠟⡁⣻⡿⠈⣟⣿⠀⢇⡂⠇⣳⣟⠀⣿⠏⢠⢻⣼⡟⠀⠀⠀⠀⠀⠈⢻⣆⠀⣿
⠀⠀⠀⠀⢠⣿⣵⢨⣾⠽⢉⣿⣷⠨⠷⠀⢿⣷⣰⡈⣿⡄⠀⠏⣽⣿⢋⠰⠃⢰⣿⣹⣿⠀⠀⠀⠀⠀⠀⠀⠀⢻⣆⡟
⠀⠀⠀⢠⣿⣿⠻⣿⣷⠠⢸⣿⡷⡩⣔⡨⢽⣿⡳⠯⢹⣷⡀⠙⣿⡏⠂⢀⠠⣼⣗⢏⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠃
⠀⠀⢠⣿⢿⣈⣾⣿⣶⣷⣿⡿⠿⢷⣶⣷⣿⣿⣷⣦⡂⢹⣷⡀⢻⡖⡈⠂⣜⢻⡧⢰⢿⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢀⣞⣵⣾⡿⠟⠋⠉⣀⣀⣤⣤⣤⣤⣤⣀⣈⠉⠛⠛⠿⣿⣷⣄⠈⠐⠀⢀⣻⣗⢜⣚⢿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⣼⠿⠋⢁⣠⢴⢾⢻⣹⣼⣿⣟⣶⣿⣿⢹⣿⣿⣶⣦⣀⡀⠉⠛⢷⣄⡀⠁⠼⣯⡴⣔⠈⢻⣧⡀⠀⠀⠀⠀⠀⠀⠀
⠘⠁⣠⣶⣫⡽⠾⠛⠋⠉⠉⠁⠉⠉⠙⠛⠻⠿⣦⣇⡝⡛⢿⣶⣤⡀⠈⠛⢷⣤⣀⠀⠀⠙⠈⠙⠓⠀⠀⠀⠀⠀⢀⡀
⠠⠾⠛⠉⠀⣀⣤⠴⡶⢿⣟⣻⣟⠻⡶⢦⣤⣀⠀⠉⠙⠻⢦⣆⡏⠻⣷⣤⡀⠉⠛⠻⠷⠶⠶⠶⠶⠟⠛⠀⣠⣴⣿⠁
⠀⠀⣠⡶⣿⣽⣸⣬⣿⠿⠿⠿⢿⣿⣯⣯⣝⢋⠿⢷⣦⣄⠀⠈⠛⢷⣯⡩⢙⣷⣦⣤⣀⣀⣀⣀⣀⣠⡴⠞⢍⡾⠃⠀
⠀⣴⣯⠾⠛⠋⠁⢀⣀⣠⣤⣤⣤⣀⡀⠉⠛⠷⣬⣏⡒⢍⣿⣦⣄⡀⠈⠛⠷⣶⣍⡍⢛⣭⣋⣟⣍⣡⣢⡿⠋⠁⢀⡄
⠘⠉⠀⢀⣠⢶⠻⣛⢟⣿⣻⣿⡾⣟⡏⣛⣶⣤⡀⠉⠛⢷⣎⡝⠟⣟⡷⣤⡀⠀⠉⠛⠻⠷⠾⠿⠟⠛⠁⠀⣠⡶⢿⠃
⠀⢀⣴⣻⣥⠶⠷⠛⠛⠛⠛⠛⠻⢾⣿⣔⠪⣿⣿⣷⣤⡀⠈⠛⢶⣆⡝⢎⠛⠷⣦⣤⣀⣀⣀⣀⣀⣤⣴⠾⢣⣹⠏⠀
⠀⠚⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠻⢿⣿⣛⡭⠛⢶⣤⡀⠈⠛⠶⣬⣉⡙⢾⠯⠏⠏⣯⡟⢿⣧⣿⠟⠁⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠛⠷⠷⠿⣽⣷⣦⣤⠈⠉⠛⠛⠶⠾⠿⠷⠞⠛⠋⠁⠀⠀⠀⠀ 
"""
        )
            print('Você chegou ---> Atracando seu Barco no Porto\n')


def checa_ilha(player):
    
    ilha_jogador = select_to_dict('SELECT id_ilha,tipo,descricao from regiao inner join jogador on regiao.id_regiao = jogador.id_regiao where nome_save = %s and id_personagem = %s',player['nome_save'],player['id_personagem'])
    missoes_liberadas = select_to_dict("SELECT id_missao, status, id_jogador_save, id_jogador_personagem FROM public.missao_status where status = 'Concluida' and id_jogador_save = %s and id_jogador_personagem = %s",player['nome_save'],player['id_personagem'])
    
    ## list of dict com os ids das ilhas que estao liberadas
    ilhas_completadas = select_to_dict("SELECT id_ilha,descricao from ilha inner join missao_status on ilha.id_missao = missao_status.id_missao where status = 'Concluida' or status = 'Liberada' and id_jogador_save = %s and id_jogador_personagem = %s",player['nome_save'],player['id_personagem'])
    
    # ignorar ilha que o personagem se encontra, mostrar apenas as ilhas que ele pode ir
    ilhas_possiveis = [i for i in ilhas_completadas if not (i['id_ilha'] == ilha_jogador[0]['id_ilha'])]  

    ilhas = [] # liberando ilha de um personagem
    for itens in ilhas_possiveis:
        ilhas.append(itens['id_ilha'])

    
    if ilha_jogador[0]['tipo'] == 'Porto':
        if len(ilhas_possiveis) <= 0:
            return
        else:   
            return ilhas_possiveis 
                 

def ataque_simples_player(atacante,atacado,experiencia,energia):
    '''
    retorna dano
    '''

    poder_especial = 0
    
    damage = ((17 *experiencia)/3)+(poder_especial) + energia*0.05

    return damage

def restart(player):

    dados_restart = select_to_dict("SELECT id_regiao_anterior,vida_maxima,energia_maxima,berries FROM jogador WHERE nome_save = %s and id_personagem = %s",player['nome_save'],player['id_personagem'])

    print(dados_restart)

    for dado in dados_restart:
        energia_personagem = dado['energia_maxima']
        vida_personagem = dado['vida_maxima']
        regiao_anterior = dado['id_regiao_anterior']
        berries = dado['berries']


    with get_connection() as db:
        with db:
            cursor = db.cursor()
            sql = "update jogador set energia = %s,vida = %s,id_regiao = %s where nome_save = %s and id_personagem = %s"
            data = [energia_personagem,vida_personagem,regiao_anterior,player['nome_save'],player['id_personagem']]
            cursor.execute(sql,data)

    print("Você morreu !!! Seja mais cuidadoso da próxima vez.\n"
    "Observe sua vida antes de entrar em combate\nComa itens para recuperar sua vida.\nBoa sorte e Bom jogo")

    nada = input("Aperte enter . . .")
    

def luta(player,inimigo):
    
    dados_luta = select_to_dict("SELECT nome,vida_maxima,vida,fraqueza,energia_maxima,energia,experiencia from jogador where nome_save = %s and id_personagem = %s",player['nome_save'],player['id_personagem'])

    #print(dados_luta)
    #print("Inimigo : ")
    #print(inimigo)
    
    vida_personagem = dados_luta[0]['vida']
    experiencia_personagem = dados_luta[0]['experiencia']
    energia_personagem = dados_luta[0]['energia']
        
    experiencia_inimigo = inimigo['experiencia']
    vida_inimigo = inimigo['vida']
    energia_inimigo = inimigo['energia']


    print(vida_personagem,vida_inimigo)

    turno = random.choice([0,1])

    print(turno)
    # enquanto algum dos dois ainda estiverem com vida > 0
    while vida_personagem > 0 and vida_inimigo > 0:
        # luta acontece
        if(turno % 2 == 0):
            print("Sua vez :\n1)Ataque Simples\n2)Poder especial\n")
            # personagem ataca
            print("É tua vez de atacar :")
            dano = ataque_simples_player(player,inimigo,experiencia_personagem,energia_personagem)
            print(f"O dano foi de {dano}")
            vida_inimigo -= dano
            energia_personagem = energia_personagem * 0.95
        else:
            #inimigo ataca
            print("Vez do Inimigo de atacar :")
            dano = ataque_simples_player(player,inimigo,experiencia_inimigo,energia_inimigo)
            print(f"O dano foi de {dano}")
            vida_personagem -= dano
            energia_inimigo = energia_inimigo * 0.95


        turno+=1

        print(f"Tua vida 🤍 : {vida_personagem}\nVida inimigo : {vida_inimigo}\n")

        time.sleep(2)

    if(vida_inimigo < 0):
        vida_inimigo = 0
        with get_connection() as db:
            with db:
                cursor = db.cursor()
                sql = "update inimigo set vida = %s where id_personagem = %s"
                data = [0,inimigo['id_personagem']]
                cursor.execute(sql,data)
    if(vida_personagem <= 0):
        print("Você Morreu ! Naniiii ????")
        restart(player)
        return
        #restart(player)
        
    # no fim da luta dá o update no banco
    with get_connection() as db:
        with db:
            cursor = db.cursor()
            sql = "update jogador set energia = %s,vida = %s where nome_save = %s and id_personagem = %s"
            data = [energia_personagem,vida_personagem,player['nome_save'],player['id_personagem']]
            cursor.execute(sql,data)

    # ataque simples

def checa_inimigo_regiao(posicao_jogador,player):
    inimigos_regiao = select_to_dict('SELECT id_personagem,id_regiao,nome,ocupacao,energia,vida,vida_maxima,experiencia FROM inimigo where id_regiao = %s and vida > 0',posicao_jogador)
    i=0
    for inimigo in inimigos_regiao:
        print(f"\n\n{i} - {inimigo['nome']} é um {inimigo['ocupacao']} e está na mesma região que você.")
        i+=1
        if(inimigo['vida'] > 0):    
            print("A luta vai começar . . .")
            time.sleep(2)
            luta(player,inimigo)

    # Pensando a luta por turno...  Simples
    # iterador par Personagem ataca
    # iterador ímpar Inimigo ataca
    


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

def compra(player,id_itens,npc_num):

    print(f'Estou comprando de {npc_num}')
    item_id = input("Digite o número do item que deseja comprar :\n>")
    # falta verificar se a escolha foi válida

    qtd_item = input("Quantidade :\n>")
    # falta verificar se a qntd é válida de acordo com o que o cara tem no inventário

    with get_connection() as db:
        with db:
            cursor = db.cursor()
            sql = "CALL compra2(%s,%s,%s,%s,%s)"
            data = (item_id,qtd_item,player['nome_save'],player['id_personagem'],npc_num)
            cursor.execute(sql,data)

    print("Compra realizada !!")


def fala_com_npc(npc_dict,player):
    print(f"Olá sou {npc_dict['nome']}\n")
    npc_id = npc_dict['id_personagem']
    if(npc_dict['is_vendedor']):
        print("Quer comprar ? ")

        # acha berries do cara
        berries_dict = select_to_dict('select berries from jogador WHERE nome_save = %s and id_personagem = %s',player['nome_save'],player["id_personagem"])
        #print(berries_dict)
        berries = berries_dict[0]["berries"]
        print(f'Você tem ฿ {berries}\n')

        print("Aqui está meu inventário :\n")
        #print(f'id : {player["id_personagem"]} \nnome: {player["nome_save"]}')
        inventario_npc = select_to_dict("SELECT id_item,qtd_item from inventario_personagem where id_jogador_save = %s and id_jogador_personagem = %s and id_personagem = %s",player["nome_save"],player["id_personagem"],npc_dict['id_personagem'])
        #print(inventario_npc)

        id_itens = sorted([item['id_item'] for item in inventario_npc])

        with get_connection() as db:
                with db:
                    cursor = db.cursor()
                    sql = "SELECT nome,preco,qtd_energia,qtd_vida from item where id_item in %s order by id_item"
                    data = tuple([str(item) for item in id_itens])
                    data = (data,)
                    cursor.execute(sql,data)

                itens = cursor.fetchall()

        nomes = [item[0] for item in itens]
        precos = [item[1] for item in itens]
        energias = [item[2] for item in itens]
        vidas = [item[3] for item in itens]

        #print(nomes)
        i = 0
        for item in inventario_npc:
            print(f"{id_itens[i]} : {str(nomes[i])}\nPreço ฿{str(precos[i])}  Quantidade : {item['qtd_item']}x \nGanha {str(vidas[i])} de vida | Ganha {str(energias[i])} de energia\n")
            i+=1

        escolha = input("\n\nVocê deseja comprar algo :\n1-Sim\n2-Não\n3-Voltar\n>")
        if int(escolha) == 1:
            compra(player,id_itens,npc_id)
            escolha2 = input("\n\nVocê deseja comprar algo a mais:\n1-Sim\n2-Não\n>")

            while int(escolha2) == 1:
                escolha2 = input("\n\nVocê deseja comprar algo a mais:\n1-Sim\n2-Não\n>")
                compra(player,id_itens)

    else:
        fala_default = [{'nome_display': npc_dict['nome'], 'texto': '...', 'id_missao_liberada': None}]
        falas = select_to_dict('select id_conversa, nome_display, texto, id_missao_liberada from proxima_fala(%s, %s, %s)', npc_id, player['nome_save'], player['id_personagem']) or fala_default

        sleep_factor = 0.05
        for fala in falas:
            print(f"{fala['nome_display']}: {fala['texto']}")
            time.sleep(len(fala['texto']) * sleep_factor)
        print()

        e_pra_concluir_conversa = falas != fala_default

        if falas[0].get('id_missao_liberada', None) is not None:
            escolha = input('Deseja começar uma nova missão?\n1-Sim\n2-Depois\n\n> ')
            if escolha == '1':
                e_pra_concluir_conversa = True
            else:
                print(f'\nMissão recusada. Você pode conversar com {npc_dict["nome"]} caso mude de ideia.\n')
                e_pra_concluir_conversa = False

        if e_pra_concluir_conversa:
            concluir_conversa(npc_id, falas[0]['id_conversa'], player)
        input('Aperte enter para continuar...')



def concluir_conversa(npc_id, conversa_id, player):
    with get_connection() as db:
        with db:
            cursor = db.cursor()
            cursor.execute('insert into conversa_concluida '
                '(id_personagem, id_conversa, id_jogador_save, id_jogador_personagem) values (%s, %s, %s, %s);',
                [npc_id, conversa_id, player['nome_save'], player['id_personagem']])


def consumir_item(player,item,qntd_item):
    # recebo um item
    
    # pego atributos desse item
    atributos_item = select_to_dict('select qtd_vida,qtd_energia from item where id_item = %s',str(item))

    vida = atributos_item[0]['qtd_vida']
    energia = atributos_item[0]['qtd_energia']

    try:
        with get_connection() as db:
            with db:
                cursor = db.cursor()
                sql = "CALL consumo_item(%s,%s,%s,%s,%s,%s)"
                data = (vida,energia,str(item),str(qntd_item),player['nome_save'],player['id_personagem'])
                cursor.execute(sql,data)
    except Exception:
        print('Você não tem o item ou não tem item suficientes')
        return

    print("Atualizado !!!")

def inventario(player):
    print("Aqui está seu inventário :\n")
    inventario_jogador = select_to_dict("SELECT id_item,qtd_item from inventario_jogador where id_jogador_save = %s and id_jogador_personagem = %s",player["nome_save"],player["id_personagem"])
    #print(inventario_jogador)

    if not inventario_jogador:
        print("Inventário está vazio !")
        return

    id_itens = [item['id_item'] for item in inventario_jogador]

    dth = {x['id_item'] : x['qtd_item'] for x in inventario_jogador}

    #print(dth)
    with get_connection() as db:
            with db:
                cursor = db.cursor()
                sql = "SELECT id_item,nome,qtd_vida,qtd_energia,preco,is_equipavel from item where id_item in %s"
                data = tuple([str(item) for item in id_itens])
                data = (data,)
                cursor.execute(sql,data)

            itens = cursor.fetchall()

    nomes = [item[1] for item in itens]
    vidas = [item[2] for item in itens]
    energias = [item[3] for item in itens]
    precos = [item[4] for item in itens]
    
    '''
    header = ['Id_item','Nome','Vida','Energia','Preço','Quantidade']

    mat = [header, ['---'] * len(header), *[[*it,dth.get(it[0],0)]for it in itens]]

    for row in mat:
        print('|' + '|'.join(str(r).center(20) for r in row) + '|')

    '''

    itens_consumiveis = []
    itens_equipaveis = []

    for item in itens:
        if item[5]:
            itens_equipaveis.append(item)
        else:
            itens_consumiveis.append(item)

    i = 0
    if itens_consumiveis:
        print("\tItens consumíveis\n")
        for key in dth:
            print(f"{key} : {str(nomes[i])}\n\tQuantidade : {dth[key]}x\n\tVida : {str(vidas[i])}\n\tEnergia : {str(energias[i])}\n\tPreço ฿ {str(precos[i])},00\n\n")
            i+=1

    i = 0
    if itens_equipaveis:
        print("\tItens equipáveis\n")
        for item in itens_equipaveis:
            print(f"{id_itens[i]} : {str(nomes[i])}\n\tQuantidade : {item['qtd_item']}x\n\tVida : {str(vidas[i])}\n\tEnergia : {str(energias[i])}\n\tPreço ฿ {str(precos[i])},00\n\n")
            i+=1

    escolha = input("\nO que deseja fazer ?\n1 - Consumir item\n2 - Equipar Item\n3 - Voltar\n>")

    if escolha == '1':
        item = int(input("Qual item deseja consumir ?\n>"))
        qtd_item = input("Qual a quantidade desse item ?\n>")
        consumir_item(player,item,qtd_item)

    elif escolha == '2':
        equipar_item()

    elif escolha == '3':
        return
    else:
        print("Opção inválida\n")

def menu(player):

    invalid = True

    while True:
        player_data = select_to_dict("SELECT nome,vida from jogador where nome_save = %s and id_personagem = %s",player['nome_save'],player['id_personagem'])
        nome_player = player_data[0]["nome"]
        vida_player = player_data[0]['vida']
        posicao_atual,regioes_to_go = regiao_player(player)
        ilha_jogador = select_to_dict('SELECT id_ilha,tipo,descricao from regiao inner join jogador on regiao.id_regiao = jogador.id_regiao where nome_save = %s and id_personagem = %s',player['nome_save'],player['id_personagem'])

       
        print("##### One Piece ! 💀 - \U0001f480 ######\n\n")
        print(f"Jogador {nome_player} 🏴‍☠️\n"
            f"Você está em {posicao_atual}\n"
            f"Na ilha {ilha_jogador[0]['descricao']} do tipo {ilha_jogador[0]['tipo']}\n")
        printa_objetivo_atual(player)    

        npcs_regiao = checa_personagem_regiao(posicao_atual)
        inimigos_regiao = checa_inimigo_regiao(posicao_atual,player)
        ilhas_disponiveis = checa_ilha(player)
        
        if ilhas_disponiveis:
            print(
            "\n\nM - Mover personagem\n"
            "I - Ver Inventário\n"
            f"H - Ir para outra Ilha\n"
            "Q - Sair\n"
        )
        
        else:
            print(
                "\n\nM - Mover personagem\n"
                "I - Ver Inventário\n"
                "Q - Sair"
            )

        escolha = input("O que você deseja fazer ?\n\n> ").lower()

        
        if escolha == 'h':
                muda_de_ilha(player)
                
        elif escolha == 'm':
            regiao = printa_regioes(nome_player,regioes_to_go)
            move_player(player,regiao)
        elif escolha == 'q':
            main()
        elif escolha == 'i':
            inventario(player)
        elif 0 <= int(escolha) <= len(npcs_regiao):
            print("-------Falando com NPC-------------\n\n")
            fala_com_npc(escolha,npcs_regiao,player)

        else:
            print("Opção inválida")

def printa_objetivo_atual(player: dict) -> None:
    obj = get_current_objective(player)

    title = 'Nenhuma Missão em andamento'
    body = 'Fale com algum Cidadão, ele pode ter uma Missão para você!'
    if obj:
        title = obj["nome"]
        body = obj["descricao"]

    size = max(len(body), 60) + 14

    print('-' * size)
    print(f'Missão: {title.center(size - 8)}')
    print(f'Objetivo: {body.center(size - 10)}')
    print('-' * size + '\n\n')


def get_current_objective(player: dict):
    obj, *_ = select_to_dict('select nome, descricao from objetivo_atual(%s, %s)', player['nome_save'], player['id_personagem']) or [None]
    return obj


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
    return select_to_dict('SELECT nome, id_personagem, nome_save,vida FROM jogador WHERE nome_save = %s', save)

def select_to_dict(query: str, *args):
    with get_connection() as conn:
        cursor = conn.cursor(cursor_factory=AS_DICT)
        cursor.execute(query, args or ...)
        return cursor.fetchall()


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

    print('='*130)
    for s in op.split('\n'):
        print(f'{s:^130}')
    print('='*130)
    print('[1] - Usar um save existente.')
    print('[2] - Criar um novo save.')
    print('[q] - Sair.')
    while True:
        value = input('Digite o número da sua opção: \n\n> ').strip()
        if value not in actions:
            print('Digite um número válido [1, 2, q].')
        else:
            return actions[value]()


def choose_save() -> str:
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

    jogador = player['nome_save']
    personagem = player['id_personagem']

    print(jogador,personagem)

    with get_connection() as db:
        with db:
            cursor = db.cursor()
            cursor.execute('UPDATE jogador SET id_regiao = %s where nome_save = %s and id_personagem = %s',[escolha,jogador,personagem])

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