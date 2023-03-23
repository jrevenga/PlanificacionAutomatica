(define (problem problem3)
    (:domain drone-dom)

    (:objects
        drone1 drone2 - drone
        carrier1 carrier2 - carrier
        box1 box2 box3 box4 box5 box6 - box
        warehouse loc1 loc2 loc3 loc4 - location
        human1 human2 human3 human4 human5 - human
        clothes water food meds - content
        n0 n1 n2 n3 n4 - num
    )

    (:init

        (drone-at drone1 warehouse)
        (drone-at drone2 loc1)
        (box-has box1 water)
        (box-has box2 water)
        (box-has box3 water)
        (box-has box4 food)
        (box-has box5 food)
     
        (drone-free drone1)
        (drone-free drone2)
        (box-free box1)
        (box-free box2)
        (box-free box3)
        (box-free box4)
        (box-free box5)
        (box-at box3 warehouse)
        (box-at box2 warehouse)
        (box-at box1 warehouse)
        (box-at box4 warehouse)
        (box-at box5 warehouse)
        (carrier-at carrier1 warehouse)
        (carrier-at carrier2 warehouse)
     	(carrier-drone-free carrier1)
     	(carrier-drone-free carrier2)
     	(human-at human1 loc1)
        (human-at human2 loc1)
        (human-at human3 loc2)
     	(human-at human4 loc2)
        (human-at human5 loc3)
     	(human-free human1)
        (human-free human2)
        (human-free human3)
        (human-free human4)
        (human-free human5)

        (next n0 n1)
        (next n1 n2)
        (next n2 n3)
        (next n3 n4)

        (= (fly-cost warehouse warehouse) 0)
        (= (fly-cost warehouse loc1) 5)
        (= (fly-cost warehouse loc2) 40)
        (= (fly-cost warehouse loc3) 80)
        (= (fly-cost loc1 warehouse) 5)
        (= (fly-cost loc2 warehouse) 40)
        (= (fly-cost loc3 warehouse) 80)
        (= (fly-cost loc1 loc2) 23)
        (= (fly-cost loc2 loc1) 23)
        (= (fly-cost loc2 loc3) 20)
        (= (fly-cost loc3 loc2) 20)
        (= (fly-cost loc1 loc3) 72)
        (= (fly-cost loc3 loc1) 72)

    )

    (:goal
        (and
            ;todo: put the goal condition here
            (drone-at drone1 warehouse)
            (drone-at drone2 warehouse)
            (carrier-at carrier1 warehouse)
            (carrier-at carrier2 warehouse)

            (human-has human1 water)
            (human-has human2 water)
            (human-has human3 water)
            (human-has human4 food)
            (human-has human5 food)
          	

        )
    )

    (:metric minimize (total-time))

)