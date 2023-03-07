(define (problem BLOCKS-4-0)
(:domain BLOCKS)
(:objects D B A C - block)
(:INIT (CLEAR C) (CLEAR A) (CLEAR B) (CLEAR D) (ONTABLE C) (ONTABLE A)
 (ONTABLE B) (ONTABLE D) (HANDEMPTY)
 ;;Nothing is observed yet
 (observed 0))
(:goal ;;Copied from one line of hyps.dat
       (AND (ON D C) (ON C B) (ON B A)
       ;;Do not observe the entire observation sequence
       (not (observed 2))))
)