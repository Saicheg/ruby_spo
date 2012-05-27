#include "IntegerToken.h"

IntegerToken::IntegerToken(long int value)
{
	this->value = value;
	this->type = IntegerToken;
}

long int IntegerToken::GetValue()
{
	return this->value;
}

void SetValue(long int value)
{
	this->value = value;
}