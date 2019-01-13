(define (domain driverlog)
  (:requirements :strips) 
  (:predicates 	(OBJ ?obj)
	       	(TRUCK ?truck)
               	(LOCATION ?loc)
		(driver ?d)
		(at ?obj ?loc)
		(in ?obj1 ?obj)
		(driving ?d ?v)
		(link ?x ?y) (path ?x ?y)
		(empty ?v)
)


(:action  LOAD-TRUCK-1
:parameters
   (?obj
    ?truck
    ?loc)
:precondition
(and(OBJ ?obj)
(TRUCK ?truck)
(LOCATION ?loc)
(at ?truck ?loc)
(at ?obj ?loc)
(not(in ?obj ?truck))
)
:effect
(and(not(at ?obj ?loc))
(in ?obj ?truck)
(OBJ ?obj)
(TRUCK ?truck)
(LOCATION ?loc)
(at ?truck ?loc)
)

)

(:action  LOAD-TRUCK-2
:parameters
   (?obj
    ?truck
    ?loc)
:precondition
(and(OBJ ?obj)
(TRUCK ?truck)
(LOCATION ?loc)
(at ?truck ?loc)
(at ?obj ?loc)
(in ?obj ?truck)
)
:effect
(and(not(at ?obj ?loc))
(in ?obj ?truck)
(OBJ ?obj)
(TRUCK ?truck)
(LOCATION ?loc)
(at ?truck ?loc)
)

)



(:action  UNLOAD-TRUCK-1
:parameters
   (?obj
    ?truck
    ?loc)
:precondition
(and(OBJ ?obj)
(TRUCK ?truck)
(LOCATION ?loc)
(at ?truck ?loc)
(in ?obj ?truck)
(not(at ?obj ?loc))
)
:effect
(and(not(in ?obj ?truck))
(at ?obj ?loc)
(OBJ ?obj)
(TRUCK ?truck)
(LOCATION ?loc)
(at ?truck ?loc)
)

)

(:action  UNLOAD-TRUCK-2
:parameters
   (?obj
    ?truck
    ?loc)
:precondition
(and(OBJ ?obj)
(TRUCK ?truck)
(LOCATION ?loc)
(at ?truck ?loc)
(in ?obj ?truck)
(at ?obj ?loc)
)
:effect
(and(not(in ?obj ?truck))
(at ?obj ?loc)
(OBJ ?obj)
(TRUCK ?truck)
(LOCATION ?loc)
(at ?truck ?loc)
)

)



(:action  BOARD-TRUCK-1
:parameters
   (?driver
    ?truck
    ?loc)
:precondition
(and(DRIVER ?driver)
(TRUCK ?truck)
(LOCATION ?loc)
(at ?truck ?loc)
(at ?driver ?loc)
(empty ?truck)
(not(driving ?driver ?truck))
)
:effect
(and(not(at ?driver ?loc))
(driving ?driver ?truck)
(not(empty ?truck))
(DRIVER ?driver)
(TRUCK ?truck)
(LOCATION ?loc)
(at ?truck ?loc)
)

)

(:action  BOARD-TRUCK-2
:parameters
   (?driver
    ?truck
    ?loc)
:precondition
(and(DRIVER ?driver)
(TRUCK ?truck)
(LOCATION ?loc)
(at ?truck ?loc)
(at ?driver ?loc)
(empty ?truck)
(driving ?driver ?truck)
)
:effect
(and(not(at ?driver ?loc))
(driving ?driver ?truck)
(not(empty ?truck))
(DRIVER ?driver)
(TRUCK ?truck)
(LOCATION ?loc)
(at ?truck ?loc)
)

)



(:action  DISEMBARK-TRUCK-1
:parameters
   (?driver
    ?truck
    ?loc)
:precondition
(and(DRIVER ?driver)
(TRUCK ?truck)
(LOCATION ?loc)
(at ?truck ?loc)
(driving ?driver ?truck)
(not(at ?driver ?loc))
(not(empty ?truck))
)
:effect
(and(not(driving ?driver ?truck))
(at ?driver ?loc)
(empty ?truck)
(DRIVER ?driver)
(TRUCK ?truck)
(LOCATION ?loc)
(at ?truck ?loc)
)

)

(:action  DISEMBARK-TRUCK-2
:parameters
   (?driver
    ?truck
    ?loc)
:precondition
(and(DRIVER ?driver)
(TRUCK ?truck)
(LOCATION ?loc)
(at ?truck ?loc)
(driving ?driver ?truck)
(at ?driver ?loc)
(not(empty ?truck))
)
:effect
(and(not(driving ?driver ?truck))
(at ?driver ?loc)
(empty ?truck)
(DRIVER ?driver)
(TRUCK ?truck)
(LOCATION ?loc)
(at ?truck ?loc)
)

)

(:action  DISEMBARK-TRUCK-3
:parameters
   (?driver
    ?truck
    ?loc)
:precondition
(and(DRIVER ?driver)
(TRUCK ?truck)
(LOCATION ?loc)
(at ?truck ?loc)
(driving ?driver ?truck)
(not(at ?driver ?loc))
(empty ?truck)
)
:effect
(and(not(driving ?driver ?truck))
(at ?driver ?loc)
(empty ?truck)
(DRIVER ?driver)
(TRUCK ?truck)
(LOCATION ?loc)
(at ?truck ?loc)
)

)

(:action  DISEMBARK-TRUCK-4
:parameters
   (?driver
    ?truck
    ?loc)
:precondition
(and(DRIVER ?driver)
(TRUCK ?truck)
(LOCATION ?loc)
(at ?truck ?loc)
(driving ?driver ?truck)
(at ?driver ?loc)
(empty ?truck)
)
:effect
(and(not(driving ?driver ?truck))
(at ?driver ?loc)
(empty ?truck)
(DRIVER ?driver)
(TRUCK ?truck)
(LOCATION ?loc)
(at ?truck ?loc)
)

)



(:action  DRIVE-TRUCK-1
:parameters
   (?truck
    ?loc-from
    ?loc-to
    ?driver)
:precondition
(and(TRUCK ?truck)
(LOCATION ?loc-from)
(LOCATION ?loc-to)
(DRIVER ?driver)
(at ?truck ?loc-from)
(driving ?driver ?truck)
(link ?loc-from ?loc-to)
(not(at ?truck ?loc-to))
)
:effect
(and(not(at ?truck ?loc-from))
(at ?truck ?loc-to)
(TRUCK ?truck)
(LOCATION ?loc-from)
(LOCATION ?loc-to)
(DRIVER ?driver)
(driving ?driver ?truck)
(link ?loc-from ?loc-to)
)

)

(:action  DRIVE-TRUCK-2
:parameters
   (?truck
    ?loc-from
    ?loc-to
    ?driver)
:precondition
(and(TRUCK ?truck)
(LOCATION ?loc-from)
(LOCATION ?loc-to)
(DRIVER ?driver)
(at ?truck ?loc-from)
(driving ?driver ?truck)
(link ?loc-from ?loc-to)
(at ?truck ?loc-to)
)
:effect
(and(not(at ?truck ?loc-from))
(at ?truck ?loc-to)
(TRUCK ?truck)
(LOCATION ?loc-from)
(LOCATION ?loc-to)
(DRIVER ?driver)
(driving ?driver ?truck)
(link ?loc-from ?loc-to)
)

)



(:action  WALK-1
:parameters
   (?driver
    ?loc-from
    ?loc-to)
:precondition
(and(DRIVER ?driver)
(LOCATION ?loc-from)
(LOCATION ?loc-to)
(at ?driver ?loc-from)
(path ?loc-from ?loc-to)
(not(at ?driver ?loc-to))
)
:effect
(and(not(at ?driver ?loc-from))
(at ?driver ?loc-to)
(DRIVER ?driver)
(LOCATION ?loc-from)
(LOCATION ?loc-to)
(path ?loc-from ?loc-to)
)

)

(:action  WALK-2
:parameters
   (?driver
    ?loc-from
    ?loc-to)
:precondition
(and(DRIVER ?driver)
(LOCATION ?loc-from)
(LOCATION ?loc-to)
(at ?driver ?loc-from)
(path ?loc-from ?loc-to)
(at ?driver ?loc-to)
)
:effect
(and(not(at ?driver ?loc-from))
(at ?driver ?loc-to)
(DRIVER ?driver)
(LOCATION ?loc-from)
(LOCATION ?loc-to)
(path ?loc-from ?loc-to)
)

)



 
)
