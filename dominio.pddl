(define (domain dron)
    (:requirements :strips :typing)
    (:types
     dron persona location contenido caja brazo contenedor num
    )

    (:predicates
        (esta-dron ?d - dron ?l - location)
        (esta-caja ?c - caja ?l - location)
        (esta-persona ?p - persona ?l - location)
        (libre ?b - brazo)
        (lleva ?d - dron ?c - caja ?b - brazo)
        (consigue ?p - persona ?con - contenido)
        (almacena ?c - caja ?con - contenido)
        (caja-libre ?c  - caja)
        (esta-contenedor ?con - contenedor ?l - location)
        (tiene-caja ?con - contenedor ?c - caja)
        (siguiente ?n1 ?n2 - num)
        (contenedor-n-cajas ?con - contenedor ?n - num)
        (dron-libre ?d - dron)
        (lleva-dron ?d - dron ?c - caja)
        (libre-dron ?d - dron)
    )

    (:action mover-contenedor
        :parameters (?d - dron ?desde ?hasta - location ?con - contenedor)
        :precondition (and
            (dron-libre ?d)
            (esta-dron ?d ?desde)
            (esta-contenedor ?con ?desde) 
        )
        :effect (and 
            (not (esta-contenedor ?con ?desde))
            (not (esta-dron ?d ?desde))
            (esta-contenedor ?con ?hasta)
            (esta-dron ?d ?hasta)
        )
        )

    (:action meter-caja-contenedor
        :parameters (?d - dron ?c - caja ?con - contenedor ?l - location ?n1 ?n2 - num)
        :precondition (and
            (esta-dron ?d ?l)
            (esta-contenedor ?con ?l)
            (esta-caja ?c ?l)
            (lleva-dron ?d ?c)
            (siguiente ?n1 ?n2)
            (contenedor-n-cajas ?con ?n1) )
        :effect (and
            (libre-dron ?d)
            (not (lleva-dron ?d ?c))
            (tiene-caja ?con ?c)
            (not (contenedor-n-cajas ?con ?n1))
            (contenedor-n-cajas ?con ?n2))
    )

    (:action sacar-caja-contenedor
        :parameters (?d - dron ?c - caja ?con - contenedor ?l - location ?n1 ?n2 - num)
        :precondition (and
            (esta-dron ?d ?l)
            (esta-contenedor ?con ?l)
            (tiene-caja ?con ?c)
            (libre-dron ?d)
            (contenedor-n-cajas ?con ?n2)
            (siguiente ?n1 ?n2))
        :effect (and
            (not (libre-dron ?d))
            (lleva-dron ?d ?c)
            (not (tiene-caja ?con ?c))
            (contenedor-n-cajas ?con ?n1)
            (not (contenedor-n-cajas ?con ?n2)))
    )

    (:action coger-sin-brazo
       :parameters  (?d - dron ?c - caja ?l - location ?con - contenido)
       :precondition (and
           (esta-dron ?d ?l)
           (esta-caja ?c ?l)
           (almacena ?c ?con)
           (caja-libre ?c)
           (libre-dron ?d))
       :effect (and
           (lleva-dron ?d ?c)
           (not (esta-caja ?c ?l))
           (not (libre-dron ?d)))
    )

    (:action soltar-sin-brazo
       :parameters  (?d - dron ?c - caja ?l - location ?p - persona ?con - contenido)
       :precondition (and
           (esta-dron ?d ?l)
           (esta-persona ?p ?l)
           (almacena ?c ?con)
           (lleva-dron ?d ?c)
           )
               
       :effect (and
           (consigue ?p ?con)
           (libre-dron ?d)
           (esta-caja ?c ?l)
           (not (lleva-dron ?d ?c))
           (not (caja-libre ?c))
           )     
    )
    
        
    
    (:action volar
       :parameters  (?from - location ?to - location ?d - dron)
       :precondition (esta-dron ?d ?from)
       :effect (and
           (esta-dron ?d ?to)
           (not (esta-dron ?d ?from)))
    )

    (:action coger-brazo
       :parameters  (?d - dron ?b - brazo ?c - caja ?l - location ?con - contenido)
       :precondition (and
           (esta-dron ?d ?l)
           (esta-caja ?c ?l)
           (almacena ?c ?con)
           (caja-libre ?c)
           (libre ?b))
       :effect (and
           (lleva ?d ?c ?b)
           (not (esta-caja ?c ?l))
           (not (libre ?b)))
    )

    (:action soltar-brazo
       :parameters  (?d - dron ?b - brazo ?c - caja ?l - location ?p - persona ?con - contenido)
       :precondition (and
           (esta-dron ?d ?l)
           (esta-persona ?p ?l)
           (almacena ?c ?con)
           (lleva ?d ?c ?b)
           )
               
       :effect (and
           (consigue ?p ?con)
           (libre ?b)
           (esta-caja ?c ?l)
           (not (lleva ?d ?c ?b))
           (not (caja-libre ?c))
           )     
    )
)