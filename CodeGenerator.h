#ifndef CODE_GENERATOR_H
#define CODE_GENERATOR_H

#include <iostream>
#include <string>
using namespace std;
#include "Tokens.h"
#include "Utils.h"
#include <typeinfo>

class CodeGenerator
{
public:
  string Generate(SyntaxToken* token);
private:
  string GetValue(SyntaxToken* token);
  
  string GenerateFunctionDefinition(SyntaxToken* token);
  string GenerateFunctionDefinitionHeader(SyntaxToken* token);
  string GenerateFunctionIdentifierToken(SyntaxToken* token);
  string GenerateFunctionDefinitionParams(SyntaxToken* token);
  string GenerateExpressionList(SyntaxToken* token);
  string GenerateReturn(SyntaxToken* token);
  string GenerateOperationToken(SyntaxToken* token);
  string OperationSign(string type);
  string GenerateAssignment(SyntaxToken* token);
  string GenerateIfToken(SyntaxToken* token);
  string GenerateFunctionCall(SyntaxToken* token);
  string GenerateFunctionCallParams(SyntaxToken* token);
  string GenerateWhileToken(SyntaxToken* token);
  string GenerateWhileExpressionList(SyntaxToken* token);

};

#endif

