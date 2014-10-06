import rfile.h
import rdir.h

void main()
{
	v=rf.get_param
	if v.count!=5
		return
	s=rfile.read_all_n(v[3])
	s+='\r\n'
	s+=rfile.read_all_n(v[4])
	rfile.remove('temp.h')
	rfile.write_all_n('temp.h',s)
	rf.cmd('rpp.exe -pre temp.h')
	rfile.remove('temp.h')
	rbuf<rstr> res
	proc(res,rfile.read_all_n('temp.txt'))
	rfile.remove('temp.txt')
	name=rdir.get_real_name(rdir.get_name(v[4]))+'.lua'
	rfile.write_all_n(name,res.join(' '))
	rf.cmd('luajit.exe '+name)
	rfile.remove(name)
}

bool proc(rbuf<rstr>& res,rstr& s)
{
	v=s.split('\r\n')
	rbuf<int> vline(v.count)
	for i=0;i<v.count;i++
		pos=v[i].find(' ')
		vline[i]=v[i].sub(0,pos).toint
		v[i]=v[i].sub(pos+1)
	for i=0;i<v.count;i++
		if i>0&&vline.get(i-1)!=vline[i]
			res+='\r\n'
		if v.get(i+1)=='++'
			res+=v[i]
			res+='='
			res+=v[i]
			res+='+'
			res+='1'
			i++
			continue
		if v[i]=='end'&&v.get(i+1)=='else'
			continue
		if v[i]=='else'&&v.get(i+1)=='if'
			res+='elseif'
			i++
			continue
		if v[i]=='!='
			v[i]='~='
		elif v[i]=='['
			if is_table_pre(v.get(i-1))
				right=find_symm_mbk(v,i)
				if right>=v.count
					return false
				v[i]='{'
				v[right]='}'
		res+=v[i]
		if v[i]=='else'&&v.get(i+1)=='{'
			i++
	return true
}

bool is_table_pre(rstr& s)
{
	return s=='='||s=='['||s=='('||s==','
}

int find_symm_mbk(const rbuf<rstr>& v,int begin=0)
{
	return find_symm_word_e(v,'[',']',begin)
}

int find_symm_word_e(const rbuf<rstr>& v,rstr &left,
	rstr &right,int begin=0)
{
	end=v.count
	if begin<0
		begin=0
	count=0
	for i=begin;i<end;i++
		if left==v[i]
			++count
		if right==v[i]
			--count
		if count==0
			return i
	return v.count
}