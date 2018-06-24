(define (domain Kpfile11)
(:requirements :strips :typing)
(:types OBJ
place - object
locatable - object
driver - object
depot - place
distributor - place
truck - locatable
hoist - locatable
surface - locatable
pallet - surface
crate - surface)
(:constants
 distributor1 - distributor
 distributor0 - distributor
 distributor2 - distributor
 depot0 - depot
 depot1 - depot
 depot2 - depot
 pallet5 - pallet
 pallet4 - pallet
 pallet1 - pallet
 pallet0 - pallet
 pallet3 - pallet
 pallet2 - pallet
 truck1 - truck
 truck0 - truck
 crate9 - crate
 crate8 - crate
 crate5 - crate
 crate4 - crate
 crate7 - crate
 crate6 - crate
 crate1 - crate
 crate0 - crate
 crate3 - crate
 crate2 - crate
 hoist0 - hoist
 hoist1 - hoist
 hoist2 - hoist
 hoist3 - hoist
 hoist4 - hoist
 hoist5 - hoist
 driver0 - driver
 driver1 - driver
)

(:predicates
(at ?x - locatable ?y - place)
(on ?x - crate ?y - surface)
(in ?x - crate ?y - truck)
(clear ?x - surface)
(lifting ?agent - place ?x - hoist ?y - crate)
(available ?agent - place ?x - hoist)
(driving ?agent - driver ?t - truck)
)

(:action lift
:parameters ( ?p - place ?x - hoist ?y - crate ?z - surface)
:precondition 
(and (at ?x ?p) (available ?p ?x) (at ?y ?p) (on ?y ?z) (clear ?y))
:effect 
(and (lifting ?p ?x ?y) (clear ?z) (not (at ?y ?p)) (not (clear ?y)) (not (available ?p ?x)) (not (on ?y ?z)))
)

(:action drop
:parameters ( ?p - place ?x - hoist ?y - crate ?z - surface)
:precondition 
(and (at ?x ?p) (at ?z ?p) (clear ?z) (lifting ?p ?x ?y))
:effect 
(and (available ?p ?x) (at ?y ?p) (clear ?y) (on ?y ?z) (not (lifting ?p ?x ?y)) (not (clear ?z)))
)

(:action load
:parameters ( ?p - place ?x - hoist ?y - crate ?z - truck)
:precondition 
(and (at ?x ?p) (at ?z ?p) (lifting ?p ?x ?y))
:effect 
(and (in ?y ?z) (available ?p ?x) (not (lifting ?p ?x ?y)))
)

(:action unload
:parameters ( ?p - place ?x - hoist ?y - crate ?z - truck)
:precondition 
(and (at ?x ?p) (at ?z ?p) (available ?p ?x) (in ?y ?z))
:effect 
(and (lifting ?p ?x ?y) (not (in ?y ?z)) (not (available ?p ?x)))
)

(:action drive
:parameters ( ?a - driver ?x - truck ?y - place ?z - place)
:precondition 
(and (at ?x ?y) (driving ?a ?x))
:effect 
(and (at ?x ?z) (not (at ?x ?y)))
)

)
