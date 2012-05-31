5

require 'test'


def greater?(a,b)
  return a>=b
end

def biggest(a,b)
  (greater?(a,b)) ? a : b
end

def pi
  return (22/7)
end

def strlen(str)
  i=0
  while (str[i] != "\n")
    i+=1
  end
  i
end

# Define variables

a = 5
b = 6
c = a + b

while (greater?(a,c))
  c -= 1
end

if (c > pi())
  c = a || b
else
  c = !(a && b) || (a & b)
end


if (c > pi())
  c = a || b
elsif (c>5)
  return 4
elsif (c>5 && c<3)
  return 4
else
  return 4
end

k = defined?(a)

str1 = "i am a single quote string"
str2 = "i am a double quotes string"
str3 = 'i am strin with escaped things inside test \t\t \ntest'
