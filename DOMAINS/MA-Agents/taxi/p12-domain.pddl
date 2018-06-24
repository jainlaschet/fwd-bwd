(define (domain Kp12)
(:requirements :strips :typing)
(:types OBJ
location - object
agent - object
taxi - agent
passenger - agent)
(:constants
 t1 - taxi
 t2 - taxi
 p1 - passenger
 p2 - passenger
 p3 - passenger
 p4 - passenger
 p5 - passenger
 g1 - location
 g2 - location
 g3 - location
 c - location
 d - location
 h1 - location
 h2 - location
 h3 - location
)

(:predicates
(directly-connected ?l1 - location ?l2 - location)
(at ?a - agent ?l - location)
(in ?p - passenger ?t - taxi)
(empty ?t - taxi)
(free ?l - location)
(goal-of ?p - passenger ?l - location)
)

(:action enter_p1
:parameters ( ?t - taxi ?l - location)
:precondition 
(and (at p1 ?l) (at ?t ?l) (empty ?t))
:effect 
(and (not (empty ?t)) (not (at p1 ?l)) (in p1 ?t))
)

(:action exit_p1
:parameters ( ?t - taxi ?l - location)
:precondition 
(and (in p1 ?t) (at ?t ?l) (goal-of p1 ?l))
:effect 
(and (not (in p1 ?t)) (empty ?t) (at p1 ?l))
)

(:action enter_p2
:parameters ( ?t - taxi ?l - location)
:precondition 
(and (at p2 ?l) (at ?t ?l) (empty ?t))
:effect 
(and (not (empty ?t)) (not (at p2 ?l)) (in p2 ?t))
)

(:action exit_p2
:parameters ( ?t - taxi ?l - location)
:precondition 
(and (in p2 ?t) (at ?t ?l) (goal-of p2 ?l))
:effect 
(and (not (in p2 ?t)) (empty ?t) (at p2 ?l))
)

(:action enter_p3
:parameters ( ?t - taxi ?l - location)
:precondition 
(and (at p3 ?l) (at ?t ?l) (empty ?t))
:effect 
(and (not (empty ?t)) (not (at p3 ?l)) (in p3 ?t))
)

(:action exit_p3
:parameters ( ?t - taxi ?l - location)
:precondition 
(and (in p3 ?t) (at ?t ?l) (goal-of p3 ?l))
:effect 
(and (not (in p3 ?t)) (empty ?t) (at p3 ?l))
)

(:action enter_p4
:parameters ( ?t - taxi ?l - location)
:precondition 
(and (at p4 ?l) (at ?t ?l) (empty ?t))
:effect 
(and (not (empty ?t)) (not (at p4 ?l)) (in p4 ?t))
)

(:action exit_p4
:parameters ( ?t - taxi ?l - location)
:precondition 
(and (in p4 ?t) (at ?t ?l) (goal-of p4 ?l))
:effect 
(and (not (in p4 ?t)) (empty ?t) (at p4 ?l))
)

(:action enter_p5
:parameters ( ?t - taxi ?l - location)
:precondition 
(and (at p5 ?l) (at ?t ?l) (empty ?t))
:effect 
(and (not (empty ?t)) (not (at p5 ?l)) (in p5 ?t))
)

(:action exit_p5
:parameters ( ?t - taxi ?l - location)
:precondition 
(and (in p5 ?t) (at ?t ?l) (goal-of p5 ?l))
:effect 
(and (not (in p5 ?t)) (empty ?t) (at p5 ?l))
)

(:action drive_t1
:parameters ( ?from - location ?to - location)
:precondition 
(and (at t1 ?from) (directly-connected ?from ?to) (free ?to))
:effect 
(and (not (at t1 ?from)) (not (free ?to)) (at t1 ?to) (free ?from))
)

(:action drive_t2
:parameters ( ?from - location ?to - location)
:precondition 
(and (at t2 ?from) (directly-connected ?from ?to) (free ?to))
:effect 
(and (not (at t2 ?from)) (not (free ?to)) (at t2 ?to) (free ?from))
)

)
