#include "StringSyntaxToken.h"
#include <sstream>

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

long int StringSyntaxToken::ToInteger()
{
  long int result = 0;
  try
  {
    istringstream buffer(str);
    buffer >> result;
  }
  catch(exception)
  {
    /* Fuck this all*/
  }
  return result; 
}

double StringSyntaxToken::ToFloat()
{
  double result = 0;
  try
  {
    istringstream buffer(str);
    buffer >> result;
  }
  catch(exception)
  {
    /* Fuck this all*/
  }
  return result; 

}
