database
  right(string, char) % правильный ответ пользовател€ char на вопрос string
  wrong(string, char) % неправильный ответ пользовател€ char на вопрос string

predicates
  nondeterm data(string, char)
    /* ѕредикат задает строку вопроса и правильный ответ на вопрос. */
    
  process(string, char) % (Quest, Ans)
    /* ѕредикат принимает на вход два параметра:
     *   Quest    - строка вопроса;
     *   Ans      - правильный ответ на вопрос.
     * ѕредикат выводит строку вопроса на экран, вводит с клавиатуры 
     * ответ пользовател€, также выводит его на экран и добавл€ет 
     * в базу данных новый факт с помощью предиката updatebase. */
  
  updatebase(string, char, char) % (Quest, Ans, Key)
    /* ѕредикат принимает три входных параметра: 
     *  Quest    - строка вопроса;
     *  Ans      - правильный ответ на вопрос;
     *  Key      - ответ, который дал пользователь.
     * ≈сли Key = Ans, предикат добавл€ет в базу данных факт 
     * right(Quest, Key), 
     * ¬ противном случае предикат добавл€ет в базу данных факт
     * wrong(Quest, Key).
     *
     * ƒл€ добавлени€ факта в базу данных используйте встроенный предикат
     * ѕролога assertz, например:
     *   assertz(right(Quest, Key))
     *
     * — фактами в динамической базе данных можно работать как с обычными 
     * фактами, в частности, можно обращатьс€ к ним из других предикатов.
     */
     
  nondeterm right_list(integer)
    /* ѕредикат перебирает все факты right, выводит каждый из них на экран 
     * и возвращает их количество. 
     * 
     * „тобы каждый факт учитывалс€ только один раз, после обработки каждого 
     * факта можно удал€ть факт из базы данных с помощью встроенного 
     * предиката ѕролога retract, например: 
     *   retract(right(Quest, Key)) */
    
  nondeterm wrong_list(integer)
    /* ѕредикат перебирает все факты wrong, выводит каждый из них на экран 
     * и возвращает их количество */
    
  nondeterm summarize
    /* ѕредикат выводит на экран список правильно отвеченных вопросов, 
     * список неправильно отвеченных вопросов и долю правильных ответов. */
  
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
    nl, write("¬ерно отвеченные вопросы:"), nl,
    right_list(RightNumber), 
    nl, write("Ќеверно отвеченные вопросы:"), nl,
    wrong_list(WrongNumber), 
    Accuracy = RightNumber / (RightNumber + WrongNumber) * 100, 
    writef("“очность ответов = %3.0f%%", Accuracy), nl.
  
goal
  write("¬ы интересуетесь..."), nl, fail; 
  data(Quest, Ans), process(Quest, Ans), fail;
  summarize.

