<!--#include file="../inc/AspCms_SettingClass.asp" -->
<%
dim action : action=getForm("action","get")
if action="add" then addGbook

dim FaqID,FaqTitle,Contact,ContactWay,Content,Reply,AddTime,ReplyTime,FaqStatus,AuditStatus
Sub addGbook
	if getForm("code","post")<>Session("Code") then alertMsgAndGo "��֤�벻��ȷ","-1"
	'if session("faq") then alertMsgAndGo "�벻Ҫ�ظ��ύ","-1"
	FaqTitle=filterPara(getForm("FaqTitle","post"))
	Contact=filterPara(getForm("Contact","post"))
	ContactWay=filterPara(getForm("ContactWay","post"))
	Content=encode(filterPara(getForm("Content","post")))
	AddTime=now()
	FaqStatus=false
	AuditStatus=false
	
	if isnul(FaqTitle) then alertMsgAndGo "���ⲻ��Ϊ��","-1"
	if isnul(Contact) then alertMsgAndGo "���ݲ���Ϊ��","-1"
	if isnul(ContactWay) then alertMsgAndGo "��ϵ�˲���Ϊ��","-1"
	if isnul(Content) then alertMsgAndGo "��ϵ��ʽ����Ϊ��","-1"
	
	
	Conn.Exec"insert into {prefix}GuestBook(LanguageID,FaqTitle,Contact,ContactWay,Content,AddTime,FaqStatus,AuditStatus) values("&setting.languageID&",'"&FaqTitle&"','"&Contact&"','"&ContactWay&"','"&Content&"','"&AddTime&"',"&FaqStatus&","&AuditStatus&")","exe"
	session("faq")=true
	
	if messageReminded then sendMail messageAlertsEmail,setting.sitetitle,setting.siteTitle&setting.siteUrl&"--������Ϣ�����ʼ���","������վ<a href=""http://"&setting.siteUrl&""">"&setting.siteTitle&"</a>���µ�������Ϣ��<br>"&"<br>���⣺"&FaqTitle&"<br>���ݣ�"&Content&"<br>��ϵ�ˣ�"&Contact&"<br>��ϵ��ʽ��"&ContactWay&"<br>ʱ�䣺"&AddTime	
	
	if SwitchCommentsStatus=0 then
		alertMsgAndGo "���Գɹ���лл���Ĳ��룡",getRefer	
	else	
		alertMsgAndGo "���Գɹ���лл���Ĳ��룡",getRefer	
	end if
End Sub

%>