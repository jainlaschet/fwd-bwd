(define (domain Kpfile16)
(:requirements :strips :typing)
(:types OBJ
location - object
locatable - object
driver - locatable
truck - locatable
package - locatable)
(:constants
 p13-14 - location
 p3-10 - location
 p3-11 - location
 p14-9 - location
 p14-8 - location
 p10-0 - location
 p14-0 - location
 package8 - package
 package9 - package
 p5-14 - location
 package1 - package
 package2 - package
 package3 - package
 package4 - package
 package5 - package
 package6 - package
 package7 - package
 truck5 - truck
 truck4 - truck
 s9 - location
 s8 - location
 truck1 - truck
 truck3 - truck
 truck2 - truck
 s3 - location
 s2 - location
 s1 - location
 s0 - location
 s7 - location
 s6 - location
 s5 - location
 p7-13 - location
 p9-6 - location
 p9-4 - location
 p12-14 - location
 p7-9 - location
 p9-0 - location
 s11 - location
 p9-8 - location
 s13 - location
 s12 - location
 package10 - package
 s10 - location
 s14 - location
 p0-1 - location
 p2-6 - location
 s4 - location
 p2-3 - location
 p0-4 - location
 p1-5 - location
 p1-2 - location
 p8-12 - location
 p13-9 - location
 p13-1 - location
 p12-4 - location
 p4-6 - location
 p3-7 - location
 driver1 - driver
 driver2 - driver
 driver3 - driver
 driver4 - driver
 driver5 - driver
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
