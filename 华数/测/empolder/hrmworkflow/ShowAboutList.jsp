<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.PageManagerUtil " %>
<%@ page import="java.util.*" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="recordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="recordSet2" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="recordSet3" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="UserDefaultManager" class="weaver.docs.tools.UserDefaultManager" scope="session" />

<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<style type="text/css">
<!--
.my_1 {
	border-top-width: thin;
	border-right-width: thin;
	border-bottom-width: thin;
	border-left-width: thin;
	border-top-style: solid;
	border-right-style: none;
	border-bottom-style: none;
	border-left-style: none;
	border-top-color: #000000;
	border-right-color: #000000;
	border-bottom-color: #000000;
	border-left-color: #000000;
}
.STYLE2 {font-size: 30px}
.my_2 {
	border-right-width: thin;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 30px;
}
.my_3 {
	border-right-width: medium;
	border-right-style: solid;
	border-right-color: #CC0000;
}
-->
a{text-decoration:none;}
a:link{text-decoration:none;}
a:visited{text-decoration:none;}
a:hover{text-decoration:none;}
a:active{text-decoration:none;}
</style>
</head>
<% 
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "基层领导力落点";
String needfav ="1";
String needhelp ="";

String amorpm = Util.null2String(request.getParameter("amorpm"));
String year = Util.null2String(request.getParameter("year"));

int id = user.getUID();
String curyear = new java.text.SimpleDateFormat("yyyy").format(new java.util.Date()); 
java.util.Calendar c = java.util.Calendar.getInstance();
c.setTime(new java.util.Date()); 
int month = c.get(java.util.Calendar.MONTH);
//月份为1-6是评前一年的下半年，当前月份是7-12，是评当年年份的上半年
int imptype = (month<=6)?1:0;
if(imptype == 1){
	curyear = String.valueOf((Integer.parseInt(curyear) - 1));
}

if("".equals(amorpm) && "".equals(year)){
	year = curyear;
	amorpm = String.valueOf(imptype);
}

    //构建where语句
    String andSql="";
//     if (!"".equals(level)) andSql+=" and deplevel="+level;
//     if(!"".equals(name)) andSql+=" and name like '%"+name+"%'";

String ld1 = "";
String ld2 = "";
String ld3 = "";
String ld4 = "";
String ld5 = "";
String ld6 = "";
String ld7 = "";
String ld8 = "";
String ld9 = "";


String ld1c = "";
String ld2c = "";
String ld3c = "";
String ld4c = "";
String ld5c = "";
String ld6c = "";
String ld7c = "";
String ld8c = "";
String ld9c = "";

%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onSearch(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
%>

<%@ include file="/systeminfo/RightClickMenu.jsp" %>

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

<FORM id=weaver name=frmmain action=FnaBudgetfeeTypeOperation.jsp method=post >
<input class=inputstyle type=hidden name=operation value="add">

                         <!--搜索部分-->
                            <TABLE  class ="ViewForm">
                                <TBODY>
                                <colgroup>
                                <col width="5%">
                                <col width="35%">
                                <col width="10%">
                                <col width="35%">
                                <TR>
                                    <TD>年份</TD>
                                    <TD class="field">
                                    	<select name="year">
                                    		<option></option>
                                    		<%
                                    			String sql = "select distinct nf from formtable_main_223";
                                    			recordSet.executeSql(sql);
                                    			while(recordSet.next()){
                                    				%>
                                    				<option value="<%=recordSet.getString("nf") %>" <%if(recordSet.getString("nf").equals(year)){ %> selected="selected" <%} %>><%=recordSet.getString("nf") %></option>
                                    				<%
                                    			}
                                    		%>
                                    	</select>
                                    </TD>
                                    <TD>上半年或下半年</TD>
                                    <TD class="field">
                                    	<select name="amorpm">
                                    		<option></option>
                                    		<option value="0" <%if("0".equals(amorpm)){ %> selected="selected" <%} %>>上半年</option>
                                    		<option value="1" <%if("1".equals(amorpm)){ %> selected="selected" <%} %>>下半年</option>
                                    	</select>
                                    </TD>
                                </TR>
                                 <TR><TD class=Line colSpan=5></TD></TR>
                                </TBODY>
                            </TABLE>
                             <%
                             
                             	String sql_1 = "select t1.jcldlld,count(t1.jcldlld) as ccount from formtable_main_223 t1"+
                             			       " left join workflow_requestbase t2 on t1.requestid = t2.requestid"+
                             			       " where t2.currentnodetype = '3' and t1.nf = '"+year+"' and t1.aporpm = '"+amorpm+"' group by t1.jcldlld";
//                                  out.print(sql_1);
                                 recordSet2.executeSql(sql_1);
                                 while(recordSet2.next()){
                                	 if(recordSet2.getString("jcldlld").equals("0")){
                                		 ld1 = recordSet2.getString("jcldlld");
                                		 ld1c = recordSet2.getString("ccount");
                                	 }else if(recordSet2.getString("jcldlld").equals("1")){
                                		 ld2 = recordSet2.getString("jcldlld");
                                		 ld2c = recordSet2.getString("ccount");
                                	 }else if(recordSet2.getString("jcldlld").equals("2")){
                                		 ld3 = recordSet2.getString("jcldlld");
                                		 ld3c = recordSet2.getString("ccount");
                                	 }else if(recordSet2.getString("jcldlld").equals("3")){
                                		 ld4 = recordSet2.getString("jcldlld");
                                		 ld4c = recordSet2.getString("ccount");
                                	 }else if(recordSet2.getString("jcldlld").equals("4")){
                                		 ld5 = recordSet2.getString("jcldlld");
                                		 ld5c = recordSet2.getString("ccount");
                                	 }else if(recordSet2.getString("jcldlld").equals("5")){
                                		 ld6 = recordSet2.getString("jcldlld");
                                		 ld6c = recordSet2.getString("ccount");
                                	 }else if(recordSet2.getString("jcldlld").equals("6")){
                                		 ld7 = recordSet2.getString("jcldlld");
                                		 ld7c = recordSet2.getString("ccount");
                                	 }else if(recordSet2.getString("jcldlld").equals("7")){
                                		 ld8 = recordSet2.getString("jcldlld");
                                		 ld8c = recordSet2.getString("ccount");
                                	 }else if(recordSet2.getString("jcldlld").equals("8")){
                                		 ld9 = recordSet2.getString("jcldlld");
                                		 ld9c = recordSet2.getString("ccount");
                                	 }
                                 }
                             %>
                                <table width="990" height="455" border="0" cellspacing="5">
  <tr>
    <td width="37" rowspan="3" valign="top" bordercolor="#F0F0F0" class="my_2"><span>发展潜力</span></td>
    <td width="46" height="127" valign="middle"><span class="STYLE2">高阶</span></td>
    <td width="274" bgcolor="#C0CBCE"><span class="STYLE2">7.待观察<span style="font-size: 20px"><%if(!"".equals(ld7)){ %><a href="resourceList.jsp?jcldlld=<%=ld7 %>&amorpm=<%=amorpm %>&year=<%=year %>" target="_blank" style="text-decoration: none;">（<%=ld7c%>）</a><%} %></span></span></td>
    <td width="299" bgcolor="#6666CC"><span class="STYLE2">4.高潜力<span style="font-size: 20px"><%if(!"".equals(ld4)){ %><a href="resourceList.jsp?jcldlld=<%=ld4 %>&amorpm=<%=amorpm %>&year=<%=year %>" target="_blank" style="text-decoration: none;">（<%=ld4c%>）</a><%} %></span></span></td>
    <td width="294" bgcolor="#6666CC"><span class="STYLE2">1.重点苗子<span style="font-size: 20px"><%if(!"".equals(ld1)){ %><a href="resourceList.jsp?jcldlld=<%=ld1 %>&amorpm=<%=amorpm %>&year=<%=year %>" target="_blank" style="text-decoration: none;">（<%=ld1c%>）</a><%} %></span></span></td>
  </tr>
  <tr>
    <td height="120" valign="middle"><span class="STYLE2">中阶</span></td>
    <td bgcolor="#C0CBCE"><span class="STYLE2">8.深入辅导<span style="font-size: 20px"><%if(!"".equals(ld8)){ %><a href="resourceList.jsp?jcldlld=<%=ld8 %>&amorpm=<%=amorpm %>&year=<%=year %>" target="_blank" style="text-decoration: none;">（<%=ld8c%>）</a><%} %></span></span></td>
    <td bgcolor="#6666CC"><span class="STYLE2">5.好苗子<span style="font-size: 20px"><%if(!"".equals(ld5)){ %><a href="resourceList.jsp?jcldlld=<%=ld5 %>&amorpm=<%=amorpm %>&year=<%=year %>" target="_blank" style="text-decoration: none;">（<%=ld5c%>）</a><%} %></span></span></td>
    <td bgcolor="#6666CC"><span class="STYLE2">2.高潜力<span style="font-size: 20px"><%if(!"".equals(ld2)){ %><a href="resourceList.jsp?jcldlld=<%=ld2 %>&amorpm=<%=amorpm %>&year=<%=year %>" target="_blank" style="text-decoration: none;">（<%=ld2c%>）</a><%} %></span></span></td>
  </tr>
  <tr>
    <td height="126" valign="middle"><span class="STYLE2">有限</span></td>
    <td bgcolor="#C0CBCE"><span class="STYLE2">9.深入辅导<span style="font-size: 20px"><%if(!"".equals(ld9)){ %><a href="resourceList.jsp?jcldlld=<%=ld9 %>&amorpm=<%=amorpm %>&year=<%=year %>" target="_blank" style="text-decoration: none;">（<%=ld9c%>）</a><%} %></span></span></td>
    <td bgcolor="#C0CBCE"><span class="STYLE2">6.具发展空间<span style="font-size: 20px"><%if(!"".equals(ld6)){ %><a href="resourceList.jsp?jcldlld=<%=ld6 %>&amorpm=<%=amorpm %>&year=<%=year %>" target="_blank" style="text-decoration: none;">（<%=ld6c%>）</a><%} %></span></span></td>
    <td bgcolor="#C0CBCE"><span class="STYLE2">3.胜任者<span style="font-size: 20px"><%if(!"".equals(ld3)){ %><a href="resourceList.jsp?jcldlld=<%=ld3 %>&amorpm=<%=amorpm %>&year=<%=year %>" target="_blank" style="text-decoration: none;">（<%=ld3c%>）</a><%} %></span></span></td>
  </tr>
  <tr>
    <td height="37">&nbsp;</td>
    <td>&nbsp;</td>
    <td align="center"><span class="STYLE2">低</span></td>
    <td align="center"><span class="STYLE2">中</span></td>
    <td align="center"><span class="STYLE2">高</span></td>
  </tr>
  <tr>
    <td height="15">&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="3" align="right" class="my_1"><span class="STYLE2">基层领导能力</span></td>
  </tr>
</table>
                  </form>



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
</body>
<SCRIPT language="javascript">
function onSearch(){
        document.frmmain.action="ShowAboutList.jsp";
		document.frmmain.submit();
}
</script>
</html>