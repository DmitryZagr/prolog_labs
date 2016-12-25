domains
  tdata = data(string, integer)
  tdatalist = tdata*
  
predicates
  nondeterm price(string, real)    % tovar, tsena
  nondeterm order(string, integer) % tovar, kolichestvo
  nondeterm getdata(tdata)
  getdatalist(tdatalist)
  nondeterm printlist(tdatalist)
  nondeterm calculate(tdatalist, real)
  
clauses
  price("notebook", 0.5).
  price("pen", 1.0).
  price("eraser", 1.0).
  price("ruler", 0.5).
  price("calculator", 2.0).
  
  order("notebook", 5).
  order("notebook", 4).
  order("pen", 12).
  order("ruler", 0).
  order("eraser", 1).
  order("pen", 3).
  
  getdata(data(Product, Qty)) :- order(Product, Qty), Qty > 0.
  getdatalist(OrderList) :- findall(Order, getdata(Order), OrderList).
  
  printlist([]).
  printlist([data(Product,Qty)|Tail]) :- write(Product,"\t",Qty), nl, printlist(Tail).
  
  calculate([], 0).
  calculate([data(Product,Qty)|Tail], Sum) :- calculate(Tail, TailSum), price(Product, HowMuch), Sum = TailSum + HowMuch * Qty.
  
goal
  getdatalist(List), 
  printlist(List), 
  calculate(List, Sum), 
  write("*******************"), nl,
  write("Order Cost = ", Sum), nl,
  write("*******************"), nl, 
  fail.
  