(define (domain Kp11-pfile11)
(:requirements :strips :typing)
(:types OBJ
satellite - object
direction - object
instrument - object
mode - object)
(:constants
 planet13 - direction
 planet14 - direction
 infrared1 - mode
 planet16 - direction
 planet19 - direction
 spectrograph4 - mode
 phenomenon15 - direction
 phenomenon7 - direction
 planet6 - direction
 image3 - mode
 star17 - direction
 star11 - direction
 star10 - direction
 star12 - direction
 thermograph2 - mode
 infrared0 - mode
 star18 - direction
 star5 - direction
 star4 - direction
 star1 - direction
 star0 - direction
 star2 - direction
 phenomenon9 - direction
 groundstation3 - direction
 star8 - direction
 satellite0 - satellite
 instrument0 - instrument
 satellite1 - satellite
 instrument2 - instrument
 instrument3 - instrument
 instrument1 - instrument
 satellite2 - satellite
 instrument6 - instrument
 instrument4 - instrument
 instrument5 - instrument
 satellite3 - satellite
 instrument7 - instrument
 satellite4 - satellite
 instrument8 - instrument
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
