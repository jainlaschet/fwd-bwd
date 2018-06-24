(define (domain Kp11)
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
 camera3 - camera
 waypoint6 - waypoint
 rover3store - store
 low_res - mode
 waypoint5 - waypoint
 rover0store - store
 waypoint2 - waypoint
 waypoint0 - waypoint
 general - lander
 camera2 - camera
 waypoint1 - waypoint
 objective0 - objective
 colour - mode
 high_res - mode
 objective1 - objective
 camera1 - camera
 waypoint3 - waypoint
 objective2 - objective
 camera0 - camera
 rover2store - store
 waypoint7 - waypoint
 rover1store - store
 waypoint4 - waypoint
 rover0 - rover
 rover1 - rover
 rover2 - rover
 rover3 - rover
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
