#include "StringToken.h"

StringToken::StringToken(string value)
{
	this->str = value;
	this->type = LiteralToken;
}

string StringToken::GetValue()
{
	return this->str;
}

void StringToken::SetValue(string value)
{
	this->str = value;
}