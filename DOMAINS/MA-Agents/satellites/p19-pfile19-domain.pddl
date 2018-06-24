(define (domain Kp19-pfile19)
(:requirements :strips :typing)
(:types OBJ
satellite - object
direction - object
instrument - object
mode - object)
(:constants
 planet15 - direction
 planet17 - direction
 star14 - direction
 star16 - direction
 star10 - direction
 star12 - direction
 thermograph1 - mode
 phenomenon11 - direction
 phenomenon13 - direction
 star19 - direction
 star18 - direction
 star6 - direction
 phenomenon8 - direction
 groundstation4 - direction
 groundstation0 - direction
 planet21 - direction
 planet22 - direction
 phenomenon7 - direction
 phenomenon5 - direction
 planet9 - direction
 image5 - mode
 image4 - mode
 phenomenon20 - direction
 star23 - direction
 phenomenon24 - direction
 infrared7 - mode
 infrared2 - mode
 infrared3 - mode
 spectrograph0 - mode
 star1 - direction
 spectrograph6 - mode
 star3 - direction
 star2 - direction
 satellite0 - satellite
 instrument2 - instrument
 instrument0 - instrument
 instrument1 - instrument
 instrument3 - instrument
 instrument6 - instrument
 instrument7 - instrument
 instrument4 - instrument
 instrument5 - instrument
 satellite1 - satellite
 instrument8 - instrument
 instrument9 - instrument
 satellite2 - satellite
 instrument10 - instrument
 instrument11 - instrument
 instrument12 - instrument
 instrument13 - instrument
 satellite3 - satellite
 instrument21 - instrument
 instrument20 - instrument
 instrument15 - instrument
 instrument14 - instrument
 instrument18 - instrument
 instrument16 - instrument
 instrument17 - instrument
 instrument19 - instrument
 instrument24 - instrument
 instrument22 - instrument
 instrument23 - instrument
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
