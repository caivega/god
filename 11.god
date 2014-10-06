print('123');print('455');

print('a'..'b')


var f
f=function(a){
	if(a<=1)
	{
		return 1
	}
	return f(a-1)*a
}
print(f(5))

var i=0
while(i<10)
{
	print(i)
	i++
}

for(i=1,10)
{
	print(i)
}

var b=['abc','123',test=111]
print(b[1])
print(b.test)
print(b['test'])

i=0
while(i<11)
{
	if(i==5)
	{
		goto continue
	}
	print(i)
	::continue::
	i++
}

if(i==2)
{
	print('equal')
}
else
{
	print('notequal')
}

if(i==2)
{
	print('equal')
}
else if(i==11)
{
	print('111')
}

if(i==11)
{
	print('222')
}

if(i==2)
{
	print('equal')
}
elseif(i==3)
{
	print('111')
}
else
{
	print('other')
}

if(i!=3)
{
	print('ok')
}

var list=['a','b',c=123,f=function(a){
	return a*2
}]
print(list[1])
print(list['c'])
print(list.f(3))

if(i==3||i==11)
{
	print(i)
}

if(!(i==3))
{
	print(i)
}

if(i==3&&i==11)
{
	print(i)
}
else
{
	print('not')
}


