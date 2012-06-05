#include "Interpreter.h"

void Interpreter::Process(string filename, SyntaxToken* root)
{
  ofstream file;
  file.open (filename, ios::trunc | ios::out );

  for(auto i = root->Children().begin(); i != root->Children().end(); ++i)
  {
    file << (*i)->GenerateCode() + "\n\n";
  }

  file.close();

}
