#include <iostream>
#include <bobcat/readlinestream>

#include "Scanner.h"
#include "Parser.h"
#include "Analyzer.h"

using namespace std;
using namespace FBB;



int main()
{
    Parser parser;
    parser.parse();
    
    Analyzer a;
    a.Show(parser.root);
}
