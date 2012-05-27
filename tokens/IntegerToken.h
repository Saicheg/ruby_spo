
#ifndef INTEGER_TOKEN_H
#define INTEGER_TOKEN_H
#include "Token.h"

class IntegerToken: public Token
{
public:
	IntegerToken(long int value);
	long int GetValue();
	void SetValue(long int value);
protected:
	long int value;
};

#endif
