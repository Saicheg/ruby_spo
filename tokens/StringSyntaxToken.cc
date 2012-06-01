#include "StringSyntaxToken.h"

StringSyntaxToken::StringSyntaxToken(const string& value)
{
	this->str = value;
	this->type = SyntaxTokenType::LiteralToken;
}

string StringSyntaxToken::GetValue()
{
	return this->str;
}

void StringSyntaxToken::SetValue(const string& value)
{
	this->str = value;
}