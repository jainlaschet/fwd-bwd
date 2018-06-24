(define (problem Kp20)
(:domain Kp20)
(:init
	(next n0 n1)
	(next n1 n2)
	(next n2 n3)
	(next n3 n4)
	(next n4 n5)
	(next n7 n8)
	(next n8 n9)
	(next n9 n10)
	(next n10 n11)
	(next n11 n12)
	(above n0 n1)
	(above n0 n2)
	(above n0 n3)
	(above n0 n4)
	(above n0 n5)
	(above n0 n7)
	(above n0 n8)
	(above n0 n9)
	(above n0 n10)
	(above n0 n11)
	(above n0 n12)
	(above n0 n14)
	(above n0 n16)
	(above n1 n2)
	(above n1 n3)
	(above n1 n4)
	(above n1 n5)
	(above n1 n7)
	(above n1 n8)
	(above n1 n9)
	(above n1 n10)
	(above n1 n11)
	(above n1 n12)
	(above n1 n14)
	(above n1 n16)
	(above n2 n3)
	(above n2 n4)
	(above n2 n5)
	(above n2 n7)
	(above n2 n8)
	(above n2 n9)
	(above n2 n10)
	(above n2 n11)
	(above n2 n12)
	(above n2 n14)
	(above n2 n16)
	(above n3 n4)
	(above n3 n5)
	(above n3 n7)
	(above n3 n8)
	(above n3 n9)
	(above n3 n10)
	(above n3 n11)
	(above n3 n12)
	(above n3 n14)
	(above n3 n16)
	(above n4 n5)
	(above n4 n7)
	(above n4 n8)
	(above n4 n9)
	(above n4 n10)
	(above n4 n11)
	(above n4 n12)
	(above n4 n14)
	(above n4 n16)
	(above n5 n7)
	(above n5 n8)
	(above n5 n9)
	(above n5 n10)
	(above n5 n11)
	(above n5 n12)
	(above n5 n14)
	(above n5 n16)
	(above n7 n8)
	(above n7 n9)
	(above n7 n10)
	(above n7 n11)
	(above n7 n12)
	(above n7 n14)
	(above n7 n16)
	(above n8 n9)
	(above n8 n10)
	(above n8 n11)
	(above n8 n12)
	(above n8 n14)
	(above n8 n16)
	(above n9 n10)
	(above n9 n11)
	(above n9 n12)
	(above n9 n14)
	(above n9 n16)
	(above n10 n11)
	(above n10 n12)
	(above n10 n14)
	(above n10 n16)
	(above n11 n12)
	(above n11 n14)
	(above n11 n16)
	(above n12 n14)
	(above n12 n16)
	(above n14 n16)
	(lift-at fast0 n16)
	(passengers fast0 n0)
	(can-hold fast0 n1)
	(can-hold fast0 n2)
	(can-hold fast0 n3)
	(can-hold fast0 n4)
	(reachable-floor fast0 n0)
	(reachable-floor fast0 n4)
	(reachable-floor fast0 n8)
	(reachable-floor fast0 n12)
	(reachable-floor fast0 n16)
	(passenger-at p0 n16)
	(passenger-at p1 n7)
	(passenger-at p2 n0)
	(passenger-at p3 n0)
	(passenger-at p4 n10)
	(passenger-at p6 n8)
	(passenger-at p7 n14)
	(passenger-at p8 n4)
	(passenger-at p9 n12)
	(passenger-at p10 n12)
	(passenger-at p11 n4)
	(passenger-at p13 n12)
	(passenger-at p14 n2)
	(passenger-at p16 n14)
	(passenger-at p17 n2)
	(passenger-at p18 n12)
	(passenger-at p19 n10)
	(passenger-at p20 n7)
	(passenger-at p21 n16)
	(passenger-at p22 n2)
	(passenger-at p23 n16)
	(passenger-at p24 n10)
	(lift-at fast1 n8)
	(passengers fast1 n0)
	(can-hold fast1 n1)
	(can-hold fast1 n2)
	(can-hold fast1 n3)
	(can-hold fast1 n4)
	(reachable-floor fast1 n0)
	(reachable-floor fast1 n4)
	(reachable-floor fast1 n8)
	(reachable-floor fast1 n12)
	(reachable-floor fast1 n16)
	(next n5 n6)
	(next n6 n7)
	(above n0 n6)
	(above n1 n6)
	(above n2 n6)
	(above n3 n6)
	(above n4 n6)
	(above n5 n6)
	(above n6 n7)
	(above n6 n8)
	(above n6 n9)
	(above n6 n10)
	(above n6 n11)
	(above n6 n12)
	(above n6 n14)
	(above n6 n16)
	(lift-at slow0-0 n5)
	(passengers slow0-0 n0)
	(can-hold slow0-0 n1)
	(can-hold slow0-0 n2)
	(can-hold slow0-0 n3)
	(reachable-floor slow0-0 n0)
	(reachable-floor slow0-0 n1)
	(reachable-floor slow0-0 n2)
	(reachable-floor slow0-0 n3)
	(reachable-floor slow0-0 n4)
	(reachable-floor slow0-0 n5)
	(reachable-floor slow0-0 n6)
	(reachable-floor slow0-0 n7)
	(reachable-floor slow0-0 n8)
	(passenger-at p12 n6)
	(next n12 n13)
	(next n13 n14)
	(next n14 n15)
	(next n15 n16)
	(above n0 n13)
	(above n0 n15)
	(above n1 n13)
	(above n1 n15)
	(above n2 n13)
	(above n2 n15)
	(above n3 n13)
	(above n3 n15)
	(above n4 n13)
	(above n4 n15)
	(above n5 n13)
	(above n5 n15)
	(above n7 n13)
	(above n7 n15)
	(above n8 n13)
	(above n8 n15)
	(above n9 n13)
	(above n9 n15)
	(above n10 n13)
	(above n10 n15)
	(above n11 n13)
	(above n11 n15)
	(above n12 n13)
	(above n12 n15)
	(above n13 n14)
	(above n13 n15)
	(above n13 n16)
	(above n14 n15)
	(above n15 n16)
	(lift-at slow1-0 n13)
	(passengers slow1-0 n0)
	(can-hold slow1-0 n1)
	(can-hold slow1-0 n2)
	(can-hold slow1-0 n3)
	(reachable-floor slow1-0 n8)
	(reachable-floor slow1-0 n9)
	(reachable-floor slow1-0 n10)
	(reachable-floor slow1-0 n11)
	(reachable-floor slow1-0 n12)
	(reachable-floor slow1-0 n13)
	(reachable-floor slow1-0 n14)
	(reachable-floor slow1-0 n15)
	(reachable-floor slow1-0 n16)
	(passenger-at p5 n15)
	(passenger-at p15 n15)
	(passenger-at p25 n13)
)
(:goal 
(and (passenger-at p0 n11) (passenger-at p1 n8) (passenger-at p2 n14) (passenger-at p3 n16) (passenger-at p4 n8) (passenger-at p5 n16) (passenger-at p6 n9) (passenger-at p7 n4) (passenger-at p8 n2) (passenger-at p9 n0) (passenger-at p10 n8) (passenger-at p11 n1) (passenger-at p12 n2) (passenger-at p13 n9) (passenger-at p14 n1) (passenger-at p15 n7) (passenger-at p16 n10) (passenger-at p17 n3) (passenger-at p18 n14) (passenger-at p19 n11) (passenger-at p20 n4) (passenger-at p21 n5) (passenger-at p22 n3) (passenger-at p23 n14) (passenger-at p24 n12) (passenger-at p25 n8) (passenger-at p0 n11) (passenger-at p1 n8) (passenger-at p2 n14) (passenger-at p3 n16) (passenger-at p4 n8) (passenger-at p5 n16) (passenger-at p6 n9) (passenger-at p7 n4) (passenger-at p8 n2) (passenger-at p9 n0) (passenger-at p10 n8) (passenger-at p11 n1) (passenger-at p12 n2) (passenger-at p13 n9) (passenger-at p14 n1) (passenger-at p15 n7) (passenger-at p16 n10) (passenger-at p17 n3) (passenger-at p18 n14) (passenger-at p19 n11) (passenger-at p20 n4) (passenger-at p21 n5) (passenger-at p22 n3) (passenger-at p23 n14) (passenger-at p24 n12) (passenger-at p25 n8) (passenger-at p0 n11) (passenger-at p1 n8) (passenger-at p2 n14) (passenger-at p3 n16) (passenger-at p4 n8) (passenger-at p5 n16) (passenger-at p6 n9) (passenger-at p7 n4) (passenger-at p8 n2) (passenger-at p9 n0) (passenger-at p10 n8) (passenger-at p11 n1) (passenger-at p12 n2) (passenger-at p13 n9) (passenger-at p14 n1) (passenger-at p15 n7) (passenger-at p16 n10) (passenger-at p17 n3) (passenger-at p18 n14) (passenger-at p19 n11) (passenger-at p20 n4) (passenger-at p21 n5) (passenger-at p22 n3) (passenger-at p23 n14) (passenger-at p24 n12) (passenger-at p25 n8) (passenger-at p0 n11) (passenger-at p1 n8) (passenger-at p2 n14) (passenger-at p3 n16) (passenger-at p4 n8) (passenger-at p5 n16) (passenger-at p6 n9) (passenger-at p7 n4) (passenger-at p8 n2) (passenger-at p9 n0) (passenger-at p10 n8) (passenger-at p11 n1) (passenger-at p12 n2) (passenger-at p13 n9) (passenger-at p14 n1) (passenger-at p15 n7) (passenger-at p16 n10) (passenger-at p17 n3) (passenger-at p18 n14) (passenger-at p19 n11) (passenger-at p20 n4) (passenger-at p21 n5) (passenger-at p22 n3) (passenger-at p23 n14) (passenger-at p24 n12) (passenger-at p25 n8)))
)

 