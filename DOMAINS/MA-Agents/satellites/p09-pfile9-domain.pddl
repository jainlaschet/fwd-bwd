(define (domain Kp09-pfile9)
(:requirements :strips :typing)
(:types OBJ
satellite - object
direction - object
instrument - object
mode - object)
(:constants
 planet11 - direction
 planet10 - direction
 planet5 - direction
 phenomenon7 - direction
 phenomenon6 - direction
 image3 - mode
 image2 - mode
 phenomenon8 - direction
 image4 - mode
 star14 - direction
 phenomenon12 - direction
 phenomenon13 - direction
 infrared1 - mode
 star4 - direction
 spectrograph0 - mode
 star0 - direction
 star3 - direction
 star2 - direction
 star9 - direction
 groundstation1 - direction
 satellite0 - satellite
 instrument2 - instrument
 instrument0 - instrument
 instrument1 - instrument
 instrument3 - instrument
 satellite1 - satellite
 instrument4 - instrument
 instrument5 - instrument
 satellite2 - satellite
 instrument6 - instrument
 satellite3 - satellite
 instrument7 - instrument
 satellite4 - satellite
 instrument8 - instrument
 instrument9 - instrument
 instrument10 - instrument
)

(:predicates
(pointing ?s - satellite ?d - direction)
(have_image ?d - direction ?m - mode)
(calibrated ?i - instrument)
(supports ?i - instrument ?m - mode)
(on_board ?i - instrument ?agent - satellite)
(calibration_target ?i - instrument ?d - direction)
(power_avail ?agent - satellite)
(power_on ?i - instrument)
)

(:action turn_to
:parameters ( ?s - satellite ?d_new - direction ?d_prev - direction)
:precondition (pointing ?s ?d_prev)
:effect 
(and (pointing ?s ?d_new) (not (pointing ?s ?d_prev)))
)

(:action switch_on
:parameters ( ?s - satellite ?i - instrument)
:precondition 
(and (on_board ?i ?s) (power_avail ?s))
:effect 
(and (power_on ?i) (not (calibrated ?i)) (not (power_avail ?s)))
)

(:action switch_off
:parameters ( ?s - satellite ?i - instrument)
:precondition 
(and (on_board ?i ?s) (power_on ?i))
:effect 
(and (power_avail ?s) (not (power_on ?i)))
)

(:action calibrate
:parameters ( ?s - satellite ?i - instrument ?d - direction)
:precondition 
(and (on_board ?i ?s) (calibration_target ?i ?d) (pointing ?s ?d) (power_on ?i))
:effect (calibrated ?i)
)

(:action take_image
:parameters ( ?s - satellite ?i - instrument ?d - direction ?m - mode)
:precondition 
(and (calibrated ?i) (on_board ?i ?s) (supports ?i ?m) (power_on ?i) (pointing ?s ?d) (power_on ?i))
:effect (have_image ?d ?m)
)

)
