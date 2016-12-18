domains
 list=integer*
predicates
 delete(list, integer, list)
 
clauses
 delete([], _Elem, []):-!.
  delete([Elem|Tail], Elem, ResultTail):- delete(Tail, Elem, ResultTail), !.
 delete([Head|Tail], Elem, [Head|ResultTail]):- delete(Tail, Elem, ResultTail). 
 
goal
 write("¬ведите число:"), readint(X), delete([5, 1, 5, 4, 5, 1, 8, 9], X, ResultList).