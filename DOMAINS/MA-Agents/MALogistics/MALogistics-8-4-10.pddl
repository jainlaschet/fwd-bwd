(define (problem KMALogistics-8-4-10)
(:domain KMALogistics-8-4-10)
(:init
	(city-in-area c0 a0)
	(city-in-area c1 a0)
	(city-in-area c2 a0)
	(city-in-area c3 a0)
	(city-in-area c4 a0)
	(truck-in-area t0 a0)
	(truck-in-city t0 c0)
	(adj c1 c0)
	(adj c0 c1)
	(adj c2 c1)
	(adj c1 c2)
	(adj c3 c2)
	(adj c2 c3)
	(adj c4 c3)
	(adj c3 c4)
	(package-in-city p1 c4)
	(package-in-city p2 c2)
	(package-in-city p3 c2)
	(package-in-city p4 c2)
	(package-in-city p5 c2)
	(package-in-city p6 c4)
	(package-in-city p7 c4)
	(package-in-city p8 c1)
	(city-in-area c4 a1)
	(city-in-area c5 a1)
	(truck-in-area t1 a1)
	(truck-in-city t1 c4)
	(adj c5 c4)
	(adj c4 c5)
	(package-in-city p0 c5)
	(city-in-area c5 a2)
	(truck-in-area t2 a2)
	(truck-in-city t2 c5)
	(city-in-area c5 a3)
	(truck-in-area t3 a3)
	(truck-in-city t3 c5)
	(city-in-area c5 a4)
	(city-in-area c6 a4)
	(city-in-area c0 a4)
	(truck-in-area t4 a4)
	(truck-in-city t4 c5)
	(adj c6 c5)
	(adj c5 c6)
	(adj c0 c6)
	(adj c6 c0)
	(city-in-area c6 a5)
	(truck-in-area t5 a5)
	(truck-in-city t5 c6)
	(city-in-area c6 a6)
	(city-in-area c7 a6)
	(truck-in-area t6 a6)
	(truck-in-city t6 c6)
	(adj c7 c6)
	(adj c6 c7)
	(city-in-area c7 a7)
	(city-in-area c8 a7)
	(city-in-area c9 a7)
	(truck-in-area t7 a7)
	(truck-in-city t7 c7)
	(adj c8 c7)
	(adj c7 c8)
	(adj c9 c8)
	(adj c8 c9)
	(package-in-city p9 c8)
)
(:goal 
(and (package-in-city p0 c1) (package-in-city p1 c1) (package-in-city p4 c1) (package-in-city p6 c1) (package-in-city p7 c1) (package-in-city p8 c2) (and ) (package-in-city p3 c6) (package-in-city p2 c7) (package-in-city p5 c7) (package-in-city p9 c7)))
)

 