(define (problem Kpfile5)
(:domain Kpfile5)
(:init
	(at plane1 city1)
	(fuel-level plane1 fl6)
	(at person1 city3)
	(at person2 city0)
	(at person3 city0)
	(at person4 city1)
	(next fl0 fl1)
	(next fl1 fl2)
	(next fl2 fl3)
	(next fl3 fl4)
	(next fl4 fl5)
	(next fl5 fl6)
	(at plane2 city2)
	(fuel-level plane2 fl0)
)
(:goal 
(and (at person1 city2) (at person2 city3) (at person3 city3) (at person4 city3)))
)

 