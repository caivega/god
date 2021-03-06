class rmutex
{
	int m_mutex
	
	~rmutex()
	{
		rf.mutex_del m_mutex
	}
	
	rmutex()
	{
		m_mutex=rf.mutex_init
	}
	
	enter()
	{
		rf.mutex_enter m_mutex
	}
	
	leave()
	{
		rf.mutex_leave m_mutex
	}
}
