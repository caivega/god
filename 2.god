var f=function(a){
	return a*2
}

print(f(3))


b=function(...){
	arg=[...]
	print(#arg)
}

b(9)
b(9,8)


c=function(a){
	return a*2,a*3
}

print(c(4))