(define (problem KMALogistics-6-6-10)
(:domain KMALogistics-6-6-10)
(:init
	(city-in-area c0 a0)
	(city-in-area c1 a0)
	(city-in-area c2 a0)
	(city-in-area c3 a0)
	(city-in-area c4 a0)
	(city-in-area c5 a0)
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
	(adj c5 c4)
	(adj c4 c5)
	(package-in-city p2 c3)
	(package-in-city p7 c0)
	(city-in-area c5 a1)
	(city-in-area c6 a1)
	(city-in-area c7 a1)
	(truck-in-area t1 a1)
	(truck-in-city t1 c5)
	(adj c6 c5)
	(adj c5 c6)
	(adj c7 c6)
	(adj c6 c7)
	(package-in-city p3 c7)
	(package-in-city p8 c7)
	(package-in-city p9 c6)
	(city-in-area c7 a2)
	(city-in-area c8 a2)
	(city-in-area c9 a2)
	(city-in-area c10 a2)
	(city-in-area c11 a2)
	(truck-in-area t2 a2)
	(truck-in-city t2 c7)
	(adj c8 c7)
	(adj c7 c8)
	(adj c9 c8)
	(adj c8 c9)
	(adj c10 c9)
	(adj c9 c10)
	(adj c11 c10)
	(adj c10 c11)
	(package-in-city p0 c11)
	(package-in-city p1 c8)
	(package-in-city p4 c8)
	(package-in-city p5 c10)
	(city-in-area c11 a3)
	(city-in-area c0 a3)
	(truck-in-area t3 a3)
	(truck-in-city t3 c11)
	(adj c0 c11)
	(adj c11 c0)
	(city-in-area c11 a4)
	(city-in-area c12 a4)
	(truck-in-area t4 a4)
	(truck-in-city t4 c11)
	(adj c12 c11)
	(adj c11 c12)
	(package-in-city p6 c12)
	(city-in-area c12 a5)
	(truck-in-area t5 a5)
	(truck-in-city t5 c12)
)
(:goal 
(and (package-in-city p0 c3) (package-in-city p1 c0) (package-in-city p2 c2) (package-in-city p3 c0) (package-in-city p5 c3) (package-in-city p6 c7) (package-in-city p7 c7) (package-in-city p8 c7) (package-in-city p4 c9) (package-in-city p9 c9) (and )))
)

 