grammar Test;

@header {
}

@members {
    static void p(String m) {
        System.out.println(m);
    }
    static int I(String s) {
        return Integer.parseInt(s);
    }
    static float F(String s) {
        return Float.parseFloat(s);
    }

    public static void main(String[] args) throws Exception {
        ANTLRInputStream input = new ANTLRInputStream(System.in);
        TestLexer lex = new TestLexer(input);
        CommonTokenStream tok = new CommonTokenStream(lex);
        TestParser parser = new TestParser(tok);

        parser.start();
    }
}

start : (expr {p("=" + $expr.v);})+ EOF
      ;

expr returns [float v]
    : a=NUM '+' b=NUM  {$v = I($a.text) + I($b.text);}
    | a=NUM '.' b=NUM { int n = $b.text.length();
                        $v = I($a.text) + F($b.text)/n;
                        p("debug" + F($a.text) + "," + F($b.text) + "," + n);
                      }
    | NUM {$v = I($NUM.text);}
    ;

NUM : ('0' .. '9') + ;
WS  : (' ' | '\t' | '\n' | '\r') {this.skip();};

