#include "FloatToken.h"

FloatToken::FloatToken(double value /* = 0.0*/)
{
	this->value = value;
	this->type = SyntaxTokenType::FloatToken;
}

double FloatToken::GetValue()
{
	return this->value;
}

void FloatToken::SetValue(double value)
{
	this->value = value;
}
