(define (problem KprobLOGISTICS-5-0)
(:domain KprobLOGISTICS-5-0)
(:init
	(at apn1 apt1)
	(at obj21 pos2)
	(at obj22 pos2)
	(at obj23 pos2)
	(at tru1 pos1)
	(at obj11 pos1)
	(at obj12 pos1)
	(at obj13 pos1)
	(in-city tru1 pos1 cit1)
	(in-city tru1 apt1 cit1)
	(at tru2 pos2)
	(in-city tru2 pos2 cit2)
	(in-city tru2 apt2 cit2)
)
(:goal 
(and (at obj23 apt2) (at obj22 apt1) (at obj13 apt2) (at obj12 pos2) (at obj11 pos2)))
)

 