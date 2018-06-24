(define (domain Kpfile20)
(:requirements :strips :typing)
(:types OBJ
location - object
locatable - object
driver - locatable
truck - locatable
package - locatable)
(:constants
 package25 - package
 package24 - package
 package23 - package
 package22 - package
 package21 - package
 package20 - package
 package12 - package
 p5-17 - location
 truck5 - truck
 truck4 - truck
 truck6 - truck
 truck1 - truck
 truck3 - truck
 truck2 - truck
 p6-11 - location
 p13-18 - location
 p8-0 - location
 p8-4 - location
 p0-2 - location
 p7-18 - location
 p7-19 - location
 p7-15 - location
 p2-9 - location
 p7-10 - location
 package18 - package
 p16-12 - location
 package11 - package
 p4-7 - location
 p4-3 - location
 p5-8 - location
 p4-9 - location
 p3-12 - location
 p3-11 - location
 p15-13 - location
 package16 - package
 p14-0 - location
 package8 - package
 package9 - package
 package19 - package
 p14-13 - location
 package17 - package
 package1 - package
 package2 - package
 package3 - package
 package4 - package
 package5 - package
 package6 - package
 package7 - package
 s9 - location
 s8 - location
 s3 - location
 s2 - location
 s1 - location
 s0 - location
 s7 - location
 s6 - location
 s5 - location
 s4 - location
 p0-16 - location
 package13 - package
 p7-6 - location
 package10 - package
 p2-15 - location
 p2-14 - location
 s19 - location
 s18 - location
 p18-6 - location
 s13 - location
 s12 - location
 s11 - location
 s10 - location
 s17 - location
 s16 - location
 s15 - location
 s14 - location
 p10-13 - location
 package14 - package
 package15 - package
 p1-14 - location
 p1-15 - location
 p4-11 - location
 p4-16 - location
 p13-5 - location
 p14-15 - location
 p13-8 - location
 p13-9 - location
 p12-1 - location
 p19-18 - location
 p15-5 - location
 p19-11 - location
 driver1 - driver
 driver2 - driver
 driver3 - driver
 driver4 - driver
 driver5 - driver
 driver6 - driver
 driver7 - driver
 driver8 - driver
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
