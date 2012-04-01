=begin

This is a test program.

=end

require 'test'


def greater?(a,b)
  return a>=b
end

def biggest(a,b)
  greater?(a,b) ? a : b
end

def pi
  return (22/7)
end

def strlen(str)
  i=0
  while str[i] != "\n"
    i+=1
  end
end

# Define variables

a = 5
b = 6
c = a + b

c -= 1 while greater?(a,c)

if c > pi
  c = a || b
else
  c = !(a && b) || (a & b)
end

str1 = "i am a single quote string"
str2 = "i am a double quotes string"
str3 = 'i am strin with escaped things inside test \t\t \ntest'
