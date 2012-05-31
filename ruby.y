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
          {
            $$ = new SyntaxToken(SyntaxTokenType::ExpressionList);
          }
        | expression_list
          {
            $$ = $1;
          }
        ;

/* expression - any code block */
expression_list : expression terminator
                  {
                    $$ = new SyntaxToken(SyntaxTokenType::ExpressionList);
                    $$->Children().push_back(*$1);
                    delete $1;
                  }
                | expression_list expression terminator
                  {
                    $1->Children().push_back(*$2);
                    delete $2;
                    $$ = $1;
                  }
                | error
                ;

expression : function_definition
             {
               $$ = $1;
             }
           | undef_statement
             {
               $$ = $1;
             }
           | require_block
             {
               $$ = $1;
             }
           | if_statement
             {
               $$ = $1;
             }
           | unless_statement
             {
               $$ = $1;
             }
           | case_statement
             {
               $$ = $1;
             }
           | alias_statement
             {
               $$ = $1;
             }
           | rvalue
             {
               $$ = $1;
             }
           | return_statement
             {
               $$ = $1;
             }
           | while_statement
             {
               $$ = $1;
             }
          ;

require_block : REQUIRE LITERAL
                {
                  $$ = new SyntaxToken(SyntaxTokenType::RequireToken);
                  $$->Children().push_back(*$2);
                  delete $2;
                }
              ;


function_definition : function_definition_header function_definition_body END
                      {
                        $$ = new SyntaxToken(SyntaxTokenType::FunctionDefinition);
                        $$->Children().push_back(*$1);
                        $$->Children().push_back(*$2);
                        delete $1;
                        delete $2;
                      }
                     ;

function_definition_body : /* empty */
                           {
                             $$ = new NilSyntaxToken();
                           }
                         | expression_list
                           {
                             $$ = $1;
                           }
                         ;

function_definition_header : DEF function_name CRLF
                             {
                               $$ = new SyntaxToken(SyntaxTokenType::FunctionDefinitionHeader);
                               $$->Children().push_back(*$2);
                               auto params = SyntaxToken(SyntaxTokenType::FunctionDefinitionParams);
                               params.Children().push_back(NilSyntaxToken());
                               $$->Children().push_back(params);
                               delete $2;
                             }
                           | DEF function_name function_definition_params CRLF
                             {
                               $$ = new SyntaxToken(SyntaxTokenType::FunctionDefinitionHeader);
                               $$->Children().push_back(*$2);
                               $$->Children().push_back(*$3);
                               delete $2;
                               delete $3;
                             }
                           ;

function_name : ID_FUNCTION
                {
                  $$ = new StringSyntaxToken(d_scanner.matched());
                  $$->SetType(SyntaxTokenType::FunctionIdentifierToken);
                }
              | ID
                {
                  $$ = new StringSyntaxToken(d_scanner.matched());
                  $$->SetType(SyntaxTokenType::IdentifierToken);
                }
              ;

function_definition_params : LEFT_RBRACKET function_definition_params_list RIGHT_RBRACKET
                             {
                               $$ = $2;
                             }
                           ;

function_definition_params_list : /* empty */
                                  {
                                    $$ = new SyntaxToken(SyntaxTokenType::FunctionDefinitionParams);
                                    $$->Children().push_back(NilSyntaxToken());
                                  }
                                | ID
                                  {
                                    $$ = new SyntaxToken(SyntaxTokenType::FunctionDefinitionParams);
                                    $$->Children().push_back(*$1);
                                    delete $1;
                                  }
                                | function_definition_params_list COMMA ID
                                  {
                                    $1->Children().push_back(*$3);
                                    delete $3;
                                    $$ = $1;
                                  }
                                ;


return_statement : RETURN rvalue
                   {
                     $$ = new SyntaxToken(SyntaxTokenType::ReturnToken);
                     $$->Children().push_back(*$2);
                     delete $2;
                   }
                 ;

function_call : function_name LEFT_RBRACKET function_call_param_list RIGHT_RBRACKET
                {
                  $$ = new SyntaxToken(SyntaxTokenType::FunctionCall);
                  $$->Children().push_back(*$1);
                  $$->Children().push_back(*$3);
                  delete $1;
                  delete $3;
                }
              ;

function_call_param_list : /* empty */
                           {
                             $$ = new SyntaxToken(SyntaxTokenType::FunctionCallParams);
                             $$->Children().push_back(NilSyntaxToken());
                           }
                         | function_call_params
                           {
                             $$ = $1;
                           }
                         ;

function_call_params : rvalue
                       {
                         $$ = new SyntaxToken(SyntaxTokenType::FunctionCallParams);
                         $$->Children().push_back(*$1);
                         delete $1;
                       }
                     | function_call_params COMMA rvalue
                       {
                         $1->Children().push_back(*$3);
                         $$ = $1;
                         delete $3;
                       }
                     ;
                     
undef_statement : UNDEF ID
                  {
                    $$ = new SyntaxToken(SyntaxTokenType::UndefToken);
                    $$->Children().push_back(*$2);
                    delete $2;
                  }
                ;
                
alias_statement : ALIAS LITERAL LITERAL
                  {
                    $$ = new SyntaxToken(SyntaxTokenType::AliasToken);
                    $$->Children().push_back(*$2);
                    $$->Children().push_back(*$3);
                    delete $2;
                    delete $3;
                  }
                ;                

if_elsif_statement : ELSIF rvalue CRLF expression_list
                     {
                       $$ = new SyntaxToken(SyntaxTokenType::IfToken);
                       $$->Children().push_back(*$2);
                       $$->Children().push_back(*$4);
                       delete $2;
                       delete $4;
                     }
                   | ELSIF rvalue CRLF expression_list ELSE expression_list
                     {
                       $$ = new SyntaxToken(SyntaxTokenType::IfToken);
                       $$->Children().push_back(*$2);
                       $$->Children().push_back(*$4);
                       $$->Children().push_back(*$6);
                       delete $2;
                       delete $4;
                       delete $6;
                     }
                   | ELSIF rvalue CRLF expression_list if_elsif_statement
                     {
                       $$ = new SyntaxToken(SyntaxTokenType::IfToken);
                       $$->Children().push_back(*$2);
                       $$->Children().push_back(*$4);
                       $$->Children().push_back(*$5);
                       delete $2;
                       delete $4;
                       delete $5;
                     }
                   ;

if_statement : IF rvalue CRLF expression_list END
               {
                 $$ = new SyntaxToken(SyntaxTokenType::IfToken);
                 $$->Children().push_back(*$2);
                 $$->Children().push_back(*$4);
                 delete $2;
                 delete $4;
               }
             | IF rvalue THEN expression_list END
               {
                 $$ = new SyntaxToken(SyntaxTokenType::IfToken);
                 $$->Children().push_back(*$2);
                 $$->Children().push_back(*$4);
                 delete $2;
                 delete $4;
               }
             | IF rvalue CRLF expression_list ELSE CRLF expression_list END
               {
                 $$ = new SyntaxToken(SyntaxTokenType::IfToken);
                 $$->Children().push_back(*$2);
                 $$->Children().push_back(*$4);
                 $$->Children().push_back(*$7);
                 delete $2;
                 delete $4;
                 delete $7;
               }
             | IF rvalue THEN expression_list ELSE expression_list END
               {
                 $$ = new SyntaxToken(SyntaxTokenType::IfToken);
                 $$->Children().push_back(*$2);
                 $$->Children().push_back(*$4);
                 $$->Children().push_back(*$6);
                 delete $2;
                 delete $4;
                 delete $6;
               }
             | IF rvalue CRLF expression_list if_elsif_statement END
               {
                 $$ = new SyntaxToken(SyntaxTokenType::IfToken);
                 $$->Children().push_back(*$2);
                 $$->Children().push_back(*$4);
                 $$->Children().push_back(*$5);
                 delete $2;
                 delete $4;
                 delete $5;
               }
             ;
               
unless_statement : UNLESS rvalue CRLF expression_list END
                   {
                     $$ = new SyntaxToken(SyntaxTokenType::UnlessToken);
                     $$->Children().push_back(*$2);
                     $$->Children().push_back(*$4);
                     delete $2;
                     delete $4;
                   }
                 ;

while_statement : WHILE rvalue CRLF while_expression_list END
                  {
                    $$ = new SyntaxToken(SyntaxTokenType::WhileToken);
                    $$->Children().push_back(*$2);
                    $$->Children().push_back(*$4);
                    delete $2;
                    delete $4;
                  }
                ;

while_expression_list : expression terminator
                        {
                          $$ = new SyntaxToken(SyntaxTokenType::WhileExpressionList);
                          $$->Children().push_back(*$1);
                          delete $1;
                        }
                      | RETRY terminator
                        {
                          $$ = new SyntaxToken(SyntaxTokenType::WhileExpressionList);
                          $$->Children().push_back(SyntaxToken(SyntaxTokenType::RetryToken));
                        }
                      | BREAK terminator
                        {
                          $$ = new SyntaxToken(SyntaxTokenType::WhileExpressionList);
                          $$->Children().push_back(SyntaxToken(SyntaxTokenType::BreakToken));
                        }
                      | while_expression_list expression terminator
                        {
                          $1->Children().push_back(*$2);
                          $$ = $1;
                          delete $2;
                        }
                      | while_expression_list RETRY terminator
                        {
                          $1->Children().push_back(SyntaxToken(SyntaxTokenType::RetryToken));
                          $$ = $1;
                        }
                      | while_expression_list BREAK terminator
                        {
                          $1->Children().push_back(SyntaxToken(SyntaxTokenType::BreakToken));
                          $$ = $1;
                        }
                      ;
case_statement : CASE rvalue CRLF case_expression_list END
                 {
                   $$ = new SyntaxToken(SyntaxTokenType::CaseToken);
                   $$->Children().push_back(*$2);
                   $$->Children().push_back(*$4);
                   delete $2;
                   delete $4;
                 }
               | CASE rvalue CRLF case_expression_list ELSE expression_list END
                 {
                   auto defaultCase = SyntaxToken(SyntaxTokenType::CaseDefaultToken);
                   defaultCase.Children().push_back(*$6);
                   $$ = new SyntaxToken(SyntaxTokenType::CaseToken);
                   $$->Children().push_back(*$2);
                   $$->Children().push_back(*$4);
                   $$->Children().push_back(defaultCase);
                   delete $2;
                   delete $4;
                   delete $6;
                 }
               ;
               
case_expression_list : WHEN rvalue CRLF expression_list
                       {
                         $$ = new SyntaxToken(SyntaxTokenType::CaseListToken);
                         auto item = SyntaxToken(SyntaxTokenType::CaseWhenToken);
                         item.Children().push_back(*$2);
                         item.Children().push_back(*$4);
                         $$->Children().push_back(item);
                         delete $2;
                         delete $4;
                       }
                     | case_expression_list WHEN rvalue CRLF expression_list
                       {
                         auto item = SyntaxToken(SyntaxTokenType::CaseWhenToken);
                         item.Children().push_back(*$3);
                         item.Children().push_back(*$5);
                         $1->Children().push_back(item);
                         $$ = $1;
                         delete $3;
                         delete $5;
                       }
                     ;
                     
ternary_statement : rvalue TERNARY_THEN rvalue TERNARY_ELSE rvalue
                    {
                      $$ = new SyntaxToken(SyntaxTokenType::TernaryToken);
                      $$->Children().push_back(*$1);
                      $$->Children().push_back(*$3);
                      $$->Children().push_back(*$5);
                      delete $1;
                      delete $3;
                      delete $5;
                    }
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
                   {
                     $$ = $2;
                   }
                 ;

array_definition_elements : rvalue
                            {
                              $$ = new SyntaxToken(SyntaxTokenType::ArrayDefinition);
                              $$->Children().push_back(*$1);
                              delete $1;
                            }
                          | array_definition_elements COMMA rvalue
                            {
                              $1->Children().push_back(*$3);
                              $$ = $1;
                              delete $3;
                            }
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
