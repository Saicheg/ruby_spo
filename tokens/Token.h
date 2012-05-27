#ifndef TOKEN_H
#define TOKEN_H

#include <string>
#include <vector>
using namespace std;

#include "SyntaxTokenType.h"

class Token
{
public:
	Token(SyntaxTokenType type);
	virtual ~Token(){};
	virtual SyntaxTokenType GetType();
	virtual void SetType(SyntaxTokenType type);
	vector<Token> Children();
protected:
	SyntaxTokenType type;
	vector<Token> children;
};

#endif
