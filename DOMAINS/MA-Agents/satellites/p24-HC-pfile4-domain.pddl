(define (domain Kp24-HC-pfile4)
(:requirements :strips :typing)
(:types OBJ
satellite - object
direction - object
instrument - object
mode - object)
(:constants
 planet11 - direction
 planet10 - direction
 planet12 - direction
 planet16 - direction
 planet19 - direction
 planet18 - direction
 star54 - direction
 star70 - direction
 phenomenon34 - direction
 phenomenon33 - direction
 star38 - direction
 star37 - direction
 star35 - direction
 thermograph2 - mode
 star31 - direction
 star30 - direction
 phenomenon72 - direction
 planet48 - direction
 planet49 - direction
 planet42 - direction
 planet41 - direction
 groundstation1 - direction
 planet64 - direction
 planet29 - direction
 planet67 - direction
 planet63 - direction
 planet21 - direction
 planet68 - direction
 planet25 - direction
 phenomenon20 - direction
 phenomenon69 - direction
 phenomenon26 - direction
 star40 - direction
 phenomenon61 - direction
 phenomenon60 - direction
 phenomenon62 - direction
 star4 - direction
 star7 - direction
 star6 - direction
 planet44 - direction
 star2 - direction
 planet56 - direction
 planet50 - direction
 planet28 - direction
 planet39 - direction
 planet71 - direction
 planet32 - direction
 planet36 - direction
 star59 - direction
 star58 - direction
 star17 - direction
 star53 - direction
 phenomenon13 - direction
 phenomenon14 - direction
 phenomenon15 - direction
 phenomenon55 - direction
 phenomenon57 - direction
 phenomenon51 - direction
 phenomenon52 - direction
 star0 - direction
 planet24 - direction
 planet5 - direction
 star65 - direction
 star66 - direction
 planet3 - direction
 phenomenon8 - direction
 phenomenon9 - direction
 star22 - direction
 star23 - direction
 star27 - direction
 infrared0 - mode
 infrared1 - mode
 phenomenon47 - direction
 phenomenon46 - direction
 phenomenon45 - direction
 phenomenon43 - direction
 satellite0 - satellite
 instrument0 - instrument
 instrument1 - instrument
 satellite1 - satellite
 instrument3 - instrument
 instrument2 - instrument
 satellite2 - satellite
 instrument4 - instrument
 instrument5 - instrument
 satellite3 - satellite
 instrument7 - instrument
 instrument6 - instrument
 satellite4 - satellite
 instrument8 - instrument
 satellite5 - satellite
 instrument9 - instrument
 instrument10 - instrument
 instrument11 - instrument
 satellite6 - satellite
 instrument14 - instrument
 instrument12 - instrument
 instrument13 - instrument
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
