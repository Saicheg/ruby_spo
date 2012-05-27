#include "Token.h"

Token::Token(SyntaxTokenType type)
{
	this->type = type;
	children.clear();
}

SyntaxTokenType Token::GetType()
{
	return this->type;
}
void Token::SetType(SyntaxTokenType type)
{
	this->type = type;
}

vector<Token> Token::Children()
{
	return this->children;
}
