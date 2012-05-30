#include "IntegerSyntaxToken.h"

IntegerSyntaxToken::IntegerSyntaxToken(long int value)
{
	this->value = value;
	this->type = SyntaxTokenType::IntegerToken;
}

long int IntegerSyntaxToken::GetValue()
{
	return this->value;
}

void IntegerSyntaxToken::SetValue(long int value)
{
	this->value = value;
}