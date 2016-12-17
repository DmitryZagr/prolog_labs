domains
 int, O, D, H, T, NUM = integer
 

predicates
 is_negative(int)
 is_not_null(int)
 is_null(int)
 is_incorrect(int)
 is_last_digit(int)
 is_not_last_digit(int)
 
 nondeterm analyze(int)
 nondeterm analyze_d(int)
 nondeterm analyze_h(int)
 nondeterm analyze_t(int)
 
clauses
 is_negative(INT):- INT < 0.
 is_not_null(INT):- INT <> 0.
 is_null(INT):- INT = 0.
 is_incorrect(INT):- INT > 9999.
 is_last_digit(INT):- INT <= 9, INT >= 0.
 is_not_last_digit(INT):- INT >= 10.
 
 analyze(INT):-is_negative(INT), write("Ошибка:Введено отрицательное число"), nl, !.
 analyze(INT):-is_null(INT), write("Введен ноль"), nl, !.
 analyze(INT):-is_incorrect(INT), write("Ошибка: введено число с большим количеством разрядов, "),
 										write("чем 4"), nl, !.						
 analyze(INT):-    O = INT mod 10, is_not_null(O), write("Единицы = "), write(O), nl, is_not_last_digit(INT), analyze_d(INT), !.
 analyze(INT):-    O = INT mod 10, is_null(O), is_not_last_digit(INT), analyze_d(INT), !. 
 analyze(INT):-    true, !.
 
 analyze_d(INT):-  D = (INT div 10) mod 10, is_not_null(D), write("Десятки = "), write(D), nl, NUM = INT div 10,
 											 is_not_last_digit(NUM), analyze_h(INT), !.
 analyze_d(INT):-  D = (INT div 10) mod 10, is_null(D), NUM = INT div 10, is_null(D), is_not_last_digit(NUM), analyze_h(INT).
 
 analyze_h(INT):-  H = (INT div 100) mod 10, is_not_null(H), write("Сотни = "), write(H), nl,
 									 NUM = INT div 100, is_not_last_digit(NUM), analyze_t(INT), !.
 analyze_h(INT):-  H = (INT div 100) mod 10, is_null(H), NUM = INT div 100, is_not_last_digit(NUM), analyze_t(INT).
 
 analyze_t(INT):-  T = (INT div 1000), write("Тысячи = "), write(T),  nl.
 
goal
 write("Enter integer: "), readint(X), write(X), nl, analyze(X).