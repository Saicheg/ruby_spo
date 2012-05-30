#include "FloatSyntaxToken.h"

FloatSyntaxToken::FloatSyntaxToken(double value /* = 0.0*/)
{
	this->value = value;
	this->type = SyntaxTokenType::FloatToken;
}

double FloatSyntaxToken::GetValue()
{
	return this->value;
}

void FloatSyntaxToken::SetValue(double value)
{
	this->value = value;
}
