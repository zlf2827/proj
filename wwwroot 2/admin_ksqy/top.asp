<!--#include file="inc/AspCms_SettingClass.asp" -->
<%CheckLogin()%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>Top</title>
<link href="css/css_top.css" rel="stylesheet" type="text/css" />
<script language='javascript'>

function $Nav(){
	if(window.navigator.userAgent.indexOf("MSIE")>=1) return 'IE';
  else if(window.navigator.userAgent.indexOf("Firefox")>=1) return 'FF';
  else return "OT";
}

var preID = 1;

function OpenMenu(cid,lurl,rurl,bid){

   if($Nav()=='IE'){
     if(rurl!='') top.document.frames.main.location = rurl;
     if(cid > -1) top.document.frames.menu.location = 'menu.asp?id='+cid;
     else if(lurl!='') top.document.frames.menu.location = lurl;
     if(bid>0) document.getElementById("d"+bid).className = 'thisclass';
     if(preID>0 && preID!=bid) document.getElementById("d"+preID).className = '';
     preID = bid;
   }else{
     if(rurl!='') top.document.getElementById("main").src = rurl;
     if(cid > -1) top.document.getElementById("menu").src = 'menu.asp?id='+cid;
     else if(lurl!='') top.document.getElementById("menu").src = lurl;
     if(bid>0) document.getElementById("d"+bid).className = 'thisclass';
     if(preID>0 && preID!=bid) document.getElementById("d"+preID).className = '';
     preID = bid;

   }
}

var preFrameW = '160,*';
var FrameHide = 0;

function ChangeMenu(way){
	var addwidth = 10;
	var fcol = top.document.all.bodyFrame.cols;
	if(way==1) addwidth = 10;
	else if(way==-1) addwidth = -10;
	else if(way==0){
		if(FrameHide == 0){
			preFrameW = top.document.all.bodyFrame.cols;
			top.document.all.bodyFrame.cols = '0,*';
			FrameHide = 1;
			return;
		}else{
			top.document.all.bodyFrame.cols = preFrameW;
			FrameHide = 0;
			return;
		}
	}
	fcols = fcol.split(',');
	fcols[0] = parseInt(fcols[0]) + addwidth;
	top.document.all.bodyFrame.cols = fcols[0]+',*';
}

function resetBT(){
	if(preID>0) document.getElementById("d"+preID).className = 'bdd';
	preID = 0;
}

</script>
</head>
<body>
<div class="topnav">
	<div class="sitenav">
		<div class="welcome">
			��ã�<span style="color:#F00"><%=rCookie("GroupName")%></span><span class="username"><%=rCookie("adminName")%></span>
            <a href="editPass.asp" target="main">�޸�����</a>
			<a href="login.asp?action=logout" target="_parent">ע����¼</a>
		</div>
		<div class="resize">
		<a href="javascript:ChangeMenu(-1)"><img src='images/frame-l.gif' border='0' alt="��С����"></a>
    <a href="javascript:ChangeMenu(0)"><img src='images/frame_on.gif' border='0' alt="����/��ʾ����"></a>
    <a href="javascript:ChangeMenu(1)" title="��������"><img src='images/frame-r.gif' border='0' alt="��������"></a>
    </div>
		<div class="sitelink">
			<a href="right.asp" target="main">��̨��ҳ</a>
			<a href="../" target="_blank">��վ��ҳ</a>
		</div>
	</div>
	<div class="leftnav">
		<ul>
			<li class="navleft"></li>
<%
dim rs,i,sql,menuid,SceneStr,firstID
'die isnul(rCookie("SceneMenu")) 
if not isnul(rCookie("SceneMenu")) then 
	SceneStr=" and MenuID in("&rCookie("SceneMenu")&")"
end if

if rCookie("GroupMenu")="all" then
	sql="select MenuID, MenuName, (select Count(*) from {prefix}Menu as b where MenuStatus=1 and b.ParentID=a.MenuID ) from {prefix}Menu as a where MenuStatus=1 and ParentID=0  "&SceneStr&" order by MenuOrder"
else
	sql="select MenuID, MenuName, (select Count(*) from {prefix}Menu as b where MenuStatus=1 and b.ParentID=a.MenuID ) from {prefix}Menu as a where MenuStatus=1 and ParentID=0 and MenuID in("&rCookie("GroupMenu")&") "&SceneStr&" order by MenuOrder"
end if
set rs=conn.exec(sql, "r1")
i=1
do while not rs.eof 
	menuid=rs(0)
	if i=1 then 
		echo "<li id='d"&i&"' class=""thisclass""><a href=""javascript:OpenMenu("&rs(0)&",'','',"&i&")"">"& rs(1)&"</a></li>"&vbcrlf
	else
		echo "<li id='d"&i&"'><a href=""javascript:OpenMenu("&rs(0)&",'','',"&i&")"">"& rs(1)&"</a></li>"&vbcrlf
	end if
	rs.moveNext
	i=i+1
loop
rs.close : set rs=nothing
%>

			<li class="navright"></li>
		</ul>
	</div>
</div>
</body>
</html>
