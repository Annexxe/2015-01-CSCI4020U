grammar Expr;

@header {
    import java.util.*;
}

@members {
    static class Node {
        static int counter = 0;
        int index;
        String label;
        List<Node> children;
        public Node(String label) {
            this.index = (counter ++);
            this.children = new ArrayList<Node>();
            this.label = label;
        }
    }

    public static void main(String[] args) throws Exception {
        ANTLRInputStream input = new ANTLRInputStream(System.in);
        ExprLexer lex = new ExprLexer(input);
        CommonTokenStream tok = new CommonTokenStream(lex);
        ExprParser parser = new ExprParser(tok);

        parser.start();
    }

    public void print(String m) {
        System.out.println(m);
    }
    public void graphviz(Node n) {
        // print the children
        for(Node c : n.children)
            graphviz(c);

        // print the node connections:
        System.out.println(
            "n" + n.index + 
            " [label=\"" + n.label + "\"];");
        // print the edge connections:
        for(Node c : n.children)
            System.out.println("n" + n.index + " -> n" + c.index + ";");
    }
}

start : expr {
            System.out.println("digraph G {");
            graphviz($expr.node);
            System.out.println("}");
        }<EOF>
      ;

expr returns [Node node]
     : t=term '+' e=expr {$node = new Node("+");
                      $node.children.add($t.node);
                      $node.children.add($e.node);}
     | term {$node = new Node("term");
             $node.children.add($term.node);}
     ;

term returns [Node node]
     : f=factor '*' t=term {$node = new Node("*");
                        $node.children.add($f.node);
                        $node.children.add($t.node);}
     | factor {$node = new Node("term");
               $node.children.add($factor.node);}
     ;

factor returns [Node node]
       : '(' expr ')' {$node = new Node("factor");
                       $node.children.add($expr.node);}
       | NUM   {$node = new Node("NUM:" + $NUM.text);}
       | ID    {$node = new Node("ID:" + $ID.text);}
       ;

NUM : ('0' .. '9') + ;
ID : ('a' .. 'z') + ;
WS : (' ' | '\n' | '\t' | '\r')+ {skip();} ;
