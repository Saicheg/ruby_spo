#include "FloatToken.h"

FloatToken::FloatToken(double value /* = 0.0*/)
{
	this->value = value;
	this->type = FloatToken;
}

double GetValue()
{
	return this->value;
}

void FloatToken::SetValue(double value)
{
	this->value = value;
}
