(define (problem Kpfile20)
(:domain Kpfile20)
(:init
	(at pallet0 depot0)
	(clear crate13)
	(at pallet1 depot1)
	(clear crate14)
	(at pallet2 depot2)
	(clear pallet2)
	(at pallet3 depot3)
	(clear crate5)
	(at pallet4 distributor0)
	(clear pallet4)
	(at pallet5 distributor1)
	(clear crate9)
	(at pallet6 distributor2)
	(clear crate8)
	(at pallet7 distributor3)
	(clear crate10)
	(at pallet8 depot1)
	(clear crate11)
	(at pallet9 depot2)
	(clear pallet9)
	(at truck0 distributor2)
	(at truck1 depot0)
	(at truck2 depot1)
	(at truck3 distributor1)
	(at hoist0 depot0)
	(available depot0 hoist0)
	(at crate0 distributor3)
	(on crate0 pallet7)
	(at crate1 distributor1)
	(on crate1 pallet5)
	(at crate2 depot3)
	(on crate2 pallet3)
	(at crate3 depot0)
	(on crate3 pallet0)
	(at crate4 depot0)
	(on crate4 crate3)
	(at crate5 depot3)
	(on crate5 crate2)
	(at crate6 depot1)
	(on crate6 pallet1)
	(at crate7 distributor2)
	(on crate7 pallet6)
	(at crate8 distributor2)
	(on crate8 crate7)
	(at crate9 distributor1)
	(on crate9 crate1)
	(at crate10 distributor3)
	(on crate10 crate0)
	(at crate11 depot1)
	(on crate11 pallet8)
	(at crate12 depot1)
	(on crate12 crate6)
	(at crate13 depot0)
	(on crate13 crate4)
	(at crate14 depot1)
	(on crate14 crate12)
	(at hoist1 depot1)
	(available depot1 hoist1)
	(at hoist2 depot2)
	(available depot2 hoist2)
	(at hoist3 depot3)
	(available depot3 hoist3)
	(at hoist4 distributor0)
	(available distributor0 hoist4)
	(at hoist5 distributor1)
	(available distributor1 hoist5)
	(at hoist6 distributor2)
	(available distributor2 hoist6)
	(at hoist7 distributor3)
	(available distributor3 hoist7)
	(driving driver0 truck0)
	(driving driver0 truck2)
	(driving driver1 truck1)
	(driving driver1 truck3)
)
(:goal 
(and (on crate0 pallet3) (on crate1 crate11) (on crate2 pallet6) (on crate3 crate0) (on crate4 crate5) (on crate5 crate14) (on crate6 pallet4) (on crate7 pallet2) (on crate8 pallet7) (on crate9 crate8) (on crate11 pallet5) (on crate12 crate6) (on crate13 crate2) (on crate14 pallet1)))
)

 