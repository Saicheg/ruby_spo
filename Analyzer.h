#ifndef ANALYZER_H
#define ANALYZER_H

#include <iostream>
#include <string>
using namespace std;
#include "Tokens.h"
#include "Utils.h"
#include <typeinfo>

class Analyzer
{

public:
  void Show(SyntaxToken* root);

private:
  void PrintNode(SyntaxToken* token, int indent = 0);
  string GetTypeName(SyntaxTokenType tokenType);
  string GetValue(SyntaxToken* token);

};

#endif
