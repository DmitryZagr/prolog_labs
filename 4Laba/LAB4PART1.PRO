DOMAINS
room =
  r1_entry; /* ���� */
  r2_food; /* ���� */
  r3_fountain; /* ������ */
  r4_gold_treasure; /* ���� */
  r5_paradise; /* ������� ������ */
  r6_exit; /* ����� */
  r7_monsters; /* ������ */
  r8_robbers; /* ���������� */
  r9_chasm; /* ������������ �������� */
  r10_swamp; /* �������� ������������ ����� */
  r11_gas; /* �������� ��� */
  r12_anaconda; /* �������� �������� */
  r13_mermaid; /* ������� */
  r14_hell /* ����������� */
roomlist = room*

PREDICATES
nondeterm gallery(room,room) /* ������� ����� ����� �������� */
nondeterm neighborroom(room,room)
  /* �������� ��������� ��������� ������ �� �������� � ��� ������� */
avoid(roomlist)
nondeterm go(room,room)
nondeterm route(room,room,roomlist)
  /* �������� ���������� �������, �� �������� ������� ����.
   * roomlist - ��� ������ ��� ���������� �����. */
nondeterm member(room,roomlist)

CLAUSES
/* ���������� ��������� */
gallery(r1_entry,r4_gold_treasure). gallery(r4_gold_treasure, r5_paradise).
gallery(r5_paradise,r2_food). gallery(r2_food,r6_exit).

neighborroom(X,Y):-gallery(X,Y).
neighborroom(X,Y):-gallery(Y,X).

/* ���������� ������ ����������� ������ */
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
