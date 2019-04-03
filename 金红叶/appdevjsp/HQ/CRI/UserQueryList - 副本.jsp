<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs_dt" class="weaver.conn.RecordSet" scope="page" />
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
	String def_pageId = "userquerylist";
	String imagefilename = "/images/hdReport_wev8.gif";
	String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
	String needfav ="1";
	String needhelp ="";
	boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
	int userid = user.getUID();
	int tmp_num = 0;
	String type = Util.null2String(request.getParameter("type"));
	String empname = Util.null2String(request.getParameter("empname"));
	String sex = Util.null2String(request.getParameter("sex"));
	String company = Util.null2String(request.getParameter("company"));
	String province = Util.null2String(request.getParameter("province"));
	String provincename = "";
	String sql = " select provincename from hrmprovince where id = '"+province+"' ";
	rs.execute(sql);
	if(rs.next()){
		provincename = Util.null2String(rs.getString("provincename"));
	}
	%>
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
		<input type="hidden" name="pageId" id="pageId" value="<%=def_pageId%>"/>
		<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="" method=post>
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">	
					<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu">
					</span>
					</td>
				</tr>
			</table>

			<div>
				<wea:layout type="4col">
				<wea:group context="查询条件">				

				<wea:item>查询种类</wea:item>
				<wea:item>
				<select class="e8_btn_top middle" name="type" id="type"> 
     			<option value="">&nbsp;</option>
     			<option value="0" <% if(type.equals("0")) {%>selected<%}%>>个人</option>
     			<option value="1" <% if(type.equals("1")) {%>selected<%}%>>公司</option>
				</select>&nbsp;&nbsp;<span class="e8tips" title="查询种类为必填"><img align="absMiddle" src="/images/tooltip_wev8.png" /></span> 
				</wea:item>
				<wea:item></wea:item><wea:item></wea:item>

				<wea:item>姓名</wea:item>
				<wea:item><INPUT name="empname" id="empname" class='InputStyle' style="width:160px" value="<%=empname%>">
				</wea:item>

				<wea:item>性别</wea:item>
				<wea:item>
				<select class="e8_btn_top middle" name="sex" id="sex"> 
     			<option value="">&nbsp;</option>
     			<option value="0" <% if(sex.equals("0")) {%>selected<%}%>>男</option>
     			<option value="1" <% if(sex.equals("1")) {%>selected<%}%>>女</option>
				</select>
				</wea:item>

				<wea:item>公司名</wea:item>
				<wea:item><INPUT name="company" id ="company" class='InputStyle' style="width:200px" value="<%=company%>">
				</wea:item>

				<wea:item>省份</wea:item>
				<wea:item>
				<brow:browser viewType="0"  name="province" id ="province" browserValue="<%=province%>"
				browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.HrmProvince_query"
				hasInput="true" isSingle="true" hasBrowser = "true" isMustInput='1'
				completeUrl="/data.jsp?type=4" width="120px"
				linkUrl=""
				browserSpanValue="<%=provincename%>">
				</brow:browser>
				</wea:item>
				
				</wea:group>
				<wea:group context="">
				<wea:item type="toolbar">
				<input type="button" value="<%=SystemEnv.getHtmlLabelName(30947,user.getLanguage())%>" class="e8_btn_submit" onclick="onBtnSearchClick(<%=userid%>);"/>
				<input type="button" value="<%=SystemEnv.getHtmlLabelName(31129,user.getLanguage())%>" class="e8_btn_cancel" id="cancel"/>
				</wea:item>
				</wea:group>
				</wea:layout>
			</div>
			<div>	
		</FORM>
			<div id = "result">
			</div>
		<%
		String backfields = " id,Num,Management1,Management2,Management3,Management4 ";
		String fromSql  = " from uf_HQ_CRI_QueryList ";
		String sqlWhere = " where Type = "+type+" ";
		String orderby = " id " ;
		String tableString = " ";
		String operateString= " ";
		if("0".equals(type)){
			if(!"".equals(empname)){sqlWhere+=" and Name = '"+empname+"' ";}
			if(!"".equals(sex)){sqlWhere+=" and Gender = "+sex+" ";}
			if("".equals(empname)&&"".equals(sex)){sqlWhere+=" and 1=2 ";}
		}else if("1".equals(type)){
			if(!"".equals(company)){sqlWhere+=" and CompanyName like '%"+company+"%' ";}
			if(!"".equals(province)){sqlWhere+=" and Province like '%"+province+"%' ";}
			if("".equals(company)&&"".equals(province)){sqlWhere+=" and 1=2 ";}
		}

		String tmp_sql = "select count(1) as tmpnum "+fromSql+sqlWhere;
		rs.execute(tmp_sql);
		if(rs.next()){
			tmp_num = rs.getInt("tmpnum");
		}

	    tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(def_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+def_pageId+"\">"+
		    "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		operateString+
		"			<head>";
		tableString+=" <col width=\"20%\" text=\"案件序号\" column=\"Num\" orderkey=\"Num\" />"+
			"		<col width=\"20%\" text=\"联系单位\" column=\"Management1\" orderkey=\"Management1\" />"+
			"		<col width=\"20%\" text=\"联系人\" column=\"Management2\" orderkey=\"Management2\" />"+
			"		<col width=\"20%\" text=\"联系电话\" column=\"Management3\" orderkey=\"Management3\" />"+
			"		<col width=\"20%\" text=\"邮件\" column=\"Management4\" orderkey=\"Management4\" />"+
		"			</head>"+
	" </table>";
	%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />
	<script type="text/javascript">
		var rsnum = <%=tmp_num%>;
		var rstype = jQuery("#type").val();
		if(rstype!=""){
			if(Number(rsnum)<=0){
				jQuery("#result").html("<h1 align=left><font face=verdana size=3>&nbsp;&nbsp;显示结果：</font><font size=2>没有搜索到该名称出现在参考名单中</font><h1>");
			}else{
				jQuery("#result").html("<h1 align=left><font face=verdana size=3>&nbsp;&nbsp;显示结果：</font><font size=2>有匹配到可能的命中结果，具体情况及后续建议请联系下面人员</font><h1>");
			}
		}

	function onBtnSearchClick(userid) {
		var type = jQuery("#type").val();
		var empname = jQuery("#empname").val();
		var sex = jQuery("#sex").val();
		var company = jQuery("#company").val();
		var province = jQuery("#province").val();

		if(type==""){
		   	window.top.Dialog.alert("查询种类必须输入!");
		   	return;
		}

		if(type=="1"&&strlen(company)<2){
		   	window.top.Dialog.alert("公司查询最少需输入两个字符!");
		   	return;
		}

		$.ajax({ 
            async: true, 
            type : "POST", 
            data : {"userid":userid,"type":type,"empname":empname,"sex":sex,"company":company,"province":province},
            url : "/appdevjsp/HQ/CRI/CheckHandle.jsp",
            dataType : "text", 
            	success : function(datas){
              		datas= datas.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
              		if(datas=="success"){
              			report.submit();
              		}else{
              			window.top.Dialog.alert("短时间内查询次数过多,已被限制,请半小时后再尝试!");
              		}
            	}
        });
	}

	function strlen(str){  
    	return str.length;
    }  

	//bindchange("#type",typechange);
	function typechange(){
      var type_val = jQuery(type).val();
      if(type_val=="0"){
      	alert(1);
      }else{
      	alert(2);
      }
    }

    function bindchange(id, fun){
  	  var old_val = jQuery(id).val();
  	  setInterval(function() {
      var new_val = jQuery(id).val();
      if(old_val != new_val) {
    	old_val = new_val;
    	fun();}
  		}, 50);
	}	
	</script>
	<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	<script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>
</BODY>
</HTML>