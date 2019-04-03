<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.general.BaseBean" %>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />

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
	int emp_id = user.getUID();
	String sub_com = ResourceComInfo.getSubCompanyID(""+emp_id);
String cjkc_name = Util.null2String(request.getParameter("cjkc_name"));
 	boolean isExist = false;
	boolean ispxadmin = false;
	int c_num = 0;
	int v_num = 0;
	String supsubcomid = "";
	String sql = "";

	//判断所在分部是否包含上级分部
	sql = " select supsubcomid from hrmsubcompany where id = "+sub_com;
    rs.executeSql(sql);
    new BaseBean().writeLog("sql---是否包含上级分部------" + sql);
    //out.println("emp_id="+ emp_id);
    if(rs.next()){
        supsubcomid = Util.null2String(rs.getString("supsubcomid"));
     }

     // 判断当前用户是否为培训管理员
	sql = " select count(id) as v_num  from formtable_main_258 where xm = "+emp_id;
    rs.executeSql(sql);
    new BaseBean().writeLog("sql---ispxadmin------" + sql);
    //out.println("emp_id="+ emp_id);
    if(rs.next()){
        v_num = rs.getInt("v_num");
        //out.println("v_num="+ v_num);
        if( v_num > 0|| emp_id==1 ){
			ispxadmin = true;
		}
     }

     // 判断当前用户是否为培训专员
    sql = " select count(id) as c_num  from formtable_main_257 where glyxm = " + emp_id;
	rs.executeSql(sql);
	new BaseBean().writeLog("sql---isExist------" + sql);
	//out.println("emp_id="+ emp_id);
		if(rs.next()){
			c_num = rs.getInt("c_num");
			//out.println("c_num="+ c_num);
			if( c_num > 0 ){
				isExist = true;
			}
		}
String tmc_pageId = "peixun001";
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

%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
	<FORM id=report name=report action=# method=post>
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

				

				<wea:item>课程名称</wea:item>
				<wea:item>
				 <input name="cjkc_name" id="cjkc_name" class="InputStyle" type="text" value="<%=cjkc_name%>"/>
				</wea:item>
				<wea:item></wea:item>
				<wea:item>
				
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
								
	String backfields = " (select subcompanyname from hrmsubcompany where id = pxzzf)as zzf_name,f.pxrq, "
												+" (select kcmc from formtable_main_193 where id = sqcjkc) as kc_name,"
												+" (select jsmc from formtable_main_192 fm where fm.id = f.jsmc) as js_name,f.ks,"
												+" (select lastname from hrmresource where id = sqr) as sqr_name,"
												+" (select workcode from hrmresource where id = sqr) as workcode,"
												+" (select subcompanyname from hrmsubcompany where id = ssgs)as gs_name ";
	String fromSql  = " from formtable_main_194 f ";
	String sqlWhere = " requestid in(select requestid from workflow_requestbase where currentnodetype in (1,2)) ";
	String orderby = " pxrq " ;
	String tableString = "";
    if(!isExist&&!ispxadmin){
		sqlWhere +=" and f.sqr =" +emp_id;
	}
	if(isExist&&!"23".equals(sub_com)){
		sqlWhere +=" and f.pxzzf in("+sub_com+","+supsubcomid+") ";
	}
	if(!"".equals(cjkc_name)){
			cjkc_name = cjkc_name.trim();
			sqlWhere += "and f.sqcjkc in (select id from formtable_main_193 where kcmc like '%"+cjkc_name+"%')";
	}


//  右侧鼠标 放上可以点击
String  operateString= "";	
tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(tmc_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+tmc_pageId +"\">"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
    operateString+
    "			<head>";
		tableString+=	"				<col width=\"32%\" text=\"课程名称\" column=\"kc_name\" orderkey=\"kc_name\"  />"+
														" 				<col width=\"9%\" text=\"培训日期\" column=\"pxrq\" orderkey=\"pxrq\"  />"+
														" 				<col width=\"6%\" text=\"课时(Hr)\" column=\"ks\" orderkey=\"ks\"  />"+
														" 				<col width=\"25%\" text=\"培训组织方\" column=\"zzf_name\" orderkey=\"zzf_name\"  />"+
														"				<col width=\"6%\" text=\"讲师名称\" column=\"js_name\" orderkey=\"js_name\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getLastname\" />"+
														" 				<col width=\"6%\" text=\"申请人\" column=\"sqr_name\" orderkey=\"sqr_name\"  />"+
														" 				<col width=\"6%\" text=\"工号\" column=\"workcode\" orderkey=\"workcode\"  />"+
														" 				<col width=\"10%\" text=\"所属公司\" column=\"gs_name\" orderkey=\"gs_name\"  />"+
    "			</head>"+
    " </table>";
%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" showExpExcel="true" />

	<script type="text/javascript">
	
		function onBtnSearchClick() {
			report.submit();
		}
		
	</script>
	</script>
			<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
</BODY>
</HTML>
