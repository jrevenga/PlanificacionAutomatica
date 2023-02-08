(define (domain dron)

    (:requirements :strips :typing)
    (:types dron persona loc contenido caja brazo - object)

    (:predicates
        (esta-dron ?d - dron ?l - loc)
        (esta-caja ?c - caja ?l - location)
        (esta-persona ?p - persona ?l - location)
        (libre ?b - brazo)
        (agarra ?d - dron ?c - caja ?b - brazo)
        (consigue ?p - persona ?con - contenido)
        (almacena ?c - caja ?con - contenido)
    )

    (:action volar
       :parameters  (?from - loc ?to - loc ?d - dron)
       :precondition (esta-dron ?d ?from)
       :effect (and
           (esta-dron ?d ?to)
           (not (esta-dron ?d ?from)))
    )

    (:action coger
       :parameters  (?d - dron ?b - brazo ?c - caja ?l - loc ?con - contenido)
       :precondition (and
           (esta-dron ?d ?l)
           (esta-caja ?c ?l)
           (almacena ?c ?con)
           (libre ?b))
       :effect (and
           (agarra ?d ?c ?b)
           (not (esta-caja ?c ?l))
           (not (libre ?b)))
    )

    (:action soltar
       :parameters  (?d - dron ?b - brazo ?c - caja ?l - loc ?p - persona ?con - contenido)
       :precondition (and
           (esta-dron ?d ?l)
           (agarra ?d ?c ?b)
           (esta-persona ?p ?l)
           (almacena ?c ?con))
       :effect (and
           (consigue ?p ?con)
           (not (agarra ?d ?c ?b))
           (libre ?b))
    )
)