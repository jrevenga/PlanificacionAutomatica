(define (problem drone_problem_d1_r2_l3_p3_c3_g3_ct2)
(:domain dron)
(:objects
	dron1 - dron
	deposito - location
	l1 - location
	l2 - location
	l3 - location
	c1 - caja
	c2 - caja
	c3 - caja
	food - contenido
	medicine - contenido
	p1 - persona
	p2 - persona
	p3 - persona
	brazo1 - brazo
	brazo2 - brazo
)
(:init
	(esta-dron dron1 deposito)
	(esta-caja c1 deposito)
	(caja-libre c1)
	(almacena c1 medicine)
	(esta-caja c2 deposito)
	(caja-libre c2)
	(almacena c2 food)
	(esta-caja c3 deposito)
	(caja-libre c3)
	(almacena c3 medicine)
	(esta-persona p1 l2)
	(esta-persona p2 l3)
	(esta-persona p3 l2)
	(libre brazo1)
	(libre brazo1)
	(libre brazo2)
	(libre brazo2)
)
(:goal (and

	(esta-dron dron1 deposito)
	(consigue p1 medicine)
	(consigue p2 food)
	(consigue p3 medicine)
	))
)
