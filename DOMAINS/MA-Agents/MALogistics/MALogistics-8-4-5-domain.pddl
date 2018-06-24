(define (domain KMALogistics-8-4-5)
(:requirements :strips :typing)
(:types OBJ truck package city area)
(:constants
 p0 - package
 p1 - package
 p2 - package
 p3 - package
 p4 - package
 c0 - city
 c1 - city
 c2 - city
 a0 - area
 t0 - truck
 c3 - city
 c4 - city
 a1 - area
 t1 - truck
 c5 - city
 a2 - area
 t2 - truck
 c6 - city
 a3 - area
 t3 - truck
 c7 - city
 c8 - city
 a4 - area
 t4 - truck
 c9 - city
 a5 - area
 t5 - truck
 c10 - city
 c11 - city
 a6 - area
 t6 - truck
 c12 - city
 c13 - city
 a7 - area
 t7 - truck
)

(:predicates
(adj ?c1 - city ?c2 - city)
(package-in-city ?p - package ?c - city)
(city-in-area ?c - city ?a - area)
(truck-in-city ?t - truck ?c - city)
(truck-in-area ?t - truck ?a - area)
(package-on-truck ?p - package ?t - truck)
)

(:action drive
:parameters ( ?t - truck ?csource - city ?ctarget - city ?a - area)
:precondition 
(and (adj ?csource ?ctarget) (truck-in-city ?t ?csource) (city-in-area ?csource ?a) (city-in-area ?ctarget ?a) (truck-in-area ?t ?a))
:effect 
(and (not (truck-in-city ?t ?csource)) (truck-in-city ?t ?ctarget))
)

(:action load
:parameters ( ?p - package ?t - truck ?c - city)
:precondition 
(and (truck-in-city ?t ?c) (package-in-city ?p ?c))
:effect 
(and (not (package-in-city ?p ?c)) (package-on-truck ?p ?t))
)

(:action unload
:parameters ( ?p - package ?t - truck ?c - city)
:precondition 
(and (truck-in-city ?t ?c) (package-on-truck ?p ?t))
:effect 
(and (not (package-on-truck ?p ?t)) (package-in-city ?p ?c))
)

)
