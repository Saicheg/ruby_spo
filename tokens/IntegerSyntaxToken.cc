#include "IntegerSyntaxToken.h"
#include <sstream>

IntegerSyntaxToken::IntegerSyntaxToken(long int value)
{
	this->value = value;
	this->type = SyntaxTokenType::IntegerToken;
}

long int IntegerSyntaxToken::GetValue()
{
	return this->value;
}

void IntegerSyntaxToken::SetValue(long int value)
{
	this->value = value;
}

double IntegerSyntaxToken::ToFloat()
{
  return (double) value;
}

string IntegerSyntaxToken::ToString()
{
  ostringstream s;
  s << value;
  return s.str();
}
