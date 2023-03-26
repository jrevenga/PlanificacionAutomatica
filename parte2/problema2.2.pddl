(define (problem problema) (:domain dron)
    (:objects
        dron1 - dron
        deposito l1 l2 l3 - location
        p1 p2 p3 p4 - persona
        c1 c2 c3 c4 c5 - caja
        medicina comida agua vendas - contenido
        n0 n1 n2 n3 n4 - num
        trans1 - transportador
    )

    (:init
        (esta-dron dron1 deposito)
        (esta-trans trans1 deposito)
        (libre-dron dron1)
        (libre-caja c2)
        (libre-caja c3)
        (libre-caja c4)
        (libre-caja c5)
        (esta-caja c1 deposito)
        (esta-caja c2 deposito)
        (esta-caja c3 deposito)
        (esta-caja c4 deposito)
        (esta-caja c5 deposito)
        (esta-persona p1 l1)
        (esta-persona p2 l2)
        (esta-persona p3 l2)
        (esta-persona p4 l3)
        (almacena c1 medicina)
        (almacena c2 comida)
        (almacena c3 medicina)
        (almacena c4 agua)
        (almacena c5 vendas)
        (siguiente n0 n1)
        (siguiente n1 n2)
        (siguiente n2 n3)
        (siguiente n3 n4)
        (trans-carga trans1 n0)
        (= (total-cost) 0)
        (= (fly-cost l1 l2) 2)
        (= (fly-cost l1 l3) 5)
        (= (fly-cost l2 l1) 1)
        (= (fly-cost l2 l3) 4)
        (= (fly-cost l3 l1) 3)
        (= (fly-cost l3 l2) 3)
    )
    (:goal (and
        (consigue p1 medicina)
        (consigue p1 comida)
        (consigue p2 medicina)
        (consigue p3 agua)
        (consigue p4 vendas)
        )
    )

    (:metric minimize (total-cost))
)
