ANTLR = ../lib/antlr-4.4-complete.jar
CP = $(ANTLR):.

all:
	java -jar $(ANTLR) -no-listener -no-visitor *.g4
	javac -cp $(CP) *.java

run:
	@java -cp $(CP) ExprParser < inputfile

clean:
	rm -rf *.java *.tokens *.class
