grammar Expr;

@header {
import org.antlr.v4.runtime.*;
}

@members {
    public static void main(String[] args) throws Exception {
        ANTLRInputStream input = new ANTLRInputStream(System.in);
        ExprLexer lex = new ExprLexer(input);
        CommonTokenStream tokens = new CommonTokenStream(lex);
        ExprParser p = new ExprParser(tokens);
        p.start();
    }
    public static void p(String s) {
        System.out.println(s);
    }
}

start returns [int a, float b]
locals [boolean x = true]
    : expr["aaa"]+ EOF {
    $a = 100;
    $b = 12.0f;
};

expr[String echo] returns [int v]
@init {
    $v = 0;
}
@after {
    p($echo + "=" + $v);
}
    : NUM '+' (e=expr["bbb"]) {p($e.text);}
    | NUM {$v = $NUM.int;}
    ;

NUM : ('0' .. '9')+ ;
WS  : (' ' | '\t' | '\n' | '\r')+ {skip();};

