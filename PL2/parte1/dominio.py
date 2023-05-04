from tabnanny import verbose
from pyhop import hop

# Operadores
def move(state, d, f, t):
    if state.drone_at[d] == f:
        state.drone_at[d] = t
        return state
    else: return False

def pick_up(state, d, b, c, l):
    if (state.drone_at[d] == l) and (state.box_at[b] == l) and (state.drone_free[d]) and (state.box_has[b] == c) and (state.box_free[b]):
        state.drone_free[d] = False
        state.box_at[b] = d # localizacion de la caja pasa a ser el drone
        state.drone_carry[d] = b
        return state
    else: return False

def drop(state, d, b, c, l, h):
    if (state.drone_at[d] == l) and (state.drone_carry[d] == b) and (state.human_at[h] == l) and (state.box_has[b] == c):
        state.drone_carry[d] = False
        state.box_free[b] = False
        #state.human_needs[h].remove(c) # borrar contenido especifico de un humano
        #if (len(state.human_needs[h]) == 0):
        state.human_needs.pop(h)
        state.drone_free[d] = True
        state.box_at[b] = l
        return state
    else: return False

# methods
def send_box(state, h, c):
    box_keys = state.box_has.keys()
    drone_keys = state.drone_at.keys()
    d = drone_keys[0] # tenemos el drone
    box_found = False

    for i in range (len(box_keys)):
        if (state.box_has[box_keys[i]] == c) and (state.box_at[box_keys[i]] == 'warehouse'):
            b = box_keys[i] # obtenemos la caja en la variable b
            box_found = True
            break
    if box_found == True:
        to = state.human_at[h] # localizacion a la que tiene que ir el drone
        f = 'warehouse' # from
        return [('pick_up', d, b, c, f), 
                ('move', d, f, to),
                ('drop', d, b, c, to, h),
                ('move', d, to, f)]
    else:
        return False

def send_all_boxes(state):
    if (len(state.human_needs) > 0):
        human_keys = state.human_needs.keys()
        return [('c', human_keys[0], state.human_needs[human_keys[0]]), ('h')]
    else:
        return []

hop.declare_operators(move, pick_up, drop) 
hop.declare_methods('c', send_box)
hop.declare_methods('h', send_all_boxes)

# initial state

state1 = hop.State('state1')

state1.drone_at = {'drone1' : 'warehouse'}

state1.box_at = {'box1': 'warehouse',
                'box2': 'warehouse',
                'box3': 'warehouse',
                'box4': 'warehouse',
                'box5': 'warehouse',
                'box6': 'warehouse',
                'box7': 'warehouse',
                'box8': 'warehouse',
                'box9': 'warehouse',
                'box10': 'warehouse'}

state1.drone_free = {'drone1' : True}

state1.box_has = {'box1' :'meds',
                    'box2' : 'meds',
                    'box3' : 'meds',
                    'box4' : 'meds',
                    'box5' : 'meds',
                    'box6' : 'food',
                    'box7' : 'food',
                    'box8' : 'food',
                    'box9' : 'food',
                    'box10' : 'food'}
                    
state1.box_free = {'box1' : True,
                    'box2' : True,
                    'box3' : True,
                    'box4' : True,
                    'box5' : True,
                    'box6' : True,
                    'box7' : True,
                    'box8' : True,
                    'box9' : True,
                    'box10' : True }

state1.drone_carry = {'drone1' : False}

state1.human_at = {'human1' : 'loc1',
                    'human2' : 'loc2',
                    'human3' : 'loc3',
                    'human4' : 'loc4',
                    'human5' : 'loc5',
                    'human6' : 'loc6',
                    'human7' : 'loc7',
                    'human8' : 'loc8',
                    'human9' : 'loc9',
                    'human10' : 'loc10'}

state1.human_needs = {'human1' : 'food',
                        'human2' : 'food',
                        'human3' : 'food',
                        'human4' : 'food',
                        'human5' : 'food',
                        'human6' : 'meds',
                        'human7' : 'meds',
                        'human8' : 'meds',
                        'human9' : 'meds',
                        'human10':  'meds'}

# execute

hop.plan(state1, [('h')], hop.get_operators(), hop.get_methods(), verbose = 1)