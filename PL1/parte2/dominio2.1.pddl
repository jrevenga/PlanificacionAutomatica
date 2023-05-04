(define (domain dron)
    (:requirements :strips :typing)
    (:types
     dron persona location contenido caja transportador num
    )

    (:predicates
        (esta-dron ?d - dron ?l - location)
        (esta-caja ?c - caja ?l - location)
        (esta-persona ?p - persona ?l - location)
        (esta-trans ?tr - transportador ?l - location)
        (libre-dron ?d - dron)
        (lleva-dron ?d - dron ?c - caja)
        (consigue ?p - persona ?con - contenido)
        (almacena ?c - caja ?con - contenido)
        (trans-lleva ?tr - transportador ?c - caja)
        (siguiente ?n1 ?n2 - num)
        (trans-carga ?tr - transportador ?n - num)
    )

    
    (:action volar
        :parameters (?d - dron ?desde ?hasta - location ?tr - transportador)
        :precondition (and
            (libre-dron ?d)
            (esta-dron ?d ?desde)
            (esta-trans ?tr ?desde) 
        )
        :effect (and 
            (not (esta-trans ?tr ?desde))
            (not (esta-dron ?d ?desde))
            (esta-trans ?tr ?hasta)
            (esta-dron ?d ?hasta)
            )    
    )

    (:action meter-caja-trans
        :parameters (?d - dron ?c - caja ?tr - transportador ?l - location ?n1 ?n2 - num)
        :precondition (and
            (esta-dron ?d ?l)
            (esta-trans ?tr ?l)
            (lleva-dron ?d ?c)
            (trans-carga ?tr ?n1)
            (siguiente ?n1 ?n2))
        :effect (and
            (libre-dron ?d)
            (trans-lleva ?tr ?c)
            (not (lleva-dron ?d ?c))
            (trans-carga ?tr ?n2)
            (not (trans-carga ?tr ?n1))
            )
    )

    (:action sacar-caja-trans
        :parameters (?d - dron ?c - caja ?tr - transportador ?l - location ?n1 ?n2 - num)
        :precondition (and
            (esta-dron ?d ?l)
            (esta-trans ?tr ?l)
            (trans-lleva ?tr ?c)
            (libre-dron ?d)
            (trans-carga ?tr ?n2)
            (siguiente ?n1 ?n2))
        :effect (and
            (not (libre-dron ?d))
            (lleva-dron ?d ?c)
            (not (trans-lleva ?tr ?c))
            (trans-carga ?tr ?n1)
            (not (trans-carga ?tr ?n2))
            )
    )

    (:action coger
       :parameters  (?d - dron ?c - caja ?l - location ?con - contenido)
       :precondition (and
           (esta-dron ?d ?l)
           (esta-caja ?c ?l)
           (almacena ?c ?con)
           (libre-dron ?d))
       :effect (and
           (lleva-dron ?d ?c)
           (not (esta-caja ?c ?l))
           (not (libre-dron ?d))
           )
    )

    (:action soltar
       :parameters  (?d - dron ?c - caja ?l - location ?p - persona ?con - contenido)
       :precondition (and
           (esta-dron ?d ?l)
           (esta-persona ?p ?l)
           (lleva-dron ?d ?c)
           )
       :effect (and
           (consigue ?p ?con)
           (libre-dron ?d)
           (not (lleva-dron ?d ?c))
           )
    )
)