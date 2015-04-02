ANTLR = ../lib/antlr-4.4-complete.jar
CP = $(ANTLR):.

all:
	java -jar $(ANTLR) -no-visitor -no-listener *.g4
	javac -cp $(CP) *.java

run:
	java -cp $(CP) ExprParser < inputfile

clean:
	rm -f *Lexer*.java
	rm -f *Parser*.java
	rm -f *Listener.java
	rm -f *.tokens *.class
