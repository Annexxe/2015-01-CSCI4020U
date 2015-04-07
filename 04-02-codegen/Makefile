ANTLR = ../lib/antlr-4.4-complete.jar
CP = $(ANTLR):.

all:
	java -jar $(ANTLR) -no-listener -no-visitor *.g4
	javac -cp $(CP) *.java

compile:
	java -cp $(CP) GenParser < inputfile > hello.j
	java -jar jasmin.jar hello.j

run:
	java Hello

clean:
	rm -rf *.java *.tokens *.class *.j
