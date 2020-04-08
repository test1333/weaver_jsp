<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.systeminfo.SystemEnv" %>
<%@ page import="weaver.general.PageIdConst" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea" %>
<%@ taglib uri="/browserTag" prefix="brow" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="dep" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<HTML>
<HEAD>
    <LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
    <script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
    <script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>
</head>
<%
    String imagefilename = "/images/hdReport_wev8.gif";
    String titlename = SystemEnv.getHtmlLabelName(20536, user.getLanguage());
    String needfav = "1";
    String needhelp = "";
    int userid = user.getUID();//获取当前登录用户的ID
    String yxzt = Util.null2String(request.getParameter("yxzt"));
    String cdepartmentid = Util.null2String(request.getParameter("cdepartmentid"));
    String ybmmc = Util.null2String(request.getParameter("ybmmc"));
    String xbmmc = Util.null2String(request.getParameter("xbmmc"));
	String deptname = "";
	String sql = "";
	if(cdepartmentid.length()>= 1){
		sql = "select departmentname from HrmDepartment where id = '"+cdepartmentid+"'";
		rs.executeSql(sql);
		if(rs.next()){
			deptname = Util.null2String(rs.getString("departmentname"));
		}
		
	}
	String multiIds = Util.null2String(request.getParameter("multiIds"));
	if(multiIds.length()>= 1){
		sql = "update uf_HrmDepartment set yxzt = 1,qrsj=to_char(sysdate, 'yyyymmdd hh24:mi:ss') where id  in ("+multiIds+")";
		rs.executeSql(sql);
	}
	
    String late_pageId = "hs_hrdept_info_004";

%>
<BODY>
<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>">
				<%=SystemEnv.getHtmlLabelName(20536, user.getLanguage()) %></span>
</div>
<input type="hidden" _showCol="true" name="pageId" id="pageId" value="<%=late_pageId%>"/>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>

<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
    RCMenu += "{" + SystemEnv.getHtmlLabelName(527, user.getLanguage()) + ",javascript:onBtnSearchClick(),_self} ";
    RCMenuHeight += RCMenuHeightStep;
    RCMenu += "{刷新,javascript:onBtnSearchClick(),_self} ";
    RCMenuHeight += RCMenuHeightStep;
	if("0".equals(yxzt)) {
		RCMenu += "{忽略预警,javascript:OnSum(),_self} ";
		RCMenuHeight += RCMenuHeightStep;
	}
	
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<FORM id=report name=report action="" method=post>
<input type="hidden" name="multiIds" value="">
    <table id="topTitle" cellpadding="0" cellspacing="0">
        <tr>
            <td></td>
            <td class="rightSearchSpan" style="text-align:right;">
                <!--input type=button class="e8_btn_top" onclick="openDialog();" value=""-->
				<%
				if("0".equals(yxzt)) {
				%>
				<input type="button" id="qrbg" name = "qrbg"  value="忽略预警" class="e8_btn_top" onClick="OnSum()" />
				<%}%>
				
                <span id="advancedSearch" class="advancedSearch">
						<%=SystemEnv.getHtmlLabelName(21995, user.getLanguage())%>
						</span>
                <span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
            </td>
        </tr>
    </table>
    <div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
        <wea:layout type="4col">
            <wea:group context="查询条件">
				
				<wea:item>部门</wea:item>
				<wea:item>
					<brow:browser viewType="0" id="cdepartmentid" name="cdepartmentid" browserValue="<%=cdepartmentid%>"
						browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp?"
						hasInput="true" isSingle="true" hasBrowser = "true" isMustInput='1'
						completeUrl="/data.jsp" width="120px"
						linkUrl=""
						browserSpanValue="<%=deptname%>">
					</brow:browser>
			</wea:item>
			<wea:item>原部门名称</wea:item>
			<wea:item>
				<input type = "text" id = "ybmmc" name = "ybmmc" value ="<%=ybmmc%>" />
			</wea:item>
			<wea:item>新部门名称</wea:item>
			<wea:item>
				<input type = "text" id = "xbmmc" name = "xbmmc" value ="<%=xbmmc%>" />
			</wea:item>
			
			
			
			
			</wea:group>

          
            <wea:group context="">
                <wea:item type="toolbar">
                    <input class="e8_btn_submit" type="submit" name="submit_1" onClick="onBtnSearchClick()"
                           value="<%=SystemEnv.getHtmlLabelName(197, user.getLanguage()) %>"/>
                    <span class="e8_sep_line">|</span>
                    <input class="e8_btn_cancel" type="button" name="reset" onclick="resetCondtion()"
                           value="<%=SystemEnv.getHtmlLabelName(2022, user.getLanguage()) %>"/>
                    <span class="e8_sep_line">|</span>
                    <input type="button" value="<%=SystemEnv.getHtmlLabelName(31129,user.getLanguage())%>"
                           class="e8_btn_cancel" id="cancel"/>
                </wea:item>
            </wea:group>
        </wea:layout>
    </div>
</FORM>
<%
    String backfields = " id,depid,(select subcompanyname from hrmsubcompany where id=(select subcompanyid1 from hrmdepartment where id=a.depid)) as subcompanyname,departmentcode,departmentname,departmentmark,departmentcodenew,departmentnamenew,departmentmarknew,crsj,case when canceled ='1' then '封存'   else '正常' end as canceled ,case when cancelednew ='1' then '封存'   else '正常' end as cancelednew,qrsj   ";
    //表单中的字段
    String fromSql = " from uf_HrmDepartment a "; // sql查询的表
    String sqlWhere = "  yxzt='"+yxzt+"' "; // where条件   0 未确认变更 1 已确认变更
	if("0".equals(yxzt)){
		sqlWhere += " and depid in(select belongdepart from hs_projectinfo) ";
	}
	
	if (!"".equals(cdepartmentid)) {
        sqlWhere += " and depid=" + cdepartmentid;
    }
	if (!"".equals(ybmmc)) {
        sqlWhere += " and departmentname like '%" + ybmmc+"%'";
    }
	if (!"".equals(xbmmc)) {
        sqlWhere += " and departmentnamenew like '%" + xbmmc+"%'";
    }
    // out.println("select "+ backfields + fromSql +" where"+ sqlWhere);
    String orderby = " id ";//排序关键字
    String tableString = "";
    tableString = " <table tabletype=\"checkbox\" pagesize=\"" + PageIdConst.getPageSize(late_pageId, user.getUID(), PageIdConst.HRM) + "\" pageId=\"" + late_pageId + "\">" +
            "	   <sql backfields=\"" + backfields + "\" sqlform=\"" + fromSql + "\" sqlwhere=\"" + Util.toHtmlForSplitPage(sqlWhere) + "\"  sqlorderby=\"" + orderby + "\" " +
            " sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>" +
            "	<head>";
    tableString += "<col width=\"10%\" text=\"公司\" column=\"subcompanyname\" orderkey=\"subcompanyname\"  />"+
	
			"<col width=\"10%\" text=\"变化部门\" column=\"depid\" orderkey=\"depid\" transmethod='hsproject.util.BrowserInfoUtil.getMulDepartname' />"+
			//"   <col width=\"10%\"  text=\"原部门编码\" column=\"departmentcode\" orderkey=\"departmentcode\"  />" +
			"		    <col width=\"10%\" text=\"原部门名称\" column=\"departmentname\" orderkey=\"departmentname\" />" +
			"		    <col width=\"10%\" text=\"原部门简称\" column=\"departmentmark\" orderkey=\"departmentmark\" />" +
			"		    <col width=\"10%\" text=\"原部门状态\" column=\"canceled\" orderkey=\"canceled\" />" +
			//"  			<col width=\"10%\"  text=\"新部门编码\" column=\"departmentcodenew\" orderkey=\"departmentcodenew\"  />" +
			"		    <col width=\"10%\" text=\"新部门名称\" column=\"departmentnamenew\" orderkey=\"departmentnamenew\" />" +
			"		    <col width=\"10%\" text=\"新部门简称\" column=\"departmentmarknew\" orderkey=\"departmentmarknew\" />" +
			"		    <col width=\"10%\" text=\"新部门状态\" column=\"cancelednew\" orderkey=\"cancelednew\" />" +
            "		    <col width=\"20%\" text=\"数据更新时间\" column=\"crsj\" orderkey=\"crsj\"  />" ;
			
			if("1".equals(yxzt)) {
				tableString = tableString + "		    <col width=\"20%\" text=\"忽略操作时间\" column=\"qrsj\" orderkey=\"qrsj\" />" ;
			}
			tableString +=	 "	</head>" + " </table>";
%>
<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run"/>
<script type="text/javascript">
    function onBtnSearchClick () {
        report.submit();
    }
	function OnSum(){//确认签收
		var ids = "";
		if(!ids){
			ids = _xtable_CheckedCheckboxId();
		}
		if(ids.match(/,$/)){
			ids = ids.substring(0,ids.length-1);
		}
		// alert("ids : "+ids);
		if(ids=="")
		{
			top.Dialog.alert("请选择要确认部门变更的数据");
			return ;
		}
		top.Dialog.confirm("确定变更吗？", function (){
			document.report.action = "/hsproject/project/list/hrdept_info.jsp?yxzt=<%=yxzt%>";
			document.report.multiIds.value = ids;
			document.report.submit();
		}, function () {
			
		}, 320, 90,true);
	}
</script>
<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>
</BODY>
</HTML>
