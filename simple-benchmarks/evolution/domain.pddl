(define (domain evolution-strips)
   (:predicates (poka ?a)
		(poke ?e)
		(poki ?i)
		(ultra ?u))

   (:action ae
       :parameters  (?a)
       :precondition (poka ?a)
       :effect (and  (poke ?a)
		     (not (poka ?a))))
		    
   (:action ei
       :parameters  (?e)
       :precondition (poke ?e)
       :effect (and  (poki ?e)
		     (not (poke ?e))))
   
   (:action uia
       :parameters  (?e ?i)
       :precondition (and (poke ?e) (poki ?i))
       :effect (and  (ultra ?i)
		     (not (poki ?i))))


)