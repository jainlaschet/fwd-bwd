(define (domain Kp14-pfile14)
(:requirements :strips :typing)
(:types OBJ
satellite - object
direction - object
instrument - object
mode - object)
(:constants
 planet15 - direction
 planet17 - direction
 planet16 - direction
 phenomenon18 - direction
 star14 - direction
 star10 - direction
 thermograph0 - mode
 phenomenon12 - direction
 phenomenon13 - direction
 star19 - direction
 thermograph4 - mode
 groundstation4 - direction
 groundstation3 - direction
 groundstation2 - direction
 groundstation1 - direction
 groundstation0 - direction
 planet21 - direction
 planet23 - direction
 phenomenon6 - direction
 phenomenon7 - direction
 phenomenon5 - direction
 image2 - mode
 image1 - mode
 planet8 - direction
 star20 - direction
 star22 - direction
 star24 - direction
 phenomenon11 - direction
 star9 - direction
 thermograph3 - mode
 satellite0 - satellite
 instrument2 - instrument
 instrument0 - instrument
 instrument1 - instrument
 instrument3 - instrument
 satellite1 - satellite
 satellite2 - satellite
 instrument6 - instrument
 instrument4 - instrument
 instrument5 - instrument
 satellite3 - satellite
 instrument8 - instrument
 instrument7 - instrument
 instrument9 - instrument
 instrument10 - instrument
 satellite4 - satellite
 satellite5 - satellite
 instrument11 - instrument
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
