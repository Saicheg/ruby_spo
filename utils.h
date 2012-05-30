#ifndef UTILS_H
#define UTILS_H

#include <sstream>
using namespace std;

double s2double( const std::string& s )
{
	istringstream i(s);
	double x;
	if (!(i >> x))
		return 0;
	return x;
} 

long int s2int( const string& s)
{
	std::istringstream i(s);
	long int x;
	if (!(i >> x))
		return 0;
	return x;
} 

SyntaxToken* CreateOperationToken(string operationType, SyntaxToken* arg1, SyntaxToken* arg2)
{
    SyntaxToken* t = new SyntaxToken(SyntaxTokenType::OperationToken);
    
    SyntaxToken* opType = new StringSyntaxToken(operationType);
    opType->SetType(SyntaxTokenType::OperationTypeToken);
    t->Children().push_back(*opType);
    delete opType;

    if(arg1 == NULL)
    {
    	return NULL;	
    }

    t->Children().push_back(*arg1);

    if(arg2 != NULL)
    {
    	t->Children().push_back(*arg2);
    }
    return t;
}

SyntaxToken* CreateAssignmentToken(SyntaxToken* arg1, SyntaxToken* arg2)
{    
    SyntaxToken* t = new SyntaxToken(SyntaxTokenType::Assignment);
 
    if(arg1 == NULL || arg2 == NULL)
    {
        return NULL;    
    }

    t->Children().push_back(*arg1);
    t->Children().push_back(*arg2);

    return t;
}

#endif
