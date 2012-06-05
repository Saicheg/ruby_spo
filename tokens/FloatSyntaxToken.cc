#include "FloatSyntaxToken.h"
#include <sstream>

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

string FloatSyntaxToken::ToString()
{
  ostringstream s;
  s << value;
  return s.str();
}

int FloatSyntaxToken::ToInteger()
{
  return (long int)value; 
}
