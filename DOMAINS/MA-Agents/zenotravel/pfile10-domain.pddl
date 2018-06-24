(define (domain Kpfile10)
(:requirements :strips :typing)
(:types OBJ
locatable - object
city - object
flevel - object
aircraft - locatable
person - locatable)
(:constants
 person2 - person
 person3 - person
 person1 - person
 person6 - person
 person7 - person
 person4 - person
 person5 - person
 city2 - city
 city3 - city
 city0 - city
 city1 - city
 person8 - person
 city4 - city
 fl1 - flevel
 fl0 - flevel
 fl3 - flevel
 fl2 - flevel
 fl5 - flevel
 fl4 - flevel
 fl6 - flevel
 plane1 - aircraft
 plane2 - aircraft
 plane3 - aircraft
)

(:predicates
(at ?x - locatable ?c - city)
(next ?l1 - flevel ?l2 - flevel)
(fuel-level ?agent - aircraft ?l - flevel)
(in ?p - person ?agent - aircraft)
)

(:action board
:parameters ( ?a - aircraft ?p - person ?c - city)
:precondition 
(and (at ?p ?c) (at ?a ?c))
:effect 
(and (in ?p ?a) (not (at ?p ?c)))
)

(:action debark
:parameters ( ?a - aircraft ?p - person ?c - city)
:precondition 
(and (in ?p ?a) (at ?a ?c))
:effect 
(and (at ?p ?c) (not (in ?p ?a)))
)

(:action fly
:parameters ( ?a - aircraft ?c1 - city ?c2 - city ?l1 - flevel ?l2 - flevel)
:precondition 
(and (at ?a ?c1) (fuel-level ?a ?l1) (next ?l2 ?l1))
:effect 
(and (at ?a ?c2) (fuel-level ?a ?l2) (not (at ?a ?c1)) (not (fuel-level ?a ?l1)))
)

(:action zoom
:parameters ( ?a - aircraft ?c1 - city ?c2 - city ?l1 - flevel ?l2 - flevel ?l3 - flevel)
:precondition 
(and (at ?a ?c1) (fuel-level ?a ?l1) (next ?l2 ?l1) (next ?l3 ?l2))
:effect 
(and (at ?a ?c2) (fuel-level ?a ?l3) (not (at ?a ?c1)) (not (fuel-level ?a ?l1)))
)

(:action refuel
:parameters ( ?a - aircraft ?c - city ?l - flevel ?l1 - flevel)
:precondition 
(and (fuel-level ?a ?l) (next ?l ?l1) (at ?a ?c))
:effect 
(and (fuel-level ?a ?l1) (not (fuel-level ?a ?l)))
)

)
