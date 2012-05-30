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
%token COMMA SEMICOLON CRLF                           /* , ; \n */

// identifiers, numbers and strings
%token ID_GLOBAL ID_FUNCTION ID LITERAL CHAR
%token NUM_FLOAT NUM_INTEGER

%left DEFINED                               /* defined? */
%left OR                               /* || */
%left AND                               /* && */
%left EQUAL NOT_EQUAL                            /* == != */
%left LESS_EQUAL LESS GREATER GREATER_EQUAL                   /* <= < > >= */
%left BIT_OR BIT_XOR                                 /* | ^ */
%left BIT_AND                               /* & */
%left BIT_SHL BIT_SHR                            /* << >> */
%left PLUS MINUS                            /* + - */
%left MUL DIV MOD                            /* / * % */
%left EXP                               /* ** */
%left TERNARY_THEN TERNARY_ELSE
%right ASSIGN PLUS_ASSIGN MINUS_ASSIGN MUL_ASSIGN DIV_ASSIGN MOD_ASSIGN EXP_ASSIGN /* = += -+ *= /= %= **=  */
%right NOT BIT_NOT                            /* ! ~ */

%start program

%%

program : /* empty */
         | expression_list
         ;

/* expression - any code block */
expression_list : expression terminator
            | expression_list expression terminator
            | error
            ;

expression : function_definition
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

require_block : REQUIRE LITERAL
               ;


function_definition : function_definition_header function_definition_body END
                     ;

function_definition_body : /* empty */
                           | expression_list
                           ;

function_definition_header : DEF function_name CRLF
                           | DEF function_name function_definition_params CRLF
                           ;

function_name : ID_FUNCTION
              | ID
              ;

function_definition_params : LEFT_RBRACKET function_definition_params_list RIGHT_RBRACKET
                           ;

function_definition_params_list : ID
                                 | ID COMMA function_definition_params_list
                                 ;


return_statement : RETURN rvalue
                  ;

function_call : function_name LEFT_RBRACKET function_call_param_list RIGHT_RBRACKET
               ;

function_call_param_list : /* empty */
                           | function_call_params
                           ;

function_call_params : rvalue
                     | function_call_params COMMA rvalue
                     ;
                     
undef_statement : UNDEF ID
                ;
                
alias_statement : ALIAS LITERAL LITERAL
                ;                

if_elsif_statement : ELSIF rvalue CRLF expression_list
                    | ELSIF rvalue CRLF expression_list if_elsif_statement
                    ;

if_statement : IF rvalue CRLF expression_list ELSE CRLF expression_list END
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

assignment : lvalue ASSIGN rvalue
             {
               $$ = CreateAssignmentToken($1, $3);
             }
           | lvalue PLUS_ASSIGN rvalue
             {
               auto oper = CreateOperationToken("PLUS", $1, $3);
               $$ = CreateAssignmentToken($1, oper);
               delete $1;
               delete $3;
               delete oper;
             }
           | lvalue MINUS_ASSIGN rvalue
             {
               auto oper = CreateOperationToken("MINUS", $1, $3);
               $$ = CreateAssignmentToken($1, oper);
               delete $1;
               delete $3;
               delete oper;
             }
           | lvalue MUL_ASSIGN rvalue
             {
               auto oper = CreateOperationToken("MUL", $1, $3);
               $$ = CreateAssignmentToken($1, oper);
               delete $1;
               delete $3;
               delete oper;
             }
           | lvalue DIV_ASSIGN rvalue
             {
               auto oper = CreateOperationToken("DIV", $1, $3);
               $$ = CreateAssignmentToken($1, oper);
               delete $1;
               delete $3;
               delete oper;
             }
           | lvalue MOD_ASSIGN rvalue
             {
               auto oper = CreateOperationToken("MOD", $1, $3);
               $$ = CreateAssignmentToken($1, oper);
               delete $1;
               delete $3;
               delete oper;
             }
           | lvalue EXP_ASSIGN rvalue
             {
               auto oper = CreateOperationToken("EXP", $1, $3);
               $$ = CreateAssignmentToken($1, oper);
               delete $1;
               delete $3;
               delete oper;
             }
           ;

array_definition : LEFT_SBRACKET array_definition_elements RIGHT_SBRACKET
                  ;

array_definition_elements : rvalue
                           | array_definition_elements COMMA rvalue
                           ;

array_selector : ID LEFT_SBRACKET rvalue RIGHT_SBRACKET
                 {
                   $$ = new SyntaxToken(SyntaxTokenType::ArraySelector);
                   $$->Children().push_back(*$1);
                   $$->Children().push_back(*$3);
                   delete $1;
                   delete $3;
                 }
               | ID_GLOBAL LEFT_SBRACKET rvalue RIGHT_SBRACKET
                 {
                   $$ = new SyntaxToken(SyntaxTokenType::ArraySelector);
                   $$->Children().push_back(*$1);
                   $$->Children().push_back(*$3);
                   delete $1;
                   delete $3;
                 }
               | function_call LEFT_SBRACKET rvalue RIGHT_SBRACKET
                 {
                   $$ = new SyntaxToken(SyntaxTokenType::ArraySelector);
                   $$->Children().push_back(*$1);
                   $$->Children().push_back(*$3);
                   delete $1;
                   delete $3;
                 }
               ;

lvalue : ID
         {
           $$ = new StringSyntaxToken(d_scanner.matched());
           $$->SetType(SyntaxTokenType::IdentifierToken);
         }
       | ID_GLOBAL
         {
           $$ = new StringSyntaxToken(d_scanner.matched());
           $$->SetType(SyntaxTokenType::GlobalIdentifierToken);
         }
       | array_selector
         {
           $$ = $1;
         }
       ;

rvalue : lvalue { $$ = $1; }
         | LEFT_RBRACKET rvalue RIGHT_RBRACKET { $$ = $2; }
         | assignment { $$ = $1; }
         | array_definition { $$ = $1; }
         | ternary_statement { $$ = $1; }
         | function_call { $$ = $1; }
         | CHAR { $$ = new StringSyntaxToken(d_scanner.matched()); }
         | LITERAL { $$ = new StringSyntaxToken(d_scanner.matched()); }
         | NUM_FLOAT { $$ = new FloatSyntaxToken(s2double(d_scanner.matched())); }
         | NUM_INTEGER { $$ = new IntegerSyntaxToken(s2int(d_scanner.matched())); }
         | TRUE { $$ = new BooleanSyntaxToken(true); }
         | FALSE { $$ = new BooleanSyntaxToken(false); }
         | NIL { $$ = new NilSyntaxToken(); }
         | DEFINED defined_param
           {
             $$ = new SyntaxToken(SyntaxTokenType::DefinedToken);
             $$->Children().push_back(*$2);
             delete $2;
           }
         | NOT rvalue { $$ = CreateOperationToken("NOT", $1, NULL); }
         | BIT_NOT rvalue { $$ = CreateOperationToken("BIT_NOT", $1, NULL); }
         | rvalue EQUAL rvalue { $$ = CreateOperationToken("EQUAL", $1, $2); }
         | rvalue NOT_EQUAL rvalue { $$ = CreateOperationToken("NOT_EQUAL", $1, $2); }
         | rvalue LESS_EQUAL rvalue { $$ = CreateOperationToken("LESS_EQUAL", $1, $2); }
         | rvalue LESS rvalue { $$ = CreateOperationToken("LESS", $1, $2); }
         | rvalue GREATER rvalue { $$ = CreateOperationToken("GREATER", $1, $2); }
         | rvalue GREATER_EQUAL rvalue { $$ = CreateOperationToken("GREATER_EQUAL", $1, $2); }
         | rvalue OR rvalue { $$ = CreateOperationToken("OR", $1, $2); }
         | rvalue AND rvalue { $$ = CreateOperationToken("AND", $1, $2); }
         | rvalue BIT_OR rvalue { $$ = CreateOperationToken("BIT_OR", $1, $2); }
         | rvalue BIT_XOR rvalue { $$ = CreateOperationToken("BIT_XOR", $1, $2); }
         | rvalue BIT_AND rvalue { $$ = CreateOperationToken("BIT_AND", $1, $2); }
         | rvalue BIT_SHL rvalue { $$ = CreateOperationToken("BIT_SHL", $1, $2); }
         | rvalue BIT_SHR rvalue { $$ = CreateOperationToken("BIT_SHR", $1, $2); }
         | rvalue PLUS rvalue { $$ = CreateOperationToken("PLUS", $1, $2); }
         | rvalue MINUS rvalue { $$ = CreateOperationToken("MINUS", $1, $2); }
         | rvalue MUL rvalue { $$ = CreateOperationToken("MUL", $1, $2); }
         | rvalue DIV rvalue { $$ = CreateOperationToken("DIV", $1, $2); }
         | rvalue MOD rvalue { $$ = CreateOperationToken("MOD", $1, $2); }
         | rvalue EXP rvalue { $$ = CreateOperationToken("EXP", $1, $2); }
         ;

defined_param : ID
                {
                  $$ = new StringSyntaxToken(d_scanner.matched());
                  $$->SetType(SyntaxTokenType::IdentifierToken);
                } 
              | ID_GLOBAL
                {
                  $$ = new StringSyntaxToken(d_scanner.matched());
                  $$->SetType(SyntaxTokenType::GlobalIdentifierToken);
                } 
              | ID_FUNCTION
                {
                  $$ = new StringSyntaxToken(d_scanner.matched());
                  $$->SetType(SyntaxTokenType::FunctionIdentifierToken);
                } 
              | LEFT_RBRACKET defined_param RIGHT_RBRACKET
                {
                  $$ = $2;
                }
              ;

terminator : terminator SEMICOLON
            | terminator CRLF
            | SEMICOLON
            | CRLF
            ;
