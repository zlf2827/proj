<!--#include file="inc/AspCms_SettingClass.asp" -->
<%
if  runMode="0"  then
	dim templateobj,templatePath : set templateobj = new TemplateClass	
	templatePath=sitePath&"/"&"templates/"&setting.defaultTemplate&"/"&setting.htmlFilePath&"/index.html"	
	'die templatePath
	if not CheckTemplateFile(templatePath) then echo "index.html"&err_16	
	with templateObj 
		.content=loadFile(templatePath) 
		.parseHtml()		
		.parseCommon
		echo .content 
	end with	
	set templateobj =nothing : terminateAllObjects
Else
	On Error Resume Next
	Server.Transfer(sitePath&setting.languagepath&"index"&FileExt)
	If -2147467259 = Err.Number Then Response.Write "<meta http-equiv='Content-Type' content='text/html;charset=gb2312'>缺少首页文件，请登录后台生成首页文件！"	
end If
%>