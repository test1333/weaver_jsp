<%@ page language="java" contentType="text/html; charset=UTF-8"%>
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
    String year_name = Util.null2String(request.getParameter("year_name"));
    String month_name = Util.null2String(request.getParameter("month_name"));
    String recipient = Util.null2String(request.getParameter("recipient"));
    String empid = Util.null2String(request.getParameter("emp_id"));
    String departmentid = Util.null2String(request.getParameter("departmentid"));
    String chkSubCompany=Util.null2o(request.getParameter("chkSubCompany"));//子分部是否包含
    String subcompanyid_para=Util.null2String(request.getParameter("subcompanyid1"));//分部
    String id = Util.null2String(request.getParameter("id")) ;
    String year1 = Util.null2String(request.getParameter("year1")) ;
    String month1 = Util.null2String(request.getParameter("month1")) ;
    String status = Util.null2String(request.getParameter("status2")) ;
    String AttendanceStartDate2 = Util.null2String(request.getParameter("AttendanceStartDate2")) ;//取消前外出时间
    String aboutOther = Util.null2String(request.getParameter("aboutOther")) ;//原外出流程编号
    String requestid = Util.null2String(request.getParameter("requestid")) ;//流程的编号

    String GYSBH = Util.null2String(request.getParameter("GYSBH")) ;//供应商编号
    String SXZT = Util.null2String(request.getParameter("SXZT")) ;//价格状态
    String DJLX = Util.null2String(request.getParameter("DJLX")) ;//定价类型
    String WLBM = Util.null2String(request.getParameter("WLBM")) ;//物料编码
    String WLLX = Util.null2String(request.getParameter("WLLX")) ;//物料类型
    String GYSMC = Util.null2String(request.getParameter("GYSMC")) ;//供应商名称

    
    if("0".equals(subcompanyid_para)) subcompanyid_para = "";
    String tmp_startdate = "";
    String tmp_enddate = "";
    
    String fromdate = Util.null2String(request.getParameter("fromdate"));
    String lenddate = Util.null2String(request.getParameter("lenddate"));
    

    
    


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
    
    String leave_pageId = "canclePlane111";
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
        %>
        <%@ include file="/systeminfo/RightClickMenu_wev8.jsp"%>
        <FORM id=weaver name=weaver method=post action="" >
            <INPUT type="hidden" id="startdate" name="startdate" value="<%=tmp_startdate%>">
            <INPUT type="hidden" id="enddate" name="enddate" value="<%=tmp_enddate%>">
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
        String backfields = " id,GYSBM,WLBM,JG  ";
        String fromSql  = " from formtable_main_222  ";
        String sqlWhere = " 1=1 and WLBM ='"+WLBM+"'";
        String orderby = " id desc" ;
        String tableString = "";
        String operateString= "";
        //供应商编号
        if(!"".equals(GYSBH)){
            sqlWhere += "and GYSBH like '%"+GYSBH+"%'";
        }
        //价格状态                                        
         if(!"".equals(SXZT)){
            sqlWhere += " and SXZT = '"+SXZT+"'";
        }
        //定价类型                                       
         if(!"".equals(DJLX)){
            sqlWhere += " and DJLX = '"+DJLX+"'";
        }
        
        //物料编码                                      
         if(!"".equals(WLBM)){
            sqlWhere += " and WLBM like '%"+WLBM+"%' ";
        }
        //物料类型                                       
        if(!"".equals(WLLX)){
            sqlWhere += " and WLLX = '"+WLLX+"' ";
        }
        //供应商名称                                       
        if(!"".equals(GYSMC)){
            sqlWhere += " and GYSMC = '"+GYSMC+"' ";
        }
        
       
    
        tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(leave_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+leave_pageId+"\">"+
        "      <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\" />"+
        operateString +
        "           <head>";
        tableString+="<col width=\"10%\"  text=\"供应商编码\" column=\"GYSBM\" orderkey=\"GYSBM\"  />"+
            "       <col width=\"10%\" text=\"物料编码\" column=\"WLBM\" orderkey=\"WLBM\" />"+
            "       <col width=\"10%\" text=\"价格\" column=\"JG\" orderkey=\"JG\" />"+  
        "           </head>"+
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