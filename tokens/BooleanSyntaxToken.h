#ifndef BOOLEAN_SYNTAX_TOKEN_H
#define BOOLEAN_SYNTAX_TOKEN_H

#include "SyntaxToken.h"

class BooleanSyntaxToken: public SyntaxToken
{
public:
	BooleanSyntaxToken(bool value);
	bool GetValue();
	void SetValue(bool value);
  string ToString();
protected:
	bool value;
};

#endif
