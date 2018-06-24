(define (domain Kp18-pfile18)
(:requirements :strips :typing)
(:types OBJ
satellite - object
direction - object
instrument - object
mode - object)
(:constants
 planet11 - direction
 star15 - direction
 phenomenon13 - direction
 planet14 - direction
 planet19 - direction
 planet23 - direction
 star8 - direction
 groundstation2 - direction
 phenomenon5 - direction
 image1 - mode
 phenomenon24 - direction
 phenomenon18 - direction
 phenomenon21 - direction
 star22 - direction
 star10 - direction
 star4 - direction
 thermograph0 - mode
 thermograph3 - mode
 thermograph2 - mode
 thermograph4 - mode
 phenomenon16 - direction
 phenomenon17 - direction
 planet20 - direction
 planet6 - direction
 planet7 - direction
 star0 - direction
 star3 - direction
 star1 - direction
 star9 - direction
 phenomenon12 - direction
 instrument2 - instrument
 instrument1 - instrument
 satellite0 - satellite
 instrument0 - instrument
 instrument3 - instrument
 satellite1 - satellite
 instrument6 - instrument
 instrument4 - instrument
 instrument5 - instrument
 satellite2 - satellite
 instrument8 - instrument
 instrument9 - instrument
 instrument7 - instrument
 satellite3 - satellite
 instrument10 - instrument
 instrument11 - instrument
 instrument12 - instrument
 satellite4 - satellite
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
