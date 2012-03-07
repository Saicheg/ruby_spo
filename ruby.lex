%option noyywrap
%option c++
%{
#include <fstream>
#include <map>
#include <string>
using namespace std;

map<string,int> tmap;
map<string,int>::iterator it;

%}

DIGIT		[0-9]
INT		-?[0-9]+
FLOAT		-?[0-9]*\.[0-9]+
ID			[a-zA-Z_][a-zA-Z0-9_]*

%%


"alias"	{
	cout << "Alias found" << endl;
	tmap["alias"]++;
	}
"break"	{
	cout << "Break found" << endl;
	tmap["break"]++;
	}
"case"	{
	cout << "Case found" << endl;
	tmap["case"]++;
	}
"def"	{
	cout << "Def found" << endl;
	tmap["def"]++;
	}
"defined?"	{
	cout << "Defined? found" << endl;
	tmap["defined?"]++;
	}
"do"	{
	cout << "Do found" << endl;
	tmap["do"]++;
	}
"else"	{
	cout << "Else found" << endl;
	tmap["else"]++;
	}
"elsif"	{
	cout << "Elsif found" << endl;
	tmap["elsif"]++;
	}
"end"	{
	cout << "End found" << endl;
	tmap["end"]++;
	}
"false"	{
	cout << "False found" << endl;
	tmap["false"]++;
	}
"for"	{
	cout << "For found" << endl;
	tmap["for"]++;
	}
"if"	{
	cout << "If found" << endl;
	tmap["if"]++;
	}
"in"	{
	cout << "In found" << endl;
	tmap["in"]++;
	}
"next"	{
	cout << "Next found" << endl;
	tmap["next"]++;
	}
"nil"	{
	cout << "Nil found" << endl;
	tmap["nil"]++;
	}
"redo"	{
	cout << "Redo found" << endl;
	tmap["redo"]++;
	}
"retry"	{
	cout << "Retry found" << endl;
	tmap["retry"]++;
	}
"return"	{
	cout << "Return found" << endl;
	tmap["return"]++;
	}
"require"	{
	cout << "Require found" << endl;
	tmap["require"]++;
	}
"then"	{
	cout << "Then found" << endl;
	tmap["then"]++;
	}
"true"	{
	cout << "True found" << endl;
	tmap["true"]++;
	}
"undef"	{
	cout << "Undef found" << endl;
	tmap["undef"]++;
	}
"unless"	{
	cout << "Unless found" << endl;
	tmap["unless"]++;
	}
"until"	{
	cout << "until found" << endl;
	tmap["until"]++;
	}
"when"	{
	cout << "When found" << endl;
	tmap["When"]++;
	}
"while"	{
	cout << "While found" << endl;
	tmap["while"]++;
	}
	
	
"+"	{
	cout << "'+' found" << endl;
	tmap["+"]++;
	}
"-"	{
	cout << "'-' found" << endl;
	tmap["-"]++;
	}
"*"	{
	cout << "'*' found" << endl;
	tmap["*"]++;
	}
"/"	{
	cout << "'/' found" << endl;
	tmap["/"]++;
	}
"%"	{
	cout << "'%' found" << endl;
	tmap["%"]++;
	}
"**"	{
	cout << "'**' found" << endl;
	tmap["**"]++;
	}

"=="	{
	cout << "'==' found" << endl;
	tmap["=="]++;
	}
"!="	{
	cout << "'!=' found" << endl;
	tmap["!="]++;
	}
">"	{
	cout << "'>' found" << endl;
	tmap[">"]++;
	}
"<"	{
	cout << "'<' found" << endl;
	tmap["<"]++;
	}
"<="	{
	cout << "'<=' found" << endl;
	tmap["<="]++;
	}
">="	{
	cout << "'>=' found" << endl;
	tmap[">="]++;
	}

"="	{
	cout << "'=' found" << endl;
	tmap["="]++;
	}
"+="	{
	cout << "'+=' found" << endl;
	tmap["+="]++;
	}
"-="	{
	cout << "'-=' found" << endl;
	tmap["-="]++;
	}
"*="	{
	cout << "'*=' found" << endl;
	tmap["*="]++;
	}
"/="	{
	cout << "'/=' found" << endl;
	tmap["/="]++;
	}
"%="	{
	cout << "'%=' found" << endl;
	tmap["%="]++;
	}
"**="	{
	cout << "'**=' found" << endl;
	tmap["**="]++;
	}

"&"	{
	cout << "'&' found" << endl;
	tmap["&"]++;
	}
"|"	{
	cout << "'|' found" << endl;
	tmap["|"]++;
	}
"^"	{
	cout << "'^' found" << endl;
	tmap["^"]++;
	}
"~"	{
	cout << "'~' found" << endl;
	tmap["~"]++;
	}
"<<"	{
	cout << "'<<' found" << endl;
	tmap["<<"]++;
	}
">>"	{
	cout << "'>>' found" << endl;
	tmap[">>"]++;
	}

"and"	{
	cout << "And found" << endl;
	tmap["and"]++;
	}
"or"	{
	cout << "Or found" << endl;
	tmap["or"]++;
	}
"not"	{
	cout << "NOT found" << endl;
	tmap["not"]++;
	}
"&&"	{
	cout << "'&&' found" << endl;
	tmap["&&"]++;
	}
"||"	{
	cout << "'||' found" << endl;
	tmap["||"]++;
	}
"!"	{
	cout << "'!' found" << endl;
	tmap["!"]++;
	}

"?"	{
	cout << "'?:' found" << endl;
	tmap["?"]++;
	}
":"	{
	cout << "':' found" << endl;
	tmap[":"]++;
	}


"#".*\n {
    cout << "Single-line comment found" << endl;
    tmap["single-line comment"]++;
    }
"=begin"[\w\n][.\n]*\n[\w\n]"=end"    {
    cout << "Multi-line comment found" << endl;
    tmap["mingle-line comment"]++;
    }

"("	{
	cout << "'(' found" << endl;
	tmap["("]++;
	}
")"	{
	cout << "')' found" << endl;
	tmap[")"]++;
	}
"["	{
	cout << "'[' found" << endl;
	tmap["["]++;
	}
"]"	{
	cout << "']' found" << endl;
	tmap["]"]++;
	}
"{"	{
	cout << "'{' found" << endl;
	tmap["{"]++;
	}
"}"	{
	cout << "'}' found" << endl;
	tmap["}"]++;
	}

","	{
	cout << "',' found" << endl;
	tmap[","]++;
	}

"$"{ID}	{
	cout << "global identifier found: "<< yytext << endl;
	tmap["global identifier"]++;
	}
	
";"	{
	cout << "semicolon found" << endl;
	tmap["semicolon"]++;
	}

\"(\\.|[^\\"])*\" |
\'(\\.|[^\\'])*\'  {
    cout << "string found :" << yytext << endl;
    tmap["string"]++;
    }

{ID}[!?]	{
	cout << "Method name found: "<< yytext << endl;
	tmap["method"]++;
	}

{ID}		{
	cout << "Identificator found: " << yytext << endl;
	tmap["id"]++;
	}
{FLOAT}	    {
    cout << "Float number found: " << yytext << endl;
    tmap["float"]++;
    }
{INT}		{
    cout << "Integer number found: " << yytext << endl;
    tmap["int"]++;
    }

\n		{
	cout << "Line break found" << endl;
	tmap["br"]++;
	}

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

