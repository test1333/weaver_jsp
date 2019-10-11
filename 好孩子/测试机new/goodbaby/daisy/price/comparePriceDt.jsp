﻿<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*,weaver.hrm.common.*" %>
<%@ include file="/systeminfo/init_wev8.jsp"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="CompanyComInfo" class="weaver.hrm.company.CompanyComInfo" scope="page" />
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page"/>
<%
    
    int userid = user.getUID();
    String WLBM = Util.null2String(request.getParameter("WLBM"));//物料编码

	Boolean isAdmin=false;
//    String jg = "";
    String sql="";
//    String gysbm = "";
//    sql=" select * from formtable_main_222 where WLBM = '"+wlbm+"'";
//    rs.executeSql(sql);
//    if(rs.next()){
//        gysbm = Util.null2String(rs.getString("GYSBM1"));
//    }
//
    String leave_pageId = "canclePlane";
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
    String imagefilename = "/images/hdMaintenance_wev8.gif";
    String titlename = SystemEnv.getHtmlLabelName(21039,user.getLanguage())
    + SystemEnv.getHtmlLabelName(480, user.getLanguage())
    + SystemEnv.getHtmlLabelName(18599, user.getLanguage())
    + SystemEnv.getHtmlLabelName(352, user.getLanguage());
    String needfav = "1";
    String needhelp = "";
    %>
    <BODY>
        <div id="tabDiv">
            <span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>">
            <%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
        </div>
        <div id="dialog">
            <div id='colShow'></div>
        </div>
        <input type="hidden" name="pageId" id="pageId" value="<%=leave_pageId%>"/>
        <%@ include file="/systeminfo/TopTitle_wev8.jsp"%>
        <%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp"%>
        <%
        RCMenu += "{" + SystemEnv.getHtmlLabelName(527, user.getLanguage())+ ",javascript:onBtnSearchClick(),_self} ";
        RCMenuHeight += RCMenuHeightStep;
        RCMenu += "{生效,javascript:onCheckup(),_self} ";
        RCMenuHeight += RCMenuHeightStep;
        %>
        <%@ include file="/systeminfo/RightClickMenu_wev8.jsp"%>
        <FORM id=weaver name=weaver method=post action="" >
            <table id="topTitle" cellpadding="0" cellspacing="0">
                <tr>
                    <td></td>
                    <td class="rightSearchSpan" style="text-align:right;">
                        <span id="advancedSearch" class="advancedSearch">
                        <%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%>
                        </span>
                        <span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu">
                        </span>
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
                <col></col>
                </colgroup>      
            </table>
            </div>
            <div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
                <wea:layout type="4col">
                <wea:group context="查询条件">
                    <wea:item>供应商编号</wea:item>
                        <wea:item>
                        <input type="text" name="GYSBH" style='width:80%' value="">
                        </wea:item>
                    <wea:item>供应商名称</wea:item>
                        <wea:item>
                        <brow:browser viewType="0"  name="GYSMC" id ="GYSMC" browserValue=""
                            browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=ztb_gysmc"
                            hasInput="true" isSingle="true" hasBrowser = "true" isMustInput='1'
                            completeUrl="/data.jsp?type=4" width="120px"
                            linkUrl=""
                            browserSpanValue="">
                        </brow:browser>
                        </wea:item>
                    
                    <wea:item>物料编码</wea:item>
					<wea:item>
						<input type="text" name="WLBM" style='width:80%' value=""> 
					</wea:item>
                     <wea:item>物料名称</wea:item>
					<wea:item>
						<input type="text" name="WLMC" style='width:80%' value=""> 
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
        String backfields = " id,(select name from CRM_CustomerInfo where id = GYSBM1) as GYSMC,(select PortalLoginid from CRM_CustomerInfo where id = GYSBM1) as GYSBH,WLBM,BJJE,WLMS";
        String fromSql  = " from formtable_main_222 ";
        String sqlWhere = "WLBM ='"+WLBM+"'";
        String orderby = " BJJE desc" ;
        String tableString = "";
        String operateString= "";

       //out.print("select " + backfields + fromSql + " where " + sqlWhere);
    
        tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(leave_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+leave_pageId+"\">"+
        "      <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\" />"+
        operateString +
        "           <head>";
        tableString+=
            "      <col width=\"10%\" text=\"物料名称\" column=\"WLMS\" orderkey=\"WLMS\" />"+
            "      <col width=\"10%\"  text=\"物料编码\" column=\"WLBM\" orderkey=\"WLBM\" />"+
            "      <col width=\"10%\" text=\"供应商编号\" column=\"GYSBH\" orderkey=\"GYSBH\" />"+
            "      <col width=\"10%\" text=\"供应商名称\" column=\"GYSMC\" orderkey=\"GYSMC\" />"+
            "      <col width=\"10%\" text=\"报价金额\" column=\"BJJE\" orderkey=\"BJJE\" />"+
        "          </head>"+
    " </table>"; 
    %>
    <wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run"  />
    <script type="text/javascript">
        function onShowSubcompanyid1(){
        data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/SubcompanyBrowser.jsp");
        if (data!=null){
            if (data.id!= ""){
                jQuery("#subcompanyid1span").html(data.name);
                jQuery("#subcompanyid1").val(data.id);
                makechecked();
            }else{
                jQuery("#subcompanyid1span").html("");
                jQuery("#subcompanyid1").val("");
            }
        }
    }
    
    function onShowDepartmentid(){
        data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp");
        if (data!=null){
            if (data.id!= ""){
                jQuery("#departmentidspan").html(data.name);
                jQuery("#departmentid").val(data.id);
                makechecked();
            }else{
                jQuery("#departmentidspan").html("");
                jQuery("#departmentid").val("");
            }
        }
    }
 function onCheckup(){
        var ids = _xtable_CheckedCheckboxId();
        if(ids != ""){
            if(window.confirm('你是否确认处理？')){
                alert(ids);
                openNewInfo(ids);
            }
        }else{
            top.Dialog.alert("<%=SystemEnv.getHtmlLabelName(20149,user.getLanguage())%>");
        }
    }

    function openNewInfo(id) {

        var title = "";
        var url = "";
        // 定义ajax参数
        var a = {
            url: '/goodbaby/daisy/Operation.jsp?ids='+id,
            type: 'post',
            // 定义请求完成时的回调函数
            success: function () {
                window.location.reload();
            }
        };
        jQuery.ajax(a);

    }
        function onBtnSearchClick() {
            weaver.submit();
        }

        function firm(){
                if(confirm("是否统计迟到时间？")){
                    weaver.action = "CountLate.jsp";
                    weaver.submit();
                }
        
            }

        function setCheckbox(chkObj) {
            if (chkObj.checked == true) {
                chkObj.value = 1;
            } else {
                chkObj.value = 0;
            }
        }
    </script>
    <SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
    <SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
    <script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>
</BODY>
</HTML>