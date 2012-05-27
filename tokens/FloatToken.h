#ifndef FLOAT_TOKEN_H
#define FLOAT_TOKEN_H
#include "Token.h"

class FloatToken : public Token
{
public:
	FloatToken(double value = 0.0);
	void SetValue(double value);
	double GetValue();
protected:
	double value;
};

#endif
