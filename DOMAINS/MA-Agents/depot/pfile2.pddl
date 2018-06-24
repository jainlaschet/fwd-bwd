(define (problem Kpfile2)
(:domain Kpfile2)
(:init
	(at pallet0 depot0)
	(clear crate0)
	(at pallet1 distributor0)
	(clear crate3)
	(at pallet2 distributor1)
	(clear crate2)
	(at truck0 depot0)
	(at truck1 depot0)
	(at hoist0 depot0)
	(available depot0 hoist0)
	(at crate0 depot0)
	(on crate0 pallet0)
	(at crate1 distributor1)
	(on crate1 pallet2)
	(at crate2 distributor1)
	(on crate2 crate1)
	(at crate3 distributor0)
	(on crate3 pallet1)
	(at hoist1 distributor0)
	(available distributor0 hoist1)
	(at hoist2 distributor1)
	(available distributor1 hoist2)
	(driving driver0 truck0)
	(driving driver1 truck1)
)
(:goal 
(and (on crate0 pallet2) (on crate1 crate3) (on crate2 pallet0) (on crate3 pallet1)))
)

 