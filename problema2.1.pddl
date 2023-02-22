(define (problem problema2) (:domain dron)
    (:objects
        dron1 - dron
        brazo1 brazo2 - brazo
        contenedor1 - contenedor
        deposito l1 l2 l3 l4 - location
        p1 p2 p3 p4 p5 - persona
        c1 c2 c3 c4 c5 c6 - caja
        medicina comida agua vendas - contenido
        n0 n1 n2 n3 n4 n5 n6 - num
    )

    (:init
        (esta-dron dron1 deposito)
        (libre-dron dron1)
        (esta-caja c1 deposito)
        (esta-caja c2 deposito)
        (esta-caja c3 deposito)
        (esta-caja c4 deposito)
        (esta-caja c5 deposito)
        (esta-caja c6 deposito)
        (esta-persona p1 l1)
        (esta-persona p2 l2)
        (esta-persona p3 l3)
        (esta-persona p4 l4)
        (esta-persona p5 l1)
        (almacena c1 medicina)
        (almacena c2 comida)
        (almacena c3 medicina)
        (almacena c4 agua)
        (almacena c5 vendas)
        (almacena c6 agua)
        (caja-libre c1)
        (caja-libre c2)
        (caja-libre c3)
        (caja-libre c4)
        (caja-libre c5)
        (caja-libre c6)
        (siguiente n0 n1)
        (siguiente n1 n2)
        (siguiente n2 n3)
        (siguiente n3 n4)
        (siguiente n4 n5)
        (siguiente n5 n6)
        (contenedor-n-cajas contenedor1 n0)
    )
    (:goal (and
        (consigue p1 medicina)
        (consigue p1 comida)
        (consigue p2 medicina)
        (consigue p3 agua)
        (consigue p4 vendas)
        (consigue p5 agua)
        )
    )
)
