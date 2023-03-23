(define (problem drone_problem_d2_r2_l10_p10_c10_g10_ct2)
(:domain drone-dom)
(:objects
	drone1 - drone
	drone2 - drone
	warehouse - location
	loc1 - location
	loc2 - location
	loc3 - location
	loc4 - location
	loc5 - location
	loc6 - location
	loc7 - location
	loc8 - location
	loc9 - location
	loc10 - location
	box1 - box
	box2 - box
	box3 - box
	box4 - box
	box5 - box
	box6 - box
	box7 - box
	box8 - box
	box9 - box
	box10 - box
	food - content
	meds - content
	human1 - human
	human2 - human
	human3 - human
	human4 - human
	human5 - human
	human6 - human
	human7 - human
	human8 - human
	human9 - human
	human10 - human
	carrier1 - carrier
	carrier2 - carrier
	n0 n1 n2 n3 n4 - num
)

(:init
	(carrier-at carrier1 warehouse)
	(carrier-n-boxes carrier1 n0)
	(carrier-drone-free carrier1)
	(carrier-at carrier2 warehouse)
	(carrier-n-boxes carrier2 n0)
	(carrier-drone-free carrier2)
	(drone-at drone1 warehouse)
	(drone-free drone1)
	(drone-at drone2 warehouse)
	(drone-free drone2)
	(box-at box1 warehouse)
	(box-free box1)
	(box-at box2 warehouse)
	(box-free box2)
	(box-at box3 warehouse)
	(box-free box3)
	(box-at box4 warehouse)
	(box-free box4)
	(box-at box5 warehouse)
	(box-free box5)
	(box-at box6 warehouse)
	(box-free box6)
	(box-at box7 warehouse)
	(box-free box7)
	(box-at box8 warehouse)
	(box-free box8)
	(box-at box9 warehouse)
	(box-free box9)
	(box-at box10 warehouse)
	(box-free box10)
	(box-has box1 food)
	(box-has box2 food)
	(box-has box3 food)
	(box-has box4 food)
	(box-has box5 food)
	(box-has box6 food)
	(box-has box7 food)
	(box-has box8 food)
	(box-has box9 meds)
	(box-has box10 meds)
	(human-at human1 loc9)
	(human-free human1)
	(human-at human2 loc3)
	(human-free human2)
	(human-at human3 loc3)
	(human-free human3)
	(human-at human4 loc1)
	(human-free human4)
	(human-at human5 loc1)
	(human-free human5)
	(human-at human6 loc4)
	(human-free human6)
	(human-at human7 loc3)
	(human-free human7)
	(human-at human8 loc2)
	(human-free human8)
	(human-at human9 loc8)
	(human-free human9)
	(human-at human10 loc9)
	(human-free human10)
	(next n0 n1)
	(next n1 n2)
	(next n2 n3)
	(next n3 n4)
	(= (fly-cost warehouse warehouse) 0)
	(= (fly-cost warehouse loc1) 8)
	(= (fly-cost warehouse loc2) 23)
	(= (fly-cost warehouse loc3) 15)
	(= (fly-cost warehouse loc4) 4)
	(= (fly-cost warehouse loc5) 39)
	(= (fly-cost warehouse loc6) 4)
	(= (fly-cost warehouse loc7) 42)
	(= (fly-cost warehouse loc8) 25)
	(= (fly-cost warehouse loc9) 9)
	(= (fly-cost warehouse loc10) 45)
	(= (fly-cost loc1 warehouse) 9)
	(= (fly-cost loc1 loc1) 0)
	(= (fly-cost loc1 loc2) 45)
	(= (fly-cost loc1 loc3) 14)
	(= (fly-cost loc1 loc4) 49)
	(= (fly-cost loc1 loc5) 11)
	(= (fly-cost loc1 loc6) 13)
	(= (fly-cost loc1 loc7) 48)
	(= (fly-cost loc1 loc8) 50)
	(= (fly-cost loc1 loc9) 8)
	(= (fly-cost loc1 loc10) 50)
	(= (fly-cost loc2 warehouse) 34)
	(= (fly-cost loc2 loc1) 30)
	(= (fly-cost loc2 loc2) 0)
	(= (fly-cost loc2 loc3) 35)
	(= (fly-cost loc2 loc4) 10)
	(= (fly-cost loc2 loc5) 9)
	(= (fly-cost loc2 loc6) 15)
	(= (fly-cost loc2 loc7) 21)
	(= (fly-cost loc2 loc8) 44)
	(= (fly-cost loc2 loc9) 29)
	(= (fly-cost loc2 loc10) 22)
	(= (fly-cost loc3 warehouse) 26)
	(= (fly-cost loc3 loc1) 15)
	(= (fly-cost loc3 loc2) 37)
	(= (fly-cost loc3 loc3) 0)
	(= (fly-cost loc3 loc4) 19)
	(= (fly-cost loc3 loc5) 32)
	(= (fly-cost loc3 loc6) 27)
	(= (fly-cost loc3 loc7) 24)
	(= (fly-cost loc3 loc8) 18)
	(= (fly-cost loc3 loc9) 43)
	(= (fly-cost loc3 loc10) 18)
	(= (fly-cost loc4 warehouse) 10)
	(= (fly-cost loc4 loc1) 12)
	(= (fly-cost loc4 loc2) 2)
	(= (fly-cost loc4 loc3) 17)
	(= (fly-cost loc4 loc4) 0)
	(= (fly-cost loc4 loc5) 5)
	(= (fly-cost loc4 loc6) 1)
	(= (fly-cost loc4 loc7) 36)
	(= (fly-cost loc4 loc8) 3)
	(= (fly-cost loc4 loc9) 32)
	(= (fly-cost loc4 loc10) 14)
	(= (fly-cost loc5 warehouse) 14)
	(= (fly-cost loc5 loc1) 49)
	(= (fly-cost loc5 loc2) 50)
	(= (fly-cost loc5 loc3) 21)
	(= (fly-cost loc5 loc4) 15)
	(= (fly-cost loc5 loc5) 0)
	(= (fly-cost loc5 loc6) 37)
	(= (fly-cost loc5 loc7) 27)
	(= (fly-cost loc5 loc8) 28)
	(= (fly-cost loc5 loc9) 28)
	(= (fly-cost loc5 loc10) 4)
	(= (fly-cost loc6 warehouse) 7)
	(= (fly-cost loc6 loc1) 40)
	(= (fly-cost loc6 loc2) 25)
	(= (fly-cost loc6 loc3) 41)
	(= (fly-cost loc6 loc4) 35)
	(= (fly-cost loc6 loc5) 41)
	(= (fly-cost loc6 loc6) 0)
	(= (fly-cost loc6 loc7) 4)
	(= (fly-cost loc6 loc8) 21)
	(= (fly-cost loc6 loc9) 12)
	(= (fly-cost loc6 loc10) 34)
	(= (fly-cost loc7 warehouse) 21)
	(= (fly-cost loc7 loc1) 22)
	(= (fly-cost loc7 loc2) 13)
	(= (fly-cost loc7 loc3) 24)
	(= (fly-cost loc7 loc4) 6)
	(= (fly-cost loc7 loc5) 4)
	(= (fly-cost loc7 loc6) 23)
	(= (fly-cost loc7 loc7) 0)
	(= (fly-cost loc7 loc8) 38)
	(= (fly-cost loc7 loc9) 33)
	(= (fly-cost loc7 loc10) 6)
	(= (fly-cost loc8 warehouse) 1)
	(= (fly-cost loc8 loc1) 35)
	(= (fly-cost loc8 loc2) 38)
	(= (fly-cost loc8 loc3) 28)
	(= (fly-cost loc8 loc4) 30)
	(= (fly-cost loc8 loc5) 35)
	(= (fly-cost loc8 loc6) 21)
	(= (fly-cost loc8 loc7) 2)
	(= (fly-cost loc8 loc8) 0)
	(= (fly-cost loc8 loc9) 35)
	(= (fly-cost loc8 loc10) 46)
	(= (fly-cost loc9 warehouse) 40)
	(= (fly-cost loc9 loc1) 15)
	(= (fly-cost loc9 loc2) 43)
	(= (fly-cost loc9 loc3) 26)
	(= (fly-cost loc9 loc4) 5)
	(= (fly-cost loc9 loc5) 13)
	(= (fly-cost loc9 loc6) 30)
	(= (fly-cost loc9 loc7) 41)
	(= (fly-cost loc9 loc8) 26)
	(= (fly-cost loc9 loc9) 0)
	(= (fly-cost loc9 loc10) 49)
	(= (fly-cost loc10 warehouse) 43)
	(= (fly-cost loc10 loc1) 27)
	(= (fly-cost loc10 loc2) 39)
	(= (fly-cost loc10 loc3) 31)
	(= (fly-cost loc10 loc4) 16)
	(= (fly-cost loc10 loc5) 16)
	(= (fly-cost loc10 loc6) 29)
	(= (fly-cost loc10 loc7) 47)
	(= (fly-cost loc10 loc8) 34)
	(= (fly-cost loc10 loc9) 17)
	(= (fly-cost loc10 loc10) 0)
)

(:goal (and
	(drone-at drone1 warehouse)
	(drone-at drone2 warehouse)
	(carrier-at carrier1 warehouse)
	(carrier-at carrier2 warehouse)
	(human-has human1 food)
	(human-has human2 food)
	(human-has human3 food)
	(human-has human4 food)
	(human-has human5 food)
	(human-has human6 food)
	(human-has human6 meds)
	(human-has human8 meds)
	(human-has human9 food)
	(human-has human10 food)
	))
(:metric minimize (total-time)))