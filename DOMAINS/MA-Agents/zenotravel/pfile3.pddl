(define (problem Kpfile3)
(:domain Kpfile3)
(:init
	(at plane1 city0)
	(fuel-level plane1 fl4)
	(at person1 city0)
	(at person2 city0)
	(at person3 city1)
	(at person4 city1)
	(next fl0 fl1)
	(next fl1 fl2)
	(next fl2 fl3)
	(next fl3 fl4)
	(next fl4 fl5)
	(next fl5 fl6)
	(at plane2 city2)
	(fuel-level plane2 fl5)
)
(:goal 
(and (at person1 city1) (at person2 city0) (at person3 city0) (at person4 city1)))
)

 