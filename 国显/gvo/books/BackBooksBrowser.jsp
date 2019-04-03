<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<HTML><HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Browser.css>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver.css></HEAD>
<%

String sqrid =  Util.null2String(request.getParameter("sqrid"));

String sqlwhere = " ";
String sql = "";

%>
<BODY>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
<tr>
<td height="10" colspan="3"></td>
</tr>
<tr>
<td ></td>
<td valign="top">
<TABLE class=Shadow>
<tr>
<td valign="top">
<FORM NAME=SearchForm STYLE="margin-bottom:0" action="SecondCodeBrowser.jsp" method=post>
<DIV align=right style="display:none">

<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:document.SearchForm.submit(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<BUTTON class=btnSearch accessKey=S type=submit><U>S</U>-<%=SystemEnv.getHtmlLabelName(197,user.getLanguage())%></BUTTON>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(199,user.getLanguage())+",javascript:document.SearchForm.reset(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<BUTTON class=btnReset accessKey=T type=reset><U>T</U>-<%=SystemEnv.getHtmlLabelName(199,user.getLanguage())%></BUTTON>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(201,user.getLanguage())+",javascript:window.parent.close(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<BUTTON class=btn accessKey=1 onclick="window.parent.close()"><U>1</U>-<%=SystemEnv.getHtmlLabelName(201,user.getLanguage())%></BUTTON>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(311,user.getLanguage())+",javascript:submitClear(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
%>	
<BUTTON class=btn accessKey=2 id=btnclear><U>2</U>-<%=SystemEnv.getHtmlLabelName(311,user.getLanguage())%></BUTTON>
</DIV>

		<table width=100% class=ViewForm>
<TR class=Spacing style="height: 1px"><TD class=Line1 colspan=4></TD></TR>
<TR>
<TD width=15%>图书名称</TD>
<TD width=35% class=field colspan="3"><input class=inputstyle name=codeName value=""></TD>

<TR style="height: 1px"><TD class=Line colSpan=6></TD></TR> 
</table>

<TABLE ID=BrowseTable class="BroswerStyle"  cellspacing="1" STYLE="margin-top:0" width="100%">
<TR class=DataHeader>
<TH style="display: none;"></TH>
<TH width=35%>图书名称</TH>
<TH width=35%>图书编号</TH>
<TH style="display: none;">藏书性质</TH>
<TH style="display: none;">藏书地点</TH>
<TH style="display: none;">图书编号</TH>
<TH style="display: none;">所属类别</TH>
</tr><TR class=Line style="height: 1px"><TH colspan="4" ></TH></TR>
<%
int i=0;
sql = "select t1.id,t1.tsmc,t1.tsbh,t1.csxz,t1.tsbh,t1.sslb, case t1.tsszd when 0 then '昆山AM' else '昆山PM' end as tsszd,t2.tslx from formtable_main_91 t1";
sql += " left join formtable_main_90 t2 ";
sql += " on t1.sslb = t2.id ";
sql += " where t1.mqjyr = '"+sqrid+"'";
//sql = " select id,tsmc,tsbh,csxz,tsbh,sslb, case tsszd when 0 then '昆山AM' else '昆山PM' end as tsszd from formtable_main_91 where mqjyr = '"+sqrid+"'";
 new BaseBean().writeLog(">>>>>>>>>>>>>>"+sql);
RecordSet.execute(sql);
while(RecordSet.next()){
	if(i==0){
		i=1;
%>
<TR class=DataLight>
<%
	}else{
		i=0;
%>
<TR class=DataDark>
	<%
	}
	%>
	<TD style="display: none;"><%=RecordSet.getString("id")%></TD>
	<TD><%=RecordSet.getString("tsmc")%></TD>
	<TD><%=RecordSet.getString("tsbh")%></TD>
	<TD style="display: none;"><%=RecordSet.getString("csxz")%></TD>
	<TD style="display: none;"><%=RecordSet.getString("tsszd")%></TD>
        <TD style="display: none;"><%=RecordSet.getString("tsbh")%></TD>
	<TD style="display: none;"><%=RecordSet.getString("tslx")%></TD>
	
</TR>
<%}%>
</TABLE></FORM>
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
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<script type="text/javascript">

jQuery(document).ready(function(){
	//alert(jQuery("#BrowseTable").find("tr").length)
	jQuery("#BrowseTable").find("tr[class^='Data'][class!='DataHeader']").bind("click",function(){
			
		window.parent.returnValue = {id:$(this).find("td:first").text(),name:$(this).find("td:first").next().text(),csxz:$(this).find("td:first").next().next().next().text(),tsszd:$(this).find("td:first").next().next().next().next().text(),tsbh:$(this).find("td:first").next().next().next().next().next().text(),sslb:$(this).find("td:first").next().next().next().next().next().next().text()};
			window.parent.close()
		})
	jQuery("#BrowseTable").find("tr[class^='Data'][class!='DataHeader']").bind("mouseover",function(){
			$(this).addClass("Selected")
		})
		jQuery("#BrowseTable").find("tr[class^='Data'][class!='DataHeader']").bind("mouseout",function(){
			$(this).removeClass("Selected")
		})

})


function submitClear()
{
	window.parent.returnValue = {id:"0",name:""};
	window.parent.close()
}

function onShowManagerID(inputname,spanname){
	var opts={
			_dwidth:'550px',
			_dheight:'550px',
			_url:'about:blank',
			_scroll:"no",
			_dialogArguments:"",
			
			value:""
		};
	var iTop = (window.screen.availHeight-30-parseInt(opts._dheight))/2+"px"; //获得窗口的垂直位置;
	var iLeft = (window.screen.availWidth-10-parseInt(opts._dwidth))/2+"px"; //获得窗口的水平位置;
	opts.top=iTop;
	opts.left=iLeft;
	
	data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp","","addressbar=no;status=0;scroll="+opts._scroll+";dialogHeight="+opts._dheight+";dialogWidth="+opts._dwidth+";dialogLeft="+opts.left+";dialogTop="+opts.top+";resizable=0;center=1;");
	if (data){
		if (data.id!=""){
			spanname.innerHTML = "<A href='HrmResource.jsp?id="+data.id+"'>"+data.name+"</A>";
			inputname.value=data.id;
		}else{
			spanname.innerHTML = "";
			inputname.value="";
		}
	}
}
</script>
</BODY></HTML>
<SCRIPT language="javascript" src="/js/datetime.js"></script>
<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker.js"></script>

