grammar Gen;

@header {
    import java.util.*;
}

@members {
    static int addr_index = 0;
    static int gen_address() {
        return (addr_index ++);
    }

    // a class for bytecode instructions
    static String iload(int addr) {
        return "iload " + addr;
    }
    static String istore(int addr) {
        return "istore " + addr;
    }
    static String iadd() {
        return "iadd";
    }
    static String imul() {
        return "imul";
    }
    static String ldc(int x) {
        return "ldc " + x;
    }

    static HashMap<String, Integer> symbolTable 
        = new HashMap<String, Integer>();


    // generated code fragments
    static class Code {
        List<String> block;
        int addr;
        public Code() {
            this.block = new ArrayList<String>();
        }
        public void extend(List<String> block) {
            this.block.addAll(block);
        }
        public void append(String... stmts) {
            for(String stmt : stmts)
                this.block.add(stmt);
        }

        public void gen() {

echo(".class public Hello");
echo(".super java/lang/Object");
echo("");
echo(".method public <init>()V");
echo("aload_0");
echo("invokenonvirtual java/lang/Object/<init>()V");
echo("return");
echo(".end method");
echo("");
echo(".method public static main([Ljava/lang/String;)V");
echo(".limit stack 10");
echo(".limit locals 100");
echo("");

for(String i : this.block) echo(i);

echo("getstatic java/lang/System/out Ljava/io/PrintStream;");
echo("ldc \"Hello World\"");
echo("invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V");
echo("return");
echo(".end method");
        }
    }

    // the executable main
    public static void main(String[] args) 
                                throws Exception {
        ANTLRInputStream input = 
            new ANTLRInputStream( System.in);

        GenLexer lexer = new GenLexer(input);

        CommonTokenStream tokens =
            new CommonTokenStream(lexer);

        GenParser parser = new GenParser(tokens);

        parser.prog();
    }

    public static void echo(String message) {
        System.out.println(message);
    }
}


prog : 
    expr ';' { $expr.code.gen(); }
    <EOF>;

expr returns [Code code]
@init { $code = new Code(); }
    : t=term '+' e=expr
            {
                int addr = gen_address();
                $code.extend($t.code.block);
                $code.extend($e.code.block);

                $code.append(
                    iload($t.code.addr),
                    iload($e.code.addr),
                    iadd(),
                    istore(addr));
                $code.addr = addr;
            }
    | t=term { $code = $t.code; }
    ;

term returns [Code code]
@init { $code = new Code(); }
    : f=factor '*' t=term
        {
            int addr = gen_address();
            $code.extend($f.code.block);
            $code.extend($t.code.block);
            $code.append(
                iload($f.code.addr),
                iload($t.code.addr),
                imul(),
                istore(addr));
            $code.addr = addr;
        }
    | f=factor {$code = $f.code;}
    ;

factor returns [Code code]
@init { $code = new Code(); }
    : '(' expr ')'
        {
            $code = $expr.code;
        }
    | NUM
        {
            int addr = gen_address();
            $code.append(
                ldc($NUM.int),
                istore(addr));
            $code.addr = addr;
        }
    | ID
        {
            String name = $ID.text;
            if(symbolTable.containsKey(name))
              $code.addr = symbolTable.get(name);
            else {
              int addr = gen_address();
              $code.addr = addr;
              $code.append(
                  ldc(0),
                  istore(addr));
            }
        }
    ;
    
NUM : ('0' .. '9') + ;
ID : ('a' .. 'z') +;
WS : (' ' | '\t' | '\n' | '\r')+ { skip(); };

