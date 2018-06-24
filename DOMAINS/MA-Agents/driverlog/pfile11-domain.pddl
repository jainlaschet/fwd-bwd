(define (domain Kpfile11)
(:requirements :strips :typing)
(:types OBJ
location - object
locatable - object
driver - locatable
truck - locatable
package - locatable)
(:constants
 p0-3 - location
 p2-6 - location
 p2-3 - location
 package1 - package
 package2 - package
 package3 - package
 package4 - package
 package5 - package
 package6 - package
 p1-5 - location
 truck1 - truck
 truck3 - truck
 truck2 - truck
 s3 - location
 s2 - location
 s1 - location
 s0 - location
 s6 - location
 s5 - location
 s4 - location
 p5-0 - location
 p1-0 - location
 p4-1 - location
 p4-0 - location
 p3-4 - location
 p6-3 - location
 p4-2 - location
 driver1 - driver
 driver2 - driver
)

(:predicates
(in ?obj1 - package ?obj - truck)
(path ?x - location ?y - location)
(empty ?v - truck)
(at ?obj - locatable ?loc - location)
(link ?x - location ?y - location)
(driving ?agent - driver ?v - truck)
)

(:action load-truck
:parameters ( ?driver - driver ?truck - truck ?obj - package ?loc - location)
:precondition 
(and (at ?truck ?loc) (at ?obj ?loc) (driving ?driver ?truck))
:effect 
(and (not (at ?obj ?loc)) (in ?obj ?truck))
)

(:action unload-truck
:parameters ( ?driver - driver ?truck - truck ?obj - package ?loc - location)
:precondition 
(and (at ?truck ?loc) (in ?obj ?truck) (driving ?driver ?truck))
:effect 
(and (not (in ?obj ?truck)) (at ?obj ?loc))
)

(:action board-truck
:parameters ( ?driver - driver ?truck - truck ?loc - location)
:precondition 
(and (at ?truck ?loc) (at ?driver ?loc) (empty ?truck))
:effect 
(and (not (at ?driver ?loc)) (driving ?driver ?truck) (not (empty ?truck)))
)

(:action disembark-truck
:parameters ( ?driver - driver ?truck - truck ?loc - location)
:precondition 
(and (at ?truck ?loc) (driving ?driver ?truck))
:effect 
(and (not (driving ?driver ?truck)) (at ?driver ?loc) (empty ?truck))
)

(:action drive-truck
:parameters ( ?driver - driver ?loc-from - location ?loc-to - location ?truck - truck)
:precondition 
(and (at ?truck ?loc-from) (driving ?driver ?truck) (link ?loc-from ?loc-to))
:effect 
(and (not (at ?truck ?loc-from)) (at ?truck ?loc-to))
)

(:action walk
:parameters ( ?driver - driver ?loc-from - location ?loc-to - location)
:precondition 
(and (at ?driver ?loc-from) (path ?loc-from ?loc-to))
:effect 
(and (not (at ?driver ?loc-from)) (at ?driver ?loc-to))
)

)
