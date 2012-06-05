#include "SyntaxToken.h"
#include "../CodeGenerator.h"

SyntaxToken::SyntaxToken(SyntaxTokenType type)
{
	this->type = type;
	children.clear();
}

SyntaxTokenType SyntaxToken::GetType()
{
	return this->type;
}
void SyntaxToken::SetType(SyntaxTokenType type)
{
	this->type = type;
}

vector<SyntaxToken*>& SyntaxToken::Children()
{
	return this->children;
}

string SyntaxToken::GenerateCode()
{
  CodeGenerator* g = new CodeGenerator();
  string code = g->Generate(this);
  delete(g);
  return code;
}
