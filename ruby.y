%filenames Parser
%scanner Scanner.h

%stype class SyntaxToken*

// keywords
%token IF THEN ELSE ELSIF UNLESS
%token DEF END UNDEF ALIAS RETURN
%token TRUE FALSE NIL
%token WHILE BREAK RETRY
%token CASE WHEN
%token REQUIRE

%token LEFT_RBRACKET RIGHT_RBRACKET
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
%left TERNARY_THEN TERNARY_ELSE
%right ASSIGN PLUS_ASSIGN MINUS_ASSIGN MUL_ASSIGN DIV_ASSIGN MOD_ASSIGN EXP_ASSIGN /* = += -+ *= /= %= **=  */
%right NOT BIT_NOT 								   /* ! ~ */

%start program

%%

program	: /* empty */
			| expression_list
			;

/* expression - any code block */
expression_list	: expression terminator
				| expression_list expression terminator
				| error
				;

expression	: function_definition
            | undef_statement
				| require_block
				| if_statement
				| unless_statement
				| case_statement
				| alias_statement
				| rvalue
				| return_statement
				| while_statement
				;

require_block	: REQUIRE LITERAL
					;


function_definition	: function_definition_header function_definition_body END
							;

function_definition_body	: /* empty */
									| expression_list
									;

function_definition_header	: DEF function_name CRLF
									| DEF function_name function_definition_params CRLF
									;

function_name : ID_FUNCTION
              | ID
              ;

function_definition_params	: LEFT_RBRACKET function_definition_params_list RIGHT_RBRACKET
									;

function_definition_params_list	: ID
											| ID COMMA function_definition_params_list
											;


return_statement	: RETURN rvalue
						;

function_call	: function_name LEFT_RBRACKET function_call_param_list RIGHT_RBRACKET
					;

function_call_param_list	: /* empty */
									| function_call_params
									;

function_call_params	: rvalue
							| function_call_params COMMA rvalue
							;
							
undef_statement : UNDEF ID
                ;
                
alias_statement : ALIAS LITERAL LITERAL
                ;                

if_elsif_statement : ELSIF rvalue CRLF expression_list
                    | ELSIF rvalue CRLF expression_list if_elsif_statement
                    ;

if_statement	: IF rvalue CRLF expression_list ELSE CRLF expression_list END
					| IF rvalue THEN expression_list ELSE expression_list END
					| IF rvalue CRLF expression_list if_elsif_statement END
					;
					
unless_statement : UNLESS rvalue CRLF expression_list END
                 ;

while_statement : WHILE rvalue CRLF while_expression_list END
                ;

while_expression_list : expression terminator
                      | RETRY terminator
                      | BREAK terminator
                      | while_expression_list expression terminator
                      | while_expression_list RETRY terminator
                      | while_expression_list BREAK terminator
                      ;
case_statement : CASE rvalue CRLF case_expression_list END
               | CASE rvalue CRLF case_expression_list ELSE expression_list END
               ;
               
case_expression_list : WHEN rvalue CRLF expression_list
                     | case_expression_list WHEN rvalue CRLF expression_list
                     ;
                     
ternary_statement : rvalue TERNARY_THEN rvalue TERNARY_ELSE rvalue
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
			| assignment
			| array_definition
         	| ternary_statement
			| function_call
			| CHAR
			| LITERAL { $$ = new StringSyntaxToken(d_scanner.matched()); }
			| NUM_FLOAT { $$ = new FloatSyntaxToken(s2double(d_scanner.matched())); }
			| NUM_INTEGER { $$ = new IntegerSyntaxToken(s2int(d_scanner.matched())); }
			| TRUE
			| FALSE
			| NIL
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
