#ifndef SYNTAX_TOKEN_TYPE_H
#define SYNTAX_TOKEN_TYPE_H

enum SyntaxTokenType
{
	NilToken,
	IntegerToken,
	FloatToken,
	LiteralToken,
	BooleanToken,

	IdentifierToken,
	GlobalIdentifierToken,
	FunctionIdentifierToken,

	ExpressionList,
	
	FunctionDefinition,
	FunctionDefinitionHeader,
	FunctionDefinitionParams,
	FunctionCall,
	FunctionCallParams,
	
	IfToken,
	TernaryToken,
	UndefToken,
	RequireToken,
	DefinedToken,
	
	CaseToken,
	CaseListToken,
	CaseWhenToken,
	CaseDefaultToken,
	
	AliasToken,
	ReturnToken,
	UnlessToken,
	BreakToken,
	RetryToken,

	WhileToken,
	WhileExpressionList,
	
	Assignment,
	ArrayDefinition,
	ArraySelector,
	OperationToken,
	OperationTypeToken
};

#endif
