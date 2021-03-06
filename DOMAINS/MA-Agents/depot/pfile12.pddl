(define (problem Kpfile12)
(:domain Kpfile12)
(:init
	(at pallet0 depot0)
	(clear pallet0)
	(at pallet1 depot1)
	(clear crate12)
	(at pallet2 depot2)
	(clear pallet2)
	(at pallet3 distributor0)
	(clear crate4)
	(at pallet4 distributor1)
	(clear crate14)
	(at pallet5 distributor2)
	(clear crate13)
	(at truck0 distributor1)
	(at truck1 depot1)
	(at hoist0 depot0)
	(available depot0 hoist0)
	(at crate0 distributor2)
	(on crate0 pallet5)
	(at crate1 depot1)
	(on crate1 pallet1)
	(at crate2 distributor0)
	(on crate2 pallet3)
	(at crate3 distributor2)
	(on crate3 crate0)
	(at crate4 distributor0)
	(on crate4 crate2)
	(at crate5 depot1)
	(on crate5 crate1)
	(at crate6 distributor2)
	(on crate6 crate3)
	(at crate7 distributor2)
	(on crate7 crate6)
	(at crate8 distributor2)
	(on crate8 crate7)
	(at crate9 distributor2)
	(on crate9 crate8)
	(at crate10 depot1)
	(on crate10 crate5)
	(at crate11 distributor1)
	(on crate11 pallet4)
	(at crate12 depot1)
	(on crate12 crate10)
	(at crate13 distributor2)
	(on crate13 crate9)
	(at crate14 distributor1)
	(on crate14 crate11)
	(at hoist1 depot1)
	(available depot1 hoist1)
	(at hoist2 depot2)
	(available depot2 hoist2)
	(at hoist3 distributor0)
	(available distributor0 hoist3)
	(at hoist4 distributor1)
	(available distributor1 hoist4)
	(at hoist5 distributor2)
	(available distributor2 hoist5)
	(driving driver0 truck0)
	(driving driver1 truck1)
)
(:goal 
(and (on crate0 pallet4) (on crate1 crate12) (on crate2 crate0) (on crate3 crate9) (on crate5 pallet0) (on crate6 crate2) (on crate9 pallet2) (on crate10 crate13) (on crate12 pallet5) (on crate13 pallet1) (on crate14 crate10)))
)

 