domains
 tdata = data(string, real, string, real)
 tdatalist = tdata*
 
predicates
 nondeterm woman(string, real) 
 nondeterm man(string, real)    
 nondeterm getdata(tdata)
 getdatalist(tdatalist)
 nondeterm printlist(tdatalist)
 nondeterm printlist1(tdatalist)
 find_maxelem(tdatalist, tdata) 
 find_maxelem_re(tdatalist, tdata, tdata) 
 append(tdatalist, tdatalist, tdatalist)
 cut_elem(tdatalist, tdata, tdatalist)	
 cut_elem_re(tdatalist, tdatalist, tdata, tdatalist) 
 sort_list_desc(tdatalist, tdatalist) 
clauses
 woman("Galina", 23).
 woman("Katerina", 31).
 woman("Dasha", 21).
 woman("Nelly", 27).
 woman("Aleksandra", 18).
 man("Vladimir", 23).
 man("Sergey", 21).
 man("Petr", 31).
 man("Trofim", 27).
 man("Aleksey", 18).
 
 getdata(data(Man, ManA, Woman , WomanA)) :- man(Man, ManA), woman(Woman, WomanA).
 getdatalist(OrderList) :- findall(Order, getdata(Order), OrderList).
 

 find_maxelem([data(Man, ManA, Woman , WomanA)| Tail], Max) :- find_maxelem_re(Tail, data(Man, ManA, Woman , WomanA), Max).
 find_maxelem_re([], Max, Max).
 find_maxelem_re([data(Man, ManA, Woman , WomanA) | Tail], data(Man1, ManA1, Woman1 , WomanA1), Max) :- Man < Man1, find_maxelem_re(Tail, data(Man, ManA, Woman , WomanA), Max), !.
 find_maxelem_re([data(Man, ManA, Woman , WomanA) | Tail], data(Man1, ManA1, Woman1 , WomanA1), Max) :- Man = Man1,  find_maxelem_re(Tail,data(Man, ManA, Woman , WomanA), Max), !.
 find_maxelem_re([_ | Tail], CurMax, Max) :- find_maxelem_re(Tail, CurMax, Max).
 append([], List2, List2).
 append([data(Man, ManA, Woman , WomanA) | Tail1], List2, [data(Man, ManA, Woman , WomanA) | Tail3]) :- append(Tail1, List2, Tail3).
 
cut_elem(List, X, NewList) :- cut_elem_re([], List, X, NewList).
 cut_elem_re(Head, [], _, Head).	
 cut_elem_re(Head, [M | Tail], X, NewList) :- M = X, append(Head, Tail, NewList), !.
 cut_elem_re(Head, [M | Tail], X, NewList) :- append(Head, [M], NewHead), cut_elem_re(NewHead, Tail, X, NewList). 
 
 sort_list_desc([], []).
 sort_list_desc(List, Result) :- 
 	find_maxelem(List, Max),      
 	cut_elem(List, Max, Rest),    	
 	sort_list_desc(Rest, Result0), 	
 	Result = [Max | Result0].
 
 printlist([]).
 printlist([data(M, A, Woman , AW)|Tail]) :-  write(M ,"\t",A, "\t", Woman, AW), nl, printlist(Tail).
 
 printlist1([]).
 printlist1([data(M, A, Woman , AW)|Tail]) :-  (A-AW) > 5, printlist1(Tail), !.
 printlist1([data(M, A, Woman , AW)|Tail]) :-  (AW-A) > 5, printlist1(Tail), !. 
 printlist1([data(M, A, Woman , AW)|Tail]) :-  (A-AW) = 5, printlist1(Tail), !.
 printlist1([data(M, A, Woman , AW)|Tail]) :-  (AW-A) = 5, printlist1(Tail), !.
 printlist1([data(M, A, Woman , AW)|Tail]) :-  (A-AW) < 5, write(M ,"\t",A, "\t", Woman, AW), nl, printlist1(Tail), !.
  printlist1([data(M, A, Woman , AW)|Tail]) :-  (AW-A) < 5, write(M ,"\t",A, "\t", Woman, AW), nl, printlist1(Tail),! .
 
 
goal
 getdatalist(List), 
 printlist(List), 
 sort_list_desc(List, Result),
 write("*******************"), nl,
 printlist1(Result), 
 write("*******************"), nl, 
 fail.