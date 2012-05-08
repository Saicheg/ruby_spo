// keywords
%token IF THEN ELSE ELSIF UNLESS
%token DEF END UNDEF ALIAS DEFINED RETURN
%token TRUE FALSE NIL
%token WHILE FOR BREAK UNTIL RETRY REDO NEXT IN
%token CASE WHEN
%token REQUIRE

// commentaries
%token C_BEGIN C_END

%token TERNARY_THEN TERNARY_ELSE
%token LEFT_RBRACKET RIGHT_RBRACKET
%token LEFT_FBRACKET RIGHT_FBRACKET
%token LEFT_SBRACKET RIGHT_SBRACKET
%token COMMA SEMICOLON CRLF								   /* , ; \n */

// identifiers, numbers and strings
%token ID_GLOBAL ID_FUNCTION ID LITERAL CHAR
%token NUM_FLOAT NUM_INTEGER

%left DEFINED 									   /* defined? */
%left OR 									   /* || */
%left AND 									   /* && */
%left EQUAL NOT_EQUAL 								   /* == != */
%left LESS_EQUAL LESS GREATER GREATER_EQUAL 					   /* <= < > >= */
%left BIT_OR BIT_XOR 							           /* | ^ */
%left BIT_AND 									   /* & */
%left BIT_SHL BIT_SHR 								   /* << >> */
%left PLUS MINUS 								   /* + - */
%left MUL DIV MOD 								   /* / * % */
%left EXP 									   /* ** */
%right ASSIGN PLUS_ASSIGN MINUS_ASSIGN MUL_ASSIGN DIV_ASSIGN MOD_ASSIGN EXP_ASSIGN /* = += -+ *= /= %= **=  */
%right NOT BIT_NOT 								   /* ! ~ */

%start program

%%

program	: /* empty */
			| expression_list
			;

/* expression - any code block */
expression_list	: /* empty */
						| expression terminator
						| expression_list expression terminator
						;

expression	: /* empty */
				| function_definition
				| require_block
				| calculable
				| line_skip
				;
				
require_block	: REQUIRE LITERAL terminator
					;

/* calculable - code block, which returns a value */				
calculable_list	: calculable terminator
						| calculable_list calculable terminator
						;
						
calculable	: assignment
				| rvalue
				;

function_definition	: function_definition_header function_definition_body END
							;

function_definition_body	: /* empty */
									| calculable_list
									| calculable_list function_return
									;

function_definition_header	: DEF function_definition_name CRLF
									| DEF function_definition_name function_definition_params CRLF
									;

function_definition_name	: ID_FUNCTION
									| ID
									;

function_definition_params	: LEFT_RBRACKET function_definition_params_list RIGHT_RBRACKET
									;

function_definition_params_list	: function_definition_parameter
											| function_definition_parameter COMMA function_definition_params_list
											;

// Allowed funciton parameters							
function_definition_parameter	: ID
										;
function_return	: RETURN calculable
						;
						
						
assignment	:
				;
				
rvalue	:
			;

terminator	: terminator SEMICOLON
				| terminator CRLF
				| SEMICOLON
				| CRLF
				;

line_skip	: CRLF
				| CRLF line_skip
				;

%%
