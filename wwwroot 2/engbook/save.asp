<!--#include file="../inc/AspCms_SettingClass.asp" -->
<%
dim action : action=getForm("action","get")
if action="add" then addGbook

dim FaqID,FaqTitle,Contact,ContactWay,Content,Reply,AddTime,ReplyTime,FaqStatus,AuditStatus
Sub addGbook
	if getForm("code","post")<>Session("Code") then alertMsgAndGo "The verification code is incorrect.","-1"
	'if session("faq") then alertMsgAndGo "请不要重复提交","-1"
	FaqTitle=filterPara(getForm("FaqTitle","post"))
	Contact=filterPara(getForm("Contact","post"))
	ContactWay=filterPara(getForm("ContactWay","post"))
	Content=encode(filterPara(getForm("Content","post")))
	AddTime=now()
	FaqStatus=false
	AuditStatus=false
	
	if isnul(FaqTitle) then alertMsgAndGo "The title is not null","-1"
	if isnul(Contact) then alertMsgAndGo "The content is not null","-1"
	if isnul(ContactWay) then alertMsgAndGo "The name is not null","-1"
	if isnul(Content) then alertMsgAndGo "The phone number is not null","-1"
	
	
	Conn.Exec"insert into {prefix}GuestBook(LanguageID,FaqTitle,Contact,ContactWay,Content,AddTime,FaqStatus,AuditStatus) values("&setting.languageID&",'"&FaqTitle&"','"&Contact&"','"&ContactWay&"','"&Content&"','"&AddTime&"',"&FaqStatus&","&AuditStatus&")","exe"
	session("faq")=true
	
	if messageReminded then sendMail messageAlertsEmail,setting.sitetitle,setting.siteTitle&setting.siteUrl&"--留言信息提醒邮件！","您的网站<a href=""http://"&setting.siteUrl&""">"&setting.siteTitle&"</a>有新的留言信息！<br>"&"<br>问题："&FaqTitle&"<br>内容："&Content&"<br>联系人："&Contact&"<br>联系方式："&ContactWay&"<br>时间："&AddTime	
	
	if SwitchCommentsStatus=0 then
		alertMsgAndGo "The message successfully, thank you for your participation.",getRefer	
	else	
		alertMsgAndGo "The message successfully, thank you for your participation.",getRefer	
	end if
End Sub

%>