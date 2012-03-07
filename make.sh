#!/bin/sh

FILE_LEX="ruby.lex"
FILE_C="ruby.lex.cpp"
FILE_OBJECT="ruby.lex.o"
FILE_EXECUTABLE="ruby.exec"
FILE_TEST="test.rb"

rm -f $FILE_C
flex++ -o $FILE_C $FILE_LEX
rm -f $FILE_EXECUTABLE
rm -f $FILE_OBJECT
g++ -c -o $FILE_OBJECT $FILE_C
g++ -o $FILE_EXECUTABLE $FILE_OBJECT -lfl
chmod +x $FILE_EXECUTABLE > /dev/null
echo "Testing..."
./$FILE_EXECUTABLE $FILE_TEST 

