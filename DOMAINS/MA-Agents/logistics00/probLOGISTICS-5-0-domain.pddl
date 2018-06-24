(define (domain KprobLOGISTICS-5-0)
(:requirements :strips :typing)
(:types OBJ
location - object
vehicle - object
package - object
city - object
airport - location
truck - vehicle
airplane - vehicle)
(:constants
 obj21 - package
 obj22 - package
 obj23 - package
 apt2 - airport
 apt1 - airport
 obj11 - package
 obj13 - package
 obj12 - package
 pos2 - location
 apn1 - airplane
 tru1 - truck
 cit1 - city
 pos1 - location
 cit2 - city
 tru2 - truck
)

(:predicates
(at ?obj - object ?loc - location)
(in ?obj1 - package ?veh - vehicle)
(in-city ?agent - truck ?loc - location ?city - city)
)

(:action load-airplane
:parameters ( ?airplane - airplane ?obj - package ?loc - airport)
:precondition 
(and (at ?obj ?loc) (at ?airplane ?loc))
:effect 
(and (not (at ?obj ?loc)) (in ?obj ?airplane))
)

(:action unload-airplane
:parameters ( ?airplane - airplane ?obj - package ?loc - airport)
:precondition 
(and (in ?obj ?airplane) (at ?airplane ?loc))
:effect 
(and (not (in ?obj ?airplane)) (at ?obj ?loc))
)

(:action fly-airplane
:parameters ( ?airplane - airplane ?loc-from - airport ?loc-to - airport)
:precondition (at ?airplane ?loc-from)
:effect 
(and (not (at ?airplane ?loc-from)) (at ?airplane ?loc-to))
)

(:action load-truck
:parameters ( ?truck - truck ?obj - package ?loc - location)
:precondition 
(and (at ?truck ?loc) (at ?obj ?loc))
:effect 
(and (not (at ?obj ?loc)) (in ?obj ?truck))
)

(:action unload-truck
:parameters ( ?truck - truck ?obj - package ?loc - location)
:precondition 
(and (at ?truck ?loc) (in ?obj ?truck))
:effect 
(and (not (in ?obj ?truck)) (at ?obj ?loc))
)

(:action drive-truck
:parameters ( ?truck - truck ?loc-from - location ?loc-to - location ?city - city)
:precondition 
(and (at ?truck ?loc-from) (in-city ?truck ?loc-from ?city) (in-city ?truck ?loc-to ?city))
:effect 
(and (not (at ?truck ?loc-from)) (at ?truck ?loc-to))
)

)
