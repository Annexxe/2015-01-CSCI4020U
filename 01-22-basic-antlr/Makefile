ANTLR = ../lib/antlr-4.4-complete.jar
CP = $(ANTLR):.

all:
	java -jar $(ANTLR) *.g4
	javac -cp $(CP) *.java

run:
	java -cp $(CP) Extract < inputfile

clean:
	rm -f ExtractLexer*.java
	rm -f ExtractParser*.java
	rm -f Extract*Listener.java
	rm -f *.tokens *.class
