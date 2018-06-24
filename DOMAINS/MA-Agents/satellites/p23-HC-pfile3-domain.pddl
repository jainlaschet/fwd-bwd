(define (domain Kp23-HC-pfile3)
(:requirements :strips :typing)
(:types OBJ
satellite - object
direction - object
instrument - object
mode - object)
(:constants
 planet15 - direction
 planet14 - direction
 planet17 - direction
 phenomenon40 - direction
 planet19 - direction
 phenomenon36 - direction
 phenomenon34 - direction
 phenomenon32 - direction
 star39 - direction
 star37 - direction
 phenomenon38 - direction
 planet48 - direction
 planet42 - direction
 planet43 - direction
 planet41 - direction
 planet46 - direction
 planet20 - direction
 star25 - direction
 star49 - direction
 phenomenon28 - direction
 star47 - direction
 star45 - direction
 star4 - direction
 star1 - direction
 star0 - direction
 star3 - direction
 star2 - direction
 star9 - direction
 planet33 - direction
 planet31 - direction
 planet35 - direction
 phenomenon18 - direction
 star16 - direction
 star10 - direction
 star13 - direction
 spectrograph2 - mode
 star50 - direction
 star52 - direction
 star29 - direction
 phenomenon6 - direction
 phenomenon7 - direction
 phenomenon5 - direction
 image1 - mode
 phenomenon8 - direction
 star21 - direction
 star22 - direction
 star23 - direction
 star24 - direction
 phenomenon30 - direction
 star26 - direction
 star27 - direction
 planet51 - direction
 star12 - direction
 infrared0 - mode
 phenomenon44 - direction
 phenomenon11 - direction
 satellite0 - satellite
 instrument0 - instrument
 instrument1 - instrument
 instrument2 - instrument
 satellite1 - satellite
 instrument3 - instrument
 instrument4 - instrument
 satellite2 - satellite
 instrument6 - instrument
 instrument7 - instrument
 instrument5 - instrument
 satellite3 - satellite
 instrument8 - instrument
 instrument9 - instrument
 satellite4 - satellite
 instrument10 - instrument
 instrument11 - instrument
 instrument12 - instrument
 satellite5 - satellite
 instrument13 - instrument
 instrument14 - instrument
 satellite6 - satellite
 instrument15 - instrument
 instrument16 - instrument
 instrument17 - instrument
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
