(define (problem KprobLOGISTICS-9-1)
(:domain KprobLOGISTICS-9-1)
(:init
	(at apn1 apt1)
	(at obj21 pos2)
	(at obj22 pos2)
	(at obj23 pos2)
	(at obj31 pos3)
	(at obj32 pos3)
	(at obj33 pos3)
	(at tru1 pos1)
	(at obj11 pos1)
	(at obj12 pos1)
	(at obj13 pos1)
	(in-city tru1 pos1 cit1)
	(in-city tru1 apt1 cit1)
	(at tru2 pos2)
	(in-city tru2 pos2 cit2)
	(in-city tru2 apt2 cit2)
	(at tru3 pos3)
	(in-city tru3 pos3 cit3)
	(in-city tru3 apt3 cit3)
)
(:goal 
(and (at obj11 apt2) (at obj31 pos3) (at obj13 pos3) (at obj23 apt3) (at obj33 apt3) (at obj22 pos2) (at obj32 apt3) (at obj21 pos2) (at obj12 pos3)))
)

 