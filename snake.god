ffi=require('ffi')

ffi.cdef[
	#pragma pack(1) 
	typedef struct 
	{
		int dwSize;
		int bVisible;
	}CONSOLE_CURSOR_INFO;
	int SetConsoleCursorInfo(int hConsoleOutput,
		CONSOLE_CURSOR_INFO* lpConsoleCursorInfo);
	int system(const char* s);
	typedef struct 
	{
		unsigned short x;
		unsigned short y;
	}COORD;
	int SetConsoleCursorPosition(int hConsoleOutput,
		COORD dwCursorPosition);
	int GetStdHandle(int nStdHandle);
	int printf(const char* fmt,...);
	typedef unsigned short ushort;
	int SetConsoleTextAttribute(int h,ushort w);
	short GetAsyncKeyState(int vkey);
	int GetTickCount();
]

clear=function(v)
{
	var i
	for(i=1,table.maxn(v))
	{
		v[i]=null
	}
}

exist=function(v,a)
{
	var i
	for(i=1,table.maxn(v))
	{
		if(v[i]==a)
		{
			return true
		}
	}
	return false
}

push=function(v,a)
{
	v[table.maxn(v)+1]=a
}

push_front=function(v,a)
{
	var count=#v
	var i
	for(i=count,1,-1)
	{
		v[i+1]=v[i]
	}
	v[1]=a
}

food=function()
{
	//todo : array index unusual
	g_food=math.modf(math.random()*10000)%200
	if(exist(g_arr,g_food))
	{
		food()
	}
}

update=function()
{
	var i
	for(i=1,200)
	{
		gotoxy(i%10*2,math.modf(i/10))
		if(exist(g_arr,i))
		{
			out('бЎ')
		}
		elif(i==g_food)
		{
			out('бя')
		}
		else
		{
			out('  ')
		}
	}
}

gotoxy=function(x,y)
{
	var pos=ffi.new('COORD',[])
	pos.x=x
	pos.y=y
	ffi.C.SetConsoleCursorPosition(g_std_out,pos)
}

out=function(s)
{
	ffi.C.printf(s)
}

init=function()
{
	math.randomseed(os.time())
	g_std_out=ffi.C.GetStdHandle(-11)
	g_next=10
	clear(g_arr)
	push(g_arr,105)
	food()
	var cur_info=ffi.new('CONSOLE_CURSOR_INFO',[])
	cur_info.dwSize=1
	cur_info.bVisible=0
	ffi.C.SetConsoleCursorInfo(g_std_out,cur_info)
	ffi.C.system('mode con cols=20 lines=22')
	ffi.C.SetConsoleTextAttribute(g_std_out,0x0a)
	gotoxy(0,20)
	out(' ******************')
}

key=function()
{
	var temp
	if(ffi.C.GetAsyncKeyState(0x26)!=0)
	{
		temp=-10
	}
	elif(ffi.C.GetAsyncKeyState(0x28)!=0)
	{
		temp=10
	}
	elif(ffi.C.GetAsyncKeyState(0x25)!=0)
	{
		temp=-1
	}
	elif(ffi.C.GetAsyncKeyState(0x27)!=0)
	{
		temp=1
	}
	else
	{
		return
	}
	if(table.maxn(g_arr)<2||g_arr[2]!=g_arr[1]+temp)
	{
		g_next=temp
	}
}

check=function()
{
	var temp=g_arr[1]+g_next
	if(temp<1||temp>200||math.abs(temp%10-g_arr[1]%10)>1||exist(g_arr,temp))
	{
		return false
	}
	return true
}

g_arr=[]
init()
var start=ffi.C.GetTickCount()
while(true)
{
	key()
	if(ffi.C.GetTickCount()-start<100)
	{
		goto continue
	}
	start=ffi.C.GetTickCount()
	if(!check())
	{
		break
	}
	push_front(g_arr,g_arr[1]+g_next)
	if(g_food!=g_arr[1])
	{
		g_arr[#g_arr]=null
	}
	else
	{
		food()
	}
	update()
	::continue::
}