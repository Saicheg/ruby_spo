#ifndef STRING_TOKEN_H
#define STRING_TOKEN_H

#include <string>
using namespace std;

#include "Token.h"

class StringToken: public Token
{
public:
	StringToken(const string& value);
	string GetValue();
	void SetValue(const string& value);
protected:
	string str;
};

#endif
