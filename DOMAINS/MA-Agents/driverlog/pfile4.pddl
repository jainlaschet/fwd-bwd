(define (problem Kpfile4)
(:domain Kpfile4)
(:init
	(at driver1 s1)
	(at truck1 s1)
	(empty truck1)
	(at truck2 s0)
	(empty truck2)
	(at package1 s2)
	(at package2 s2)
	(at package3 s0)
	(at package4 s1)
	(path s0 p0-1)
	(path p0-1 s0)
	(path s1 p0-1)
	(path p0-1 s1)
	(path s1 p1-2)
	(path p1-2 s1)
	(path s2 p1-2)
	(path p1-2 s2)
	(link s0 s2)
	(link s2 s0)
	(link s1 s0)
	(link s0 s1)
	(link s2 s1)
	(link s1 s2)
	(at driver2 s1)
	(at driver3 s0)
)
(:goal 
(and (at truck1 s1) (at truck2 s2) (at package1 s1) (at package2 s2) (at package3 s2) (at package4 s0)))
)

 