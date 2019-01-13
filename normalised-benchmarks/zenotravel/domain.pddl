(define (domain zeno-travel)
(:predicates
	 (at ?x ?c) (in ?p ?a) (fuel-level ?a ?l) (next ?l1 ?l2)(aircraft ?p) (person ?x) (city ?x) (flevel ?x) )
(:action  board-1
:parameters ( ?p ?a ?c)
:precondition
(and(person ?p)
(aircraft ?a)
(city ?c)
(at ?p ?c)
(at ?a ?c)
(not(in ?p ?a))
)
:effect
(and(in ?p ?a)
(not(at ?p ?c))
(person ?p)
(aircraft ?a)
(city ?c)
(at ?a ?c)
)

)

(:action  board-2
:parameters ( ?p ?a ?c)
:precondition
(and(person ?p)
(aircraft ?a)
(city ?c)
(at ?p ?c)
(at ?a ?c)
(in ?p ?a)
)
:effect
(and(in ?p ?a)
(not(at ?p ?c))
(person ?p)
(aircraft ?a)
(city ?c)
(at ?a ?c)
)

)



(:action  debark-1
:parameters ( ?p ?a ?c)
:precondition
(and(person ?p)
(aircraft ?a)
(city ?c)
(in ?p ?a)
(at ?a ?c)
(not(at ?p ?c))
)
:effect
(and(at ?p ?c)
(not(in ?p ?a))
(person ?p)
(aircraft ?a)
(city ?c)
(at ?a ?c)
)

)

(:action  debark-2
:parameters ( ?p ?a ?c)
:precondition
(and(person ?p)
(aircraft ?a)
(city ?c)
(in ?p ?a)
(at ?a ?c)
(at ?p ?c)
)
:effect
(and(at ?p ?c)
(not(in ?p ?a))
(person ?p)
(aircraft ?a)
(city ?c)
(at ?a ?c)
)

)



(:action  fly-1
:parameters ( ?a ?c1 ?c2 ?l1 ?l2)
:precondition
(and(aircraft ?a)
(city ?c1)
(city ?c2)
(flevel ?l1)
(flevel ?l2)
(at ?a ?c1)
(fuel-level ?a ?l1)
(next ?l2 ?l1)
(not(at ?a ?c2))
(not(fuel-level ?a ?l2))
)
:effect
(and(at ?a ?c2)
(fuel-level ?a ?l2)
(not(at ?a ?c1))
(not(fuel-level ?a ?l1))
(aircraft ?a)
(city ?c1)
(city ?c2)
(flevel ?l1)
(flevel ?l2)
(next ?l2 ?l1)
)

)

(:action  fly-2
:parameters ( ?a ?c1 ?c2 ?l1 ?l2)
:precondition
(and(aircraft ?a)
(city ?c1)
(city ?c2)
(flevel ?l1)
(flevel ?l2)
(at ?a ?c1)
(fuel-level ?a ?l1)
(next ?l2 ?l1)
(at ?a ?c2)
(not(fuel-level ?a ?l2))
)
:effect
(and(at ?a ?c2)
(fuel-level ?a ?l2)
(not(at ?a ?c1))
(not(fuel-level ?a ?l1))
(aircraft ?a)
(city ?c1)
(city ?c2)
(flevel ?l1)
(flevel ?l2)
(next ?l2 ?l1)
)

)

(:action  fly-3
:parameters ( ?a ?c1 ?c2 ?l1 ?l2)
:precondition
(and(aircraft ?a)
(city ?c1)
(city ?c2)
(flevel ?l1)
(flevel ?l2)
(at ?a ?c1)
(fuel-level ?a ?l1)
(next ?l2 ?l1)
(not(at ?a ?c2))
(fuel-level ?a ?l2)
)
:effect
(and(at ?a ?c2)
(fuel-level ?a ?l2)
(not(at ?a ?c1))
(not(fuel-level ?a ?l1))
(aircraft ?a)
(city ?c1)
(city ?c2)
(flevel ?l1)
(flevel ?l2)
(next ?l2 ?l1)
)

)

(:action  fly-4
:parameters ( ?a ?c1 ?c2 ?l1 ?l2)
:precondition
(and(aircraft ?a)
(city ?c1)
(city ?c2)
(flevel ?l1)
(flevel ?l2)
(at ?a ?c1)
(fuel-level ?a ?l1)
(next ?l2 ?l1)
(at ?a ?c2)
(fuel-level ?a ?l2)
)
:effect
(and(at ?a ?c2)
(fuel-level ?a ?l2)
(not(at ?a ?c1))
(not(fuel-level ?a ?l1))
(aircraft ?a)
(city ?c1)
(city ?c2)
(flevel ?l1)
(flevel ?l2)
(next ?l2 ?l1)
)

)



(:action  zoom-1
:parameters ( ?a ?c1 ?c2 ?l1 ?l2 ?l3)
:precondition
(and(aircraft ?a)
(city ?c1)
(city ?c2)
(flevel ?l1)
(flevel ?l2)
(flevel ?l3)
(at ?a ?c1)
(fuel-level ?a ?l1)
(next ?l2 ?l1)
(next ?l3 ?l2)
(not(at ?a ?c2))
(not(fuel-level ?a ?l3))
)
:effect
(and(at ?a ?c2)
(fuel-level ?a ?l3)
(not(at ?a ?c1))
(not(fuel-level ?a ?l1))
(aircraft ?a)
(city ?c1)
(city ?c2)
(flevel ?l1)
(flevel ?l2)
(flevel ?l3)
(next ?l2 ?l1)
(next ?l3 ?l2)
)

)

(:action  zoom-2
:parameters ( ?a ?c1 ?c2 ?l1 ?l2 ?l3)
:precondition
(and(aircraft ?a)
(city ?c1)
(city ?c2)
(flevel ?l1)
(flevel ?l2)
(flevel ?l3)
(at ?a ?c1)
(fuel-level ?a ?l1)
(next ?l2 ?l1)
(next ?l3 ?l2)
(at ?a ?c2)
(not(fuel-level ?a ?l3))
)
:effect
(and(at ?a ?c2)
(fuel-level ?a ?l3)
(not(at ?a ?c1))
(not(fuel-level ?a ?l1))
(aircraft ?a)
(city ?c1)
(city ?c2)
(flevel ?l1)
(flevel ?l2)
(flevel ?l3)
(next ?l2 ?l1)
(next ?l3 ?l2)
)

)

(:action  zoom-3
:parameters ( ?a ?c1 ?c2 ?l1 ?l2 ?l3)
:precondition
(and(aircraft ?a)
(city ?c1)
(city ?c2)
(flevel ?l1)
(flevel ?l2)
(flevel ?l3)
(at ?a ?c1)
(fuel-level ?a ?l1)
(next ?l2 ?l1)
(next ?l3 ?l2)
(not(at ?a ?c2))
(fuel-level ?a ?l3)
)
:effect
(and(at ?a ?c2)
(fuel-level ?a ?l3)
(not(at ?a ?c1))
(not(fuel-level ?a ?l1))
(aircraft ?a)
(city ?c1)
(city ?c2)
(flevel ?l1)
(flevel ?l2)
(flevel ?l3)
(next ?l2 ?l1)
(next ?l3 ?l2)
)

)

(:action  zoom-4
:parameters ( ?a ?c1 ?c2 ?l1 ?l2 ?l3)
:precondition
(and(aircraft ?a)
(city ?c1)
(city ?c2)
(flevel ?l1)
(flevel ?l2)
(flevel ?l3)
(at ?a ?c1)
(fuel-level ?a ?l1)
(next ?l2 ?l1)
(next ?l3 ?l2)
(at ?a ?c2)
(fuel-level ?a ?l3)
)
:effect
(and(at ?a ?c2)
(fuel-level ?a ?l3)
(not(at ?a ?c1))
(not(fuel-level ?a ?l1))
(aircraft ?a)
(city ?c1)
(city ?c2)
(flevel ?l1)
(flevel ?l2)
(flevel ?l3)
(next ?l2 ?l1)
(next ?l3 ?l2)
)

)



(:action  refuel-1
:parameters ( ?a ?c ?l ?l1)
:precondition
(and(aircraft?a)
(city ?c)
(flevel ?l)
(flevel ?l1)
(fuel-level ?a ?l)
(next ?l ?l1)
(at ?a ?c)
(not(fuel-level ?a ?l1))
)
:effect
(and(fuel-level ?a ?l1)
(not(fuel-level ?a ?l))
(aircraft?a)
(city ?c)
(flevel ?l)
(flevel ?l1)
(next ?l ?l1)
(at ?a ?c)
)

)

(:action  refuel-2
:parameters ( ?a ?c ?l ?l1)
:precondition
(and(aircraft?a)
(city ?c)
(flevel ?l)
(flevel ?l1)
(fuel-level ?a ?l)
(next ?l ?l1)
(at ?a ?c)
(fuel-level ?a ?l1)
)
:effect
(and(fuel-level ?a ?l1)
(not(fuel-level ?a ?l))
(aircraft?a)
(city ?c)
(flevel ?l)
(flevel ?l1)
(next ?l ?l1)
(at ?a ?c)
)

)



)
