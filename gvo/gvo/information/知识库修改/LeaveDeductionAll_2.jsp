<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<%!
	//获取当前日期
	public String getNowDate(){   
   	 String temp_str="";   
    	Date dt = new Date();   
    	//最后的aa表示“上午”或“下午”    HH表示24小时制    如果换成hh表示12小时制   
    	//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss aa");
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");     
    	temp_str=sdf.format(dt);   
    	return temp_str;   
	} 
%>

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
	
	int userid = user.getUID();//获取当前登录用户的ID
	String year_name = Util.null2String(request.getParameter("year_name"));//在页面中获取字段的值；Util.null2String：如果对象为空则强制转换为String类型
	String month_name = Util.null2String(request.getParameter("month_name"));
	String recipient = Util.null2String(request.getParameter("recipient"));
	String empid = Util.null2String(request.getParameter("emp_id"));
	String tmp_startdate = "";
	String tmp_enddate = "";
	
	Calendar cal = Calendar.getInstance();
		if (!"".equals(year_name) && !"".equals(month_name)) {
		cal.set(Integer.parseInt(year_name),Integer.parseInt(month_name)-1, 1);
	}else{
		cal.set(Calendar.DAY_OF_MONTH, 1);
	}
	if("".equals(year_name))   year_name  = Integer.toString(cal.get(Calendar.YEAR));
	if("".equals(month_name))   month_name  = Integer.toString(cal.get(Calendar.MONTH)+1);
	
	String bef_month = Integer.toString(Integer.parseInt(month_name)-1);
	String bef_year = Integer.toString(Integer.parseInt(year_name)-1);
	
	//out.println("bef_month="+bef_month);
	
	if("0".equals(bef_month)){
		bef_month = "12";
		tmp_startdate = bef_year + "-" + (bef_month.length()==1?"0"+bef_month:bef_month) + "-"+ "26";
		tmp_enddate = year_name + "-" + (month_name.length()==1?"0"+month_name:month_name) + "-"+ "25"; 
	}
	else{
		tmp_startdate = year_name + "-" + (bef_month.length()==1?"0"+bef_month:bef_month) + "-"+ "26";
		tmp_enddate = year_name + "-" + (month_name.length()==1?"0"+month_name:month_name) + "-"+ "25";
	}
	
	Boolean isAdmin=false;
    String sql="";
    sql=" select count(id) as num_admin from HrmRoleMembers where roleid=36 and resourceid="+userid;
    rs.executeSql(sql);
    if(rs.next()){
        int num_admin=rs.getInt("num_admin");
        if(num_admin>0){
            isAdmin=true;
        }
    }
	
	String late_pageId = "late_info";
	%>
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
		<input type="hidden" name="pageId" id="pageId" value="<%=late_pageId%>"/>
		<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
		RCMenu += "{" + SystemEnv.getHtmlLabelName(527, user.getLanguage())+ ",javascript:onBtnSearchClick(),_self} ";
		RCMenuHeight += RCMenuHeightStep;//添加鼠标右键菜单：527为数据库中HtmlLableIndex表中对应的id，可通过id值获取显示的内容
		if(isAdmin){
		RCMenu +="{" + SystemEnv.getHtmlLabelName(-10946, user.getLanguage())+ ",javascript:firm(),_self} ";
		RCMenuHeight += RCMenuHeightStep;
		}
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="" method=post>
			<INPUT type="hidden" id="startdate" name="startdate" value="<%=tmp_startdate%>">
			<INPUT type="hidden" id="enddate" name="enddate" value="<%=tmp_enddate%>">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
						<%if(isAdmin){%>
						<input type=button class="e8_btn_top" onclick="firm();" value="迟到统计">
						<%}%>
						<span id="advancedSearch" class="advancedSearch">
						<%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%>
						</span>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
					</td>
				</tr>
			</table>
			<div>
			<table width="100%" class="ListStyle" style="font-size: 8pt">
			    <colgroup>
			    <col width="10%"></col>
			    <col width="5%"></col>
			    <col width="10%"></col>
			    <col width="5%"></col>
			    <col width="60%"></col>
			    <col width="10%"></col>
			    </colgroup>
				
				<tr>
					<td class=Field>
						<select id="year_name" name="year_name">
					    <option value=""></option>
					    <option value="2014" <%if ("2014".equals(year_name)) {%>selected<%}%>>2014</option>
					    <option value="2015" <%if ("2015".equals(year_name)) {%>selected<%}%>>2015</option>
					    <option value="2016" <%if ("2016".equals(year_name)) {%>selected<%}%>>2016</option>
					    <option value="2017" <%if ("2017".equals(year_name)) {%>selected<%}%>>2017</option>
					    <option value="2018" <%if ("2018".equals(year_name)) {%>selected<%}%>>2018</option>
					    <option value="2019" <%if ("2019".equals(year_name)) {%>selected<%}%>>2019</option>
				        </select>
					</td>
					<td class=Field>年</td>
					<td><select id="month_name" name="month_name">
					<option value=""></option>
					<option value="1" <%if ("1".equals(month_name)) {%>selected<%}%>>01</option>
					<option value="2" <%if ("2".equals(month_name)) {%>selected<%}%>>02</option>
					<option value="3" <%if ("3".equals(month_name)) {%>selected<%}%>>03</option>
					<option value="4" <%if ("4".equals(month_name)) {%>selected<%}%>>04</option>
					<option value="5" <%if ("5".equals(month_name)) {%>selected<%}%>>05</option>
					<option value="6" <%if ("6".equals(month_name)) {%>selected<%}%>>06</option>
					<option value="7" <%if ("7".equals(month_name)) {%>selected<%}%>>07</option>
					<option value="8" <%if ("8".equals(month_name)) {%>selected<%}%>>08</option>
					<option value="9" <%if ("9".equals(month_name)) {%>selected<%}%>>09</option>
					<option value="10" <%if ("10".equals(month_name)) {%>selected<%}%>>10</option>
					<option value="11" <%if ("11".equals(month_name)) {%>selected<%}%>>11</option>
					<option value="12" <%if ("12".equals(month_name)) {%>selected<%}%>>12</option>
				    </select></td>
				    <td class=Field>月</td>
					<td class=Field>当月迟到统计表  <font color="red">[<%=tmp_startdate%> - <%=tmp_enddate%>]</font></td>
				</tr>
			</table>
			</div>
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">
				<wea:item>员工姓名</wea:item>
				<wea:item>
				<brow:browser viewType="0"  name="recipient" browserValue="<%=recipient %>" 
				    browserOnClick=""
				    browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
				    hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
				    completeUrl="/data.jsp" width="165px"
				    browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(recipient),user.getLanguage())%>">
				</brow:browser>
				</wea:item>
				</wea:group>

				<wea:group context="">
				<wea:item type="toolbar">
				<input type="button" value="<%=SystemEnv.getHtmlLabelName(30947,user.getLanguage())%>" class="e8_btn_submit" onclick="onBtnSearchClick();"/>
				<input type="button" value="<%=SystemEnv.getHtmlLabelName(31129,user.getLanguage())%>" class="e8_btn_cancel" id="cancel"/>
				</wea:item>
				</wea:group>
				
				<wea:group context="">
				<wea:item type="toolbar">
				<input class="e8_btn_submit" type="submit" name="submit_1" onClick="onBtnSearchClick()" value="<%=SystemEnv.getHtmlLabelName(197, user.getLanguage()) %>"/>
				<span class="e8_sep_line">|</span>
				<input class="e8_btn_cancel" type="button" name="reset" onclick="resetCondtion()" value="<%=SystemEnv.getHtmlLabelName(2022, user.getLanguage()) %>"/>
				<span class="e8_sep_line">|</span>
				<input type="button" value="<%=SystemEnv.getHtmlLabelName(31129,user.getLanguage())%>" class="e8_btn_cancel" id="cancel"/>
				</wea:item>
				</wea:group>
				</wea:layout>
			</div>
		</FORM>
		<%
		String backfields = " za.xh,decode(za.type,0,'弱电',1,'运维',2,'应用系统') as leibie,"
		 +" decode(za.details2,0,'综合布线',1,'网络',2,'视频系统',3,'考勤门禁',4,'监控系统',5,'电话',6,'桌面支持',7,'服务器',8,'数据库',9,'存储',10,'会务',11,'SAP ERP',12,'Kingdee ERP',13,'鼎捷 ERP',14,'泛微OA',15,'EMC D2',16,'HR',17,'BI',18,'FineReport',19,'旧OA','') as new1,"
		 +" decode(za.details3,0,'故障恢复方法',1,'根本解决方案',2,'操作手册',3,'管理规程',4,'其他知识','') as new2,"
		 +" za.recorder,za.subject,za.descrip,za.reason,za.solution,za.unsolutioned,za.recorddate,za.remark,za.attached  ";
		//表单中的字段
		String fromSql  = " from formtable_main_325 za  ";//sql查询的表
		String sqlWhere = " 1=1 ";//where条件
		//out.println("select "+ backfields + fromSql +"where"+ sqlWhere);
		
		String orderby = " za.recorder " ;//排序关键字
		String tableString = "";
		String operateString= "";
        
		
		operateString = " <operates>";
		operateString +="    <popedom transmethod=\"weaver.workflow.workflow.WFAgentTransMethod.getAgentOperation\" ></popedom> ";
		operateString +=" </operates>";
        
	    tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(late_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+late_pageId+"\">"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"za.recorder\" sqlsortway=\"asc\" sqlisdistinct=\"false\"/>"+
		operateString +
		"			<head>";
		tableString+="<col width=\"20%\" labelid=\"413\" text=\"记录人\" column=\"recorder\" orderkey=\"recorder\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\" />"+
			"		<col width=\"20%\" labelid=\"1933\" text=\"类别\" column=\"leibie\" orderkey=\"leibie\" />"+
			"		<col width=\"20%\" labelid=\"-10975\" text=\"二级分类\" column=\"new1\" orderkey=\"new1\" />"+
			"		<col width=\"20%\" labelid=\"-10984\" text=\"三级分类\" column=\"new2\" orderkey=\"new2\" />"+
			"		<col width=\"20%\" labelid=\"-10985\" text=\"登记日期\" column=\"recorddate\" orderkey=\"recorddate\"/>"+
			"		<col width=\"20%\" labelid=\"1933\" text=\"主题\" column=\"subject\" orderkey=\"subject\" />"+
			"		<col width=\"20%\" labelid=\"-10975\" text=\"问题描述\" column=\"descrip\" orderkey=\"descrip\" />"+
			"		<col width=\"20%\" labelid=\"-10984\" text=\"问题发生原因\" column=\"reason\" orderkey=\"reason\" />"+
			"		<col width=\"20%\" labelid=\"-10985\" text=\"解决方案\" column=\"solution\" orderkey=\"solution\"/>"+
			"			</head>"+
			" </table>"; 
	%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run"/>
	<script type="text/javascript">
		function onBtnSearchClick() {
			report.submit();
		}
		function setCheckbox(chkObj) {
			if (chkObj.checked == true) {
				chkObj.value = 1;
			} else {
				chkObj.value = 0;
			}
		}
		
		function firm(){
			Dialog.confirm("是否统计迟到时间？", function (){
	        		report.action="/seahonor/attend/jsp/CountLate.jsp";
					report.submit();
				}, function () {}, 320, 90,false);
		
		}
		//查看地图
		/*function showMap(id, uid, thisDate){
			parent.parent.location.href = "/hrm/HrmTab.jsp?_fromURL=mobileSignIn&showMap=true&id="+id+"&uid="+uid+"&thisDate="+thisDate;
		}
		href=\"javascript:this.showMap('sign9',operater,operate_date)\"
		*/
		function showMap(id, uid, thisDate){
			var title = "";
			var url = "";
			title = "<%=SystemEnv.getHtmlLabelNames("82634",user.getLanguage())%>";
			url="/hrm/mobile/signin/mapView.jsp?id="+id+"&uid="+uid+"&thisDate="+thisDate;
		
			diag_vote = new window.top.Dialog();
			diag_vote.currentWindow = window;
			diag_vote.Width = 600;
			diag_vote.Height = 400;
			diag_vote.maxiumnable = true;
			diag_vote.Modal = true;
			diag_vote.Title = title;
			diag_vote.URL = url;
			diag_vote.show();
		}
		//编辑
		function onagentedit(emp_id){
				dialog = new window.top.Dialog();
				dialog.currentWindow = window;
				var operate_id = emp_id;
				var startDate=document.getElementById("startdate").value;//<%=tmp_startdate%>;
				var endDate=document.getElementById("enddate").value;//<%=tmp_enddate%>;
				//var endDate=<%=tmp_enddate%>;
				//alert("startDate="+startDate);
				//alert("endDate="+endDate);
				var url = "/seahonor/attend/jsp/SH_late_detail.jsp?emp_id="+operate_id+"&startDate="+startDate+"&endDate="+endDate+" ";
				dialog.Title = "迟到/早退明细";
				dialog.Width = 600;
				dialog.Height =550;
				dialog.Drag = true;
				 
				dialog.URL = url;
				dialog.show();
		}
	</script>
	<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	<script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>
</BODY>
</HTML>