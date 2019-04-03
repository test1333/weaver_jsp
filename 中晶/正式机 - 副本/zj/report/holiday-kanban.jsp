<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />

<%
Integer lg=(Integer)user.getLanguage();
int user_id = user.getUID();
Calendar today = Calendar.getInstance() ; 
String currentyear = Util.add0(today.get(Calendar.YEAR),4) ;
String currentdate = Util.add0(today.get(Calendar.YEAR),4) + "-" + Util.add0(today.get(Calendar.MONTH)+1,2) + "-" + Util.add0(today.get(Calendar.DAY_OF_MONTH),2);
//out.println(currentyear);
//out.println(currentdate);
String tmc_pageId = "hkb001";
weaver.general.AccountType.langId.set(lg);
String subid = Util.null2String(request.getParameter("subid"));
String searchyear = Util.null2String(request.getParameter("searchyear"));
String xm = Util.null2String(request.getParameter("xm"));
String sql="";
	String department = Util.null2String(request.getParameter("department"));
	String departmentStr = "";
    String sql1 = "select departmentname from HrmDepartment where id in ("+department+")";
	rs.executeSql(sql1);
	String text="";
	String flag="";
	while(rs.next()){
	       departmentStr =departmentStr+""+flag;
	       text = Util.null2String(rs.getString("departmentname"));
		  departmentStr +=text;
		  flag = ",";
	   }
if("".equals(searchyear)){
	searchyear=currentyear;
}
	String backfields="id,workcode,'"+searchyear+"' as year,lastname,'"+searchyear+"/01/01' as startday,[dbo].[f_get_holiday_info](id,'1','"+searchyear+"') as kxnxj,[dbo].[f_get_holiday_info](id,'2','"+searchyear+"') as yxnxj,[dbo].[f_get_holiday_info](id,'3','"+searchyear+"') as kxtxj,[dbo].[f_get_holiday_info](id,'4','"+searchyear+"') as yxtxj,[dbo].[f_get_holiday_info](id,'5','"+searchyear+"') as sj,[dbo].[f_get_holiday_info](id,'6','"+searchyear+"') as bj,[dbo].[f_get_holiday_info](id,'7','"+searchyear+"') as tqj,[dbo].[f_get_holiday_info](id,'8','"+searchyear+"') as hj,[dbo].[f_get_holiday_info](id,'9','"+searchyear+"') as cj,[dbo].[f_get_holiday_info](id,'10','"+searchyear+"') as brj, [dbo].[f_get_holiday_info](id,'11','"+searchyear+"') as sangjia,[dbo].[f_get_holiday_info](id,'12','"+searchyear+"') as wc,"+
					  "[dbo].[f_get_holiday_info](id,'13','"+searchyear+"') as pcj,[dbo].[f_get_holiday_info](id,'14','"+searchyear+"') as cjj,[dbo].[f_get_holiday_info](id,'15','"+searchyear+"') as jyssj,[dbo].[f_get_holiday_info](id,'16','"+searchyear+"') as gsj,[dbo].[f_get_holiday_info](id,'17','"+searchyear+"')as sgyynxcj,[dbo].[f_get_holiday_info](id,'18','"+searchyear+"') as sgyywxcj ";
		String fromSql="  from hrmresource ";
		String sqlWhere=" where subcompanyid1='"+subid+"' and status in (0,1,2,3) ";
		String orderby = " id ";
		if(!"".equals(xm)){
			sqlWhere = sqlWhere +" and id='"+xm+"'";
		}
		if(!"".equals(department)){
			sqlWhere = sqlWhere +" and departmentid in ("+department+") ";
		}
		
//String sqlquery="select workcode,'"+searchyear+"' as year,lastname,'"+searchyear+"/01/01' as startday,[dbo].[f_get_holiday_info](id,'1','"+searchyear+"') as kxnxj,[dbo].[f_get_holiday_info](id,'2','"+searchyear+"') as yxnxj,[dbo].[f_get_holiday_info](id,'3','"+searchyear+"') as kxtxj,[dbo].[f_get_holiday_info](id,'4','"+searchyear+"') as yxtxj,[dbo].[f_get_holiday_info](id,'5','"+searchyear+"') as sj,[dbo].[f_get_holiday_info](id,'6','"+searchyear+"') as bj,[dbo].[f_get_holiday_info](id,'7','"+searchyear+"') as tqj,[dbo].[f_get_holiday_info](id,'8','"+searchyear+"') as hj,[dbo].[f_get_holiday_info](id,'9','"+searchyear+"') as cj,[dbo].[f_get_holiday_info](id,'10','"+searchyear+"') as brj, [dbo].[f_get_holiday_info](id,'11','"+searchyear+"') as sangjia,[dbo].[f_get_holiday_info](id,'12','"+searchyear+"') as wc,"+
//"[dbo].[f_get_holiday_info](id,'13','"+searchyear+"') as pcj,[dbo].[f_get_holiday_info](id,'14','"+searchyear+"') as cjj,[dbo].[f_get_holiday_info](id,'15','"+searchyear+"') as jyssj,[dbo].[f_get_holiday_info](id,'16','"+searchyear+"') as gsj,[dbo].[f_get_holiday_info](id,'17','"+searchyear+"')as sgyynxcj,[dbo].[f_get_holiday_info](id,'18','"+searchyear+"') as sgyywxcj "+
//" from hrmresource where subcompanyid1='"+subid+"' and status in (0,1,2,3) ";
//if(!"".equals(xm)){
//	sqlquery = sqlquery +" and id='"+xm+"'";
//}
//if(!"".equals(department)){
//	sqlquery = sqlquery +" and departmentid in ("+department+") ";
//}
String sqlquery="select "+backfields+fromSql+sqlWhere+" order by id asc";
//out.print(sqlquery);
int with1=1740;
int with2=1780;
%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="AccountType" class="weaver.general.AccountType" scope="page" />
<jsp:useBean id="LicenseCheckLogin" class="weaver.login.LicenseCheckLogin" scope="page" />
<HTML>
	<HEAD>
		<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
		<script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
		<script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>
		<link rel="stylesheet" href="/css/init_wev8.css" type="text/css" />
		<style>
		.checkbox {
			display: none
		}
		TABLE.ViewForm1 {
			WIDTH: <%=with1%>px;
			border:0;margin:0;
			border-collapse:collapse;
		
	   }
		TABLE.ViewForm1 TD {
			padding:0 0 0 5px;
		}
		TABLE.ViewForm1 TR {
			height: 35px;
		}
		.table-head{padding-right:17px}
         .table-body{width:100%;overflow-y:auto;overflow-x: hidden}
		</style>
		
	</head>
	<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
    <link href="/js/swfupload/default_wev8.css" rel="stylesheet" type="text/css" />
  <link type="text/css" rel="stylesheet" href="/css/crmcss/lanlv_wev8.css" />
  <link type="text/css" rel="stylesheet" href="/wui/theme/ecology8/skins/default/wui_wev8.css" />
	<BODY >
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
			RCMenu += "{刷新,javascript:refersh(),_self} " ;
		RCMenu += "{导出,javascript:_xtable_getAllExcel(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="/zj/report/holiday-kanban.jsp" method=post>
			<input type="hidden" name="requestid" value="">
			<input type="hidden" name="subid" id="subid" value="<%=subid%>">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
					<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
					</td>
				</tr>
			</table>
			
			<% // 查询条件 %>
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">
				 <wea:item>年份</wea:item>
				<wea:item>
				  <select class="e8_btn_top middle" name="searchyear" id="searchyear">
				    <option value="" <%if("".equals(searchyear)){%> selected<%} %>>
                    <%=""%></option>
				  <%
						int length = Integer.parseInt(currentyear)-2017+10; 
						 	for(int i=0;i<length;i++){
							  String selectvalue=2017+i+"";
				  %>
					   <option value="<%=selectvalue%>" <%if(selectvalue.equals(searchyear)){%> selected<%} %>>
                    <%=selectvalue%></option>
				  <% }%>
		          </select>
				</wea:item>
				<wea:item>部门</wea:item>
                   <wea:item>
                    <brow:browser viewType="0" name="department" browserValue='<%=department %>'
                    browserurl="/systeminfo/BrowserMain.jsp?mouldID=hrm&url=/hrm/company/MutiDepartmentBrowser.jsp?selectedids="
                    hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
                    completeUrl="/data.jsp?type=4"
                    browserSpanValue='<%=Util.toScreen(departmentStr,user.getLanguage())%>'></brow:browser>
                    </wea:item>
				<wea:item>姓名</wea:item>
                <wea:item>
                <brow:browser viewType="0"  name="xm" browserValue="<%=xm%>"
                browserOnClick=""
                browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
                hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
                completeUrl="/data.jsp" width="165px"
                browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(xm),user.getLanguage())%>">
                </brow:browser>
                </wea:item>

				</wea:group>
				<wea:group context="">
				<wea:item type="toolbar">
				<input type="button" value="<%=SystemEnv.getHtmlLabelName(30947,user.getLanguage())%>" class="e8_btn_submit" onclick="onBtnSearchClick();"/>
				<input type="button" value="<%=SystemEnv.getHtmlLabelName(31129,user.getLanguage())%>" class="e8_btn_cancel" id="cancel"/>
				</wea:item>
				</wea:group>
				</wea:layout>
			</div>
		</FORM>
	
	<div style="width:<%=with2%>px; ">	
	<div class="table-head" style="width:<%=with1%>px; ">
			<table class="ViewForm1  outertable" scrolling="auto">
    <tbody>		
        <tr>			
            <td>
            <table class="ViewForm1  maintable" scrolling="auto" id='table11'>
                <colgroup> 
				<col width="100px">
				 <col width="100px">
				 <col width="100px">
				 <col width="100px">
				 <col width="100px">
				 <col width="100px">
				 <col width="100px">
				 <col width="100px">
				 <col width="50px">
				 <col width="50px">
				 <col width="50px">
				 <col width="50px">
				 <col width="100px">
				 <col width="50px">
				 <col width="50px">
				 <col width="50px">
				 <col width="50px">
				 <col width="50px">
				 <col width="100px">
				 <col width="50px">
				 <col width="120px">
				 <col width="120px">

				
				
				 
				 </colgroup>
                <tbody>
					 <tr>
						
				  	  <td class="fname">工号</td>
					  <td class="fname">休假年度</td>
					  <td class="fname">姓名</td>
					  <td class="fname">年休起始日</td>
					  <td class="fname">可休年休假</td>
					  <td class="fname">已休年休假</td>
					  <td class="fname">可休调休假</td>
					  <td class="fname">已休调休假</td>
					  <td class="fname">事假</td>
					  <td class="fname">病假</td>
					  <td class="fname">探亲假</td>
					  <td class="fname">婚假</td>
					  <td class="fname">产假及看护假</td>
					  <td class="fname">哺乳假</td>
					  <td class="fname">丧假</td>
					  <td class="fname">外出</td>
					  <td class="fname">陪产假</td>
					  <td class="fname">产检假</td>
					  <td class="fname">节育手术假</td>
					  <td class="fname">工伤假</td>
					  <td class="fname">四个月以内小产假</td>
					  <td class="fname">四个月以外小产假</td>
					 
				</tr>
				</tbody>
            </table>
            </td>
        </tr>
    </tbody>
</table>
	</div>
	<div class="table-body" id="div22" style="width:<%=with2%>px; ">
	<table class="ViewForm1  outertable" scrolling="auto">
    <tbody>		
        <tr>			
            <td>
            <table class="ViewForm1  maintable" scrolling="auto">
                <colgroup>  
				<col width="100px">
				 <col width="100px">
				 <col width="100px">
				 <col width="100px">
				 <col width="100px">
				 <col width="100px">
				 <col width="100px">
				 <col width="100px">
				 <col width="50px">
				 <col width="50px">
				 <col width="50px">
				 <col width="50px">
				 <col width="100px">
				 <col width="50px">
				 <col width="50px">
				 <col width="50px">
				 <col width="50px">
				 <col width="50px">
				 <col width="100px">
				 <col width="50px">
				 <col width="120px">
				 <col width="120px">

				 </colgroup>
                <tbody>
				 <%
					 	rs1.executeSql(sqlquery);
						 while(rs1.next()){
					 %>
					 <tr>
						  <td class="fvalue"><%=rs1.getString("workcode")%></td>
						  <td class="fvalue"><%=rs1.getString("year")%></td>
						  <td class="fvalue"><a href=javaScript:showkanban('<%=rs1.getString("id")%>')><%=rs1.getString("lastname")%></a></td>
						  <td class="fvalue"><%=rs1.getString("startday")%></td>
						  <td class="fvalue"><%=rs1.getString("kxnxj")%></td>
						  <td class="fvalue"><%=rs1.getString("yxnxj")%></td>
						  <td class="fvalue"><%=rs1.getString("kxtxj")%></td>
						  <td class="fvalue"><%=rs1.getString("yxtxj")%></td>
						  <td class="fvalue"><%=rs1.getString("sj")%></td>
						  <td class="fvalue"><%=rs1.getString("bj")%></td>
						  <td class="fvalue"><%=rs1.getString("tqj")%></td>
						  <td class="fvalue"><%=rs1.getString("hj")%></td>
						  <td class="fvalue"><%=rs1.getString("cj")%></td>
						  <td class="fvalue"><%=rs1.getString("brj")%></td>
						  <td class="fvalue"><%=rs1.getString("sangjia")%></td>
						  <td class="fvalue"><%=rs1.getString("wc")%></td>
						  <td class="fvalue"><%=rs1.getString("pcj")%></td>
						  <td class="fvalue"><%=rs1.getString("cjj")%></td>
						  <td class="fvalue"><%=rs1.getString("jyssj")%></td>
						  <td class="fvalue"><%=rs1.getString("gsj")%></td>
						  <td class="fvalue"><%=rs1.getString("sgyynxcj")%></td>
						  <td class="fvalue"><%=rs1.getString("sgyywxcj")%></td>
						
					 </tr>

					 <%
						 }
					 %>
					
                </tbody>
            </table>
			 </td>
        </tr>
    </tbody>
</table>
           
</div>
</div>	
<div style="display:none">
		  <td class="fvalue"><%=rs1.getString("workcode")%></td>
						  <td class="fvalue"><%=rs1.getString("year")%></td>
						  <td class="fvalue"><%=rs1.getString("lastname")%></td>
						  <td class="fvalue"><%=rs1.getString("startday")%></td>
						  <td class="fvalue"><%=rs1.getString("kxnxj")%></td>
						  <td class="fvalue"><%=rs1.getString("yxnxj")%></td>
						  <td class="fvalue"><%=rs1.getString("kxtxj")%></td>
						  <td class="fvalue"><%=rs1.getString("yxtxj")%></td>
						  <td class="fvalue"><%=rs1.getString("sj")%></td>
						  <td class="fvalue"><%=rs1.getString("bj")%></td>
						  <td class="fvalue"><%=rs1.getString("tqj")%></td>
						  <td class="fvalue"><%=rs1.getString("hj")%></td>
						  <td class="fvalue"><%=rs1.getString("cj")%></td>
						  <td class="fvalue"><%=rs1.getString("brj")%></td>
						  <td class="fvalue"><%=rs1.getString("sangjia")%></td>
						  <td class="fvalue"><%=rs1.getString("wc")%></td>
						  <td class="fvalue"><%=rs1.getString("pcj")%></td>
						  <td class="fvalue"><%=rs1.getString("cjj")%></td>
						  <td class="fvalue"><%=rs1.getString("jyssj")%></td>
						  <td class="fvalue"><%=rs1.getString("gsj")%></td>
						  <td class="fvalue"><%=rs1.getString("sgyynxcj")%></td>
						  <td class="fvalue"><%=rs1.getString("sgyywxcj")%></td>
	<%
	String tableString="";
	String  operateString= "";
tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(tmc_pageId,user.getUID(),PageIdConst.HRM)+"\" >"+	
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"asc\" sqlisdistinct=\"false\"/>"+
    operateString+
    "			<head>";
		tableString+="<col width=\"100px\"  text=\"工号\" column=\"workcode\" orderkey=\"workcode\" hide=\"true\"/>"+
					"<col width=\"100px\"  text=\"休假年度\" column=\"year\" orderkey=\"year\" hide=\"true\"/>"+
		             "<col width=\"100px\"  text=\"姓名\" column=\"lastname\" orderkey=\"lastname\" hide=\"true\"/>"+
					 "<col width=\"100px\"  text=\"年休起始日\" column=\"startday\" orderkey=\"startday\" hide=\"true\"/>"+
					 "<col width=\"100px\"  text=\"可休年休假\" column=\"kxnxj\" orderkey=\"kxnxj\" hide=\"true\"/>"+
					 "<col width=\"100px\"  text=\"已休年休假\" column=\"yxnxj\" orderkey=\"yxnxj\" hide=\"true\"/>"+
					 "<col width=\"100px\"  text=\"可休调休假\" column=\"kxtxj\" orderkey=\"kxtxj\" hide=\"true\"/>"+
					 "<col width=\"100px\"  text=\"已休调休假\" column=\"yxtxj\" orderkey=\"yxtxj\" hide=\"true\"/>"+
					 "<col width=\"50px\"  text=\"事假\" column=\"sj\" orderkey=\"sj\" hide=\"true\"/>"+
					 "<col width=\"50px\"  text=\"病假\" column=\"bj\" orderkey=\"bj\" hide=\"true\"/>"+
					 "<col width=\"50px\"  text=\"探亲假\" column=\"tqj\" orderkey=\"tqj\" hide=\"true\"/>"+
					 "<col width=\"50px\"  text=\"婚假\" column=\"hj\" orderkey=\"hj\" hide=\"true\"/>"+
					 "<col width=\"100px\"  text=\"产假及看护假\" column=\"cj\" orderkey=\"cj\" hide=\"true\"/>"+
					 "<col width=\"50px\"  text=\"哺乳假\" column=\"brj\" orderkey=\"brj\" hide=\"true\"/>"+
					 "<col width=\"50px\"  text=\"丧假\" column=\"sangjia\" orderkey=\"sangjia\" hide=\"true\"/>"+
					 "<col width=\"50px\"  text=\"外出\" column=\"wc\" orderkey=\"wc\" hide=\"true\"/>"+
					 "<col width=\"50px\"  text=\"陪产假\" column=\"pcj\" orderkey=\"pcj\" hide=\"true\"/>"+
					 "<col width=\"50px\"  text=\"产检假\" column=\"cjj\" orderkey=\"cjj\" hide=\"true\"/>"+
					 "<col width=\"100px\"  text=\"节育手术假\" column=\"jyssj\" orderkey=\"jyssj\" hide=\"true\"/>"+
					 "<col width=\"50px\"  text=\"工伤假\" column=\"gsj\" orderkey=\"gsj\" hide=\"true\"/>"+
					 "<col width=\"120px\"  text=\"四个月以内小产假\" column=\"sgyynxcj\" orderkey=\"sgyynxcj\" hide=\"true\"/>"+
					 "<col width=\"120px\"  text=\"四个月以外小产假\" column=\"sgyywxcj\" orderkey=\"sgyywxcj\" hide=\"true\"/>";
		

	tableString +="			</head>"+
    " </table>";
%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" showExpExcel="true"/>
</div>
	<script type="text/javascript">
	window.onload=function(){
		var clienthei= document.body.clientHeight;
		var height1=Number(clienthei)-100;
		height1=height1+'px';
		document.getElementById('div22').style.height=height1;
	}
	  
		var parentWin;
		try{
		parentWin = parent.getParentWindow(window);
		}catch(e){}
		function onBtnSearchClick() {
			report.submit();
		}
        	var parentWin="";
		function refersh() {
  			window.location.reload();
  		}
		  function onBtnSaveClick() {	
			$('#report1').submit();	
			window.close();
		}
	   
function showkanban(xm){
	var diag_vote;
        var searchyear=<%=searchyear%>;
        var title = "";
        var url = "";
        title = "个人假期看板";
        url="/zj/report/holiday-person-kanban.jsp?searchyear="+searchyear+"&xm="+xm;

        if(window.top.Dialog){
        diag_vote = new window.top.Dialog();
     } else {
         diag_vote = new Dialog();
     };
     diag_vote.currentWindow = window;
        
        diag_vote.maxiumnable = true;
        diag_vote.Width = 1000;
        diag_vote.Height = 800;
        diag_vote.Model = true;
        diag_vote.Title = title;
        diag_vote.URL = url;
        diag_vote.CancelEvent=function(){diag_vote.close();window.location.reload();};
        diag_vote.show(""); 
        }

	</script>
<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
</BODY>
</HTML>