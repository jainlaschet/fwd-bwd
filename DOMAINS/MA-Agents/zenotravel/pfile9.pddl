(define (problem Kpfile9)
(:domain Kpfile9)
(:init
	(at plane1 city2)
	(fuel-level plane1 fl5)
	(at person1 city4)
	(at person2 city1)
	(at person3 city2)
	(at person4 city0)
	(at person5 city4)
	(at person6 city3)
	(at person7 city3)
	(next fl0 fl1)
	(next fl1 fl2)
	(next fl2 fl3)
	(next fl3 fl4)
	(next fl4 fl5)
	(next fl5 fl6)
	(at plane2 city2)
	(fuel-level plane2 fl2)
	(at plane3 city1)
	(fuel-level plane3 fl0)
)
(:goal 
(and (at person1 city2) (at person2 city0) (at person3 city4) (at person4 city3) (at person5 city1) (at person6 city4) (at person7 city4)))
)

 