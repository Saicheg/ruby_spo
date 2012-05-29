#include "StringToken.h"

StringToken::StringToken(const string& value)
{
	this->str = value;
	this->type = SyntaxTokenType::LiteralToken;
}

string StringToken::GetValue()
{
	return this->str;
}

void StringToken::SetValue(const string& value)
{
	this->str = value;
}