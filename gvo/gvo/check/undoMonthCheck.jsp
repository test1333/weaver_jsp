<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>

<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%
	int user_id = user.getUID();
%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />

<HTML>
<HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
<script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>

<style>
.checkbox {
	display: none
}
</style>
</head>
<%
String imagefilename = "/images/hdReport_wev8.gif";
String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
String needfav ="1";
String needhelp ="";



String checkstatus = (String)session.getAttribute("checkstatus");
String checkbmjl =  Util.null2String((String)session.getAttribute("checkbmjl"));
String checkbmzg =  Util.null2String((String)session.getAttribute("checkbmzg"));
String tiaojian = "";
 int userid  = user.getUID();
String tmc_pageId = "monthcheck11";
Calendar now = Calendar.getInstance();
	int now_year = now.get(Calendar.YEAR);
	int now_month = now.get(Calendar.MONTH) + 1;
	String nowmonth = "";
	if(now_month<10){
		nowmonth="0"+now_month;

	}else{
		nowmonth=""+now_month;
	}
	String dqny=now_year+"-"+nowmonth;
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
String gh = Util.null2String(request.getParameter("gh"));
String ygxm=Util.null2String(request.getParameter("ygxm"));

%>
	


<BODY>
<div id="tabDiv">
	<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
</div>
<div id="dialog">
 <div id='colShow'></div>
</div>
<input type="hidden" name="pageId" id="pageId" value="<%=tmc_pageId %>"/>
	<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
	<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
	<%
RCMenu += "{刷新,javascript:onBtnSearchClick(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
if("0".equals(checkstatus)){
RCMenu += "{添加记录,javascript:addRecord(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{删除记录,javascript:deleteRecord(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;	
}
RCMenu += "{所有提交,javascript:commitALL(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{所选提交,javascript:commitPart(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
if(!"0".equals(checkstatus)){
RCMenu += "{退回记录,javascript:backRecord(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
}
%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
	<FORM id=report name=report action="/gvo/check/undoMonthCheck.jsp" method=post>
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
                 <wea:item>员工部门</wea:item>
					<wea:item>
					<brow:browser viewType="0" name="department" browserValue='<%=department %>' 
					browserurl="/systeminfo/BrowserMain.jsp?mouldID=hrm&url=/hrm/company/MutiDepartmentBrowser.jsp?selectedids="
					hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
					completeUrl="/data.jsp?type=4"
					browserSpanValue='<%=Util.toScreen(departmentStr,user.getLanguage())%>'></brow:browser>
					</wea:item>
				<wea:item>工号</wea:item>
				<wea:item>
				 <input name="gh" id="gh" class="InputStyle" type="text" value="<%=gh%>"/>
				</wea:item>
				<wea:item>员工姓名</wea:item>
				<wea:item>
				<brow:browser viewType="0"  name="ygxm" browserValue="<%=ygxm %>" 
				browserOnClick=""
				browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
				hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
				completeUrl="/data.jsp?type=1" width="165px"
				browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(ygxm),user.getLanguage())%>">
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
    
	<%	
	 String backfields="";
	String fromSql ="";
	String sqlWhere = "";
	
     backfields = " id ,ygbm,khny,gh,ygxm,jxfs,jxdj,jxje,bzsm ,bmzg,bmjl "; 
	 fromSql  = " from uf_month_check  ";
	 sqlWhere = " where 1=1  and khny='"+dqny+"'  ";
	 if(!"".equals(checkstatus)){
		 sqlWhere += "and khzt='"+checkstatus+"'";
	 }
	  if(!"".equals(department)){
		sqlWhere +=" and ygbm in("+department+") ";
	}
	 if(!"".equals(gh)){
		sqlWhere +=" and gh ='"+gh+"' ";
	}
	 if(!"".equals(ygxm)){
		sqlWhere +=" and ygxm ='"+ygxm+"' ";
	}
    //if(userid !=1){
	if("1".equals(checkstatus)){
		sqlWhere +=" and bmzg ='"+userid+"'";
	}
	if("2".equals(checkstatus)){
		sqlWhere +=" and bmjl ='"+userid+"'";
	}
	//}
	if(!"".equals(checkbmjl)){
		sqlWhere +=" and bmjl ='"+checkbmjl+"'";
	}
	if(!"".equals(checkbmzg)){
		sqlWhere +=" and bmzg ='"+checkbmzg+"'";
	}
	 
  
	//out.print("select "+backfields+fromSql+sqlWhere);
	String orderby = " id " ;
   
	String tableString = "";
	

   


//  右侧鼠标 放上可以点击
String  operateString= "";
if("1".equals(checkstatus)){
	operateString = "<operates width=\"5%\">"+
 	        	    " <popedom transmethod=\"weaver.hrm.common.SplitPageTagOperate.getBasicOperate\" otherpara=\""+String.valueOf(user.isAdmin())+":true:true:true:true\"></popedom> "+
						 "     <operate href=\"javascript:editRecord();\" linkkey=\"id\" linkvaluecolumn=\"id\" text=\"考核\" target=\"_fullwindow\" isalwaysshow='true' index=\"0\"/>"+
 	       				"</operates>";
}
tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(tmc_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+tmc_pageId +"\">"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
    operateString+
    "			<head>";
		tableString+="<col width=\"15%\"  text=\"员工部门\" column=\"ygbm\" orderkey=\"ygbm\"  transmethod=\"weaver.hrm.company.DepartmentComInfo.getDepartmentname\"/>"+
		"<col width=\"10%\"  text=\"考核年月\" column=\"khny\" orderkey=\"khny\"/>"+
		"<col width=\"10%\"  text=\"工号\" column=\"gh\" orderkey=\"gh\"/>"+
		"<col width=\"10%\"  text=\"员工姓名\" column=\"ygxm\" orderkey=\"ygxm\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\"/>"+
		
		"<col width=\"10%\"  text=\"部门主管\" column=\"bmzg\" orderkey=\"bmzg\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\" display=\"false\"/>"+
		"<col width=\"10%\"  text=\"部门经理\" column=\"bmjl\" orderkey=\"bmjl\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\" display=\"false\"/>"+
		"<col width=\"10%\"  text=\"绩效分数\" column=\"jxfs\" orderkey=\"jxfs\"/>"+
		"<col width=\"10%\"  text=\"绩效等级\" column=\"jxdj\" orderkey=\"jxdj\"/>"+
		"<col width=\"10%\"  text=\"绩效金额\" column=\"jxje\" orderkey=\"jxje\"/>"+
		"<col width=\"20%\"  text=\"备注说明\" column=\"bzsm\" orderkey=\"bzsm\"/>"+
		
	"			</head>"+
    " </table>";
%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />
	<script type="text/javascript">
        function onBtnSearchClick() {
			report.submit();
		 }
	
		
		function deleteRecord(){
			var ids = _xtable_CheckedCheckboxId();
			//alert(sqr);
            if(ids!=null && ids!=""){
			  //alert(ids);
			  	var xhr = null;
				if (window.ActiveXObject) {//IE浏览器
					xhr = new ActiveXObject("Microsoft.XMLHTTP");
				} else if (window.XMLHttpRequest) {
					xhr = new XMLHttpRequest();
				}
				if (null != xhr) {
					xhr.open("GET","/gvo/check/deleteRecord.jsp?id="+ids, false);
					xhr.onreadystatechange = function () {
						if (xhr.readyState == 4) {
							if (xhr.status == 200) {
								var text = xhr.responseText;
								text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');		
								//alert(text);
								
							}	
						}
					}
				xhr.send(null);			
				}
				window.location.reload();
			}
		}
		function addRecord() {
		var title = "";
		var url = "/systeminfo/BrowserMain.jsp?url=/gvo/check/ModeForward.jsp?typex=addRecord";
		// var url = "/systeminfo/BrowserMain.jsp?url=/seahonor/crm/ModeForward.jsp?typex=custom,,";

		var diag_vote = new window.top.Dialog();
		diag_vote.currentWindow = window;
		diag_vote.Width = 650;
		diag_vote.Height = 400;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.isIframe=false;
		diag_vote.CancelEvent=function(){diag_vote.close();window.location.reload();};
		diag_vote.show();
		

	}
	function backRecord(){
		var status=<%=checkstatus%>;
			var ids = _xtable_CheckedCheckboxId();
			//alert(sqr);
            if(ids!=null && ids!=""){
			  //alert(ids);
			  	var xhr = null;
				if (window.ActiveXObject) {//IE浏览器
					xhr = new ActiveXObject("Microsoft.XMLHTTP");
				} else if (window.XMLHttpRequest) {
					xhr = new XMLHttpRequest();
				}
				if (null != xhr) {
					xhr.open("GET","/gvo/check/backRecord.jsp?id="+ids+"&status="+status, false);
					xhr.onreadystatechange = function () {
						if (xhr.readyState == 4) {
							if (xhr.status == 200) {
								var text = xhr.responseText;
								text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');		
								//alert(text);
								
							}	
						}
					}
				xhr.send(null);			
				}
				window.location.reload();
			}
		}
	function editRecord(id) {
		var title = "";
		var url = "/systeminfo/BrowserMain.jsp?url=/gvo/check/ModeForward.jsp?typex=editRecord,"+id;
		// var url = "/systeminfo/BrowserMain.jsp?url=/seahonor/crm/ModeForward.jsp?typex=custom,,";

		var diag_vote = new window.top.Dialog();
		diag_vote.currentWindow = window;
		diag_vote.Width = 650;
		diag_vote.Height = 400;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.isIframe=false;
		diag_vote.CancelEvent=function(){diag_vote.close();window.location.reload();};
		diag_vote.show();
		

	}
	function commitALL(){
		var status=<%=checkstatus%>;
		var tiaojian = "<%=tiaojian%>";
		var userid = <%=userid%>;
		var dqny = "<%=dqny%>";
		var checkbmjl = "<%=checkbmjl%>";
		var checkbmzg = "<%=checkbmzg%>";
			//  alert(status);
			  	var xhr = null;
				if (window.ActiveXObject) {//IE浏览器
					xhr = new ActiveXObject("Microsoft.XMLHTTP");
				} else if (window.XMLHttpRequest) {
					xhr = new XMLHttpRequest();
				}
				if (null != xhr) {
					xhr.open("GET","/gvo/check/commitAll.jsp?dqny="+dqny+"&status="+status+"&userid="+userid+"&checkbmjl="+checkbmjl+"&checkbmzg="+checkbmzg, false);
					xhr.onreadystatechange = function () {
						if (xhr.readyState == 4) {
							if (xhr.status == 200) {
								var text = xhr.responseText;
								text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');		
							//	alert(text);
								
							}	
						}
					}
				xhr.send(null);			
				}
				window.location.reload();
			
	}

	function commitPart(){
		var status=<%=checkstatus%>;
		var ids = _xtable_CheckedCheckboxId();
			//alert(sqr);
            if(ids!=null && ids!=""){
			  //alert(status);
			  	var xhr = null;
				if (window.ActiveXObject) {//IE浏览器
					xhr = new ActiveXObject("Microsoft.XMLHTTP");
				} else if (window.XMLHttpRequest) {
					xhr = new XMLHttpRequest();
				}
				if (null != xhr) {
					xhr.open("GET","/gvo/check/commitPart.jsp?id="+ids+"&status="+status, false);
					xhr.onreadystatechange = function () {
						if (xhr.readyState == 4) {
							if (xhr.status == 200) {
								var text = xhr.responseText;
								text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');		
								//alert(text);
								
							}	
						}
					}
				xhr.send(null);			
				}
				window.location.reload();
			}
	}
	</script>
	
	<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
</BODY>
</HTML>
