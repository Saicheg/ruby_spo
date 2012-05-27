#include "BooleanToken.h"

BooleanToken::BooleanToken(bool value)
{
	this->value = value;
	this->type = BooleanToken;
}

bool BooleanToken::GetValue()
{
	return value;
}

void BooleanToken::SetValue(bool value)
{
	this->value = value;
}