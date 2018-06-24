(define (domain Kp20-pfile20)
(:requirements :strips :typing)
(:types OBJ
satellite - object
direction - object
instrument - object
mode - object)
(:constants
 planet13 - direction
 planet15 - direction
 planet17 - direction
 planet18 - direction
 phenomenon19 - direction
 star16 - direction
 star11 - direction
 star10 - direction
 phenomenon12 - direction
 phenomenon14 - direction
 thermograph7 - mode
 star6 - direction
 groundstation3 - direction
 groundstation1 - direction
 star0 - direction
 phenomenon21 - direction
 thermograph8 - mode
 planet22 - direction
 planet7 - direction
 phenomenon5 - direction
 image3 - mode
 image2 - mode
 planet9 - direction
 phenomenon8 - direction
 image4 - mode
 star20 - direction
 star23 - direction
 star24 - direction
 infrared9 - mode
 infrared5 - mode
 infrared1 - mode
 star4 - direction
 spectrograph0 - mode
 spectrograph6 - mode
 star2 - direction
 instrument8 - instrument
 instrument9 - instrument
 instrument2 - instrument
 instrument3 - instrument
 instrument0 - instrument
 instrument1 - instrument
 instrument6 - instrument
 instrument7 - instrument
 instrument4 - instrument
 instrument5 - instrument
 satellite0 - satellite
 satellite1 - satellite
 instrument14 - instrument
 instrument15 - instrument
 instrument10 - instrument
 instrument11 - instrument
 instrument12 - instrument
 instrument13 - instrument
 satellite2 - satellite
 instrument16 - instrument
 instrument17 - instrument
 instrument18 - instrument
 instrument19 - instrument
 satellite3 - satellite
 instrument21 - instrument
 instrument20 - instrument
 instrument25 - instrument
 instrument24 - instrument
 instrument27 - instrument
 instrument26 - instrument
 instrument23 - instrument
 instrument22 - instrument
 instrument28 - instrument
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
