DOMAINS
room =
  r1_entry; /* вход */
  r2_food; /* пища */
  r3_fountain; /* родник */
  r4_gold_treasure; /* клад */
  r5_paradise; /* райский уголок */
  r6_exit; /* выход */
  r7_monsters; /* монстр */
  r8_robbers; /* разбойники */
  r9_chasm; /* непроходимая пропасть */
  r10_swamp; /* глубокое непроходимое озеро */
  r11_gas; /* ядовитый газ */
  r12_anaconda; /* свирепая анаконда */
  r13_mermaid; /* горгона */
  r14_hell /* преисподняя */
roomlist = room*

PREDICATES
nondeterm gallery(room,room) /* Коридор между двумя пещерами */
nondeterm neighborroom(room,room)
  /* Предикат позволяет разрешить проход по коридору в обе стороны */
avoid(roomlist)
nondeterm go(room,room)
nondeterm route(room,room,roomlist)
  /* Предикат определяет маршрут, по которому следует идти.
   * roomlist - это список уже пройденных пещер. */
nondeterm member(room,roomlist)

CLAUSES
/* Объявление коридоров */
gallery(r1_entry,r7_monsters). gallery(r1_entry,r3_fountain).
gallery(r3_fountain,r14_hell). gallery(r3_fountain,r2_food).
gallery(r6_exit,r4_gold_treasure). gallery(r3_fountain,r13_mermaid).
gallery(r8_robbers,r4_gold_treasure). gallery(r3_fountain,r8_robbers).
gallery(r2_food,r4_gold_treasure). gallery(r13_mermaid,r6_exit).
gallery(r7_monsters,r4_gold_treasure). gallery(r4_gold_treasure,r6_exit).

neighborroom(X,Y):-gallery(X,Y).
neighborroom(X,Y):-gallery(Y,X).

/* Объявление списка запрещенных комнат */
avoid([r7_monsters,r8_robbers]).

go(Here,There):-route(Here,There,[Here]).

route(Room,Room,VisitedRooms):-
  member(r4_gold_treasure,VisitedRooms),
  write(VisitedRooms),nl.

route(Room,Way_out,VisitedRooms):-
  neighborroom(Room,Nextroom),
  avoid(DangerousRooms),
  not(member(NextRoom,DangerousRooms)),
  not(member(NextRoom,VisitedRooms)),
  route(NextRoom,Way_out,[NextRoom|VisitedRooms]).

member(X,[X|_]).
member(X,[_|H]):-member (X,H).

GOAL
go(r1_entry,r6_exit).
