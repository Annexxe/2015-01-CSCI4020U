import org.antlr.v4.runtime.*;

class Extract {
    public static void main(String[] args) throws Exception {
        ANTLRInputStream input = new ANTLRInputStream(System.in);
        ExtractLexer lex = new ExtractLexer(input);
        CommonTokenStream tokens = new CommonTokenStream(lex);
        ExtractParser p = new ExtractParser(tokens);

        System.out.println("==== start parsing ====");
        p.sentence();
    }
}
