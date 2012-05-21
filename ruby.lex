%option noyywrap
%option c++
%{
#include <fstream>
#include <map>
#include <string>
#include "ruby.bison.defines.h"
using namespace std;

map<string,int> tmap;
map<string,int>::iterator it;

%}

DIGIT		[0-9]
INT			-?[0-9]+
FLOAT		-?[0-9]*\.[0-9]+
ID			[a-zA-Z_][a-zA-Z0-9_]*

%%


"alias"		{ return(ALIAS); }
"break"		{ return(BREAK); }
"case"		{ return(CASE); }
def"		{ return(DEF); }
"defined?"	{ return(DEFINED); }
"else"		{ return(ELSE); }
"elsif"		{ return(ELSIF); }
"end"		{ return(END); }
"false"		{ return(FALSE); }
"if"		{ return(IF); }
"nil"		{ return(NIL); }
"retry"		{ return(RETRY); }
"return"	{ return(RETURN); }
"require"	{ return(REQUIRE); }
"then"		{ return(THEN); }
"true"		{ return(TRUE); }
"undef"		{ return(UNDEF); }
"unless"	{ return(UNLESS); }
"when"		{ return(WHEN); }
"while"		{ return(WHILE); }
	
	
"+"			{ return(PLUS); }
"-"			{ return(MINUS); }
"*"			{ return(MUL); }
"/"			{ return(DIV); }
"%"			{ return(MOD); }
"**"		{ return(EXP); }

"=="		{ return(EQUAL); }
"!="		{ return(NOT_EQUAL); } 
">"			{ return(GREATER); }
"<"			{ return(LESS); }
"<="		{ return(LESS_EQUAL); }
">="		{ return(GREATER_EQUAL); }

"="			{ return(ASSIGN); }
"+="		{ return(PLUS_ASSIGN); }
"-="		{ return(MINUS_ASSIGN); }
"*="		{ return(MUL_ASSIGN); }
"/="		{ return(DIV_ASSIGN); }
"%="		{ return(MOD_ASSIGN); }
"**="		{ return(EXP_ASSIGN); }

"&"			{ return(BIT_AND); }			
"|"			{ return(BIT_OR); }
"^"			{ return(BIT_XOR); }
"~"			{ return(BIT_NOT); }
"<<"		{ return(BIT_SHL); }
">>"		{ return(BIT_SHR); }

"and"		{ return(AND); }
"or"		{ return(OR); }
"not"		{ return(NOT); }
"&&"		{ return(AND); }
"||"		{ return(OR); }
"!"			{ return(NOT); }

"?"			{ return(ASSIGN); }
":"			{ return(ASSIGN); }


"#".*\n 	{/* skip oneline */} 							// oneline comment
"=begin"[\w\n][.\n]*\n[\w\n]"=end"	{/* skip multiline */}	// multiline comment

"("			{ return(LEFT_RBRACKET); }
")"			{ return(RIGHT_RBRACKET); }
"["			{ return(LEFT_SBRACKET); }
"]"			{ return(RIGHT_SBRACKET); }

","			{ return(COMMA); }

"$"{ID}		{ return(ID_GLOBAL); }
	
";"			{ return(SEMICOLON); }

\"(\\.|[^\\"])*\" |
\'(\\.|[^\\'])*\'   { return(LITERAL); }

{ID}[!?]	{ return(ID_FUNCTION); }

{ID}		{ return(ID); }
{FLOAT}		{ return(NUM_FLOAT); }
{INT}		{ return(NUM_INTEGER); }

\n 			{ return(CRLF); }

[ \t\n\r] { /* skip whitespace */ }

%%

int main(int argc, char* argv[])
{
	ifstream LexerFIn;
	if (argc > 1)
	{
		LexerFIn.open(argv[1]);
		if (LexerFIn.fail())
		{
			cerr << "Input file cannot be opened\n";
			return 0;
		}
	}
	else
	{
		cerr << "Input file not specified\n";
		return 0;
	}
	yyFlexLexer Lexer(&LexerFIn);
	Lexer.yylex();
	
	cout << endl << "Stats:" << endl;
	for (it=tmap.begin();it!=tmap.end();it++)
	{
		cout << (*it).first << " => " << (*it).second << endl;
	}
	return 0;
}

