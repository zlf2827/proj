<!--#include file="../../inc/AspCms_SettingClass.asp" -->
<%
dim action : action=getForm("action","get")

Select case action	
	case "del" : DelSpec
	case "add" : AddSpec
	case "save" :SaveSpec	
	case "order" :updateOrder	
End Select

dim SpecID, SpecName, SpecOrder, SpecField

dim sql, msg


Sub AddSpec 	
	SpecName=getForm("SpecName","post")
	SpecOrder=getForm("SpecOrder","post")
	SpecField=getForm("SpecField","post")	
	
	if isnul(SpecName) then alertMsgAndGo "参数名称不能为空，请修改","-1"
	if isnul(SpecField) then alertMsgAndGo "字段名称不能为空，请修改","-1"
	Dim rsObj	:	Set rsObj=conn.Exec("select count(*) from {prefix}SpecSet where SpecField='"&SpecField&"'","r1")
	if rsObj(0) >0 then alertMsgAndGo "字段名称已存在，请修改","-1"
	rsObj.close	:	Set rsObj = nothing
	conn.Exec "ALTER TABLE {prefix}Content ADD column "&SpecField&" Text(255)" ,"exe"	
	if Err then alertMsgAndGo "添加字段失败,请联系管理员","-1"
	conn.Exec "insert into {prefix}SpecSet(SpecName,SpecField,SpecOrder) values('"&SpecName&"','"&SpecField&"',"&SpecOrder&")","exe"		
	alertMsgAndGo "添加成功","AspCms_Spec.asp"
End Sub	

Sub specList
	Dim rsObj	:	Set rsObj=conn.Exec("select SpecID,SpecName,SpecField,SpecOrder from {prefix}SpecSet Order by SpecOrder Asc,SpecID","r1")
	If rsObj.Eof Then 
		echo"<tr bgcolor=""#FFFFFF"" align=""center"">"&vbcrlf& _
			"<td colspan=""5"">没有数据</td>"&vbcrlf& _
		  "</tr>"&vbcrlf
	Else
		Do while not rsObj.Eof 
		 echo "<tr bgcolor=""#FFFFFF"" align=""center"">"
		 echo "<td height=""28"">"
		 echo "<input type=""checkbox"" name=""id"" value="""&rsObj(0)&""" class=""checkbox"" onclick='silbingCheck(this)' />"
		 echo "<input type=""checkbox"" name=""SpecField"" value=""'"&rsObj(2)&"'"" style=""display:none"" />"
		 echo "<input type=""hidden"" name=""SpecIDs"" value="""&rsObj(0)&""" /></td>"
		 echo "<td>"&rsObj(0)&"</td>"
		 echo "<td>"&rsObj(1)&"</td>" 
		 echo "<td>"&rsObj(2)&"</td>" 
		 echo "<td><input class=""input"" style=""width:30px"" name=""SpecOrders"" value="""&rsObj(3)&"""/></td>"
		 echo "<td><a href=""?action=del&id="&rsObj(0)&"&SpecField="&rsObj(2)&"""  onClick=""return confirm('确定要删除吗')"">删除</a></td>"
		 echo "</tr>"
		  rsObj.MoveNext
		Loop
	End If
	rsObj.close : Set rsObj = nothing
End Sub

Sub DelSpec 
	Dim sql
	dim ID 	:	ID = getForm("id","both")
	dim SpecField:SpecField=getForm("SpecField","both")
	dim m_SpecField:m_SpecField=replace(SpecField,"&apos;","'")
	SpecField = replace(SpecField,"&apos;","")
	
	sql = "ALTER TABLE {prefix}Content drop column "&SpecField
	
	conn.Exec sql,"exe"
	
	
	if instr(m_SpecField,"'")=0 then m_SpecField = "'"&m_SpecField&"'"
	sql = "Delete * from {prefix}SpecSet where SpecField in ("&m_SpecField&")"
	'echo sql & "<br>"
	conn.Exec sql,"exe"
	alertMsgAndGo "删除成功","AspCms_Spec.asp"	
	
	if Err then echo err.description 'alertMsgAndGo "删除字段失败,请联系管理员","-1"
	
End Sub 

Sub updateOrder
	Dim ids				:	ids=split(getForm("SpecIDs","post"),",")
	Dim orders		:	orders=split(getForm("SpecOrders","post"),",")
	If Ubound(ids)=-1 Then 	'防止有值为空时下标越界
		ReDim ids(0)
		ids(0)=""
	End If	
	
	If Ubound(orders)=-1 Then
		ReDim orders(0)
		orders(0)=0
	End If
	Dim i
	
	For i=0 To Ubound(ids)		
		if isnum(trim(orders(i))) then
			Conn.Exec "update {prefix}SpecSet Set SpecOrder="&trim(orders(i))&" Where SpecID="&trim(ids(i)),"exe"	
		else
			Conn.Exec "update {prefix}SpecSet Set SpecOrder=0 Where SpecID="&trim(ids(i)),"exe"	
		end if
	Next
	
	
	alertMsgAndGo "更新排序成功","AspCms_Spec.asp"
End Sub

%>