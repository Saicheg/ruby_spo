#ifndef BOOLEAN_TOKEN_H
#define BOOLEAN_TOKEN_H

#include "Token.h"

class BooleanToken: public Token
{
public:
	BooleanToken(bool value);
	bool GetValue();
	void SetValue(bool value);
protected:
	bool value;
};

#endif
