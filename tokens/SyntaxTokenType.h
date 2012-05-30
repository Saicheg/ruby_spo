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
	CasesListToken,
	CasesDefaultCaseToken,
	
	AliasToken,
	ReturnToken,
	WhileToken,
	UnlessToken,
	
	Assignment,
	ArrayDefinition,
	ArraySelector,
	OperationToken,
	OperationTypeToken
};

#endif
