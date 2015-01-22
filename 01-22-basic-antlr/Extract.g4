grammar Extract;

// Nonterminals start with lowercase

sentence : thing+
         ;

thing : Type { System.out.println("type:" + $Type.text); }
      | Num  { System.out.println("num:" + $Num.text); }
      | Any
      ;

// Terminals rules start with uppercase
Type : 'int'
     | 'char'
     ;

Num : ('0' .. '9')+
    ;

Whitespace : (' ' | '\t' | '\n' | '\r')+ { skip(); };

Any : .
    ;
