LANG_NAME='ruby'

FILE_LEX='$(LANG_NAME).lex'
FILE_LEX_HEADER='Scanner.h'
FILE_LEX_OUTPUT='lex.cc'
FILE_LEX_OBJECT='Scanner.o'
FLEX='flexc++'

FILE_BISON='$(LANG_NAME).y'
FILE_BISON_OUTPUT='parse.cc'
FILE_BISON_OBJECT='parse.o'
BISON='bisonc++'

FILE_MAIN='main.cc'
FILE_MAIN_OBJECT='main.o'

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
	g++ --std=c++0x -c -o $(FILE_LEX_OBJECT) $(FILE_LEX_OUTPUT)	 	
	g++ --std=c++0x -c -o $(FILE_BISON_OBJECT) $(FILE_BISON_OUTPUT)
	g++ --std=c++0x -c -o $(FILE_MAIN_OBJECT) $(FILE_MAIN)
	g++ --std=c++0x -ggdb -o $(FILE_OUTPUT) $(FILE_BISON_OBJECT) $(FILE_LEX_OBJECT) $(FILE_MAIN) $(LIB_BOBCAT) *Token.o
	chmod +x $(FILE_OUTPUT)	

run: compile
	cat $(FILE_TEST) | ./$(FILE_OUTPUT) 

clean:
	rm -f *.o
	rm -f Scanner.h Parserbase.h Scannerbase.h
	rm -f lex.cc parse.cc
	rm -f $(FILE_OUTPUT)
