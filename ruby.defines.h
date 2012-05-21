#include <string>
using namespace std;

enum SyntaxTokenType
{
	EmptyToken,
	BooleanToken,
	NilToken,
	
	IntegerToken,
	FloatToken,
	LiteralToken,
	CharToken,
	IdentifierToken,

	ExpressionList,
	
	FunctionDefinition,
	FunctionDefinitionName,
	FunctionDefinitionParams,
	FunctionCall,
	FunctionCallParams,
	
	IfToken,
	UndefToken,
	RequireToken
	
	CaseToken,
	CasesListToken,
	CasesDefaultCaseToken,
	
	AliasToken,
	ReturnToken
	WhileToken,
	UnlessToken
	
	Assignment,
	ArrayDefinition,
	ArrayDefinitionElements,
	ArraySelector,
	OperationToken,
	OperationTypeToken
};

class SyntaxToken
{
public:
	SyntaxToken(SyntaxTokenType type);
	vector<SyntaxToken> NestedTokens;
	string StringValue;
	int IntegerValue;
	double DoubleValue;
};
