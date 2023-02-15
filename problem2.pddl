(define (problem problema2) (:domain dron)
    (:objects
        dron1 - dron
        brazo1 brazo2 - brazo
        deposito l1 l2 - location
        p1 p2 - persona
        c1 c2 c3 - caja
        medicina comida - contenido
    )

    (:init
        (esta-dron dron1 deposito)
        (esta-caja c1 deposito)
        (esta-caja c2 deposito)
        (esta-caja c3 deposito)
        (esta-persona p1 l1)
        (esta-persona p2 l2)
        (almacena c1 medicina)
        (almacena c2 comida)
        (almacena c3 medicina)
        (libre brazo1)
        (libre brazo2)
        (caja-libre c1)
        (caja-libre c2)
        (caja-libre c3)
    )
    (:goal (and
        (consigue p1 medicina)
        (consigue p1 comida)
        (consigue p2 medicina))
    )
)
