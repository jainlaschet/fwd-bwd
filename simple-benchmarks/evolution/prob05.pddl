(define (problem strips-evolution-x-1)
   (:domain evolution-strips)
   (:objects pikachu caterpie pidgeotto bulbasaur charmander squirtle)
   (:init (evol_third pikachu)
          (evol_first caterpie)
          (evol_first pidgeotto)
          (evol_first bulbasaur)
          (evol_first charmander)
          (evol_first squirtle)
          (depend caterpie pikachu)
          (depend pidgeotto caterpie)
          (depend bulbasaur pidgeotto)
          (depend charmander bulbasaur)
          (depend squirtle charmander))
   (:goal (evol_third squirtle)))