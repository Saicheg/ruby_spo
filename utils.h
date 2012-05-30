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

#endif