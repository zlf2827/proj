<!--#include file="AspCms_ApplyFun.asp" -->
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
<form action="?<%="sortType="&sortType&"&sortid="&sortid&"&keyword="&keyword&"&page="&page&"&psize="&psize&"&order="&order&"&ordsc="&ordsc&""%>" method="post" name="form">
<DIV class=searchzone>

<TABLE height=30 cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR>
    <TD height=30>�����˻���ϵ�绰��
      <input type="text" name="keyword" value="<%=keyword%>" class="input"/>&nbsp;&nbsp;  
      <INPUT class="button" type="submit" value="����" name="Submit" onClick="form.action='?<%="sortType="&sortType&"&sortid="&sortid&"&keyword="&keyword&"&page=&psize="&psize&"&order="&order&"&ordsc="&ordsc&""%>';">
      <INPUT onClick="location.href='<%=getPageName()%>?<%="sortType="&sortType%>'" type="button" value="ȫ��" class="button" /></TD>
    <TD align=right colSpan=2>
    <INPUT onClick="location.href='<%=getPageName()%>?<%="sortType="&sortType&"&sortid="&sortid&"&keyword="&keyword&"&page="&page&"&psize="&psize&"&order="&order&"&ordsc="&ordsc&""%>'" type="button" value="ˢ��" class="button" /> 
</TD></TR></TBODY></TABLE></DIV>
<DIV class=listzone>
<TABLE cellSpacing=0 cellPadding=3 width="100%" align=center border=0>
  <TBODY>
  <TR class=list>
    <TD width=37 align="center" class=biaoti>ѡ��</TD>
    <TD width=36 align="center" class=biaoti>���</TD>
    <TD width="174" height=28 align="center" class=biaoti><span class="searchzone">ӦƸְλ</span></TD>
    <TD width=112 align="center" class=biaoti><span class="searchzone">������</span></TD>
    <TD width=49 align="center" class=biaoti><span class="searchzone">����</span></TD>
    <TD width=49 align="center" class=biaoti><span class="searchzone">�Ա�</span></TD>
    <TD width=199 align="center" class=biaoti><span class="searchzone">��ϵ�绰</span></TD>
    <TD width=148 align="center" class=biaoti><span class="searchzone">����ʱ��</span></TD>
    <TD width=39 align="center" class=biaoti><span class="searchzone">״̬</span></TD>
    <TD width=80 align="center" class=biaoti><span class="searchzone">����</span></TD>
    </TR>
	<%ApplyList%>
    </TBODY></TABLE>
</DIV>
<DIV class="piliang">
<INPUT onClick="SelAll(this.form)" type="checkbox" value="1" name="SELALL"> ȫѡ&nbsp;
<INPUT class="button" type="submit" value="ɾ��" onClick="if(confirm('ȷ��Ҫ����ɾ����?\n\n�˲���������!')){form.action='?action=del<%="&sortType="&sortType&"&sortid="&sortid&"&keyword="&keyword&"&page="&page&"&psize="&psize&"&order="&order&"&ordsc="&ordsc&""%>';}else{return false};"/>  



</DIV>
</FORM>
</BODY></HTML>