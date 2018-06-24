(define (domain Kp13-pfile13)
(:requirements :strips :typing)
(:types OBJ
satellite - object
direction - object
instrument - object
mode - object)
(:constants
 planet11 - direction
 planet10 - direction
 planet13 - direction
 planet15 - direction
 planet17 - direction
 planet16 - direction
 phenomenon18 - direction
 star14 - direction
 thermograph1 - mode
 thermograph0 - mode
 phenomenon12 - direction
 thermograph2 - mode
 star19 - direction
 groundstation3 - direction
 groundstation2 - direction
 planet28 - direction
 planet29 - direction
 planet20 - direction
 planet23 - direction
 planet24 - direction
 planet25 - direction
 planet7 - direction
 phenomenon5 - direction
 image3 - mode
 planet9 - direction
 planet8 - direction
 image4 - mode
 star21 - direction
 star22 - direction
 star26 - direction
 phenomenon27 - direction
 star4 - direction
 planet6 - direction
 star1 - direction
 star0 - direction
 instrument1 - instrument
 satellite0 - satellite
 instrument0 - instrument
 satellite1 - satellite
 instrument2 - instrument
 satellite2 - satellite
 instrument3 - instrument
 instrument4 - instrument
 satellite3 - satellite
 instrument5 - instrument
 satellite4 - satellite
 instrument8 - instrument
 instrument6 - instrument
 instrument7 - instrument
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
