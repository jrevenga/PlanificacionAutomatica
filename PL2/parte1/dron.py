from pyhop import hop

# Operadores
def volar(state,d,f,t):
    if state.esta_dron[d] == f:
        state.esta_dron[d] = t
        return state
    else: return False

def coger(state,d,c,b):
    if state.esta_dron[d] == state.esta_caja[c] and state.lleva[d] == False and state.libre[b]:
        state.libre[b] = False
        state.esta_caja[c] = d
        state.lleva[d] = True
        return state
    else: return False

def soltar(state,d,c,p,b):
    if state.esta_dron[d] == state.esta_persona[p] and state.esta_caja[c] == d and state.necesita[p] == state.almacena[c] and state.libre[b]:
        state.esta_caja[c] = p
        state.lleva[d] = False
        del state.necesita[p]
        del state.almacena[c]
        state.libre[b] = True
        return state
    else: return False

def enviar(state):
    lista_cajas = list(state.almacena.keys())
    d = list(state.lleva.keys())[0]
    if len(lista_cajas) > 0:
        persona = list(state.necesita.keys())[0]
        for i in lista_cajas:
            if state.esta_dron[d] == state.esta_caja[i] and state.almacena[i] == state.necesita[persona]:
                return [('coger',d,i),
                    ('volar',d,state.esta_dron[d],state.esta_persona[persona]),
                    ('soltar',d,i,persona),
                    ('h')]
            elif state.almacena[i] == state.necesita[persona]:
                return [('move',d,state.esta_dron[d],state.esta_caja[i]),
                    ('coger',d,i),
                    ('volar',d,state.esta_caja[i],state.esta_persona[persona]),
                    ('soltar',d,i,persona),
                    ('h')]
    else:
        return []

hop.declare_operators(volar, coger, soltar)
hop.declare_methods('h', enviar)

state1 = hop.State('state1')
state1.libre = {'brazo1' : True, 'brazo2' : True}
state1.esta_dron = {'dron1':'deposito'}
state1.esta_caja = {'c1': 'deposito','c2': 'deposito','c3': 'deposito','c4': 'deposito','c5': 'deposito'}
state1.esta_persona = {'p1' : 'l1','p2' : 'l2','p3' : 'l3','p4' : 'l4','p5' : 'l5'}
state1.almacena = {'c1' :'medicina','c2' : 'comida','c3' : 'comida','c4' : 'comida','c5' : 'medicina'}
state1.necesita = {'p1' : 'comida','p2' : 'comida','p3' : 'medicina','p4' : 'medicina','p5' : 'comida'}
state1.lleva = {'dron1':False}

hop.plan(state1,
         [('h')],
         hop.get_operators(),
         hop.get_methods(),
         verbose = 1)
