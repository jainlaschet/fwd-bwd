(define (problem strips-evolution-x-1)
   (:domain evolution-strips)
   (:objects pikachu caterpie pidgeotto bulbasaur)
   (:init (evol_third pikachu)
          (evol_first caterpie)
          (evol_first pidgeotto)
          (evol_first bulbasaur)
          (depend caterpie pikachu)
          (depend pidgeotto caterpie)
          (depend bulbasaur pidgeotto))
   (:goal (evol_third bulbasaur)))