// keywords
%token IF THEN ELSE ELSIF UNLESS
%token DEF END UNDEF ALIAS RETURN
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

%token ASS

%start program

%%

program	: /* empty */
			| expression_list
			;

/* expression - any code block */
expression_list	: expression terminator
						| expression_list expression terminator
//						| expression_list
						;

expression	: function_definition
				| require_block
				| calculable
//				| line_skip
				;

require_block	: REQUIRE LITERAL
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


assignment	: lvalue ASSIGN rvalue
				| lvalue PLUS_ASSIGN rvalue
				| lvalue MINUS_ASSIGN rvalue
				| lvalue MUL_ASSIGN rvalue
				| lvalue DIV_ASSIGN rvalue
				| lvalue MOD_ASSIGN rvalue
				| lvalue EXP_ASSIGN rvalue
				;

array_definition	: LEFT_SBRACKET array_definition_elements RIGHT_SBRACKET
						;

array_definition_elements	: rvalue
									| array_definition_elements COMMA rvalue
									;

array_selector	: ID LEFT_SBRACKET rvalue RIGHT_SBRACKET
					| ID_GLOBAL LEFT_SBRACKET rvalue RIGHT_SBRACKET
//					| function_call array_selector_param
					;

lvalue	: ID
			| ID_GLOBAL
			| array_selector
			;

rvalue	: lvalue
			| LEFT_RBRACKET rvalue RIGHT_RBRACKET
			| array_definition
			| CHAR
			| LITERAL
			| NUM_FLOAT
			| NUM_INTEGER
			| DEFINED defined_param
			| NOT rvalue
			| BIT_NOT rvalue
			| rvalue EQUAL rvalue
			| rvalue NOT_EQUAL rvalue
			| rvalue LESS_EQUAL rvalue
			| rvalue LESS rvalue
			| rvalue GREATER rvalue
			| rvalue GREATER_EQUAL rvalue
			| rvalue OR rvalue
			| rvalue AND rvalue
			| rvalue BIT_OR rvalue
			| rvalue BIT_XOR rvalue
			| rvalue BIT_AND rvalue
			| rvalue BIT_SHL rvalue
			| rvalue BIT_SHR rvalue
			| rvalue PLUS rvalue
			| rvalue MINUS rvalue
			| rvalue MUL rvalue
			| rvalue DIV rvalue
			| rvalue MOD rvalue
			| rvalue EXP rvalue
			;

defined_param	: ID
					| ID_GLOBAL
					| ID_FUNCTION
					| LEFT_RBRACKET defined_param RIGHT_RBRACKET
					;

terminator	: terminator SEMICOLON
				| terminator CRLF
				| SEMICOLON
				| CRLF
				;
%%
