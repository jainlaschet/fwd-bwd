(define (problem strips-evolution-x-1)
   (:domain evolution-strips)
   (:objects pikachu caterpie pidgeotto bulbasaur charmander squirtle krabby raticate)
   (:init (evol_third pikachu)
          (evol_first caterpie)
          (evol_first pidgeotto)
          (evol_first bulbasaur)
          (evol_first charmander)
          (evol_first squirtle)
          (evol_first krabby)
          (evol_first raticate)
          (depend caterpie pikachu)
          (depend pidgeotto caterpie)
          (depend bulbasaur pidgeotto)
          (depend charmander bulbasaur)
          (depend squirtle charmander)
          (depend krabby squirtle)
          (depend raticate krabby))
   (:goal (evol_third raticate)))