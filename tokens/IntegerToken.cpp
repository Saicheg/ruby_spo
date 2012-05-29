#include "IntegerToken.h"

IntegerToken::IntegerToken(long int value)
{
	this->value = value;
	this->type = SyntaxTokenType::IntegerToken;
}

long int IntegerToken::GetValue()
{
	return this->value;
}

void IntegerToken::SetValue(long int value)
{
	this->value = value;
}