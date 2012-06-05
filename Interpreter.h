#ifndef INTERPRETER_H
#define INTERPRETER_H

#include <iostream>
#include <fstream>
#include <string>
using namespace std;
#include "Tokens.h"
#include "Utils.h"
#include <typeinfo>

class Interpreter
{

public:
  void Process(string filename, SyntaxToken* root);

};

#endif
