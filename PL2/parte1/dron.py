from pyhop import hop

# Operadores
def volar(state,d,f,t):
    if state.loc[d] == f:
        state.loc[d] = t
        return state
    else: return False

def coger(state,d,c):
    if state.loc[d] == state.loc[c] and state.carry[d] == False:
        state.loc[c] = d
        state.carry[d] = True
        return state
    else: return False

def soltar(state,d,c,p):
    if state.loc[d] == state.loc[p] and state.loc[c] == d and state.necesita[p] == state.almacena[c]:
        state.loc[c] = p
        state.carry[d] = False
        del state.necesita[p]
        del state.almacena[c]
        return state
    else: return False

def enviar(state):
    lista_cajas = list(state.almacena.keys())
    d = list(state.carry.keys())[0]
    if len(lista_cajas) > 0:
        persona = list(state.necesita.keys())[0]
        for i in lista_cajas:
            if state.loc[d] == state.loc[i] and state.almacena[i] == state.necesita[persona]:
                return [('coger',d,i),
                ('volar',d,state.loc[d],state.loc[persona]),
                ('soltar',d,i,persona),
                ('h')]
            elif state.almacena[i] == state.necesita[persona]:
                return [('volar',d,state.loc[d],state.loc[i]),
                ('coger',d,i),
                ('volar',d,state.loc[i],state.loc[persona]),
                ('soltar',d,i,persona),
                ('h')]
    else:
        return []

hop.declare_operators(volar, coger, soltar)
hop.declare_methods('h', enviar)

state1 = hop.State('state1')
state1.loc = {'dron1':'deposito',
              'c1': 'deposito','c2': 'deposito','c3': 'deposito','c4': 'deposito','c5': 'deposito',
              'p1' : 'l1','p2' : 'l2','p3' : 'l3','p4' : 'l4','p5' : 'l5'}
state1.almacena = {'c1' :'medicina','c2' : 'comida','c3' : 'comida','c4' : 'comida','c5' : 'medicina'}
state1.necesita = {'p1' : 'comida','p2' : 'comida','p3' : 'medicina','p4' : 'medicina','p5' : 'comida'}
state1.carry = {'dron1':False}
#state1.libre = {'brazo1' : True, 'brazo2' : True}

hop.plan(state1,
         [('h')],
         hop.get_operators(),
         hop.get_methods(),
         verbose = 1)
