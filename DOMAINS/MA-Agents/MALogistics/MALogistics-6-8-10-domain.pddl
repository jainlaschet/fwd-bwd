(define (domain KMALogistics-6-8-10)
(:requirements :strips :typing)
(:types OBJ truck package city area)
(:constants
 p0 - package
 p1 - package
 p2 - package
 p3 - package
 p4 - package
 p5 - package
 p6 - package
 p7 - package
 p8 - package
 p9 - package
 c0 - city
 c1 - city
 c2 - city
 c3 - city
 a0 - area
 t0 - truck
 c4 - city
 c5 - city
 c6 - city
 a1 - area
 t1 - truck
 a2 - area
 t2 - truck
 c7 - city
 a3 - area
 t3 - truck
 c8 - city
 c9 - city
 c10 - city
 c11 - city
 c12 - city
 a4 - area
 t4 - truck
 c13 - city
 a5 - area
 t5 - truck
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
