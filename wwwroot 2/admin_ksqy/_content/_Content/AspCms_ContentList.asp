<!--#include file="AspCms_ContentFun.asp" -->
<%CheckAdmin("AspCms_ContentList.asp?sortType="&sortType)%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml"><HEAD><TITLE></TITLE>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<LINK href="../../images/style.css" type=text/css rel=stylesheet>
<META content="MSHTML 6.00.3790.4807" name=GENERATOR></HEAD>
<SCRIPT>
function SelAll(theForm){
		for ( i = 0 ; i < theForm.elements.length ; i ++ )
		{
			if ( theForm.elements[i].type == "checkbox" && theForm.elements[i].name != "SELALL" )
			{
				theForm.elements[i].checked = ! theForm.elements[i].checked ;
			}
		}
}
</SCRIPT>
<BODY>
<FORM name="" action="?" method="post">
<DIV class=searchzone>

<TABLE height=30 cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR>
    <TD height=30>分类：<%LoadSelect "SortID","Aspcms_Sort","SortName","SortID",SortID, 0,"and SortType="&sortType&" order by SortOrder","所有分类"%>
      关键词：<INPUT class="input" size="16" name="keyword" value="<%=keyword%>">
      <INPUT class="button" type="submit" value="搜索" name="Submit" onClick="form.action='?<%="sortType="&sortType&"&sortid="&sortid&"&keyword="&keyword&"&page=&psize="&psize&"&order="&order&"&ordsc="&ordsc&""%>';">
      <INPUT onClick="location.href='<%=getPageName()%>?<%="sortType="&sortType%>'" type="button" value="全部" class="button" /></TD>
    <TD align=right colSpan=2>
    
    
    <INPUT onClick="location.href='AspCms_ContentAdd.asp?<%="sortType="&sortType&"&sortid="&sortid&"&keyword="&keyword&"&page="&page&"&psize="&psize&"&order="&order&"&ordsc="&ordsc&""%>'" type="button" value="添加<%=sortTypeName%>" class="button" > 
<%if sortType=3 then%>
    <INPUT onClick="location.href='../_Spec/AspCms_Spec.asp'" type="button" value="产品参数设置" class="button" > 
<%end if%>
    <INPUT onClick="location.href='<%=getPageName()%>?<%="sortType="&sortType&"&sortid="&sortid&"&keyword="&keyword&"&page="&page&"&psize="&psize&"&order="&order&"&ordsc="&ordsc&""%>'" type="button" value="刷新" class="button" /> 
</TD></TR></TBODY></TABLE></DIV>
<DIV class=listzone>
<TABLE cellSpacing=0 cellPadding=3 width="100%" align=center border=0>
  <TBODY>
  <TR class=list>
    <TD width=47 align="center" class=biaoti>选择</TD>
    <TD width=46 align="center" class=biaoti>编号</TD>
    <TD width="279" height=28 align="left" class=biaoti><span class="searchzone">标题</span></TD>
    <TD width=163 align="center" class=biaoti><span class="searchzone">分类</span></TD>
    <TD width=166 align="center" class=biaoti><span class="searchzone">发布时间</span></TD>
    <TD width=50 align="center" class=biaoti><span class="searchzone">排序</span></TD>
    <TD width=44 align="center" class=biaoti><span class="searchzone">状态</span></TD>
    <TD width=140 align="center" class=biaoti><span class="searchzone">操作</span></TD>
    </TR>
	<%listContent%>
    </TBODY></TABLE>
</DIV>
<DIV class="piliang">
<INPUT onClick="SelAll(this.form)" type="checkbox" value="1" name="SELALL"> 全选&nbsp;
<INPUT class="button" type="submit" value="删除" onClick="if(confirm('确定要删除吗')){form.action='?action=del<%="&sortType="&sortType&"&sortid="&sortid&"&keyword="&keyword&"&page="&page&"&psize="&psize&"&order="&order&"&ordsc="&ordsc&""%>';}else{return false};"/>  
<INPUT class="button" type="submit" value="禁用" onClick="form.action='?action=off<%="&sortType="&sortType&"&sortid="&sortid&"&keyword="&keyword&"&page="&page&"&psize="&psize&"&order="&order&"&ordsc="&ordsc&""%>';"./>
<INPUT class="button" type="submit" value="启用" onClick="form.action='?action=on<%="&sortType="&sortType&"&sortid="&sortid&"&keyword="&keyword&"&page="&page&"&psize="&psize&"&order="&order&"&ordsc="&ordsc&""%>';"/>
<INPUT class="button" type="submit" value="更新排序" onClick="form.action='?action=order<%="&sortType="&sortType&"&sortid="&sortid&"&keyword="&keyword&"&page="&page&"&psize="&psize&"&order="&order&"&ordsc="&ordsc&""%>';"/>

移动到:<%LoadSelect "moveSortID","Aspcms_Sort","SortName","SortID",getForm("id","get"), 0,"and SortType="&sortType&" order by SortOrder","请选择分类"%>
<INPUT class="button" type="submit" value="移动" onClick="form.action='?action=move<%="&sortType="&sortType&"&sortid="&sortid&"&keyword="&keyword&"&page="&page&"&psize="&psize&"&order="&order&"&ordsc="&ordsc&""%>';"/>

</DIV>
</FORM>
</BODY></HTML>
