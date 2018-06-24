(define (domain Kpfile19)
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
 s4 - location
 truck5 - truck
 truck4 - truck
 truck1 - truck
 truck3 - truck
 truck2 - truck
 p17-14 - location
 package18 - package
 s6 - location
 p8-9 - location
 p8-5 - location
 p0-3 - location
 p7-17 - location
 p0-9 - location
 p7-12 - location
 p16-13 - location
 p16-12 - location
 package11 - package
 p4-7 - location
 p5-3 - location
 p13-8 - location
 p4-9 - location
 p3-16 - location
 p17-0 - location
 p14-4 - location
 p14-6 - location
 package16 - package
 p14-0 - location
 package8 - package
 package9 - package
 s18 - location
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
 p19-0 - location
 s1 - location
 s0 - location
 s7 - location
 p6-4 - location
 s5 - location
 p19-1 - location
 package12 - package
 package13 - package
 p18-11 - location
 p19-3 - location
 s11 - location
 p7-3 - location
 s19 - location
 p18-2 - location
 p18-5 - location
 s13 - location
 s12 - location
 p15-18 - location
 s10 - location
 s17 - location
 s16 - location
 s15 - location
 s14 - location
 p10-11 - location
 package19 - package
 p10-15 - location
 package14 - package
 package15 - package
 p13-2 - location
 p14-19 - location
 p12-5 - location
 p9-17 - location
 p11-8 - location
 package10 - package
 p9-13 - location
 s2 - location
 p19-17 - location
 p15-4 - location
 p1-10 - location
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
