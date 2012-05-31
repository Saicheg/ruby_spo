#ifndef UTILS_H
#define UTILS_H

#include <sstream>
using namespace std;

#include "Tokens.h"

inline double s2double( const std::string& s )
{
	istringstream i(s);
	double x;
	if (!(i >> x))
		return 0;
	return x;
} 

inline long int s2int( const string& s)
{
	std::istringstream i(s);
	long int x;
	if (!(i >> x))
		return 0;
	return x;
} 

inline SyntaxToken* CreateOperationToken(string operationType, SyntaxToken* arg1, SyntaxToken* arg2)
{
    auto t = new StringSyntaxToken(operationType);
    t->SetType(SyntaxTokenType::OperationToken);

    if(arg1 == NULL)
    {
    	return NULL;	
    }

    t->Children().push_back(arg1);

    if(arg2 != NULL)
    {
    	t->Children().push_back(arg2);
    }
    return t;
}

inline SyntaxToken* CreateAssignmentToken(SyntaxToken* arg1, SyntaxToken* arg2)
{    
    SyntaxToken* t = new SyntaxToken(SyntaxTokenType::Assignment);
 
    if(arg1 == NULL || arg2 == NULL)
    {
        return NULL;    
    }

    t->Children().push_back(arg1);
    t->Children().push_back(arg2);

    return t;
}

template<class T> 
string ToString(T value)
{
    std::ostringstream strs;
    strs << value;
    return strs.str();
}

#endif
