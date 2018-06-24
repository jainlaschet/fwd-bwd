(define (domain Kp16-pfile16)
(:requirements :strips :typing)
(:types OBJ
satellite - object
direction - object
instrument - object
mode - object)
(:constants
 planet11 - direction
 planet10 - direction
 planet19 - direction
 phenomenon18 - direction
 star14 - direction
 star16 - direction
 star13 - direction
 star12 - direction
 thermograph1 - mode
 phenomenon17 - direction
 groundstation4 - direction
 groundstation1 - direction
 groundstation0 - direction
 star15 - direction
 planet21 - direction
 planet22 - direction
 planet7 - direction
 phenomenon5 - direction
 image2 - mode
 image0 - mode
 planet8 - direction
 phenomenon9 - direction
 star20 - direction
 phenomenon23 - direction
 star24 - direction
 infrared4 - mode
 spectrograph3 - mode
 planet6 - direction
 star3 - direction
 star2 - direction
 instrument2 - instrument
 instrument0 - instrument
 satellite0 - satellite
 instrument1 - instrument
 instrument3 - instrument
 satellite1 - satellite
 instrument4 - instrument
 instrument5 - instrument
 satellite2 - satellite
 instrument6 - instrument
 satellite3 - satellite
 instrument7 - instrument
 instrument8 - instrument
 instrument9 - instrument
 instrument10 - instrument
 satellite4 - satellite
 satellite5 - satellite
 instrument11 - instrument
 instrument12 - instrument
 instrument13 - instrument
 instrument14 - instrument
 instrument15 - instrument
 instrument16 - instrument
 satellite6 - satellite
 satellite7 - satellite
 instrument17 - instrument
 instrument18 - instrument
 satellite8 - satellite
 instrument21 - instrument
 instrument19 - instrument
 instrument20 - instrument
 satellite9 - satellite
 instrument22 - instrument
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
