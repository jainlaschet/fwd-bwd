;; logistics domain
;;

(define (domain logistics)
  (:requirements :strips) 
  (:predicates  (package ?obj)
          (truck ?truck)
    (airplane ?airplane)
                (airport ?airport)
                (location ?loc)
    (in-city ?obj ?city)
                (city ?city)
    (at ?obj ?loc)
    (in ?obj ?obj))

 
(:action  load-truck-1
:parameters
   (?obj
    ?truck
    ?loc)
  :precondition
(and(package ?obj)
(truck ?truck)
(location ?loc)
(at ?truck ?loc)
(at ?obj ?loc)
(not(in ?obj ?truck))
)
:effect
(and(not(at ?obj ?loc))
(in ?obj ?truck)
(package ?obj)
(truck ?truck)
(location ?loc)
(at ?truck ?loc)
)

)

(:action  load-truck-2
:parameters
   (?obj
    ?truck
    ?loc)
  :precondition
(and(package ?obj)
(truck ?truck)
(location ?loc)
(at ?truck ?loc)
(at ?obj ?loc)
(in ?obj ?truck)
)
:effect
(and(not(at ?obj ?loc))
(in ?obj ?truck)
(package ?obj)
(truck ?truck)
(location ?loc)
(at ?truck ?loc)
)

)



(:action  load-airplane-1
:parameters
   (?obj
    ?airplane
    ?loc)
  :precondition
(and(package ?obj)
(airplane ?airplane)
(location ?loc)
(at ?obj ?loc)
(at ?airplane ?loc)
(not(in ?obj ?airplane))
)
:effect
(and(not(at ?obj ?loc))
(in ?obj ?airplane)
(package ?obj)
(airplane ?airplane)
(location ?loc)
(at ?airplane ?loc)
)

)

(:action  load-airplane-2
:parameters
   (?obj
    ?airplane
    ?loc)
  :precondition
(and(package ?obj)
(airplane ?airplane)
(location ?loc)
(at ?obj ?loc)
(at ?airplane ?loc)
(in ?obj ?airplane)
)
:effect
(and(not(at ?obj ?loc))
(in ?obj ?airplane)
(package ?obj)
(airplane ?airplane)
(location ?loc)
(at ?airplane ?loc)
)

)



(:action  unload-truck-1
:parameters
   (?obj
    ?truck
    ?loc)
  :precondition
(and(package ?obj)
(truck ?truck)
(location ?loc)
(at ?truck ?loc)
(in ?obj ?truck)
(not(at ?obj ?loc))
)
:effect
(and(not(in ?obj ?truck))
(at ?obj ?loc)
(package ?obj)
(truck ?truck)
(location ?loc)
(at ?truck ?loc)
)

)

(:action  unload-truck-2
:parameters
   (?obj
    ?truck
    ?loc)
  :precondition
(and(package ?obj)
(truck ?truck)
(location ?loc)
(at ?truck ?loc)
(in ?obj ?truck)
(at ?obj ?loc)
)
:effect
(and(not(in ?obj ?truck))
(at ?obj ?loc)
(package ?obj)
(truck ?truck)
(location ?loc)
(at ?truck ?loc)
)

)



(:action  unload-airplane-1
:parameters
   (?obj
    ?airplane
    ?loc)
  :precondition
(and(package ?obj)
(airplane ?airplane)
(location ?loc)
(in ?obj ?airplane)
(at ?airplane ?loc)
(not(at ?obj ?loc))
)
:effect
(and(not(in ?obj ?airplane))
(at ?obj ?loc)
(package ?obj)
(airplane ?airplane)
(location ?loc)
(at ?airplane ?loc)
)

)

(:action  unload-airplane-2
:parameters
   (?obj
    ?airplane
    ?loc)
  :precondition
(and(package ?obj)
(airplane ?airplane)
(location ?loc)
(in ?obj ?airplane)
(at ?airplane ?loc)
(at ?obj ?loc)
)
:effect
(and(not(in ?obj ?airplane))
(at ?obj ?loc)
(package ?obj)
(airplane ?airplane)
(location ?loc)
(at ?airplane ?loc)
)

)



(:action  drive-truck-1
:parameters
   (?truck
    ?loc-from
    ?loc-to
    ?city)
  :precondition
(and(truck ?truck)
(location ?loc-from)
(location ?loc-to)
(city ?city)
(at ?truck ?loc-from)
(in-city ?loc-from ?city)
(in-city ?loc-to ?city)
(not(at ?truck ?loc-to))
)
:effect
(and(not(at ?truck ?loc-from))
(at ?truck ?loc-to)
(truck ?truck)
(location ?loc-from)
(location ?loc-to)
(city ?city)
(in-city ?loc-from ?city)
(in-city ?loc-to ?city)
)

)

(:action  drive-truck-2
:parameters
   (?truck
    ?loc-from
    ?loc-to
    ?city)
  :precondition
(and(truck ?truck)
(location ?loc-from)
(location ?loc-to)
(city ?city)
(at ?truck ?loc-from)
(in-city ?loc-from ?city)
(in-city ?loc-to ?city)
(at ?truck ?loc-to)
)
:effect
(and(not(at ?truck ?loc-from))
(at ?truck ?loc-to)
(truck ?truck)
(location ?loc-from)
(location ?loc-to)
(city ?city)
(in-city ?loc-from ?city)
(in-city ?loc-to ?city)
)

)



(:action  fly-airplane-1
:parameters
   (?airplane
    ?loc-from
    ?loc-to)
  :precondition
(and(airplane ?airplane)
(airport ?loc-from)
(airport ?loc-to)
(at ?airplane ?loc-from)
(not(at ?airplane ?loc-to))
)
:effect
(and(not(at ?airplane ?loc-from))
(at ?airplane ?loc-to)
(airplane ?airplane)
(airport ?loc-from)
(airport ?loc-to)
)

)

(:action  fly-airplane-2
:parameters
   (?airplane
    ?loc-from
    ?loc-to)
  :precondition
(and(airplane ?airplane)
(airport ?loc-from)
(airport ?loc-to)
(at ?airplane ?loc-from)
(at ?airplane ?loc-to)
)
:effect
(and(not(at ?airplane ?loc-from))
(at ?airplane ?loc-to)
(airplane ?airplane)
(airport ?loc-from)
(airport ?loc-to)
)

)


)
