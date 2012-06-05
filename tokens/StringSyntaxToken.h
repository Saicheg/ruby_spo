#ifndef STRING_SYNTAX_TOKEN_H
#define STRING_SYNTAX_TOKEN_H

#include <string>
using namespace std;

#include "SyntaxToken.h"

class StringSyntaxToken: public SyntaxToken
{
public:
	StringSyntaxToken(const string& value);
	string GetValue();
	void SetValue(const string& value);
  long int ToInteger();
  double ToFloat();
protected:
	string str;
};

#endif
