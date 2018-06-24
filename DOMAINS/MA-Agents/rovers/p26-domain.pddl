(define (domain Kp26)
(:requirements :strips :typing)
(:types OBJ
rover - object
waypoint - object
store - object
camera - object
mode - object
lander - object
objective - object)
(:constants
 rover7store - store
 rover3store - store
 rover4store - store
 rover9store - store
 high_res - mode
 rover2store - store
 low_res - mode
 rover5store - store
 objective1 - objective
 objective0 - objective
 objective3 - objective
 objective2 - objective
 objective5 - objective
 objective4 - objective
 camera0 - camera
 rover8store - store
 camera1 - camera
 waypoint12 - waypoint
 camera3 - camera
 camera2 - camera
 rover0store - store
 general - lander
 camera6 - camera
 rover6store - store
 waypoint25 - waypoint
 waypoint24 - waypoint
 waypoint27 - waypoint
 waypoint26 - waypoint
 waypoint21 - waypoint
 waypoint20 - waypoint
 waypoint23 - waypoint
 waypoint22 - waypoint
 waypoint29 - waypoint
 waypoint28 - waypoint
 camera4 - camera
 waypoint8 - waypoint
 waypoint9 - waypoint
 waypoint6 - waypoint
 waypoint7 - waypoint
 waypoint4 - waypoint
 waypoint5 - waypoint
 waypoint2 - waypoint
 waypoint3 - waypoint
 waypoint0 - waypoint
 waypoint1 - waypoint
 waypoint18 - waypoint
 waypoint19 - waypoint
 camera5 - camera
 waypoint10 - waypoint
 waypoint11 - waypoint
 colour - mode
 waypoint13 - waypoint
 waypoint14 - waypoint
 waypoint15 - waypoint
 waypoint16 - waypoint
 waypoint17 - waypoint
 rover1store - store
 rover0 - rover
 rover1 - rover
 rover2 - rover
 rover3 - rover
 rover4 - rover
 rover5 - rover
 rover6 - rover
 rover7 - rover
 rover8 - rover
 rover9 - rover
)

(:predicates
(visible ?w - waypoint ?p - waypoint)
(visible_from ?o - objective ?w - waypoint)
(at_rock_sample ?w - waypoint)
(at_soil_sample ?w - waypoint)
(at_lander ?x - lander ?y - waypoint)
(communicated_image_data ?o - objective ?m - mode)
(communicated_rock_data ?w - waypoint)
(communicated_soil_data ?w - waypoint)
(empty ?s - store)
(full ?s - store)
(supports ?c - camera ?m - mode)
(calibration_target ?i - camera ?o - objective)
(channel_free ?l - lander)
(at ?agent - rover ?y - waypoint)
(can_traverse ?agent - rover ?x - waypoint ?y - waypoint)
(equipped_for_soil_analysis ?agent - rover)
(equipped_for_rock_analysis ?agent - rover)
(equipped_for_imaging ?agent - rover)
(have_rock_analysis ?agent - rover ?w - waypoint)
(have_soil_analysis ?agent - rover ?w - waypoint)
(calibrated ?c - camera ?agent - rover)
(available ?agent - rover)
(have_image ?agent - rover ?o - objective ?m - mode)
(store_of ?s - store ?agent - rover)
(on_board ?i - camera ?agent - rover)
)

(:action navigate
:parameters ( ?x - rover ?y - waypoint ?z - waypoint)
:precondition 
(and (can_traverse ?x ?y ?z) (available ?x) (at ?x ?y) (visible ?y ?z))
:effect 
(and (not (at ?x ?y)) (at ?x ?z))
)

(:action sample_soil
:parameters ( ?x - rover ?s - store ?p - waypoint)
:precondition 
(and (at ?x ?p) (at_soil_sample ?p) (equipped_for_soil_analysis ?x) (store_of ?s ?x) (empty ?s))
:effect 
(and (not (empty ?s)) (full ?s) (have_soil_analysis ?x ?p) (not (at_soil_sample ?p)))
)

(:action sample_rock
:parameters ( ?x - rover ?s - store ?p - waypoint)
:precondition 
(and (at ?x ?p) (at_rock_sample ?p) (equipped_for_rock_analysis ?x) (store_of ?s ?x) (empty ?s))
:effect 
(and (not (empty ?s)) (full ?s) (have_rock_analysis ?x ?p) (not (at_rock_sample ?p)))
)

(:action drop
:parameters ( ?x - rover ?y - store)
:precondition 
(and (store_of ?y ?x) (full ?y))
:effect 
(and (not (full ?y)) (empty ?y))
)

(:action calibrate
:parameters ( ?r - rover ?i - camera ?t - objective ?w - waypoint)
:precondition 
(and (equipped_for_imaging ?r) (calibration_target ?i ?t) (at ?r ?w) (visible_from ?t ?w) (on_board ?i ?r))
:effect (calibrated ?i ?r)
)

(:action take_image
:parameters ( ?r - rover ?p - waypoint ?o - objective ?i - camera ?m - mode)
:precondition 
(and (calibrated ?i ?r) (on_board ?i ?r) (equipped_for_imaging ?r) (supports ?i ?m) (visible_from ?o ?p) (at ?r ?p))
:effect 
(and (have_image ?r ?o ?m) (not (calibrated ?i ?r)))
)

(:action communicate_soil_data
:parameters ( ?r - rover ?l - lander ?p - waypoint ?x - waypoint ?y - waypoint)
:precondition 
(and (at ?r ?x) (at_lander ?l ?y) (have_soil_analysis ?r ?p) (visible ?x ?y) (available ?r) (channel_free ?l))
:effect 
(and (not (available ?r)) (not (channel_free ?l)) (channel_free ?l) (communicated_soil_data ?p) (available ?r))
)

(:action communicate_rock_data
:parameters ( ?r - rover ?l - lander ?p - waypoint ?x - waypoint ?y - waypoint)
:precondition 
(and (at ?r ?x) (at_lander ?l ?y) (have_rock_analysis ?r ?p) (visible ?x ?y) (available ?r) (channel_free ?l))
:effect 
(and (not (available ?r)) (not (channel_free ?l)) (channel_free ?l) (communicated_rock_data ?p) (available ?r))
)

(:action communicate_image_data
:parameters ( ?r - rover ?l - lander ?o - objective ?m - mode ?x - waypoint ?y - waypoint)
:precondition 
(and (at ?r ?x) (at_lander ?l ?y) (have_image ?r ?o ?m) (visible ?x ?y) (available ?r) (channel_free ?l))
:effect 
(and (not (available ?r)) (not (channel_free ?l)) (channel_free ?l) (communicated_image_data ?o ?m) (available ?r))
)

)
