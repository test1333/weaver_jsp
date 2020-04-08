
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.conn.*" %>
<%@ page import="java.util.*,java.sql.Timestamp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<%
    String id = (String)request.getParameter("id");
    int currentpage =Util.getIntValue((String)request.getParameter("currentpage"),1);
    String from = Util.null2String(request.getParameter("from"));
    
    String name = Util.null2String(request.getParameter("fname"));
    String datetype = Util.null2String(request.getParameter("datetype"));
    String startdate = Util.null2String(request.getParameter("startdate"));
    String enddate = Util.null2String(request.getParameter("enddate"));
  //  startdate = DateTransformer.getServerDate(startdate,"00:00:00");
  //  enddate = DateTransformer.getServerDate(enddate,"23:59:59");
    
 String sqlWhere = "nicknameid="+id;
   
   if(!"".equals(name)){
		sqlWhere += " and name like '%"+name+"%'";
	}
   if(!"".equals(datetype) && !"6".equals(datetype)){
		sqlWhere += " and edittime >= '"+TimeUtil.getDateByOption(datetype+"","0")+" 00:00:00'";
		sqlWhere += " and edittime <= '"+TimeUtil.getDateByOption(datetype+"","")+" 23:59:59'";
	}

	if("6".equals(datetype) && !"".equals(startdate)){
		sqlWhere += " and edittime >= '"+startdate+" 00:00:00'";
	}

	if("6".equals(datetype) && !"".equals(enddate)){
		sqlWhere += " and edittime <= '"+enddate+" 23:59:59'";
	}
	//new BaseBean().writeLog("name:"+name);
	//new BaseBean().writeLog("sqlWhere:"+sqlWhere);
	
	String tableString = "";
	int perpage=10;                                 
	String backfields = " id,edittime,operator,name,etype";
	String fromSql  = "nicknameLog" ;
	
	String orderby = " edittime desc ";
	
	tableString = " <table pagesize=\""+perpage+"\" tabletype=\"none\">"+
				  " <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"Desc\" />"+
	              " <head>"+
	              "	<col width='45%' text=\""+SystemEnv.getHtmlLabelName(277,user.getLanguage())+"\" orderkey=\"edittime\" column=\"edittime\" />"+
	              "	<col width=\"15%\" text=\""+SystemEnv.getHtmlLabelName(99,user.getLanguage())+"\" orderkey=\"operator\" column=\"operator\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getLastname\"/>"+
				  " <col width=\"15%\" text=\""+SystemEnv.getHtmlLabelName(63,user.getLanguage())+"\" orderkey=\"etype\" column=\"etype\" transmethod=\"weaver.general.CoworkTransMethod.getCoworkNicknameLogType\"/>"+
         		  "	<col width=\"25%\" text=\""+"昵称"+"\" orderkey=\"name\" column=\"name\" />";	 
	 tableString+="	</head></table>";
	
%>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<script language=javascript src="/js/weaver_wev8.js"></script>


<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>

<jsp:include page="/systeminfo/commonTabHead.jsp">
   <jsp:param name="mouldID" value="collaboration"/>
   <jsp:param name="navName" value="<%=SystemEnv.getHtmlLabelName(31704,user.getLanguage())%>"/>
</jsp:include>
<wea:SplitPageTag  tableString='<%=tableString%>'  mode="run" isShowTopInfo="false"/>
<div id="zDialog_div_bottom" class="zDialog_div_bottom">
	<wea:layout>
		<wea:group context="" attributes="{groupDisplay:none}">
			<wea:item type="toolbar">
				<input type="button" value="<%=SystemEnv.getHtmlLabelName(309,user.getLanguage()) %>" id="zd_btn_cancle"  class="zd_btn_cancle" onclick="parent.getDialog(window).close();">
			</wea:item>
		</wea:group>
	</wea:layout>
</div>


<table id="topTitle" cellpadding="0" cellspacing="0">
	<tr>
		<td></td>
		<td class="rightSearchSpan" style="text-align:right;">
			<input type="text" class="searchInput" name="searchRemark" id="searchRemark"  value="<%=name %>"/>
       		<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(347,user.getLanguage())%></span>
			<span title="<%=SystemEnv.getHtmlLabelName(81804,user.getLanguage())%>" class="cornerMenu"></span>
		</td>
	</tr>
</table>
<!-- 高级搜索 -->
<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;" >
<form id="weaver" name="weaver" action="/cowork/nickname/CoworkNicknameLogView.jsp" method="post">
 <input type="hidden" name="id" value="<%=id %>">
  <input type="hidden" name="ffname" value="">
	<wea:layout type="4col" attributes="{'layoutTableId':'oTable1'}">
			<wea:group context='<%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%>'>
				<wea:item>昵称</wea:item>
		        <wea:item>
		        	<input type="text" id="fname" name="fname" value="<%=name%>" style="width: 150px;"/>       
		        </wea:item> 
		        		       		       		        
		        <wea:item><%=SystemEnv.getHtmlLabelName(277,user.getLanguage())%></wea:item>
		        <wea:item>
		        	<span>
			        	<SELECT  name="datetype" id="datetype" onchange="onChangetype(this)" style="width: 100px;">
						  <option value="" 	<%if(datetype.equals("")){%> selected<%}%>><%=SystemEnv.getHtmlLabelName(332,user.getLanguage())%></option>
						  <option value="1" <%if(datetype.equals("1")){%> selected="selected" <%}%>><%=SystemEnv.getHtmlLabelName(15537,user.getLanguage())%></option>
						  <option value="2" <%if(datetype.equals("2")){%> selected="selected" <%}%>><%=SystemEnv.getHtmlLabelName(15539,user.getLanguage())%></option>
						  <option value="3" <%if(datetype.equals("3")){%> selected="selected" <%}%>><%=SystemEnv.getHtmlLabelName(15541,user.getLanguage())%></option>
						  <option value="4" <%if(datetype.equals("4")){%> selected="selected" <%}%>><%=SystemEnv.getHtmlLabelName(21904,user.getLanguage())%></option>
						  <option value="5" <%if(datetype.equals("5")){%> selected="selected" <%}%>><%=SystemEnv.getHtmlLabelName(15384,user.getLanguage())%></option>
						  <option value="6" <%if(datetype.equals("6")){%> selected="selected" <%}%>><%=SystemEnv.getHtmlLabelName(32530,user.getLanguage())%></option>
						</SELECT>
					</span>     
					
					<span id="dateTd" style="margin-left: 10px;padding-top: 5px;">
				        <button class="Calendar" style="height: 16px" type="button" onclick="getDate(startdatespan,startdate)" value="<%=startdate%>"></button>
						<span id="startdatespan"><%=startdate%></span>
						<input type="hidden" id="startdate" name="startdate">
						－
						<button class="Calendar" style="height: 16px" type="button" onclick="getDate(enddatespan,enddate)" value="<%=enddate%>"></button>
						<span id="enddatespan"><%=enddate%></span>
						<input type="hidden" id="enddate" name="enddate">
					</span>
		        </wea:item>
		     </wea:group>
		     <wea:group context="" attributes="{'Display':'none'}">
				<wea:item type="toolbar">
					<input type="submit" class="e8_btn_submit" value="<%=SystemEnv.getHtmlLabelName(197,user.getLanguage())%>" id="searchBtn"/>
					<input type="button" value="<%=SystemEnv.getHtmlLabelName(2022,user.getLanguage())%>" class="e8_btn_cancel" onclick="resetCondition()"/>
					<input type="button" value="<%=SystemEnv.getHtmlLabelName(201,user.getLanguage())%>" class="e8_btn_cancel" id="cancel"/>
				</wea:item>
			</wea:group>
	</wea:layout>	        
</form>
</div>

<script type="text/javascript">
$(document).ready(function(){
	jQuery("#topTitle").topMenuTitle({searchFn:searchRemark});
	jQuery("#hoverBtnSpan").hoverBtn();
	
 
	
	if("<%=datetype%>" == 6){
		jQuery("#dateTd").show();
	}else{
		jQuery("#dateTd").hide();
	}
});
function searchRemark(){
	var searchRemark = jQuery("#searchRemark").val();
	jQuery("#fname").val(searchRemark);
	window.weaver.submit();
}

function onChangetype(obj){
	if(obj.value == 6){
		jQuery("#dateTd").show();
	}else{
		jQuery("#dateTd").hide();
	}
}
</script>


<script language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
<script language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script> 
<jsp:include page="/systeminfo/commonTabFoot.jsp"></jsp:include> 

