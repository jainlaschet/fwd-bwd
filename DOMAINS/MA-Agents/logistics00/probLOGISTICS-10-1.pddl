(define (problem KprobLOGISTICS-10-1)
(:domain KprobLOGISTICS-10-1)
(:init
	(at apn1 apt2)
	(at obj11 pos1)
	(at obj12 pos1)
	(at obj13 pos1)
	(at obj31 pos3)
	(at obj32 pos3)
	(at obj33 pos3)
	(at obj41 pos4)
	(at obj42 pos4)
	(at obj43 pos4)
	(at tru1 pos1)
	(in-city tru1 pos1 cit1)
	(in-city tru1 apt1 cit1)
	(at tru2 pos2)
	(at obj21 pos2)
	(at obj22 pos2)
	(at obj23 pos2)
	(in-city tru2 pos2 cit2)
	(in-city tru2 apt2 cit2)
	(at tru3 pos3)
	(in-city tru3 pos3 cit3)
	(in-city tru3 apt3 cit3)
	(at tru4 pos4)
	(in-city tru4 pos4 cit4)
	(in-city tru4 apt4 cit4)
)
(:goal 
(and (at obj43 apt4) (at obj32 pos3) (at obj42 apt3) (at obj12 pos1) (at obj41 apt3) (at obj23 pos3) (at obj13 apt4) (at obj22 pos4) (at obj31 apt3) (at obj33 apt1)))
)

 