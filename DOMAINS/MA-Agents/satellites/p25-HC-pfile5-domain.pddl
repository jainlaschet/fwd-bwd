(define (domain Kp25-HC-pfile5)
(:requirements :strips :typing)
(:types OBJ
satellite - object
direction - object
instrument - object
mode - object)
(:constants
 star52 - direction
 planet16 - direction
 planet18 - direction
 star54 - direction
 phenomenon33 - direction
 star38 - direction
 star37 - direction
 thermograph0 - mode
 star34 - direction
 star69 - direction
 phenomenon70 - direction
 phenomenon71 - direction
 phenomenon49 - direction
 groundstation2 - direction
 groundstation1 - direction
 groundstation0 - direction
 planet66 - direction
 planet67 - direction
 planet60 - direction
 planet61 - direction
 planet62 - direction
 planet63 - direction
 planet68 - direction
 planet27 - direction
 phenomenon6 - direction
 star48 - direction
 phenomenon22 - direction
 phenomenon26 - direction
 phenomenon29 - direction
 phenomenon28 - direction
 star41 - direction
 star46 - direction
 star47 - direction
 star44 - direction
 star45 - direction
 star4 - direction
 spectrograph1 - mode
 star3 - direction
 planet57 - direction
 planet51 - direction
 planet53 - direction
 planet39 - direction
 planet72 - direction
 planet32 - direction
 planet31 - direction
 planet30 - direction
 planet35 - direction
 star59 - direction
 star14 - direction
 star17 - direction
 star11 - direction
 star12 - direction
 phenomenon10 - direction
 star50 - direction
 phenomenon13 - direction
 star19 - direction
 phenomenon15 - direction
 star56 - direction
 phenomenon55 - direction
 planet36 - direction
 phenomenon58 - direction
 star64 - direction
 star65 - direction
 phenomenon5 - direction
 image2 - mode
 planet9 - direction
 star7 - direction
 phenomenon8 - direction
 star20 - direction
 star21 - direction
 star23 - direction
 star24 - direction
 star25 - direction
 phenomenon43 - direction
 phenomenon42 - direction
 phenomenon40 - direction
 satellite0 - satellite
 instrument0 - instrument
 satellite1 - satellite
 instrument2 - instrument
 instrument3 - instrument
 instrument1 - instrument
 satellite2 - satellite
 instrument5 - instrument
 instrument4 - instrument
 satellite3 - satellite
 instrument6 - instrument
 instrument7 - instrument
 satellite4 - satellite
 instrument8 - instrument
 instrument9 - instrument
 instrument10 - instrument
 satellite5 - satellite
 instrument11 - instrument
 satellite6 - satellite
 instrument12 - instrument
 instrument13 - instrument
 instrument14 - instrument
 satellite7 - satellite
 instrument15 - instrument
 instrument16 - instrument
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
