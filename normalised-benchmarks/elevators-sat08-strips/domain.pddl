(define (domain elevators-sequencedstrips)
  (:requirements :typing :action-costs)
  (:types 	elevator - object 
			slow-elevator fast-elevator - elevator
   			passenger - object
          	count - object
         )

(:predicates 
	(passenger-at ?person - passenger ?floor - count)
	(boarded ?person - passenger ?lift - elevator)
	(lift-at ?lift - elevator ?floor - count)
	(reachable-floor ?lift - elevator ?floor - count)
	(above ?floor1 - count ?floor2 - count)
	(passengers ?lift - elevator ?n - count)
	(can-hold ?lift - elevator ?n - count)
	(next ?n1 - count ?n2 - count)
)

(:functions (total-cost) - number
            (travel-slow ?f1 - count ?f2 - count) - number
            (travel-fast ?f1 - count ?f2 - count) - number 
)




(:action  move-up-slow-1
:parameters (?lift - slow-elevator ?f1 - count ?f2 - count )
:precondition
(and(lift-at ?lift ?f1)
(above ?f1 ?f2 )
(reachable-floor ?lift ?f2)
(not(lift-at ?lift ?f2))
)
:effect
(and(lift-at ?lift ?f2)
(not(lift-at ?lift ?f1))
(above ?f1 ?f2 )
(reachable-floor ?lift ?f2)
(increase (total-cost) (travel-slow ?f1 ?f2))
)

)

(:action  move-up-slow-2
:parameters (?lift - slow-elevator ?f1 - count ?f2 - count )
:precondition
(and(lift-at ?lift ?f1)
(above ?f1 ?f2 )
(reachable-floor ?lift ?f2)
(lift-at ?lift ?f2)
)
:effect
(and(lift-at ?lift ?f2)
(not(lift-at ?lift ?f1))
(above ?f1 ?f2 )
(reachable-floor ?lift ?f2)
(increase (total-cost) (travel-slow ?f1 ?f2))
)

)





(:action  move-down-slow-1
:parameters (?lift - slow-elevator ?f1 - count ?f2 - count )
:precondition
(and(lift-at ?lift ?f1)
(above ?f2 ?f1 )
(reachable-floor ?lift ?f2)
(not(lift-at ?lift ?f2))
)
:effect
(and(lift-at ?lift ?f2)
(not(lift-at ?lift ?f1))
(above ?f2 ?f1 )
(reachable-floor ?lift ?f2)
(increase (total-cost) (travel-slow ?f2 ?f1))
)

)

(:action  move-down-slow-2
:parameters (?lift - slow-elevator ?f1 - count ?f2 - count )
:precondition
(and(lift-at ?lift ?f1)
(above ?f2 ?f1 )
(reachable-floor ?lift ?f2)
(lift-at ?lift ?f2)
)
:effect
(and(lift-at ?lift ?f2)
(not(lift-at ?lift ?f1))
(above ?f2 ?f1 )
(reachable-floor ?lift ?f2)
(increase (total-cost) (travel-slow ?f2 ?f1))
)

)





(:action  move-up-fast-1
:parameters (?lift - fast-elevator ?f1 - count ?f2 - count )
:precondition
(and(lift-at ?lift ?f1)
(above ?f1 ?f2 )
(reachable-floor ?lift ?f2)
(not(lift-at ?lift ?f2))
)
:effect
(and(lift-at ?lift ?f2)
(not(lift-at ?lift ?f1))
(above ?f1 ?f2 )
(reachable-floor ?lift ?f2)
(increase (total-cost) (travel-fast ?f1 ?f2))
)

)

(:action  move-up-fast-2
:parameters (?lift - fast-elevator ?f1 - count ?f2 - count )
:precondition
(and(lift-at ?lift ?f1)
(above ?f1 ?f2 )
(reachable-floor ?lift ?f2)
(lift-at ?lift ?f2)
)
:effect
(and(lift-at ?lift ?f2)
(not(lift-at ?lift ?f1))
(above ?f1 ?f2 )
(reachable-floor ?lift ?f2)
(increase (total-cost) (travel-fast ?f1 ?f2))
)

)





(:action  move-down-fast-1
:parameters (?lift - fast-elevator ?f1 - count ?f2 - count )
:precondition
(and(lift-at ?lift ?f1)
(above ?f2 ?f1 )
(reachable-floor ?lift ?f2)
(not(lift-at ?lift ?f2))
)
:effect
(and(lift-at ?lift ?f2)
(not(lift-at ?lift ?f1))
(above ?f2 ?f1 )
(reachable-floor ?lift ?f2)
(increase (total-cost) (travel-fast ?f2 ?f1))
)

)

(:action  move-down-fast-2
:parameters (?lift - fast-elevator ?f1 - count ?f2 - count )
:precondition
(and(lift-at ?lift ?f1)
(above ?f2 ?f1 )
(reachable-floor ?lift ?f2)
(lift-at ?lift ?f2)
)
:effect
(and(lift-at ?lift ?f2)
(not(lift-at ?lift ?f1))
(above ?f2 ?f1 )
(reachable-floor ?lift ?f2)
(increase (total-cost) (travel-fast ?f2 ?f1))

)

)





(:action  board-1
:parameters (?p - passenger ?lift - elevator ?f - count ?n1 - count ?n2 - count)
:precondition
(and(lift-at ?lift ?f)
(passenger-at ?p ?f)
(passengers ?lift ?n1)
(next ?n1 ?n2)
(can-hold ?lift ?n2)
(not(boarded ?p ?lift))
(not(passengers ?lift ?n2))
)
:effect
(and(not(passenger-at ?p ?f))
(boarded ?p ?lift)
(not(passengers ?lift ?n1))
(passengers ?lift ?n2)
(lift-at ?lift ?f)
(next ?n1 ?n2)
(can-hold ?lift ?n2)
)

)

(:action  board-2
:parameters (?p - passenger ?lift - elevator ?f - count ?n1 - count ?n2 - count)
:precondition
(and(lift-at ?lift ?f)
(passenger-at ?p ?f)
(passengers ?lift ?n1)
(next ?n1 ?n2)
(can-hold ?lift ?n2)
(boarded ?p ?lift)
(not(passengers ?lift ?n2))
)
:effect
(and(not(passenger-at ?p ?f))
(boarded ?p ?lift)
(not(passengers ?lift ?n1))
(passengers ?lift ?n2)
(lift-at ?lift ?f)
(next ?n1 ?n2)
(can-hold ?lift ?n2)
)

)

(:action  board-3
:parameters (?p - passenger ?lift - elevator ?f - count ?n1 - count ?n2 - count)
:precondition
(and(lift-at ?lift ?f)
(passenger-at ?p ?f)
(passengers ?lift ?n1)
(next ?n1 ?n2)
(can-hold ?lift ?n2)
(not(boarded ?p ?lift))
(passengers ?lift ?n2)
)
:effect
(and(not(passenger-at ?p ?f))
(boarded ?p ?lift)
(not(passengers ?lift ?n1))
(passengers ?lift ?n2)
(lift-at ?lift ?f)
(next ?n1 ?n2)
(can-hold ?lift ?n2)
)

)

(:action  board-4
:parameters (?p - passenger ?lift - elevator ?f - count ?n1 - count ?n2 - count)
:precondition
(and(lift-at ?lift ?f)
(passenger-at ?p ?f)
(passengers ?lift ?n1)
(next ?n1 ?n2)
(can-hold ?lift ?n2)
(boarded ?p ?lift)
(passengers ?lift ?n2)
)
:effect
(and(not(passenger-at ?p ?f))
(boarded ?p ?lift)
(not(passengers ?lift ?n1))
(passengers ?lift ?n2)
(lift-at ?lift ?f)
(next ?n1 ?n2)
(can-hold ?lift ?n2)
)

)





(:action  leave -1
:parameters (?p - passenger ?lift - elevator ?f - count ?n1 - count ?n2 - count)
:precondition
(and(lift-at ?lift ?f)
(boarded ?p ?lift)
(passengers ?lift ?n1)
(next ?n2 ?n1)
(not(passenger-at ?p ?f))
(not(passengers ?lift ?n2))
)
:effect
(and(passenger-at ?p ?f)
(not(boarded ?p ?lift))
(not(passengers ?lift ?n1))
(passengers ?lift ?n2)
(lift-at ?lift ?f)
(next ?n2 ?n1)
)

)

(:action  leave -2
:parameters (?p - passenger ?lift - elevator ?f - count ?n1 - count ?n2 - count)
:precondition
(and(lift-at ?lift ?f)
(boarded ?p ?lift)
(passengers ?lift ?n1)
(next ?n2 ?n1)
(passenger-at ?p ?f)
(not(passengers ?lift ?n2))
)
:effect
(and(passenger-at ?p ?f)
(not(boarded ?p ?lift))
(not(passengers ?lift ?n1))
(passengers ?lift ?n2)
(lift-at ?lift ?f)
(next ?n2 ?n1)
)

)

(:action  leave -3
:parameters (?p - passenger ?lift - elevator ?f - count ?n1 - count ?n2 - count)
:precondition
(and(lift-at ?lift ?f)
(boarded ?p ?lift)
(passengers ?lift ?n1)
(next ?n2 ?n1)
(not(passenger-at ?p ?f))
(passengers ?lift ?n2)
)
:effect
(and(passenger-at ?p ?f)
(not(boarded ?p ?lift))
(not(passengers ?lift ?n1))
(passengers ?lift ?n2)
(lift-at ?lift ?f)
(next ?n2 ?n1)
)

)

(:action  leave -4
:parameters (?p - passenger ?lift - elevator ?f - count ?n1 - count ?n2 - count)
:precondition
(and(lift-at ?lift ?f)
(boarded ?p ?lift)
(passengers ?lift ?n1)
(next ?n2 ?n1)
(passenger-at ?p ?f)
(passengers ?lift ?n2)
)
:effect
(and(passenger-at ?p ?f)
(not(boarded ?p ?lift))
(not(passengers ?lift ?n1))
(passengers ?lift ?n2)
(lift-at ?lift ?f)
(next ?n2 ?n1)
)

)


  
)

