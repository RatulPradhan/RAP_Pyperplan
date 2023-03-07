;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 4 Op-blocks world
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; We have obs.dat observations: (unstack A B) (unstack C D)

(define (domain BLOCKS)
  (:requirements :strips :typing)
  (:types block seq-num)
  ;; 0 is the initial (nothing observed yet)
  ;; 1 is (unstack A B)
  ;; 2 is (unstack C D)
  (:constants 0 1 2 - seq-num
  	      ;;We need to move these here from the problem file because they are used in actions that match grounded observations
  	      A B C D - block)
  (:predicates (on ?x - block ?y - block)
	       (ontable ?x - block)
	       (clear ?x - block)
	       (handempty)
	       (holding ?x - block)
	       ;; Creates (observed 0), (observed 1), and (observed 2) due to the constants in this domain file
	       (observed ?n - seq-num)
	       )

  (:action pick-up
	     :parameters (?x - block)
	     :precondition (and (clear ?x) (ontable ?x) (handempty))
	     :effect
	     (and (not (ontable ?x))
		   (not (clear ?x))
		   (not (handempty))
		   (holding ?x)))

  (:action put-down
	     :parameters (?x - block)
	     :precondition (holding ?x)
	     :effect
	     (and (not (holding ?x))
		   (clear ?x)
		   (handempty)
		   (ontable ?x)))
  (:action stack
	     :parameters (?x - block ?y - block)
	     :precondition (and (holding ?x) (clear ?y))
	     :effect
	     (and (not (holding ?x))
		   (not (clear ?y))
		   (clear ?x)
		   (handempty)
		   (on ?x ?y)))
  (:action unstack
	     :parameters (?x - block ?y - block)
	     :precondition (and (on ?x ?y) (clear ?x) (handempty))
	     :effect
	     (and (holding ?x)
		   (clear ?y)
		   (not (clear ?x))
		   (not (handempty))
		   (not (on ?x ?y))))

  ;;Matches the first observation (unstack A B)
  (:action unstack1
	     :parameters (?x - block ?y - block)
	     :precondition (and (on ?x ?y) (clear ?x) (handempty)
	     		   ;;Saw no observations beforehand
	     		   (observed 0)
			   ;;Parameters must match the grounding of the observation to progress the observation sequence, not just any ordinary unstack action
			   (= ?x A)
			   (= ?y B)
			   )
	     :effect
	     (and (holding ?x)
		   (clear ?y)
		   (not (clear ?x))
		   (not (handempty))
		   (not (on ?x ?y)))
		   ;;Progress in the observation
		   (observed 1))

  ;;Matches the second observation (unstack C D)
  (:action unstack2
	     :parameters (?x - block ?y - block)
	     :precondition (and (on ?x ?y) (clear ?x) (handempty)
	     		   (observed 1)
			   (= ?x C)
			   (= ?y D))
	     :effect
	     (and (holding ?x)
		   (clear ?y)
		   (not (clear ?x))
		   (not (handempty))
		   (not (on ?x ?y)))
		   (observed 2))

)
