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
	FunctionDefinitionName,
	FunctionDefinitionParams,
	FunctionCall,
	FunctionCallParams,
	
	IfToken,
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
	ArrayDefinitionElements,
	ArraySelector,
	OperationToken,
	OperationTypeToken
};

#endif
