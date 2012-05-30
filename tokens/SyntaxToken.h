#ifndef SYNTAX_TOKEN_H
#define SYNTAX_TOKEN_H

#include <string>
#include <vector>
using namespace std;

#include "SyntaxTokenType.h"

class SyntaxToken
{
public:
	SyntaxToken(SyntaxTokenType type = SyntaxTokenType::NilToken);
	virtual ~SyntaxToken(){};
	virtual SyntaxTokenType GetType();
	virtual void SetType(SyntaxTokenType type);
	vector<SyntaxToken> Children();
protected:
	SyntaxTokenType type;
	vector<SyntaxToken> children;
};

#endif
