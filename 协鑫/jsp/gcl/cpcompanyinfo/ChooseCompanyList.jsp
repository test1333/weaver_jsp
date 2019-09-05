<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %>
 <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<HTML>
<base target="_self">
<HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver.css>
<style type="text/css">
.DataDark{
background-color:white;
}
.DataLight{
background-color:#F5FAFA;
}
.Selected{
background-color:#B1D4D9;
}
</style>

</HEAD>
<%
	String companyid = Util.null2String(request.getParameter("companyid"));
	String se_fieldname = Util.null2String(request.getParameter("se_fieldname"));
	String se_fielddesc = Util.null2String(request.getParameter("se_fielddesc"));
	String sql="";
	if("sqlserver".equals(rs.getDBType())){
		 sql = "select t1.*,(case substring(t1.archivenum,0,1) when 'L' then 1 when 'H' then 2 when 'R' then 3 when 'W' then 4 end ) as ablity from CPCOMPANYINFO t1 where t1.isdel='T' and t1.companyid !='"+companyid+"' ";
	}else{
		 sql = "select t1.*,(case substr(t1.archivenum,0,1) when 'L' then 1 when 'H' then 2 when 'R' then 3 when 'W' then 4 end ) as ablity from CPCOMPANYINFO t1 where t1.isdel='T' and t1.companyid !='"+companyid+"' ";
	}
	if(!"".equals(se_fieldname)){
		sql+=" and ARCHIVENUM like '%"+se_fieldname+"%'";
	}
	if(!"".equals(se_fielddesc)){
		sql+=" and COMPANYNAME like '%"+se_fielddesc+"%'";
	}
	sql+=" order by ablity asc,t1.archivenum asc";
	//System.out.println("执行的sql"+sql);
	rs.execute(sql);
	int i = 1;
%>
<BODY>

<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{搜索,javascript:window.parent.onseach(),_self} " ;
RCMenuHeight += RCMenuHeightStep;
RCMenu += "{清除,javascript:window.parent.onClean(),_self} " ;
RCMenuHeight += RCMenuHeightStep;
RCMenu += "{"+SystemEnv.getHtmlLabelName(201,user.getLanguage())+",javascript:window.parent.close(),_self} " ;
RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>

<form action="/cpcompanyinfo/ChooseCompanyList.jsp" method="post"  id="SearchForm">
	<input type="hidden" name="companyid"  value="<%=companyid %>" >
	
<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="*">
<col width="10">
<tr>
	<td height="10" colspan="3"></td>
</tr>
<tr>
	<td ></td>
	<td valign="top">
		<TABLE class=Shadow>
		<tr>
		<td valign="top" width="100%">
						<table width=100% class="viewform">
						<TR style="height:1px;"><TD class=Line colSpan=2></TD></TR> 
						<tr>
						<TD >公司编号</TD>
						<TD  class=field>
								<input type='text' name='se_fieldname' value='<%=se_fieldname%>'>
						</TD>
						<TD >公司名称</TD>
						<TD  class=field>
								<input type='text' name='se_fielddesc' value='<%=se_fielddesc%>'>
						</TD>
						</TR>
						<TR class="Spacing"  style="height:1px;"><TD class="Line1" colspan=2></TD></TR>
						</table>

						<TABLE ID=BrowseTable class='' cellSpacing=10 cellPadding=10   style="table-layout: fixed;width:100%;">
						<colgroup>
							<col width="0">
							<col width="50%">
							<col width="50%">
						</colgroup>
								<TR class=DataHeader>
								<TH width="0"></TH>
								<TH width=50% >公司编号</TH>
								<TH width=50% >公司名称</TH>
								</tr>
									<%
										while(rs.next()){
									%>
									<tr class="<%=i%2==0?"DataDark":"DataLight" %>" >
										<td width="0"  >
											<%=rs.getString("COMPANYID") %>
										</td>
										<td width="50%" style="word-wrap:break-word;"   >
											<%=rs.getString("ARCHIVENUM") %>
										</td>
										<td width="50%" style="word-wrap:break-word;"  >
											<%=rs.getString("COMPANYNAME") %>
										</td>
									</tr>
										
									<%
										i++;
									}
									%>	
						</table>
</td>
		</tr>
		</TABLE>
	</td>
	<td></td>
</tr>
<tr>
	<td height="10" colspan="3"></td>
</tr>
</table>
</form>
</BODY></HTML>

<SCRIPT LANGUAGE="javascript">
var ids = "";
var names = "";
//多选
jQuery(document).ready(function(){
	//alert(jQuery("#BrowseTable").find("tr").length)
	jQuery("#BrowseTable").find("tr[class^='Data'][class!='DataHeader']").bind("click",function(event){
		if($(this)[0].tagName=="TR"&&event.target.tagName!="INPUT"){
					ids = jQuery(this).find("td:eq(0)").text();
			   		names =jQuery(this).find("td:eq(2)").text();
			   		window.parent.returnValue = {id: ids,name: names};
     				window.parent.close();
		}
	})
	jQuery("#BrowseTable").find("tr[class^='Data'][class!='DataHeader']").bind("mouseover",function(){
		$(this).addClass("Selected")
	})
	jQuery("#BrowseTable").find("tr[class^='Data'][class!='DataHeader']").bind("mouseout",function(){
		$(this).removeClass("Selected")
	})

});
function onSubmit() {
		$G("SearchForm").submit()
}
function onClean()
{
	 window.parent.returnValue = {id: "0",name: ""};
     window.parent.close();
}
function onseach(){
	$("#SearchForm").submit()
}
</script>