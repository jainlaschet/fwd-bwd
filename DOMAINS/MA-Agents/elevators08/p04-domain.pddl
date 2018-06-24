(define (domain Kp04)
(:requirements :strips :typing)
(:types OBJ
elevator - object
passenger - object
count - object
slow-elevator - elevator
fast-elevator - elevator)
(:constants
 p2 - passenger
 p3 - passenger
 p0 - passenger
 p1 - passenger
 p6 - passenger
 p4 - passenger
 p5 - passenger
 n8 - count
 n0 - count
 n1 - count
 n2 - count
 n3 - count
 n4 - count
 n5 - count
 n6 - count
 n7 - count
 fast0 - fast-elevator
 fast1 - fast-elevator
 slow0-0 - slow-elevator
 slow1-0 - slow-elevator
)

(:predicates
(next ?n1 - count ?n2 - count)
(passenger-at ?person - passenger ?floor - count)
(above ?floor1 - count ?floor2 - count)
(can-hold ?agent - elevator ?n - count)
(reachable-floor ?agent - elevator ?floor - count)
(lift-at ?lift - elevator ?floor - count)
(boarded ?person - passenger ?lift - elevator)
(passengers ?lift - elevator ?n - count)
)

(:action move-up-fast
:parameters ( ?lift - fast-elevator ?f1 - count ?f2 - count)
:precondition 
(and (lift-at ?lift ?f1) (above ?f1 ?f2) (reachable-floor ?lift ?f2))
:effect 
(and (lift-at ?lift ?f2) (not (lift-at ?lift ?f1)) (increase total-cost travel-fast))
)

(:action move-down-fast
:parameters ( ?lift - fast-elevator ?f1 - count ?f2 - count)
:precondition 
(and (lift-at ?lift ?f1) (above ?f2 ?f1) (reachable-floor ?lift ?f2))
:effect 
(and (lift-at ?lift ?f2) (not (lift-at ?lift ?f1)) (increase total-cost travel-fast))
)

(:action board
:parameters ( ?lift - elevator ?p - passenger ?f - count ?n1 - count ?n2 - count)
:precondition 
(and (lift-at ?lift ?f) (passenger-at ?p ?f) (passengers ?lift ?n1) (next ?n1 ?n2) (can-hold ?lift ?n2))
:effect 
(and (not (passenger-at ?p ?f)) (boarded ?p ?lift) (not (passengers ?lift ?n1)) (passengers ?lift ?n2))
)

(:action leave
:parameters ( ?lift - elevator ?p - passenger ?f - count ?n1 - count ?n2 - count)
:precondition 
(and (lift-at ?lift ?f) (boarded ?p ?lift) (passengers ?lift ?n1) (next ?n2 ?n1))
:effect 
(and (passenger-at ?p ?f) (not (boarded ?p ?lift)) (not (passengers ?lift ?n1)) (passengers ?lift ?n2))
)

(:action move-up-slow
:parameters ( ?lift - slow-elevator ?f1 - count ?f2 - count)
:precondition 
(and (lift-at ?lift ?f1) (above ?f1 ?f2) (reachable-floor ?lift ?f2))
:effect 
(and (lift-at ?lift ?f2) (not (lift-at ?lift ?f1)) (increase total-cost travel-slow))
)

(:action move-down-slow
:parameters ( ?lift - slow-elevator ?f1 - count ?f2 - count)
:precondition 
(and (lift-at ?lift ?f1) (above ?f2 ?f1) (reachable-floor ?lift ?f2))
:effect 
(and (lift-at ?lift ?f2) (not (lift-at ?lift ?f1)) (increase total-cost travel-slow))
)

)
