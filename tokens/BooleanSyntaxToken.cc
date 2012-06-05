#include "BooleanSyntaxToken.h"

BooleanSyntaxToken::BooleanSyntaxToken(bool value)
{
	this->value = value;
	this->type = SyntaxTokenType::BooleanToken;
}

bool BooleanSyntaxToken::GetValue()
{
	return value;
}

void BooleanSyntaxToken::SetValue(bool value)
{
	this->value = value;
}

string BooleanSyntaxToken::ToString()
{
  return value ? "true" : "false";
}
