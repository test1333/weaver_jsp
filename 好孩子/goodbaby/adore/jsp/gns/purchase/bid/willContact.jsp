<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.systeminfo.SystemEnv" %>
<%@ page import="weaver.general.PageIdConst" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea" %>
<%@ taglib uri="/browserTag" prefix="brow" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rci" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
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

    int userId = user.getUID();//获取当前登录用户的ID
    String idkey = Util.null2String(request.getParameter("idkey"));
    String recipient = Util.null2String(request.getParameter("recipient"));

    String late_pageId = "adore7";

    Boolean isService = false; // 是否服务类采购员
    Boolean isInvest = false; // 是否投资了服务员
    String sql = "";
    sql = " select count(id) as num_admin from HrmRoleMembers where roleid=94 and resourceid=" + userId;
    rs.executeSql(sql);
    if (rs.next()) {
        int num_admin = rs.getInt("num_admin");
        if (num_admin > 0) {
            isService = true;
        }
    }

    sql = " select count(id) as num_admin from HrmRoleMembers where roleid=92 and resourceid=" + userId;
    rs.executeSql(sql);
    if (rs.next()) {
        int num_admin = rs.getInt("num_admin");
        if (num_admin > 0) {
            isInvest = true;
        }
    }
%>
<BODY>
<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>">
				<%=SystemEnv.getHtmlLabelName(20536, user.getLanguage()) %></span>
</div>
<input type="hidden" _showCol="false" name="pageId" id="pageId" value="<%=late_pageId%>"/>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
    RCMenu += "{" + SystemEnv.getHtmlLabelName(527, user.getLanguage()) + ",javascript:onBtnSearchClick(),_self} ";
    RCMenuHeight += RCMenuHeightStep;
    RCMenu += "{发起流程,javascript:createWorkflow(),_self} ";
    RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<FORM id=report name=report action="" method=post>
    <table id="topTitle" cellpadding="0" cellspacing="0">
        <tr>
            <td></td>
            <td class="rightSearchSpan" style="text-align:right;">
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
                <wea:item>员工姓名</wea:item>
                <wea:item>
                    <brow:browser viewType="0" name="recipient" browserValue="<%=recipient %>"
                                  browserOnClick=""
                                  browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
                                  hasInput="true" isSingle="false" hasBrowser="true" isMustInput='1'
                                  completeUrl="/data.jsp" width="165px"
                                  browserSpanValue="<%=Util.toScreen(rci.getResourcename(recipient),user.getLanguage())%>">
                    </brow:browser>
                </wea:item>
            </wea:group>

            <wea:group context="">
                <wea:item type="toolbar">
                    <input type="button" value="<%=SystemEnv.getHtmlLabelName(30947,user.getLanguage())%>"
                           class="e8_btn_submit" onclick="onBtnSearchClick();"/>
                    <input type="button" value="<%=SystemEnv.getHtmlLabelName(31129,user.getLanguage())%>"
                           class="e8_btn_cancel" id="cancel"/>
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
    String backfields = " id,dataId,WLMC,WLBM,gysId,GYSMC,a.requestId,CGY,needDate,flowNum,PP,XH,GG,DW,SL,YGDJ ";
    //表单中的字段
    String fromSql = " from gb_bidPurchaseView v join " +
            " (select r.requestId,CGY,dtId from formtable_main_200 f left join  workflow_requestbase r " +
            " on f.requestId=r.requestid where r.currentnodetype in(3)) a on v.id = a.dtId ";//sql查询的表
    String sqlWhere = " id not in (select isnull(dtId,0) from formtable_main_207) ";//where条件
    // out.println("select "+ backfields + fromSql +"where"+ sqlWhere);

    if(isService){
        sqlWhere += " and dataId in(select id from uf_inquiryForm where WLLX1 " +
                " in(select id from uf_NPP where buydl=1)) ";
    }

    if(isInvest){
        sqlWhere += " and dataId in(select id from uf_inquiryForm where WLLX1 " +
                " in(select id from uf_NPP where buydl=3)) ";
    }

    String orderby = " requestId ";//排序关键字
    String tableString = "";

    tableString = " <table tabletype=\"checkbox\" pagesize=\"" + PageIdConst.getPageSize(late_pageId, user.getUID(), PageIdConst.HRM) + "\" pageId=\"" + late_pageId + "\">" +
            "	   <sql backfields=\"" + backfields + "\" sqlform=\"" + fromSql + "\" sqlwhere=\"" + Util.toHtmlForSplitPage(sqlWhere) + "\"  sqlorderby=\"" + orderby + "\" " +
            "      sqlprimarykey=\"id\" sqlsortway=\"asc\" sqlisdistinct=\"false\"/>" +
            "	<head>";
    tableString += "    <col width=\"33%\" text=\"物料名称\" column=\"WLMC\" orderkey=\"WLMC\" " +
            "           linkvaluecolumn=\"dataId\" linkkey=\"billid\" " +
            "           href=\"/formmode/view/AddFormMode.jsp?type=0&amp;modeId=42&amp;formId=-225\" target=\"_fullwindow\" />" +
            "		    <col width=\"33%\" text=\"品牌\" column=\"PP\" orderkey=\"PP\" />" +
            "		    <col width=\"33%\" text=\"型号\" column=\"XH\" orderkey=\"XH\" />" +
            "		    <col width=\"33%\" text=\"规格\" column=\"GG\" orderkey=\"GG\" />" +
            "		    <col width=\"33%\" text=\"单位\" column=\"DW\" orderkey=\"DW\" />" +
            "		    <col width=\"33%\" text=\"数量\" column=\"SL\" orderkey=\"SL\" />" +
            "		    <col width=\"33%\" text=\"单价\" column=\"YGDJ\" orderkey=\"YGDJ\" display=\"false\" />" +
            "		    <col width=\"33%\" text=\"供应商\" column=\"GYSMC\" orderkey=\"GYSMC\" />" +
            "		    <col width=\"33%\" text=\"交期\" column=\"needDate\" orderkey=\"needDate\" />" +
            "		    <col width=\"33%\" text=\"申请人\" column=\"CGY\" orderkey=\"CGY\" " +
            "           transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\" />" +
            "		    <col width=\"33%\" text=\"流程\" column=\"requestid\" orderkey=\"requestid\" " +
            "           transmethod=\"weaver.workflow.request.RequestComInfo.getRequestname\" " +
            "           linkvaluecolumn=\"requestid\" linkkey=\"requestid\" " +
            "           href=\"/workflow/request/ViewRequest.jsp\" target=\"_fullwindow\" />" +
            "	</head>" +
            " </table>";
%>
<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run"/>
<script type="text/javascript">
    function onBtnSearchClick () {
        report.submit();
    }

    /**
     * 发起流程
     * @returns {boolean}
     */
    function createWorkflow () {
        var ids = _xtable_CheckedCheckboxId()
        var userId = '<%=userId%>'
        // alert("ids="+ids);
        if (ids === '') {
            Dialog.alert('<%=SystemEnv.getHtmlLabelName(19689,user.getLanguage())%>')
            return false
        }
        Dialog.confirm('确定发起流程', function () {
            report.action = 'createContactFlow.jsp?id=' + ids + '&userId=' + userId
            report.submit()
        }, function () {}, 320, 90, false)
    }

    var idkey = '<%=idkey%>'
    // alert("idkey="+idkey);
    if (idkey === '0') {
        Dialog.alert('流程创建成功')
    }
</script>
<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>
</BODY>
</HTML>
