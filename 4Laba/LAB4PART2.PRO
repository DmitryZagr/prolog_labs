database
  right(string, char) % ���������� ����� ������������ char �� ������ string
  wrong(string, char) % ������������ ����� ������������ char �� ������ string

predicates
  nondeterm data(string, char)
    /* �������� ������ ������ ������� � ���������� ����� �� ������. */
    
  process(string, char) % (Quest, Ans)
    /* �������� ��������� �� ���� ��� ���������:
     *   Quest    - ������ �������;
     *   Ans      - ���������� ����� �� ������.
     * �������� ������� ������ ������� �� �����, ������ � ���������� 
     * ����� ������������, ����� ������� ��� �� ����� � ��������� 
     * � ���� ������ ����� ���� � ������� ��������� updatebase. */
  
  updatebase(string, char, char) % (Quest, Ans, Key)
    /* �������� ��������� ��� ������� ���������: 
     *  Quest    - ������ �������;
     *  Ans      - ���������� ����� �� ������;
     *  Key      - �����, ������� ��� ������������.
     * ���� Key = Ans, �������� ��������� � ���� ������ ���� 
     * right(Quest, Key), 
     * � ��������� ������ �������� ��������� � ���� ������ ����
     * wrong(Quest, Key).
     *
     * ��� ���������� ����� � ���� ������ ����������� ���������� ��������
     * ������� assertz, ��������:
     *   assertz(right(Quest, Key))
     *
     * � ������� � ������������ ���� ������ ����� �������� ��� � �������� 
     * �������, � ���������, ����� ���������� � ��� �� ������ ����������.
     */
     
  nondeterm right_list(integer)
    /* �������� ���������� ��� ����� right, ������� ������ �� ��� �� ����� 
     * � ���������� �� ����������. 
     * 
     * ����� ������ ���� ���������� ������ ���� ���, ����� ��������� ������� 
     * ����� ����� ������� ���� �� ���� ������ � ������� ����������� 
     * ��������� ������� retract, ��������: 
     *   retract(right(Quest, Key)) */
    
  nondeterm wrong_list(integer)
    /* �������� ���������� ��� ����� wrong, ������� ������ �� ��� �� ����� 
     * � ���������� �� ���������� */
    
  nondeterm summarize
    /* �������� ������� �� ����� ������ ��������� ���������� ��������, 
     * ������ ����������� ���������� �������� � ���� ���������� �������. */
  
clauses
  data("Question1", 'y').
  data("Question2", 'y').
  data("Question3", 'n').
  data("Question4", 'n').
  data("Question5", 'y').
  data("Question6", 'y').
  data("Question7", 'n').
  data("Question8", 'y').
  
  
  summarize :- 
    nl, write("����� ���������� �������:"), nl,
    right_list(RightNumber), 
    nl, write("������� ���������� �������:"), nl,
    wrong_list(WrongNumber), 
    Accuracy = RightNumber / (RightNumber + WrongNumber) * 100, 
    writef("�������� ������� = %3.0f%%", Accuracy), nl.
  
goal
  write("�� �������������..."), nl, fail; 
  data(Quest, Ans), process(Quest, Ans), fail;
  summarize.
