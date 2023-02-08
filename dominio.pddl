(define (domain dron)

    (:requirements :strips :typing)
    (:types
     dron persona location contenido caja brazo - object
    )

    (:predicates
        (esta-dron ?d - dron ?l - location)
        (esta-caja ?c - caja ?l - location)
        (esta-persona ?p - persona ?l - location)
        (libre ?b - brazo)
        (lleva ?d - dron ?c - caja ?b - brazo)
        (consigue ?p - persona ?con - contenido)
        (almacena ?c - caja ?con - contenido)
    )

    (:action volar
       :parameters  (?from - location ?to - location ?d - dron)
       :precondition (esta-dron ?d ?from)
       :effect (and
           (esta-dron ?d ?to)
           (not (esta-dron ?d ?from)))
    )

    (:action coger
       :parameters  (?d - dron ?b - brazo ?c - caja ?l - location ?con - contenido)
       :precondition (and
           (esta-dron ?d ?l)
           (esta-caja ?c ?l)
           (almacena ?c ?con)
           (libre ?b))
       :effect (and
           (lleva ?d ?c ?b)
           (not (esta-caja ?c ?l))
           (not (libre ?b)))
    )

    (:action soltar
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
           )     
    )
)