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
	<div class="bodytitletxt">��վͳ��</div>
</div>
<div class="tab_bk1">
	<div class="txtbox1">
		<p>���� <strong class="red"><%=getTodayVisits%></strong> �� ������ <strong class="red"><%=getYesterdayVisits%></strong> �� ������ <strong class="red"><%=getMonthVisits%></strong> �� ���ܷ��� <strong class="red"><%=getAllVisits%></strong> �ˡ�</p>
	</div>
</div>
<div class="bodytitle">
	<div class="bodytitleleft"></div>
	<div class="bodytitletxt">ϵͳ��Ϣ</div>
</div>
<table width="100%" border="0" align="center" cellpadding="10" cellspacing="1" bgcolor="#cad9ea" >
	<tr>
		<td align="right" bgcolor="#f5fafe" class="main_bleft" width="250">��ǰ����汾��</td>
		<td bgcolor="#FFFFFF" class="main_bright"><%=aspcmsVersion%>     ���°汾��<span id="version">��ʱû�п������ļ�</span></td>
	</tr>
	<tr>
		<td align="right" bgcolor="#f5fafe" class="main_bleft">���������ƣ�</td>
		<td bgcolor="#FFFFFF" class="main_bright">���� <%=Request.ServerVariables("SERVER_NAME")%>(IP:<%=Request.ServerVariables("LOCAL_ADDR")%>) �˿�:<%=Request.ServerVariables("SERVER_PORT")%></td>
	</tr>
	<tr>
		<td align="right" bgcolor="#f5fafe" class="main_bleft">վ������·����</td>
		<td bgcolor="#FFFFFF" class="main_bright"><%=Request.ServerVariables("PATH_TRANSLATED")%></td>
	</tr>
	<tr>
		<td align="right" bgcolor="#f5fafe" class="main_bleft">FSO�ı���д��</td>
		<td bgcolor="#FFFFFF" class="main_bright"><%If Not isInstallObj(FSO_OBJ_NAME) Then%>
          <font color="#FF0066"><b>��</b>��վ��������ʹ��</font>
          <%else%>
          <b>��</b>
          <%end if%></td>
	</tr>
    <tr>
		<td align="right" bgcolor="#f5fafe" class="main_bleft">JMail�����</td>
		<td bgcolor="#FFFFFF" class="main_bright"><%If Not isInstallObj("JMail.Message") Then%>
        <font color="#FF0066"><b>��</b>�ʼ����ѹ��ܲ�������ʹ��</font>
        <%else%>
        <b>��</b>
        <%end if%></td>
	</tr>
    <tr>
		<td align="right" bgcolor="#f5fafe" class="main_bleft"> ASPJpeg �����</td>
		<td bgcolor="#FFFFFF" class="main_bright"><%If Not isInstallObj("Persits.Jpeg") Then%>
        <font color="#FF0066"><b>��</b>ˮӡ���ܲ�������ʹ��</font>
        <%else%>
        <b>��</b>
        <%end if%></td>
	</tr>
	<tr>
		<td align="right" bgcolor="#f5fafe" class="main_bleft">�ű��������棺</td>
		<td bgcolor="#FFFFFF" class="main_bright"><%=ScriptEngine & "/"& ScriptEngineMajorVersion &"."&ScriptEngineMinorVersion&"."& ScriptEngineBuildVersion %></td>
	</tr>
	<tr>
		<td align="right" bgcolor="#f5fafe" class="main_bleft">������IIS�汾��</td>
		<td bgcolor="#FFFFFF" class="main_bright"><%=Request.ServerVariables("SERVER_SOFTWARE")%></td>
	</tr>
</table>


</body>
</html>