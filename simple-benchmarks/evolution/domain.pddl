(define (domain evolution-strips)
   (:predicates (evol_first ?f)
		(evol_second ?s)
		(evol_third ?t)
    (depend ?a ?b))

   (:action stage_one
       :parameters  (?a ?b)
       :precondition (and (evol_first ?a) (depend ?a ?b) (evol_third ?b))
       :effect (and  (evol_second ?a)
		     (not (evol_first ?a))))

   (:action stage_two
       :parameters  (?a ?b)
       :precondition (and (evol_second ?a) (depend ?a ?b) (evol_third ?b))
       :effect (and  (evol_third ?a)
         (not (evol_second ?a))))
)