#ifndef FLOAT_SYNTAX_TOKEN_H
#define FLOAT_SYNTAX_TOKEN_H
#include "SyntaxToken.h"


class FloatSyntaxToken: public SyntaxToken
{
public:
	FloatSyntaxToken(double value = 0.0);
	void SetValue(double value);
	double GetValue();
  string ToString();
  int ToInteger();
protected:
	double value;
};

#endif
