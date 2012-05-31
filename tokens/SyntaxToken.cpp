#include "SyntaxToken.h"

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
