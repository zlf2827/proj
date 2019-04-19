<!--#include file="inc/AspCms_SettingClass.asp" -->
<%CheckLogin()%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>Home</title>
<link href="css/css_body.css" rel="stylesheet" type="text/css" />
</head>

<body>
<%
if "admin"=lcase(getAdminDir) then 
%>
<%end if%>

<div class="bodytitle">
	<div class="bodytitleleft"></div>
	<div class="bodytitletxt">网站统计</div>
</div>
<div class="tab_bk1">
	<div class="txtbox1">
		<p>今日 <strong class="red"><%=getTodayVisits%></strong> 人 ，昨日 <strong class="red"><%=getYesterdayVisits%></strong> 人 ，本月 <strong class="red"><%=getMonthVisits%></strong> 人 ，总访问 <strong class="red"><%=getAllVisits%></strong> 人。</p>
	</div>
</div>
<div class="bodytitle">
	<div class="bodytitleleft"></div>
	<div class="bodytitletxt">系统信息</div>
</div>
<table width="100%" border="0" align="center" cellpadding="10" cellspacing="1" bgcolor="#cad9ea" >
	<tr>
		<td align="right" bgcolor="#f5fafe" class="main_bleft" width="250">当前程序版本：</td>
		<td bgcolor="#FFFFFF" class="main_bright"><%=aspcmsVersion%>     最新版本：<span id="version">暂时没有可升级文件</span></td>
	</tr>
	<tr>
		<td align="right" bgcolor="#f5fafe" class="main_bleft">服务器名称：</td>
		<td bgcolor="#FFFFFF" class="main_bright">名称 <%=Request.ServerVariables("SERVER_NAME")%>(IP:<%=Request.ServerVariables("LOCAL_ADDR")%>) 端口:<%=Request.ServerVariables("SERVER_PORT")%></td>
	</tr>
	<tr>
		<td align="right" bgcolor="#f5fafe" class="main_bleft">站点物理路径：</td>
		<td bgcolor="#FFFFFF" class="main_bright"><%=Request.ServerVariables("PATH_TRANSLATED")%></td>
	</tr>
	<tr>
		<td align="right" bgcolor="#f5fafe" class="main_bleft">FSO文本读写：</td>
		<td bgcolor="#FFFFFF" class="main_bright"><%If Not isInstallObj(FSO_OBJ_NAME) Then%>
          <font color="#FF0066"><b>×</b>网站不能正常使用</font>
          <%else%>
          <b>√</b>
          <%end if%></td>
	</tr>
    <tr>
		<td align="right" bgcolor="#f5fafe" class="main_bleft">JMail组件：</td>
		<td bgcolor="#FFFFFF" class="main_bright"><%If Not isInstallObj("JMail.Message") Then%>
        <font color="#FF0066"><b>×</b>邮件提醒功能不能正常使用</font>
        <%else%>
        <b>√</b>
        <%end if%></td>
	</tr>
    <tr>
		<td align="right" bgcolor="#f5fafe" class="main_bleft"> ASPJpeg 组件：</td>
		<td bgcolor="#FFFFFF" class="main_bright"><%If Not isInstallObj("Persits.Jpeg") Then%>
        <font color="#FF0066"><b>×</b>水印功能不能正常使用</font>
        <%else%>
        <b>√</b>
        <%end if%></td>
	</tr>
	<tr>
		<td align="right" bgcolor="#f5fafe" class="main_bleft">脚本解释引擎：</td>
		<td bgcolor="#FFFFFF" class="main_bright"><%=ScriptEngine & "/"& ScriptEngineMajorVersion &"."&ScriptEngineMinorVersion&"."& ScriptEngineBuildVersion %></td>
	</tr>
	<tr>
		<td align="right" bgcolor="#f5fafe" class="main_bleft">服务器IIS版本：</td>
		<td bgcolor="#FFFFFF" class="main_bright"><%=Request.ServerVariables("SERVER_SOFTWARE")%></td>
	</tr>
</table>


</body>
</html>