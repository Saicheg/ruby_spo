#ifndef INTEGER_SYNTAX_TOKEN_H
#define INTEGER_SYNTAX_TOKEN_H
#include "SyntaxToken.h"

class IntegerSyntaxToken: public SyntaxToken
{
public:
	IntegerSyntaxToken(long int value);
	long int GetValue();
	void SetValue(long int value);
  double ToFloat();
  string ToString();
protected:
	long int value;
};

#endif
