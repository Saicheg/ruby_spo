#include "analyzer.h"


void Analyzer::Show(SyntaxToken* root)
{
  PrintNode(root);
}

void Analyzer::PrintNode(SyntaxToken* token, int indent)
{
  if(token == NULL) return;

  for(int i=0; i < indent;i++) cout << "  ";

  cout << GetTypeName(token->GetType()) << " (" << token->Children().size() << " children)" << endl;

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
      return "Nil token";
    case SyntaxTokenType::ExpressionList:
      return "Expression list";
    default:
      return "Some shit!";  
  }
}
