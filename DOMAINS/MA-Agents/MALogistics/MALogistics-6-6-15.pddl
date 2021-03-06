(define (problem KMALogistics-6-6-15)
(:domain KMALogistics-6-6-15)
(:init
	(city-in-area c0 a0)
	(city-in-area c1 a0)
	(city-in-area c2 a0)
	(city-in-area c3 a0)
	(city-in-area c4 a0)
	(city-in-area c5 a0)
	(city-in-area c6 a0)
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
	(adj c6 c5)
	(adj c5 c6)
	(package-in-city p1 c1)
	(package-in-city p6 c2)
	(package-in-city p9 c1)
	(package-in-city p10 c3)
	(package-in-city p13 c6)
	(city-in-area c6 a1)
	(city-in-area c7 a1)
	(city-in-area c8 a1)
	(city-in-area c9 a1)
	(truck-in-area t1 a1)
	(truck-in-city t1 c6)
	(adj c7 c6)
	(adj c6 c7)
	(adj c8 c7)
	(adj c7 c8)
	(adj c9 c8)
	(adj c8 c9)
	(package-in-city p5 c7)
	(package-in-city p14 c9)
	(city-in-area c9 a2)
	(city-in-area c10 a2)
	(city-in-area c11 a2)
	(city-in-area c12 a2)
	(city-in-area c13 a2)
	(truck-in-area t2 a2)
	(truck-in-city t2 c9)
	(adj c10 c9)
	(adj c9 c10)
	(adj c11 c10)
	(adj c10 c11)
	(adj c12 c11)
	(adj c11 c12)
	(adj c13 c12)
	(adj c12 c13)
	(city-in-area c13 a3)
	(city-in-area c14 a3)
	(city-in-area c15 a3)
	(city-in-area c16 a3)
	(city-in-area c0 a3)
	(truck-in-area t3 a3)
	(truck-in-city t3 c13)
	(adj c14 c13)
	(adj c13 c14)
	(adj c15 c14)
	(adj c14 c15)
	(adj c16 c15)
	(adj c15 c16)
	(adj c0 c16)
	(adj c16 c0)
	(package-in-city p0 c14)
	(package-in-city p2 c14)
	(package-in-city p3 c15)
	(city-in-area c16 a4)
	(city-in-area c17 a4)
	(city-in-area c18 a4)
	(city-in-area c19 a4)
	(city-in-area c20 a4)
	(truck-in-area t4 a4)
	(truck-in-city t4 c16)
	(adj c17 c16)
	(adj c16 c17)
	(adj c18 c17)
	(adj c17 c18)
	(adj c19 c18)
	(adj c18 c19)
	(adj c20 c19)
	(adj c19 c20)
	(package-in-city p7 c18)
	(package-in-city p8 c20)
	(package-in-city p12 c18)
	(city-in-area c20 a5)
	(city-in-area c21 a5)
	(city-in-area c22 a5)
	(truck-in-area t5 a5)
	(truck-in-city t5 c20)
	(adj c21 c20)
	(adj c20 c21)
	(adj c22 c21)
	(adj c21 c22)
	(package-in-city p4 c21)
	(package-in-city p11 c21)
)
(:goal 
(and (package-in-city p1 c5) (package-in-city p2 c2) (package-in-city p4 c5) (package-in-city p9 c3) (package-in-city p10 c0) (package-in-city p13 c1) (and ) (package-in-city p3 c13) (package-in-city p6 c11) (package-in-city p8 c11) (package-in-city p11 c10) (package-in-city p12 c10) (package-in-city p5 c15) (package-in-city p7 c16) (package-in-city p0 c20) (package-in-city p14 c22)))
)

 