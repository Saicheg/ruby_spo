#include "CodeGenerator.h"

string CodeGenerator::Generate(SyntaxToken* token)
{
  string code;

  switch(token->GetType())
  {
    case SyntaxTokenType::NilToken:
      return GetValue(token);
    
    case SyntaxTokenType::ExpressionList:
      return GenerateExpressionList(token);
    
    case SyntaxTokenType::IntegerToken:
      return GetValue(token);
    
    case SyntaxTokenType::FloatToken:
      return GetValue(token);
    
    case SyntaxTokenType::LiteralToken:
      return GetValue(token);
   
    case SyntaxTokenType::BooleanToken:
      return GetValue(token);
        
    case SyntaxTokenType::IdentifierToken:
      return GetValue(token);
   
    case SyntaxTokenType::GlobalIdentifierToken:
      return GetValue(token);
    
    case SyntaxTokenType::FunctionIdentifierToken:
      return GenerateFunctionIdentifierToken(token);
  
    case SyntaxTokenType::FunctionDefinition:
      return GenerateFunctionDefinition(token);
    
    case SyntaxTokenType::FunctionDefinitionHeader:
      return GenerateFunctionDefinitionHeader(token);
  
    case SyntaxTokenType::FunctionDefinitionParams:
      return GenerateFunctionDefinitionParams(token);

    case SyntaxTokenType::FunctionCall:
      return GenerateFunctionCall(token);
  
    case SyntaxTokenType::FunctionCallParams:
      return GenerateFunctionCallParams(token);

    case SyntaxTokenType::IfToken:
      return GenerateIfToken(token);
    
    case SyntaxTokenType::TernaryToken:
      return "TernaryToken";
  
    case SyntaxTokenType::UndefToken:
      return "UndefToken";

    case SyntaxTokenType::RequireToken:
      return "/*require was here*/";
    
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
      return GenerateReturn(token);
  
    case SyntaxTokenType::UnlessToken:
      return "UnlessToken";

    case SyntaxTokenType::BreakToken:
      return "BreakToken";
    
    case SyntaxTokenType::RetryToken:
      return "RetryToken";
  
    case SyntaxTokenType::WhileToken:
      return GenerateWhileToken(token);

    case SyntaxTokenType::WhileExpressionList:
      return GenerateWhileExpressionList(token);
    
    case SyntaxTokenType::Assignment:
      return GenerateAssignment(token);
  
    case SyntaxTokenType::ArrayDefinition:
      return "ArrayDefinition";

    case SyntaxTokenType::ArraySelector:
      return "ArraySelector";
    
    case SyntaxTokenType::OperationToken:
      return GenerateOperationToken(token);
  
    case SyntaxTokenType::OperationTypeToken:
      return "OperationTypeToken";

    default:
      return "Some shit!";
  }
}
string CodeGenerator::GetValue(SyntaxToken* token)
{
  if(typeid(*token) == typeid(StringSyntaxToken))
  {
    return dynamic_cast<StringSyntaxToken*>(token)->GetValue();
  }
  else if (typeid(*token) == typeid(FloatSyntaxToken))
  {
    return ToString(dynamic_cast<FloatSyntaxToken*>(token)->ToString());
  }
  else if (typeid(*token) == typeid(IntegerSyntaxToken))
  {
    return ToString(dynamic_cast<IntegerSyntaxToken*>(token)->ToString());
  }
  else if (typeid(*token) == typeid(BooleanSyntaxToken))
  {
    return dynamic_cast<BooleanSyntaxToken*>(token)->ToString();
  }

  return "";
}

string CodeGenerator::GenerateFunctionDefinition(SyntaxToken* token)
{
  string code;
  for(auto i = token->Children().begin(); i != token->Children().end(); ++i)
  {
    code += (*i)->GenerateCode();
  }
  return code;
}

string CodeGenerator::GenerateFunctionDefinitionHeader(SyntaxToken* token)
{
  string code;
  for(auto i = token->Children().begin(); i != token->Children().end(); ++i)
  {
    if((*i)->GetType() == SyntaxTokenType::IdentifierToken)
    {
      code += GenerateFunctionIdentifierToken(*i);
    }
    else
    {
      code += (*i)->GenerateCode();
    }
  }
  return code;
}

string CodeGenerator::GenerateFunctionIdentifierToken(SyntaxToken* token)
{  
  string code;
  code = "var " + GetValue(token) + " = function";
  return code;
  
}

string CodeGenerator::GenerateFunctionDefinitionParams(SyntaxToken* token)
{
  string code;
  code = "(";
  for(auto i = token->Children().begin(); i != token->Children().end(); ++i)
  {
    code += " ";
    code += GetValue(*i);
    code += ",";
  }
  code = code.substr(0, code.size()-1); // remove last comma
  code += " )";
  return code;
}

string CodeGenerator::GenerateExpressionList(SyntaxToken* token)
{
  string code;
  code = "{\n";
  for(auto i = token->Children().begin(); i != token->Children().end(); ++i)
  {
    code += "  ";
    code += (*i)->GenerateCode();
  }
  code += "\n}";
  return code;
}

string CodeGenerator::GenerateReturn(SyntaxToken* token)
{
  string code;
  code = "return ";
  for(auto i = token->Children().begin(); i != token->Children().end(); ++i)
  {
    code += (*i)->GenerateCode();
  }
  code += ";";
  return code;
}

string CodeGenerator::GenerateOperationToken(SyntaxToken* token)
{
  string code;
  string operation = GetValue(token);

  if(operation == "NOT")
  {
    code = "!" + token->Children()[0]->GenerateCode();
  }
  else if (operation == "BIT_NOT")
  {
    code = "~" + token->Children()[0]->GenerateCode();
  }
  else if (operation == "EXP")
  {    
      code = "Math.pow(" + token->Children()[0]->GenerateCode() + ", " +
                           token->Children()[1]->GenerateCode() + ")" ;
  }
  else
  {
      code = token->Children()[0]->GenerateCode() 
             + " "
             + OperationSign(operation) 
             + " "
             + token->Children()[1]->GenerateCode();
  }
  return code;

}

string CodeGenerator::OperationSign(string type)
{ 
  if(type == "EQUAL"){ return "=="; }
  else if(type == "NOT_EQUAL") { return  "!="; }
  else if(type == "LESS_EQUAL") { return "<="; }
  else if(type == "LESS") { return "<"; }
  else if(type == "GREATER") { return ">"; }
  else if(type == "GREATER_EQUAL") { return ">="; }
  else if(type == "OR") { return "||"; }
  else if(type == "AND") { return "&&"; }
  else if(type == "BIT_OR") { return "|"; }
  else if(type == "BIT_XOR") { return "^"; }
  else if(type == "BIT_AND") { return "&"; }
  else if(type == "BIT_SHL") { return "<<"; }
  else if(type == "BIT_SHR") { return ">>"; }
  else if(type == "PLUS") { return "+"; }
  else if(type == "MINUS") { return "-"; }
  else if(type == "MUL") { return "*"; }
  else if(type == "DIV") { return "\\"; }
  else if(type == "MOD") { return "%"; }
  return "wtf?";
}

string CodeGenerator::GenerateAssignment(SyntaxToken* token)
{
  string code;
  code += token->Children()[0]->GenerateCode();
  code += " = ";
  code += token->Children()[1]->GenerateCode();
  code += ";"; 
  return code;
}

string CodeGenerator::GenerateIfToken(SyntaxToken* token)
{
  string code;
  if(token->Children().size() == 2)
  {
    code += "if(";
    code += token->Children()[0]->GenerateCode();
    code += ")\n";
    code += token->Children()[1]->GenerateCode();
  }
  else  
  {
    code += "if(";
    code += token->Children()[0]->GenerateCode();
    code += ")\n";
    code += token->Children()[1]->GenerateCode();
    code += "else\n";
    code += token->Children()[2]->GenerateCode();
    code += ")\n";
  }
  return code;
}

string CodeGenerator::GenerateFunctionCall(SyntaxToken* token)
{
  string code;
  for(auto i = token->Children().begin(); i != token->Children().end(); ++i)
  {
    code += (*i)->GenerateCode();
  }
  return code;  
}

string CodeGenerator::GenerateFunctionCallParams(SyntaxToken* token)
{
  if (token->Children().size() == 0)
  {
    return "()";
  }
  
  string code;
  code = "(";
  for(auto i = token->Children().begin(); i != token->Children().end(); ++i)
  {
    code += " ";
    code += GetValue(*i);
    code += ",";
  }
  code = code.substr(0, code.size()-1); // remove last comma
  code += " )";
  return code;
}


string CodeGenerator::GenerateWhileToken(SyntaxToken* token)
{
  string code;
  code += "while(";
  code += token->Children()[0]->GenerateCode();
  code += ")";
  code += token->Children()[1]->GenerateCode();             
  return code;
}

string CodeGenerator::GenerateWhileExpressionList(SyntaxToken* token)
{
  string code;
  code = "{\n";
  for(auto i = token->Children().begin(); i != token->Children().end(); ++i)
  {
    code += "  ";
    code += (*i)->GenerateCode();
  }
  code += "\n}";
   return code;
}
