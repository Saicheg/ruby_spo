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
				;

/* calculable - code block, which returns a value */				
calculable_list	: calculable terminator
						| calculable_list calculable terminator
						;
						
calculable	: assignment
				| rvalue
				;

function_definition	: function_header function_body END
							;

function_body	: /* empty */
					| calculable
					| calculable function_return
					;

function_header	: DEF function_name CRLF
						| DEF function_name function_params CRLF
						;

function_name	: ID_METHOD
					| ID
					;

function_params	: LEFT_RBRACKET function_params_list RIGHT_RBRACKET
						;

function_params_list	: function_parameter
							| function_params_list COMMA function_parameter
							;

// Allowed funciton parameters							
function_parameter	: ID
							| rvalue
							;

function_return	: RETURN calculable
						;

terminator	: terminator terminator
				| SEMICOLON
				| CRLF
				;

line_skip	: CRLF
				| line_skip CRLF
				;

none	: // none
	;

%%
