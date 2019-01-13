;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 4 Op-blocks world
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (domain BLOCKS)
  (:requirements :strips)
  (:predicates (on ?x ?y)
	       (ontable ?x)
	       (clear ?x)
	       (handempty)
	       (holding ?x)
	       )

  (:action  pick-up-1
:parameters (?x)
:precondition
(and(clear ?x)
(ontable ?x)
(handempty)
(not(holding ?x))
)
:effect
(and(not(ontable ?x))
(not(clear ?x))
(not(handempty))
(holding ?x)
)

)

(:action  pick-up-2
:parameters (?x)
:precondition
(and(clear ?x)
(ontable ?x)
(handempty)
(holding ?x)
)
:effect
(and(not(ontable ?x))
(not(clear ?x))
(not(handempty))
(holding ?x)
)

)



  (:action  put-down-1
:parameters (?x)
:precondition
(and(holding ?x)
(not(clear ?x))
(not(handempty))
(not(ontable ?x))
)
:effect
(and(not(holding ?x))
(clear ?x)
(handempty)
(ontable ?x)
)

)

(:action  put-down-2
:parameters (?x)
:precondition
(and(holding ?x)
(clear ?x)
(not(handempty))
(not(ontable ?x))
)
:effect
(and(not(holding ?x))
(clear ?x)
(handempty)
(ontable ?x)
)

)

(:action  put-down-3
:parameters (?x)
:precondition
(and(holding ?x)
(not(clear ?x))
(handempty)
(not(ontable ?x))
)
:effect
(and(not(holding ?x))
(clear ?x)
(handempty)
(ontable ?x)
)

)

(:action  put-down-4
:parameters (?x)
:precondition
(and(holding ?x)
(clear ?x)
(handempty)
(not(ontable ?x))
)
:effect
(and(not(holding ?x))
(clear ?x)
(handempty)
(ontable ?x)
)

)

(:action  put-down-5
:parameters (?x)
:precondition
(and(holding ?x)
(not(clear ?x))
(not(handempty))
(ontable ?x)
)
:effect
(and(not(holding ?x))
(clear ?x)
(handempty)
(ontable ?x)
)

)

(:action  put-down-6
:parameters (?x)
:precondition
(and(holding ?x)
(clear ?x)
(not(handempty))
(ontable ?x)
)
:effect
(and(not(holding ?x))
(clear ?x)
(handempty)
(ontable ?x)
)

)

(:action  put-down-7
:parameters (?x)
:precondition
(and(holding ?x)
(not(clear ?x))
(handempty)
(ontable ?x)
)
:effect
(and(not(holding ?x))
(clear ?x)
(handempty)
(ontable ?x)
)

)

(:action  put-down-8
:parameters (?x)
:precondition
(and(holding ?x)
(clear ?x)
(handempty)
(ontable ?x)
)
:effect
(and(not(holding ?x))
(clear ?x)
(handempty)
(ontable ?x)
)

)


  (:action  stack-1
:parameters (?x ?y)
:precondition
(and(holding ?x)
(clear ?y)
(not(clear ?x))
(not(handempty))
(not(on ?x ?y))
)
:effect
(and(not(holding ?x))
(not(clear ?y))
(clear ?x)
(handempty)
(on ?x ?y)
)

)

(:action  stack-2
:parameters (?x ?y)
:precondition
(and(holding ?x)
(clear ?y)
(clear ?x)
(not(handempty))
(not(on ?x ?y))
)
:effect
(and(not(holding ?x))
(not(clear ?y))
(clear ?x)
(handempty)
(on ?x ?y)
)

)

(:action  stack-3
:parameters (?x ?y)
:precondition
(and(holding ?x)
(clear ?y)
(not(clear ?x))
(handempty)
(not(on ?x ?y))
)
:effect
(and(not(holding ?x))
(not(clear ?y))
(clear ?x)
(handempty)
(on ?x ?y)
)

)

(:action  stack-4
:parameters (?x ?y)
:precondition
(and(holding ?x)
(clear ?y)
(clear ?x)
(handempty)
(not(on ?x ?y))
)
:effect
(and(not(holding ?x))
(not(clear ?y))
(clear ?x)
(handempty)
(on ?x ?y)
)

)

(:action  stack-5
:parameters (?x ?y)
:precondition
(and(holding ?x)
(clear ?y)
(not(clear ?x))
(not(handempty))
(on ?x ?y)
)
:effect
(and(not(holding ?x))
(not(clear ?y))
(clear ?x)
(handempty)
(on ?x ?y)
)

)

(:action  stack-6
:parameters (?x ?y)
:precondition
(and(holding ?x)
(clear ?y)
(clear ?x)
(not(handempty))
(on ?x ?y)
)
:effect
(and(not(holding ?x))
(not(clear ?y))
(clear ?x)
(handempty)
(on ?x ?y)
)

)

(:action  stack-7
:parameters (?x ?y)
:precondition
(and(holding ?x)
(clear ?y)
(not(clear ?x))
(handempty)
(on ?x ?y)
)
:effect
(and(not(holding ?x))
(not(clear ?y))
(clear ?x)
(handempty)
(on ?x ?y)
)

)

(:action  stack-8
:parameters (?x ?y)
:precondition
(and(holding ?x)
(clear ?y)
(clear ?x)
(handempty)
(on ?x ?y)
)
:effect
(and(not(holding ?x))
(not(clear ?y))
(clear ?x)
(handempty)
(on ?x ?y)
)

)


  (:action  unstack-1
:parameters (?x ?y)
:precondition
(and(on ?x ?y)
(clear ?x)
(handempty)
(not(holding ?x))
(not(clear ?y))
)
:effect
(and(holding ?x)
(clear ?y)
(not(clear ?x))
(not(handempty))
(not(on ?x ?y))
)

)

(:action  unstack-2
:parameters (?x ?y)
:precondition
(and(on ?x ?y)
(clear ?x)
(handempty)
(holding ?x)
(not(clear ?y))
)
:effect
(and(holding ?x)
(clear ?y)
(not(clear ?x))
(not(handempty))
(not(on ?x ?y))
)

)

(:action  unstack-3
:parameters (?x ?y)
:precondition
(and(on ?x ?y)
(clear ?x)
(handempty)
(not(holding ?x))
(clear ?y)
)
:effect
(and(holding ?x)
(clear ?y)
(not(clear ?x))
(not(handempty))
(not(on ?x ?y))
)

)

(:action  unstack-4
:parameters (?x ?y)
:precondition
(and(on ?x ?y)
(clear ?x)
(handempty)
(holding ?x)
(clear ?y)
)
:effect
(and(holding ?x)
(clear ?y)
(not(clear ?x))
(not(handempty))
(not(on ?x ?y))
)

)

)
