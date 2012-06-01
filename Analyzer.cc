#include "Analyzer.h"



void Analyzer::Show(SyntaxToken* root)
{
  PrintNode(root);
}

void Analyzer::PrintNode(SyntaxToken* token, int indent)
{
  if(token == NULL) return;

  for(int i=0; i < indent;i++) cout << "  ";

  cout << GetTypeName(token->GetType()) << " (" << token->Children().size() << " children) ";  
  cout << "[" << GetValue(token) << "]" << endl;

  for(auto i = token->Children().begin(); i != token->Children().end(); ++i)
  {
    PrintNode(*i, indent+1);
  }

}

string Analyzer::GetValue(SyntaxToken* token)
{
  if(typeid(*token) == typeid(StringSyntaxToken))
  {
    return dynamic_cast<StringSyntaxToken*>(token)->GetValue();
  }
  else if (typeid(*token) == typeid(FloatSyntaxToken))
  {
    return ToString(dynamic_cast<FloatSyntaxToken*>(token)->GetValue());
  }
  else if (typeid(*token) == typeid(IntegerSyntaxToken))
  {
    return ToString(dynamic_cast<IntegerSyntaxToken*>(token)->GetValue());
  }
  else if (typeid(*token) == typeid(BooleanSyntaxToken))
  {
    return ToString(dynamic_cast<BooleanSyntaxToken*>(token)->GetValue());
  }
  return "";

}

string Analyzer::GetTypeName(SyntaxTokenType tokenType)
{
  switch(tokenType)
  {
    case SyntaxTokenType::NilToken:
      return "Nil token";
    
    case SyntaxTokenType::ExpressionList:
      return "Expression list";
    
    case SyntaxTokenType::IntegerToken:
      return "IntegerToken";
  
    case SyntaxTokenType::FloatToken:
      return "FloatToken";
    
    case SyntaxTokenType::LiteralToken:
      return "LiteralToken";
  
    case SyntaxTokenType::BooleanToken:
      return "BooleanToken";
    
    case SyntaxTokenType::IdentifierToken:
      return "IdentifierToken";
  
    case SyntaxTokenType::GlobalIdentifierToken:
      return "GlobalIdentifierToken";
    
    case SyntaxTokenType::FunctionIdentifierToken:
      return "FunctionIdentifierToken";
  
    case SyntaxTokenType::FunctionDefinition:
      return "FunctionDefinition";
    
    case SyntaxTokenType::FunctionDefinitionHeader:
      return "FunctionDefinitionHeader";
  
    case SyntaxTokenType::FunctionDefinitionParams:
      return "FunctionDefinitionParams";
    
    case SyntaxTokenType::FunctionCall:
      return "FunctionCall";
  
    case SyntaxTokenType::FunctionCallParams:
      return "FunctionCallParams";

    case SyntaxTokenType::IfToken:
      return "IfToken";
    
    case SyntaxTokenType::TernaryToken:
      return "TernaryToken";
  
    case SyntaxTokenType::UndefToken:
      return "UndefToken";

    case SyntaxTokenType::RequireToken:
      return "RequireToken";
    
    case SyntaxTokenType::DefinedToken:
      return "DefinedToken";
  
    case SyntaxTokenType::CaseToken:
      return "CaseToken";

    case SyntaxTokenType::CaseListToken:
      return "CaseListToken";
    
    case SyntaxTokenType::CaseWhenToken:
      return "CaseWhenToken";
  
    case SyntaxTokenType::CaseDefaultToken:
      return "CaseDefaultToken";

    case SyntaxTokenType::AliasToken:
      return "AliasToken";
    
    case SyntaxTokenType::ReturnToken:
      return "ReturnToken";
  
    case SyntaxTokenType::UnlessToken:
      return "UnlessToken";

    case SyntaxTokenType::BreakToken:
      return "BreakToken";
    
    case SyntaxTokenType::RetryToken:
      return "RetryToken";
  
    case SyntaxTokenType::WhileToken:
      return "WhileToken";

    case SyntaxTokenType::WhileExpressionList:
      return "WhileExpressionList";
    
    case SyntaxTokenType::Assignment:
      return "Assignment";
  
    case SyntaxTokenType::ArrayDefinition:
      return "ArrayDefinition";

    case SyntaxTokenType::ArraySelector:
      return "ArraySelector";
    
    case SyntaxTokenType::OperationToken:
      return "OperationToken";
  
    case SyntaxTokenType::OperationTypeToken:
      return "OperationTypeToken";

    default:
      return "Some shit!";  
  }
}
