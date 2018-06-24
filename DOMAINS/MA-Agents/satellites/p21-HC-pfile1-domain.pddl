(define (domain Kp21-HC-pfile1)
(:requirements :strips :typing)
(:types OBJ
satellite - object
direction - object
instrument - object
mode - object)
(:constants
 planet11 - direction
 planet13 - direction
 planet38 - direction
 planet14 - direction
 planet19 - direction
 planet24 - direction
 planet31 - direction
 planet37 - direction
 planet39 - direction
 planet34 - direction
 star36 - direction
 star15 - direction
 phenomenon35 - direction
 phenomenon32 - direction
 star10 - direction
 thermograph0 - mode
 phenomenon12 - direction
 star33 - direction
 phenomenon16 - direction
 star30 - direction
 planet42 - direction
 groundstation2 - direction
 groundstation1 - direction
 phenomenon18 - direction
 star21 - direction
 planet22 - direction
 planet26 - direction
 planet27 - direction
 phenomenon6 - direction
 planet7 - direction
 image1 - mode
 planet8 - direction
 phenomenon20 - direction
 phenomenon25 - direction
 phenomenon29 - direction
 phenomenon28 - direction
 planet23 - direction
 star41 - direction
 phenomenon17 - direction
 phenomenon4 - direction
 star5 - direction
 spectrograph2 - mode
 star0 - direction
 phenomenon40 - direction
 star9 - direction
 phenomenon3 - direction
 satellite0 - satellite
 instrument0 - instrument
 instrument1 - instrument
 instrument2 - instrument
 satellite1 - satellite
 instrument3 - instrument
 instrument4 - instrument
 instrument5 - instrument
 satellite2 - satellite
 instrument6 - instrument
 instrument7 - instrument
 satellite3 - satellite
 instrument8 - instrument
 satellite4 - satellite
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
