(define (problem KprobLOGISTICS-13-1)
(:domain KprobLOGISTICS-13-1)
(:init
	(at apn1 apt4)
	(at obj11 pos1)
	(at obj12 pos1)
	(at obj13 pos1)
	(at obj21 pos2)
	(at obj22 pos2)
	(at obj23 pos2)
	(at obj31 pos3)
	(at obj32 pos3)
	(at obj33 pos3)
	(at obj41 pos4)
	(at obj42 pos4)
	(at obj43 pos4)
	(at obj51 pos5)
	(at obj52 pos5)
	(at obj53 pos5)
	(at apn2 apt2)
	(at tru1 pos1)
	(in-city tru1 pos1 cit1)
	(in-city tru1 apt1 cit1)
	(at tru2 pos2)
	(in-city tru2 pos2 cit2)
	(in-city tru2 apt2 cit2)
	(at tru3 pos3)
	(in-city tru3 pos3 cit3)
	(in-city tru3 apt3 cit3)
	(at tru4 pos4)
	(in-city tru4 pos4 cit4)
	(in-city tru4 apt4 cit4)
	(at tru5 pos5)
	(in-city tru5 pos5 cit5)
	(in-city tru5 apt5 cit5)
)
(:goal 
(and (at obj12 pos2) (at obj53 apt2) (at obj51 pos4) (at obj11 pos1) (at obj23 apt1) (at obj13 pos5) (at obj52 apt4) (at obj42 pos3) (at obj22 pos1) (at obj33 apt4) (at obj21 apt2) (at obj41 pos4) (at obj31 pos3)))
)

 