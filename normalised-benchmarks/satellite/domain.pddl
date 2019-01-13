(define (domain satellite)
(:requirements :equality :strips)
(:predicates
	 (on_board ?i ?s) (supports ?i ?m) (pointing ?s ?d) (power_avail ?s) (power_on ?i) (calibrated ?i) (have_image ?d ?m) (calibration_target ?i ?d)(satellite ?x) (direction ?x) (instrument ?x) (mode ?x) )
(:action  turn_to-1
:parameters ( ?s ?d_new ?d_prev)
:precondition
(and(satellite ?s)
(direction ?d_new)
(direction ?d_prev)
(pointing ?s ?d_prev)
(not(pointing ?s ?d_new))
)
:effect
(and(pointing ?s ?d_new)
(not(pointing ?s ?d_prev))
(satellite ?s)
(direction ?d_new)
(direction ?d_prev)
)

)

(:action  turn_to-2
:parameters ( ?s ?d_new ?d_prev)
:precondition
(and(satellite ?s)
(direction ?d_new)
(direction ?d_prev)
(pointing ?s ?d_prev)
(pointing ?s ?d_new)
)
:effect
(and(pointing ?s ?d_new)
(not(pointing ?s ?d_prev))
(satellite ?s)
(direction ?d_new)
(direction ?d_prev)
)

)



(:action  switch_on-1
:parameters ( ?i ?s)
:precondition
(and(instrument ?i)
(satellite ?s)
(on_board ?i ?s)
(power_avail ?s)
(not(power_on ?i))
(not(calibrated ?i))
)
:effect
(and(power_on ?i)
(not(calibrated ?i))
(not(power_avail ?s))
(instrument ?i)
(satellite ?s)
(on_board ?i ?s)
)

)

(:action  switch_on-2
:parameters ( ?i ?s)
:precondition
(and(instrument ?i)
(satellite ?s)
(on_board ?i ?s)
(power_avail ?s)
(power_on ?i)
(not(calibrated ?i))
)
:effect
(and(power_on ?i)
(not(calibrated ?i))
(not(power_avail ?s))
(instrument ?i)
(satellite ?s)
(on_board ?i ?s)
)

)

(:action  switch_on-3
:parameters ( ?i ?s)
:precondition
(and(instrument ?i)
(satellite ?s)
(on_board ?i ?s)
(power_avail ?s)
(not(power_on ?i))
(calibrated ?i)
)
:effect
(and(power_on ?i)
(not(calibrated ?i))
(not(power_avail ?s))
(instrument ?i)
(satellite ?s)
(on_board ?i ?s)
)

)

(:action  switch_on-4
:parameters ( ?i ?s)
:precondition
(and(instrument ?i)
(satellite ?s)
(on_board ?i ?s)
(power_avail ?s)
(power_on ?i)
(calibrated ?i)
)
:effect
(and(power_on ?i)
(not(calibrated ?i))
(not(power_avail ?s))
(instrument ?i)
(satellite ?s)
(on_board ?i ?s)
)

)



(:action  switch_off-1
:parameters ( ?i ?s)
:precondition
(and(instrument ?i)
(satellite ?s)
(on_board ?i ?s)
(power_on ?i)
(not(power_avail ?s))
)
:effect
(and(power_avail ?s)
(not(power_on ?i))
(instrument ?i)
(satellite ?s)
(on_board ?i ?s)
)

)

(:action  switch_off-2
:parameters ( ?i ?s)
:precondition
(and(instrument ?i)
(satellite ?s)
(on_board ?i ?s)
(power_on ?i)
(power_avail ?s)
)
:effect
(and(power_avail ?s)
(not(power_on ?i))
(instrument ?i)
(satellite ?s)
(on_board ?i ?s)
)

)



(:action  calibrate-1
:parameters ( ?s ?i ?d)
:precondition
(and(satellite ?s)
(instrument ?i)
(direction ?d)
(on_board ?i ?s)
(calibration_target ?i ?d)
(pointing ?s ?d)
(power_on ?i)
(not(calibrated ?i))
)
:effect
(and(calibrated ?i)
(satellite ?s)
(instrument ?i)
(direction ?d)
(on_board ?i ?s)
(calibration_target ?i ?d)
(pointing ?s ?d)
(power_on ?i)
)

)

(:action  calibrate-2
:parameters ( ?s ?i ?d)
:precondition
(and(satellite ?s)
(instrument ?i)
(direction ?d)
(on_board ?i ?s)
(calibration_target ?i ?d)
(pointing ?s ?d)
(power_on ?i)
(calibrated ?i)
)
:effect
(and(calibrated ?i)
(satellite ?s)
(instrument ?i)
(direction ?d)
(on_board ?i ?s)
(calibration_target ?i ?d)
(pointing ?s ?d)
(power_on ?i)
)

)



(:action  take_image-1
:parameters ( ?s ?d ?i ?m)
:precondition
(and(satellite ?s)
(direction ?d)
(instrument ?i)
(mode ?m)
(calibrated ?i)
(on_board ?i ?s)
(supports ?i ?m)
(power_on ?i)
(pointing ?s ?d)
(power_on ?i)
(not(have_image ?d ?m))
)
:effect
(and(have_image ?d ?m)
(satellite ?s)
(direction ?d)
(instrument ?i)
(mode ?m)
(calibrated ?i)
(on_board ?i ?s)
(supports ?i ?m)
(power_on ?i)
(pointing ?s ?d)
(power_on ?i)
)

)

(:action  take_image-2
:parameters ( ?s ?d ?i ?m)
:precondition
(and(satellite ?s)
(direction ?d)
(instrument ?i)
(mode ?m)
(calibrated ?i)
(on_board ?i ?s)
(supports ?i ?m)
(power_on ?i)
(pointing ?s ?d)
(power_on ?i)
(have_image ?d ?m)
)
:effect
(and(have_image ?d ?m)
(satellite ?s)
(direction ?d)
(instrument ?i)
(mode ?m)
(calibrated ?i)
(on_board ?i ?s)
(supports ?i ?m)
(power_on ?i)
(pointing ?s ?d)
(power_on ?i)
)

)



)
