(define (problem problema1) (:domain dron)
    (:objects
        dron1 - dron
        brazo1 brazo2 - brazo
        deposito l1 - location
        p1 - persona
        c1 - caja
        medicina comida - contenido
    )

    (:init
        (esta-dron dron1 deposito)
        (esta-caja c1 deposito)
        (esta-persona p1 l1)
        (almacena c1 medicina)
        (libre brazo1)
        (libre brazo2)
        (caja-libre c1)
    )

    (:goal 
        (consigue p1 medicina)
    )
)