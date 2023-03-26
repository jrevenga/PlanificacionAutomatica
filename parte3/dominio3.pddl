(define (domain dron)
    (:requirements :strips :typing :durative-actions :fluents)
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

    (:functions
        (fly-cost ?desde - location ?hasta - location)
    )
    
    (:durative-action volar
        :parameters (?d - dron ?desde ?hasta - location ?tr - transportador)
        :duration (= ?duration (fly-cost ?desde ?hasta))
        :condition (at start 
                (and
                (libre-dron ?d)
                (esta-dron ?d ?desde)
                (esta-trans ?tr ?desde)
                ))
        :effect (and 
            (at start 
                (and (not (esta-trans ?tr ?desde))
                (not (esta-dron ?d ?desde))))
            (at end
                (and (esta-trans ?tr ?hasta)
                (esta-dron ?d ?hasta)))
            )
    )

    (:durative-action meter-caja-trans
        :parameters (?d - dron ?c - caja ?tr - transportador ?l - location ?n1 ?n2 - num)
        :duration (= ?duration 1)
        :condition (at start 
                (and (esta-dron ?d ?l)
                (esta-trans ?tr ?l)
                (lleva-dron ?d ?c)
                (trans-carga ?tr ?n1)
                (siguiente ?n1 ?n2)
                ))
        :effect (and 
            (at start 
                (and (not (lleva-dron ?d ?c))))
            (at end
                (and (libre-dron ?d)
                (trans-lleva ?tr ?c)
                (trans-carga ?tr ?n2)
                (not (trans-carga ?tr ?n1))))
            )
    )

    (:durative-action sacar-caja-trans
        :parameters (?d - dron ?c - caja ?tr - transportador ?l - location ?n1 ?n2 - num)
        :duration (= ?duration 1)
        :condition (at start 
                (and (esta-dron ?d ?l)
                (esta-trans ?tr ?l)
                (trans-lleva ?tr ?c)
                (libre-dron ?d)
                (trans-carga ?tr ?n2)
                (siguiente ?n1 ?n2)
                )) 
        
        :effect (and 
            (at start 
                (and (not (libre-dron ?d))
                (not (trans-lleva ?tr ?c))
                (trans-carga ?tr ?n1)
                (not (trans-carga ?tr ?n2))))
            (at end
                (and (lleva-dron ?d ?c)))
            )
    )

    (:durative-action coger
       :parameters  (?d - dron ?c - caja ?l - location ?con - contenido)
       :duration (= ?duration 1)
       :condition (at start 
                (and (esta-dron ?d ?l)
                (esta-caja ?c ?l)
                (libre-dron ?d)
                )) 
       :effect (and 
            (at start 
                (and (not (esta-caja ?c ?l))
                (not (libre-dron ?d))))
            (at end
                (and (lleva-dron ?d ?c)))
            )
    )

    (:durative-action soltar
       :parameters  (?d - dron ?c - caja ?l - location ?p - persona ?con - contenido)
       :duration (= ?duration 1)
       :condition (at start 
                (and (esta-dron ?d ?l)
                (esta-persona ?p ?l)
                (lleva-dron ?d ?c)
                (almacena ?c ?con)
                ))
       :effect (and 
            (at start 
                (and (consigue ?p ?con)
                (not (lleva-dron ?d ?c))))
            (at end
                (and (libre-dron ?d)))
            )
    )
)