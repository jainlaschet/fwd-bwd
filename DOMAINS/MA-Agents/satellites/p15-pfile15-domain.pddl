(define (domain Kp15-pfile15)
(:requirements :strips :typing)
(:types OBJ
satellite - object
direction - object
instrument - object
mode - object)
(:constants
 planet11 - direction
 planet14 - direction
 planet17 - direction
 thermograph4 - mode
 star15 - direction
 star13 - direction
 star12 - direction
 phenomenon10 - direction
 thermograph3 - mode
 star19 - direction
 star18 - direction
 phenomenon16 - direction
 groundstation2 - direction
 groundstation0 - direction
 star4 - direction
 planet20 - direction
 planet21 - direction
 planet22 - direction
 planet23 - direction
 planet24 - direction
 planet7 - direction
 phenomenon5 - direction
 image1 - mode
 phenomenon9 - direction
 infrared0 - mode
 spectrograph2 - mode
 planet6 - direction
 star1 - direction
 star3 - direction
 star8 - direction
 satellite0 - satellite
 instrument0 - instrument
 instrument1 - instrument
 satellite1 - satellite
 instrument2 - instrument
 instrument3 - instrument
 satellite2 - satellite
 instrument4 - instrument
 instrument5 - instrument
 satellite3 - satellite
 instrument6 - instrument
 instrument8 - instrument
 instrument9 - instrument
 instrument7 - instrument
 satellite4 - satellite
 satellite5 - satellite
 instrument10 - instrument
 instrument11 - instrument
 instrument12 - instrument
 instrument14 - instrument
 instrument15 - instrument
 satellite6 - satellite
 instrument13 - instrument
 satellite7 - satellite
 instrument16 - instrument
 instrument17 - instrument
 instrument18 - instrument
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
