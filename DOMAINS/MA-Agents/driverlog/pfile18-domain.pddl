(define (domain Kpfile18)
(:requirements :strips :typing)
(:types OBJ
location - object
locatable - object
driver - locatable
truck - locatable
package - locatable)
(:constants
 p13-12 - location
 package20 - package
 p5-15 - location
 p5-16 - location
 truck5 - truck
 truck4 - truck
 truck1 - truck
 truck3 - truck
 truck2 - truck
 p11-3 - location
 p17-10 - location
 p6-10 - location
 p6-15 - location
 p6-19 - location
 p2-4 - location
 p0-5 - location
 p1-9 - location
 p1-7 - location
 p0-9 - location
 s11 - location
 p12-8 - location
 package11 - package
 p5-2 - location
 p5-3 - location
 p18-4 - location
 p3-13 - location
 p16-6 - location
 p3-18 - location
 s19 - location
 package8 - package
 package9 - package
 package19 - package
 package1 - package
 package2 - package
 package3 - package
 package4 - package
 package5 - package
 package6 - package
 package7 - package
 s9 - location
 s8 - location
 s17 - location
 s3 - location
 s2 - location
 s1 - location
 s0 - location
 s7 - location
 s6 - location
 s5 - location
 s4 - location
 s13 - location
 s12 - location
 p7-4 - location
 p7-5 - location
 p7-0 - location
 p18-14 - location
 p18-17 - location
 package18 - package
 s18 - location
 p2-10 - location
 p2-12 - location
 package12 - package
 package13 - package
 package10 - package
 s10 - location
 package16 - package
 s16 - location
 s15 - location
 package17 - package
 p10-11 - location
 package14 - package
 package15 - package
 p13-5 - location
 p18-8 - location
 p11-8 - location
 p19-18 - location
 p6-0 - location
 s14 - location
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
