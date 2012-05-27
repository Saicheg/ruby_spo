%print-tokens

DIGIT		[0-9]
INT			-?[0-9]+
FLOAT		-?[0-9]*\.[0-9]+
ID			[a-zA-Z_][a-zA-Z0-9_]*

%%

"#".*\n 	{/* skip oneline */} 							// oneline comment
^"=begin"[\w\n][.\n]*[\w\n]"=end"$	{/* skip multiline */}	// multiline comment

"alias"		{ return(Parser::ALIAS); }
"break"		{ return(Parser::BREAK); }
"case"		{ return(Parser::CASE); }
"def"		{ return(Parser::DEF); }
"defined?"	{ return(Parser::DEFINED); }
"else"		{ return(Parser::ELSE); }
"elsif"		{ return(Parser::ELSIF); }
"end"		{ return(Parser::END); }
"false"		{ return(Parser::FALSE); }
"if"		{ return(Parser::IF); }
"nil"		{ return(Parser::NIL); }
"retry"		{ return(Parser::Parser::RETRY); }
"return"	{ return(Parser::RETURN); }
"require"	{ return(Parser::REQUIRE); }
"then"		{ return(Parser::THEN); }
"true"		{ return(Parser::TRUE); }
"undef"		{ return(Parser::UNDEF); }
"unless"	{ return(Parser::UNLESS); }
"when"		{ return(Parser::WHEN); }
"while"		{ return(Parser::WHILE); }
	
	
"+"			{ return(Parser::PLUS); }
"-"			{ return(Parser::MINUS); }
"*"			{ return(Parser::MUL); }
"/"			{ return(Parser::DIV); }
"%"			{ return(Parser::MOD); }
"**"		{ return(Parser::EXP); }

"=="		{ return(Parser::EQUAL); }
"!="		{ return(Parser::NOT_EQUAL); } 
">"			{ return(Parser::GREATER); }
"<"			{ return(Parser::LESS); }
"<="		{ return(Parser::LESS_EQUAL); }
">="		{ return(Parser::GREATER_EQUAL); }

"="			{ return(Parser::ASSIGN); }
"+="		{ return(Parser::PLUS_ASSIGN); }
"-="		{ return(Parser::MINUS_ASSIGN); }
"*="		{ return(Parser::MUL_ASSIGN); }
"/="		{ return(Parser::DIV_ASSIGN); }
"%="		{ return(Parser::MOD_ASSIGN); }
"**="		{ return(Parser::EXP_ASSIGN); }

"&"			{ return(Parser::BIT_AND); }			
"|"			{ return(Parser::BIT_OR); }
"^"			{ return(Parser::BIT_XOR); }
"~"			{ return(Parser::BIT_NOT); }
"<<"		{ return(Parser::BIT_SHL); }
">>"		{ return(Parser::BIT_SHR); }

"and"		{ return(Parser::AND); }
"or"		{ return(Parser::OR); }
"not"		{ return(Parser::NOT); }
"&&"		{ return(Parser::AND); }
"||"		{ return(Parser::OR); }
"!"			{ return(Parser::NOT); }

"?"			{ return(Parser::ASSIGN); }
":"			{ return(Parser::ASSIGN); }

"("			{ return(Parser::LEFT_RBRACKET); }
")"			{ return(Parser::RIGHT_RBRACKET); }
"["			{ return(Parser::LEFT_SBRACKET); }
"]"			{ return(Parser::RIGHT_SBRACKET); }

","			{ return(Parser::COMMA); }

"$"{ID}		{ return(Parser::ID_GLOBAL); }
	
";"			{ return(Parser::SEMICOLON); }

\"(\\.|[^\\"])*\" |
\'(\\.|[^\\'])*\'   { return(Parser::LITERAL); }

{ID}[!?]	{ return(Parser::ID_FUNCTION); }

{ID}		{ return(Parser::ID); }
{FLOAT}		{ return(Parser::NUM_FLOAT); }
{INT}		{ return(Parser::NUM_INTEGER); }

\n 			{ return(Parser::CRLF); }

[ \t\n\r] { /* skip whitespace */ }

%% 
