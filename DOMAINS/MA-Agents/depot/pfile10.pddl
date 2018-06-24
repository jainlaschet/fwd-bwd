(define (problem Kpfile10)
(:domain Kpfile10)
(:init
	(at pallet0 depot0)
	(clear crate1)
	(at pallet1 depot1)
	(clear crate0)
	(at pallet2 depot2)
	(clear crate4)
	(at pallet3 distributor0)
	(clear crate5)
	(at pallet4 distributor1)
	(clear pallet4)
	(at pallet5 distributor2)
	(clear crate3)
	(at truck0 depot1)
	(at truck1 depot2)
	(at hoist0 depot0)
	(available depot0 hoist0)
	(at crate0 depot1)
	(on crate0 pallet1)
	(at crate1 depot0)
	(on crate1 pallet0)
	(at crate2 distributor2)
	(on crate2 pallet5)
	(at crate3 distributor2)
	(on crate3 crate2)
	(at crate4 depot2)
	(on crate4 pallet2)
	(at crate5 distributor0)
	(on crate5 pallet3)
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
(and (on crate0 crate4) (on crate2 pallet3) (on crate3 pallet0) (on crate4 pallet5)))
)

 