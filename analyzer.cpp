#include "analyzer.h"


void Analyzer::Show(SyntaxToken* root)
{
  PrintNode(root);
}

void Analyzer::PrintNode(SyntaxToken* token, int indent)
{
  if(token == NULL) return;

  for(int i=0; i < indent;i++) cout << "  ";

  cout << GetTypeName(token->GetType()) << endl;

  for(auto i = token->Children().begin(); i != token->Children().end(); ++i)
  {
    PrintNode(*i, indent+1);
  }

}

string Analyzer::GetTypeName(SyntaxTokenType tokenType)
{
  switch(tokenType)
  {
    case SyntaxTokenType::NilToken:
      return "NilToken";
    default:
      return "Some shit!";  
  }
}
