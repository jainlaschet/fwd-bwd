(define (domain Kp22-HC-pfile2)
(:requirements :strips :typing)
(:types OBJ
satellite - object
direction - object
instrument - object
mode - object)
(:constants
 planet13 - direction
 planet12 - direction
 planet17 - direction
 phenomenon32 - direction
 phenomenon30 - direction
 phenomenon31 - direction
 star37 - direction
 star36 - direction
 phenomenon38 - direction
 planet49 - direction
 planet46 - direction
 groundstation2 - direction
 groundstation1 - direction
 planet45 - direction
 planet29 - direction
 planet21 - direction
 planet22 - direction
 phenomenon20 - direction
 phenomenon23 - direction
 phenomenon24 - direction
 phenomenon27 - direction
 phenomenon26 - direction
 star42 - direction
 star40 - direction
 star41 - direction
 star44 - direction
 star7 - direction
 star0 - direction
 planet51 - direction
 planet50 - direction
 planet39 - direction
 planet33 - direction
 planet35 - direction
 planet34 - direction
 star15 - direction
 phenomenon19 - direction
 star16 - direction
 star11 - direction
 star10 - direction
 phenomenon14 - direction
 star18 - direction
 phenomenon52 - direction
 phenomenon6 - direction
 planet4 - direction
 phenomenon5 - direction
 planet3 - direction
 image2 - mode
 planet9 - direction
 planet8 - direction
 star25 - direction
 star28 - direction
 infrared0 - mode
 infrared1 - mode
 phenomenon47 - direction
 phenomenon43 - direction
 phenomenon48 - direction
 satellite0 - satellite
 instrument0 - instrument
 satellite1 - satellite
 instrument1 - instrument
 instrument2 - instrument
 satellite2 - satellite
 instrument3 - instrument
 instrument4 - instrument
 instrument5 - instrument
 satellite3 - satellite
 instrument6 - instrument
 instrument7 - instrument
 satellite4 - satellite
 instrument8 - instrument
 instrument9 - instrument
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
