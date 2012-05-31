LANG_NAME='ruby'

FILE_LEX='$(LANG_NAME).lex'
FILE_LEX_HEADER='Scanner.h'
FILE_LEX_OUTPUT='lex.cc'
FLEX='flexc++'

FILE_BISON='$(LANG_NAME).y'
FILE_BISON_OUTPUT='parse.cc'

BISON='bisonc++'

FILE_MAIN='main.cc'

FILE_ANALYZER='analyzer.cpp'

FILE_OUTPUT='$(LANG_NAME).run'
FILE_TEST='test.rb'

LIB_BOBCAT='-lbobcat'

default: compile
  
$(FILE_BISON):
	$(BISON) $(FILE_BISON)

$(FILE_LEX):
	$(FLEX) $(FILE_LEX)

compile: clean $(FILE_BISON) $(FILE_LEX)
	g++ --std=c++0x -c tokens/*Token.cpp
	g++ --std=c++0x -ggdb -o $(FILE_OUTPUT) $(FILE_BISON_OUTPUT) $(FILE_LEX_OUTPUT) $(FILE_ANALYZER) $(FILE_MAIN) $(LIB_BOBCAT) *Token.o
	chmod +x $(FILE_OUTPUT)	

run: compile
	cat $(FILE_TEST) | ./$(FILE_OUTPUT) 

clean:
	rm -f *.o
	rm -f Scanner.h Parserbase.h Scannerbase.h
	rm -f lex.cc parse.cc
	rm -f $(FILE_OUTPUT)
