(define (domain drone-dom)

    (:requirements
        :strips :fluents :typing :durative-actions 
    )

    (:types
        drone human box content location carrier num
    )

    (:predicates
        (drone-at ?d - drone ?l - location) 
        (drone-free ?d - drone)
        (drone-carry-box ?d - drone ?b - box)
        (human-at ?h - human ?l - location)
        (human-has ?h - human ?c - content)
        (box-at ?b - box ?l - location)
        (box-has ?b - box ?c - content)
        (box-free ?b - box)
        (carrier-at ?r - carrier ?l - location)
        (carrier-has-box ?r - carrier ?b - box)
        (next ?n1 ?n2 - num)
        (carrier-n-boxes ?r - carrier ?n - num)
        (human-free ?h - human) ;para comprobar que el humano solo pueda recibir 1 caja a la vez
        (carrier-drone-free ?r - carrier)    ;para que un dron no mueva el carrier si el otro lo esta cargando
    )

    (:functions
        (total-cost)
        (fly-cost ?origen ?destino - location)
    )

    (:durative-action move-carrier
        :parameters (?d - drone ?to ?from - location ?r - carrier)
        :duration (= ?duration (fly-cost ?to ?from))
        :condition (and
            (at start (and 
                (carrier-at ?r ?from)              
                (drone-at ?d ?from)
                (drone-free ?d)
            ))
        )
        :effect (and 
            (at start (and 
                (not(carrier-at ?r ?from))
                (not(drone-at ?d ?from))
                (not(carrier-drone-free ?r))
                (not (drone-free ?d))
            ))
            (at end (and 
                (carrier-at ?r ?to)
                (drone-at ?d ?to)
                (carrier-drone-free ?r)
                (drone-free ?d)
            ))
        )
    )

    (:durative-action move
        :parameters (?d - drone ?from ?to - location)
        :duration (= ?duration (fly-cost ?from ?to))
        :condition (and 
            (at start (and
                (drone-at ?d ?from))
        ))
        :effect (and
            (at start (and 
                (not (drone-at ?d ?from))
            ))
            (at end (and
                (drone-at ?d ?to))
            ))                                  
    )
    
    (:durative-action put-box-on-carrier
        :parameters (?d - drone ?b - box ?l - location ?r - carrier ?n1 ?n2 - num)
        :duration (= ?duration 1)
        :condition (and 
            (at start (and 
                (carrier-at ?r ?l) ;debe estar bajado el carrier
                (drone-carry-box ?d ?b) ;el dron tiene que tener la caja (haber hecho pick-up)
            ))
            (over all (and 
                (drone-at ?d ?l)
                (next ?n1 ?n2) ;no ha llegado al limite de capacidad
            ))
        )
        
        :effect (and
            (at start (and
                (not (drone-carry-box ?d ?b)) ;el dron deja de tener la caja
                (not (carrier-n-boxes ?r ?n1))
                ;(not (carrier-drone-free ?r))
            ))
            (at end (and 
                (carrier-has-box ?r ?b) ;para tenerla el carrier            
                (carrier-n-boxes ?r ?n2)
                (drone-free ?d)
            ))          
        )
    )
    
    (:durative-action pick-up
        :parameters (?d - drone ?b - box ?c - content ?l - location)
        :duration (= ?duration 1)
        :condition (and 
            (at start (and
                (box-at ?b ?l)
                (drone-free ?d)            
                (box-free ?b)
            ))
            (over all (and
                (box-has ?b ?c)
                (drone-at ?d ?l)
            ))
        )               
        :effect (and 
            (at start (and
                (not (drone-free ?d))
                (not (box-at ?b ?l))
            ))
            (at end (and 
                (drone-carry-box ?d ?b)
            ))
        )
    )

    (:durative-action take-off-box-carrier
        :parameters (?d - drone ?b - box ?l - location ?r - carrier ?n1 ?n2 - num)
        :duration (= ?duration 1)
        :condition (and 
            (at start (and 
                (carrier-at ?r ?l) ;el carrier y el dron deben estar en el mismo sitio
                (carrier-has-box ?r ?b) ;la caja a coger la tiene que tener el carrier
                (drone-free ?d) ;el dron tiene que estar vacio
                (carrier-n-boxes ?r ?n2)
            ))
            (over all (and
                (drone-at ?d ?l)
                (next ?n1 ?n2)
            ))
        )
        :effect (and
            (at start (and 
                (not(drone-free ?d))
                (not(carrier-has-box ?r ?b)) ;el carrier ya no la tendrá
                (not(carrier-n-boxes ?r ?n2))
            ))
            (at end (and
                (drone-carry-box ?d ?b) ;el dron coge la caja
                (carrier-n-boxes ?r ?n1)
            ))
        )
    )
    
    (:durative-action drop
        :parameters (?d - drone ?b - box ?c - content ?l - location ?h - human)
        :duration (= ?duration 1)
        :condition (and 
            (at start (and  
                (human-at ?h ?l)
                (drone-carry-box ?d ?b)
                (human-free ?h)
            ))
            (over all (and  
                (box-has ?b ?c)
                (drone-at ?d ?l)
            ))
        )
        :effect (and 
            (at start (and 
                (not (drone-carry-box ?d ?b))
                (not (box-free ?b))
                (not (human-free ?h))
            ))
            (at end (and 
                (drone-free ?d)
                (box-at ?b ?l)
                (human-has ?h ?c)
                (human-free ?h)
            ))
        )
    )
)