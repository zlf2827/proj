<!--#include file="../../inc/AspCms_SettingClass.asp" -->
<!--#include file="../../editor/fckeditor.asp" -->
<%
CheckAdmin("AspCms_Sort.asp")
dim action : action=getForm("action","get")
Select case action	
	case "add" : addSort
	case "quick" : quickAdd
	case "edit" : editSort
	case "del" : delSort
	case "saveall" : saveAll
	case "on" : onOff "on", "Sort", "SortID", "SortStatus", "", getPageName()
	case "off" : onOff "off", "Sort", "SortID", "SortStatus", "", getPageName()
	case "move" : moveSort
End Select

dim SortID, LanguageID, ParentID, SortOrder, SortType, SortName, SortURL, SortLevel, AddTime, PageTitle, PageKeywords, PageDesc, SortPath, SortTemplate, ContentTemplate, SortFolder, ContentFolder, SortFileName, ContentFileName, SortStatus, TopSortID, GroupID, Exclusive, Content
dim sql, msg

Sub getSort
	dim id : id=getForm("id","get")
	if not isnul(ID) then		
		sql ="select * from {prefix}Sort where SortID="&id
		dim rs : set rs = conn.exec(sql,"r1")
		if rs.eof then 
			alertMsgAndGo "没有这条记录","-1"
		else
			SortID=rs("SortID")
			LanguageID=rs("LanguageID")
			ParentID=rs("ParentID")
			SortOrder=rs("SortOrder")
			SortType=rs("SortType")
			SortName=rs("SortName")
			SortURL=rs("SortURL")
			SortLevel=rs("SortLevel")
			AddTime=rs("AddTime")
			PageTitle=rs("PageTitle")
			PageKeywords=rs("PageKeywords")
			PageDesc=rs("PageDesc")
			SortPath=rs("SortPath")
			SortTemplate=rs("SortTemplate")
			ContentTemplate=rs("ContentTemplate")
			SortFolder=rs("SortFolder")
			ContentFolder=rs("ContentFolder")
			SortFileName=rs("SortFileName")
			ContentFileName=rs("ContentFileName")
			SortStatus=rs("SortStatus")
			TopSortID=rs("TopSortID")
			GroupID=rs("GroupID")
			Exclusive=rs("Exclusive")
			Content=rs("SortContent")
		end if
		rs.close : set rs=nothing
	else		
		alertMsgAndGo "没有这条记录","-1"
	end if 
End Sub

Sub moveSort
	dim id	:	id=getForm("id","post")
	if isnul(id) then alertMsgAndGo "请选择要操作的内容","-1"
	dim moveSortID 
	moveSortID=getForm("moveSortID","post")
	
	dim ids,i
	ids=split(id,",")
	for i=0 to ubound(ids)
		'if ids(i)>4 then conn.exec "delete * from {prefix}UserGroup where IsAdmin=1 and GroupID="&ids(i),"exe"
		if moveSortID="0" then 
			SortLevel="1"
			TopSortID=ids(i)
			SortPath =TopSortID&","
		else
			dim rs 	: set rs=Conn.Exec("select SortLevel, TopSortID, SortPath from {prefix}Sort where SortID="&moveSortID,"r1")
			SortLevel=rs(0)+1
			TopSortID=rs(1)
			SortPath=rs(2)&ids(i)&","
		end if		
		conn.exec "update {prefix}Sort set ParentID="&moveSortID&", SortLevel="&SortLevel&", TopSortID="&TopSortID&", SortPath='"&trim(SortPath)&"' where LanguageID="&rCookie("languageID")&" and SortID ="&ids(i), "exe"
		'将此类下的所有子类修改一次
		editSubSort(ids(i))
	next
		
	alertMsgAndGo "移动成功！", getPageName()
End Sub

Function editSubSort(sortID)	
	dim rs,prs,SortPath,SortLevel
	set rs=conn.exec("select * from {prefix}Sort where parentID="&sortID,"r1")	
	if not rs.eof then		
		set prs=conn.exec("select * from {prefix}Sort where SortID="&rs("parentID"),"r1")	
		do while not rs.eof			
			if rs("SortLevel")=1 then 
				SortPath = rs("SortID")&","
				conn.exec "update {prefix}Sort set TopSortID="&rs("SortID")&",SortPath='"&SortPath&"' where SortID="&rs("SortID"),"exe"
			else
				SortPath =trim(prs("SortPath"))&rs("SortID")&","
				SortLevel=prs("SortLevel")+1
				conn.exec "update {prefix}Sort set TopSortID="&prs("TopSortID")&", SortLevel="&SortLevel&", SortPath='"&SortPath&"' where SortID="&rs("SortID"),"exe"
			end if			
			editSubSort rs("SortID")			
			rs.movenext
		loop		
		prs.close : set prs=nothing
	end if
	rs.close : set rs=nothing
End Function 


Sub quickAdd
	dim i,TopSortName,SubSortName
	LanguageID=cint(rCookie("languageID"))	
	AddTime=now()
	GroupID=getForm("GroupID", "post")	
	Exclusive=getForm("Exclusive", "post")	
	SortStatus=1
	
	for i=1 to 10	
		ParentID=0
		TopSortName=getForm("TopSortName"&i, "post")		
		if not isnul(TopSortName) then 
			SortOrder=getForm("SortOrder"&i, "post")
			SortType=getForm("SortType"&i, "post")
			SubSortName=getForm("SubSortName"&i, "post")
			SortURL=getForm("SortURL"&i, "post")
			
			select case SortType
				case "1"
					SortTemplate="about.html"
					ContentTemplate=""
					SortFolder="{sitepath}"&setting.languagePath&htmlDir&"/about/"
					ContentFolder=""
					SortFileName="about-{sortid}"
					ContentFileName="" 
				case "2"
					SortTemplate="newslist.html"
					ContentTemplate="news.html"
					SortFolder="{sitepath}"&setting.languagePath&htmlDir&"/newslist/"
					ContentFolder="{sitepath}"&setting.languagePath&htmlDir&"/news/"
					SortFileName="list-{sortid}-{page}"
					ContentFileName="{y}-{m}-{d}/{id}"
				case "3"
					SortTemplate="productlist.html"
					ContentTemplate="product.html"
					SortFolder="{sitepath}"&setting.languagePath&htmlDir&"/productlist/"
					ContentFolder="{sitepath}"&setting.languagePath&htmlDir&"/product/"
					SortFileName="list-{sortid}-{page}"
					ContentFileName="{y}-{m}-{d}/{id}"  
				case "4"  
					SortTemplate="downlist.html"
					ContentTemplate="down.html"
					SortFolder="{sitepath}"&setting.languagePath&htmlDir&"/downlist/"
					ContentFolder="{sitepath}"&setting.languagePath&htmlDir&"/down/"
					SortFileName="list-{sortid}-{page}"
					ContentFileName="{y}-{m}-{d}/{id}"
				case "5"
					SortTemplate="joblist.html"
					ContentTemplate="job.html"
					SortFolder="{sitepath}"&setting.languagePath&htmlDir&"/jobtlist/"
					ContentFolder="{sitepath}"&setting.languagePath&htmlDir&"/job/"
					SortFileName="list-{sortid}-{page}"
					ContentFileName="{y}-{m}-{d}/{id}"				
				case "6"
					SortTemplate="albumlist.html"
					ContentTemplate="album.html"
					SortFolder="{sitepath}"&setting.languagePath&htmlDir&"/albumtlist/"
					ContentFolder="{sitepath}"&setting.languagePath&htmlDir&"/album/"
					SortFileName="list-{sortid}-{page}"
					ContentFileName="{y}-{m}-{d}/{id}"				
			end select
			
			conn.exec "insert into {prefix}Sort(ParentID, SortOrder, SortType, SortName, SortURL, SortTemplate, ContentTemplate, SortFolder, ContentFolder, SortFileName, ContentFileName, SortStatus, LanguageID, AddTime, GroupID, Exclusive) values("&ParentID&", "&SortOrder&", "&SortType&", '"&TopSortName&"', '"&SortURL&"', '"&SortTemplate&"', '"&ContentTemplate&"', '"&SortFolder&"', '"&ContentFolder&"', '"&SortFileName&"', '"&ContentFileName&"', "&SortStatus&", "&LanguageID&", '"&AddTime&"', "&GroupID&", '"&Exclusive&"')", "exe"
			SortID=Conn.Exec("select @@identity","r1")(0)
			SortLevel="1"
			TopSortID=SortID
			SortPath = TopSortID&","			
			conn.exec "update {prefix}Sort set SortLevel="&SortLevel&", TopSortID="&TopSortID&", SortPath='"&SortPath&"' where SortID="&SortID, "exe"
			
			ParentID=SortID
			if not isnul(SubSortName) then
				SubSortName=split(SubSortName,",")
				dim j
				for j=0 to ubound(SubSortName)	
					if not isnul(SubSortName(j)) then
						conn.exec "insert into {prefix}Sort(ParentID, SortOrder, SortType, SortName, SortURL, SortTemplate, ContentTemplate, SortFolder, ContentFolder, SortFileName, ContentFileName, SortStatus, LanguageID, AddTime, GroupID, Exclusive) values("&ParentID&", "&SortOrder&", "&SortType&", '"&SubSortName(j)&"', '"&SortURL&"', '"&SortTemplate&"', '"&ContentTemplate&"', '"&SortFolder&"', '"&ContentFolder&"', '"&SortFileName&"', '"&ContentFileName&"', "&SortStatus&", "&LanguageID&", '"&AddTime&"', "&GroupID&", '"&Exclusive&"')", "exe"
					end if
				next
			end if		
			editSubSort(sortID)	
		end if	
	next	
	alertMsgAndGo "保存成功","AspCms_Sort.asp"
End Sub

Sub saveAll
	Dim ids				:	ids=split(getForm("SortIDs","post"),",")
	Dim SortNames		:	SortNames=split(getForm("SortNames","post"),",")
	Dim SortURLs		:	SortURLs=split(getForm("SortURLs","post"),",")
	'Dim SortTypes		:	SortTypes=split(getForm("SortTypes","post"),",")
	Dim SortOrders		:	SortOrders=split(getForm("SortOrders","post"),",")
	If Ubound(ids)=-1 Then 	'防止有值为空时下标越界
		ReDim ids(0)
		ids(0)=""
	End If	
	If Ubound(SortNames)=-1 Then
		ReDim SortNames(0)
		SortNames(0)=""
	End If
	If Ubound(SortURLs)=-1 Then
		ReDim SortURLs(0)
		SortURLs(0)=""
	End If
	'If Ubound(SortTypes)=-1 Then
	'	ReDim SortTypes(0)
	'	SortStyles(0)=""
	'End If
	If Ubound(SortOrders)=-1 Then
		ReDim SortOrders(0)
		SortOrders(0)=0
	End If
	Dim i
	For i=0 To Ubound(ids)		
		if not isnum(SortOrders(i))  then SortOrders(i)=0
		Conn.Exec "update {prefix}Sort Set SortName='"&trim(SortNames(i))&"',SortURL='"&trim(SortURLs(i))&"',SortOrder='"&trim(SortOrders(i))&"' Where SortID="&trim(ids(i)),"exe"		
	Next
	alertMsgAndGo "保存成功","AspCms_Sort.asp"
End Sub	

function sortList(ParentID)
	Dim rs :set rs =Conn.Exec ("select *,(select count(*) from {prefix}Sort where ParentID=t.SortID) as c from AspCms_Sort t where LanguageID="&rCookie("languageID")&" and ParentID="&ParentID&" order by Sortorder,Sortorder ","r1")
	
	dim sortTypenames : sortTypenames=split(sortTypes,",")
	IF rs.eof or rs.bof Then
		echo "<tr bgcolor=""#ffffff"" align=""center""><td colspan=""8"">还没有记录</td></tr>"
	Else
		Do While not rs.eof 
			echo "<tr bgcolor=""#ffffff"" align=""center"" onMouseOver=""this.bgColor='#CDE6FF'"" onMouseOut=""this.bgColor='#FFFFFF'"">"&vbcrlf
			echo "<td><input type=""checkbox"" name=""id"" value="""&rs("SortID")&""" class=""checkbox"" /><input type=""hidden"" name=""SortIDs"" value="""&rs("SortID")&""" /></td>"&vbcrlf
			echo "<td>"&rs("SortID")&"</td>"&vbcrlf
			
			echo "<td align=""left"">"&getLevel(rs("SortLevel"))&"<input name=""SortNames"" type=""text"" class=""input"" id=""SortNames"" value="""&rs("SortName")&""" maxlength=""200"" style=""width:120px;""/></td>"&vbcrlf
			echo "<td>"	
			echo sortTypenames(rs("SortType")-1)
         	'echo makeSortTypeSelect("SortTypes",rs("SortType"),"")
         	'echo rs("SortType")
			echo "</td>"&vbcrlf
			echo "<td><input name=""SortUrls"" type=""text""  id=""SortUrls"" value="""&rs("SortUrl")&""" size=""18"" maxlength=""255"" class=""input"" style=""width:90%""/></td>"&vbcrlf
			echo "<td>"
			echo "<input name=""SortOrders"" type=""text"" class=""input"" id=""SortOrders"" value="""&rs("SortOrder")&""" size=""3"" maxlength=""4"" style=""width:90%""/>"
			echo "</td>"&vbcrlf
			echo "<TD>"&getStr(rs("SortStatus"),"<a href=""?action=off&id="&rs("SortID")&""" title=""启用"" ><IMG src=""../../images/toolbar_ok.gif""></a>","<a href=""?action=on&id="&rs("SortID")&""" title=""禁用"" ><IMG src=""../../images/toolbar_no.gif""></a>")&"</TD>"&vbcrlf
			echo "<td><a href=""AspCms_SortAdd.asp?id="&rs("Sortid")&""">添加子类</a> <a href=""AspCms_SortEdit.asp?id="&rs("Sortid")&""">修改</a> <a href=""?action=del&id="&rs("Sortid")&""" onClick=""return confirm('确定要删除吗')"">删除</a></td>"&vbcrlf			
			echo "</tr>"	&vbcrlf			
			if rs("c")>0 then SortList(rs("SortID"))			
			rs.MoveNext
		Loop
		rs.close : set rs = nothing
	End If
End Function

'语言ID
'上级分类ID
'分类级别
'发布时间
'顶级分类ID
'分类路径
'访问权限
'用户组
Sub addSort	
	ParentID=getForm("ParentID", "post")
	SortOrder=getForm("SortOrder", "post")
	SortType=getForm("SortType", "post")
	SortName=getForm("SortName", "post")
	SortURL=getForm("SortURL", "post")
	PageTitle=getForm("PageTitle", "post")
	PageKeywords=getForm("PageKeywords", "post")
	PageDesc=getForm("PageDesc", "post")
	SortTemplate=getForm("SortTemplate", "post")
	ContentTemplate=getForm("ContentTemplate", "post")
	SortFolder=getForm("SortFolder", "post")
	ContentFolder=getForm("ContentFolder", "post")
	SortFileName=getForm("SortFileName", "post")
	ContentFileName=getForm("ContentFileName", "post")
	SortStatus=getCheck(getForm("SortStatus", "post"))
	Content=getForm("Content", "post")	
	LanguageID=cint(rCookie("languageID"))		
	AddTime=now()
	GroupID=getForm("GroupID", "post")	
	Exclusive=getForm("Exclusive", "post")	
	
	if isnul(SortName) then alertMsgAndGo "分类名称不能为空","-1"
	
	conn.exec "insert into {prefix}Sort(ParentID, SortOrder, SortType, SortName, SortURL, PageTitle, PageKeywords, PageDesc, SortTemplate, ContentTemplate, SortFolder, ContentFolder, SortFileName, ContentFileName, SortStatus, SortContent, LanguageID, AddTime, GroupID, Exclusive) values("&ParentID&", "&SortOrder&", "&SortType&", '"&SortName&"', '"&SortURL&"', '"&PageTitle&"', '"&PageKeywords&"', '"&PageDesc&"', '"&SortTemplate&"', '"&ContentTemplate&"', '"&SortFolder&"', '"&ContentFolder&"', '"&SortFileName&"', '"&ContentFileName&"', "&SortStatus&", '"&Content&"', "&LanguageID&", '"&AddTime&"', "&GroupID&", '"&Exclusive&"')", "exe" 
	
	SortID=Conn.Exec("select @@identity","r1")(0)
	if ParentID="0" then 
		SortLevel="1"
		TopSortID=SortID
		SortPath = TopSortID&","
	else
		dim rs 	: set rs=Conn.Exec("select SortLevel, TopSortID, SortPath from {prefix}Sort where SortID="&ParentID,"r1")
		SortLevel=rs(0)+1
		TopSortID=rs(1)
		SortPath=rs(2)&SortID&","
	end if
	conn.exec "update {prefix}Sort set SortLevel="&SortLevel&", TopSortID="&TopSortID&", SortPath='"&SortPath&"' where SortID="&SortID, "exe"	
	alertMsgAndGo "添加成功","AspCms_Sort.asp"
End Sub


Sub editSort	
	SortID=getForm("SortID", "post")
	ParentID=getForm("ParentID", "post")
	SortOrder=getForm("SortOrder", "post")
	SortType=getForm("SortType", "post")
	SortName=getForm("SortName", "post")
	SortURL=getForm("SortURL", "post")
	PageTitle=getForm("PageTitle", "post")
	PageKeywords=getForm("PageKeywords", "post")
	PageDesc=getForm("PageDesc", "post")
	SortTemplate=getForm("SortTemplate", "post")
	ContentTemplate=getForm("ContentTemplate", "post")
	SortFolder=getForm("SortFolder", "post")
	ContentFolder=getForm("ContentFolder", "post")
	SortFileName=getForm("SortFileName", "post")
	ContentFileName=getForm("ContentFileName", "post")
	SortStatus=getCheck(getForm("SortStatus", "post"))
	Content=getForm("Content", "post")	
	LanguageID=cint(rCookie("languageID"))		
	AddTime=now()
	GroupID=getForm("GroupID", "post")	
	Exclusive=getForm("Exclusive", "post")	
	
	if isnul(SortName) then alertMsgAndGo "分类名称不能为空","-1"
	
	conn.exec "update {prefix}Sort set ParentID="&ParentID&",  SortOrder="&SortOrder&", SortType="&SortType&", SortStatus="&SortStatus&", LanguageID="&LanguageID&", GroupID="&GroupID&", SortName='"&SortName&"', SortURL='"&SortURL&"', PageTitle='"&PageTitle&"', PageKeywords='"&PageKeywords&"', PageDesc='"&PageDesc&"', SortTemplate='"&SortTemplate&"', ContentTemplate='"&ContentTemplate&"', SortFolder='"&SortFolder&"', ContentFolder='"&ContentFolder&"', SortFileName='"&SortFileName&"', ContentFileName='"&ContentFileName&"', SortContent='"&Content&"',AddTime ='"&AddTime&"', Exclusive='"&Exclusive&"' where SortID="&SortID, "exe"
	

	if ParentID="0" then 
		SortLevel="1"
		TopSortID=SortID
		SortPath = TopSortID&","
	else
		dim rs 	: set rs=Conn.Exec("select SortLevel, TopSortID, SortPath from {prefix}Sort where SortID="&ParentID,"r1")
		SortLevel=rs(0)+1
		TopSortID=rs(1)
		SortPath=rs(2)&SortID&","
	end if
	conn.exec "update {prefix}Sort set SortLevel="&SortLevel&", TopSortID="&TopSortID&", SortPath='"&SortPath&"' where SortID="&SortID, "exe"	
	editSubSort(SortID)
	alertMsgAndGo "修改成功","AspCms_Sort.asp"
End Sub	

Sub delSort
	dim id	:	id=getForm("id","both")
	if isnul(id) then alertMsgAndGo "请选择要操作的内容","-1"
	dim ids,i
	ids=split(id,",")
	for i=0 to ubound(ids)
		'删除子分类和子类中的内容		
		'conn.exec "delete * from {prefix}Content where SortID in(select SortID from {prefix}Sort where ParentID=)"&ids(i),"exe"
		'conn.exec "delete * from {prefix}Sort where TopSortID="&ids(i),"exe"
		if not isnul(ids(i)) then 
			dim subids : subids=getSubSort(ids(i), 1)
			dim subid : subid=split(subids,",")
			dim j
			if runmode=1 then
				for j=0 to ubound(subid)
					delList(trim(subid(j)))
				next
				dim rs, sql, filepath
				dim templateobj : set templateobj=new TemplateClass
				sql="select * from {prefix}Content where SortID in ("&subids&")"
				sql="select ContentID,Title,sortType,SortFolder,a.GroupID,ContentFolder,ContentFileName,a.AddTime,a.PageFileName,a.SortID,b.GroupID from {prefix}Content as a, {prefix}Sort as b where a.LanguageID="&rCookie("languageID")&" and a.SortID=b.SortID and b.SortID in ("&subids&")"
				set rs=conn.exec(sql,"r1")		
				do while not rs.eof
					
					filepath=templateobj.getContentLink(rs("SortID"),rs("ContentID"),rs("SortFolder"),rs("a.GroupID"),rs("ContentFolder"),rs("ContentFileName"),rs("AddTime"),rs("PageFileName"),rs("b.GroupID"))
					if isExistFile(filepath) then delFile filepath	
					'echo filepath&"<br>"
					rs.movenext
				loop
			end if
			conn.exec "delete * from {prefix}Content where SortID in ("&subids&")","exe"
			conn.exec "delete * from {prefix}Sort where SortID in ("&subids&")","exe"
		end if
	next
	alertMsgAndGo "删除成功",getPageName()		
End Sub


Function delList(Byval sortID)
	if not isnum(sortID) then exit function
	dim templateFile,page
	dim templateobj,TemplatePath : set templateobj=new TemplateClass
	dim rsObj,rsObjSmalltype,rsObjBigtype,channelTemplateName,tempStr,tempArr,pageStr,sql,sperStr,sperStrs,content,contentLink
	
	set rsobj=conn.exec("select * from {prefix}Sort where SortID="&sortID, "exe")							
	if rsObj.eof then delList="" : exit function	
	templateFile=rsObj("SortTemplate")
	if isnul(templateFile) then 
		select case rsObj("SortType")
			case "2"
				templateFile="newslist.html"
			case "3"
				templateFile="productlist.html"
			case "4"
				templateFile="downlist.html"
			case "5"
				templateFile="joblist.html"
			case "6"
				templateFile="albumlist.html"		
		end select
	end if
	templatePath=sitePath&"/"&"templates/"&setting.defaultTemplate&"/"&setting.htmlFilePath&"/"	&templateFile	
	'die templatePath
	if not CheckTemplateFile(templatePath) then echo templateFile&err_16
	
	
	if not isnul(rsObj("GroupID")) then	
		if not ViewNoRight(rsObj("GroupID"),rsObj("Exclusive")) then exit function	
	end if	
	
	'开始解析标签
	templateObj.load(templatePath)
	tempstr=templateObj.content
	Dim objRegExp, Match, Matches, pages
	Set objRegExp=new Regexp 
	objRegExp.IgnoreCase=True 
	objRegExp.Global=True 	
	objRegExp.Pattern="{aspcms:list([\s\S]*?)}([\s\S]*?){/aspcms:list}"
	'进行匹配	
	set Matches=objRegExp.Execute(tempstr) 	
	for each Match in Matches 
		pages=templateObj.parseArr(Match.SubMatches(0))("size")
	next 
	'die pages
	set objRegExp=Nothing 	
	
	templateObj.parseHtml()	
	tempStr=templateObj.content 
	dim rs
	set rs =conn.exec("select * from {prefix}Content where ContentStatus=1 and SortID in ("&getSubSort(sortID, 1)&")","r1")
	dim pcount
	if isnul(pages) then 	
		rs.pagesize=1
		pcount=1
	else
		rs.pagesize=pages
		pcount=rs.pagecount
		if pcount=0 then pcount=1	
	end if
	'echo pages&"AA"&pcount&"<br>"
	for page=1 to pcount	
	
		dim sortFolder, sortFileName
		sortFolder=rsObj("sortFolder")
		sortFileName=rsObj("sortFileName")		
		sortFolder=replace(sortFolder, "{sitepath}", sitePath)	
		sortFileName=replace(sortFileName, "{sortid}", sortID)	
		
		sortFileName=replace(sortFileName, "{page}", page)
		if isExistFile(sortFolder&sortFileName&fileExt) then delFile sortFolder&sortFileName&fileExt		
		
		'echo sortFolder&sortFileName&fileExt&"<br>"
	next
		
	'makeList=templateObj.content 	
	rsObj.close : set rsObj=nothing
	set templateobj=nothing
End Function
%>