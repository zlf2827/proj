<%
dim err_01, err_02, err_03, err_04, err_05, err_06, err_07, err_08, err_09, err_10, err_11, err_12, err_13, err_14, err_15, err_16, err_17
dim channellistInfo(1),searchlistInfo(1),pageRunStr(2),topicpageInfo(0),newspageInfo(0)
dim str_01, str_02, str_03, str_04, str_05, str_06, str_07, str_08, str_09, str_10, str_11, str_12, str_13, str_14, str_15, str_16

if setting.Alias="cn" then	
	err_01="���ݿ����Ӵ���"
	err_02="���Ա������ô���"
	err_03="ִ��SQL������"
	err_04="st"&"ream����ʵ������ʧ��"
	err_05="F"&"SO����ʵ������ʧ��" 
	err_06="�����ļ�ʧ��"
	err_07="�����б�δָ������"
	err_08="�����б�δָ����"
	err_09="д���ļ�ʧ��"	
	err_10="�����ļ���ʧ��"
	err_11="ɾ���ļ���ʧ��"	
	err_12="ɾ���ļ�ʧ��"	
	err_13="�ļ��в�����"
	err_14="�ƶ��ļ���ʧ��"
	err_15="������Ĭ������"
	err_16="ģ���ļ�������"
	err_17="����ǰ�����û����޲鿴Ȩ�ޣ�"
		
	str_01="��ҳ"
	str_02="βҳ"
	str_03="��һҳ"
	str_04="��һҳ"
	str_05="ҳ��" 
	str_06="��"
	str_07="ҳ"
	str_08=" "
	str_09=""	
	str_10=" "
	str_11=""	
	str_12=""	
	str_13=""
	str_14=""
	str_15=""
	str_16=""
	
	newspageInfo(0)="<font color='red'> </font>"
	channellistInfo(0)="<font color='red'>  </font>":channellistInfo(1)="ָ���������"
	searchlistInfo(0)=""
	pageRunStr(0)="ҳ��ִ��ʱ��: ":pageRunStr(1)="��&nbsp;":pageRunStr(2)="�����ݲ�ѯ"
	
else
	err_01="Database Connection Error!"
	err_02="Language alias setting error!"
	err_03="Execute SQL statement error!"
	err_04="St"&"ream object instance creation failed!"
	err_05="F"&"SO object instance creation failed!" 
	err_06="Load file failed!"
	err_07="Data list the primary key is not specified!"
	err_08="Data list table is not specified!"
	err_09="Write to file failed!"	
	err_10="Failed to create the folder!"
	err_11="Failed to delete folder!"	
	err_12="Delete file failed!"	
	err_13="Folder does not exist!"
	err_14="Move Folder fails!"
	err_15="������Ĭ������"
	err_16="ģ���ļ�������"
	err_17="����ǰ�����û����޲鿴Ȩ�ޣ�"
	
	
	str_01="Home page"
	str_02="Last page"
	str_03="Previous page"
	str_04="Next page"
	str_05="Page"
	str_06="Total"
	str_07="Page"
	str_08="Sorry, no records of the category"
	str_09="Sorry, the keyword "
	str_10="no record"
	
	newspageInfo(0)="<font color='red'> Sorry, no content! </font>"
	channellistInfo(0)="<font color='red'> Sorry, no content! </font>":channellistInfo(1)="Specifies the classification error!"
	searchlistInfo(0)="Sorry, did not find any records"
	pageRunStr(0)="Page execution time ":pageRunStr(1)=" seconds,&nbsp;":pageRunStr(2)=" Data Query!"

end if

%>