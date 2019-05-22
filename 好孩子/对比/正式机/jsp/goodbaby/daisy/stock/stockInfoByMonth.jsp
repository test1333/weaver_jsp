<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.*,weaver.hrm.common.*" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea" %>
<%@ taglib uri="/browserTag" prefix="brow" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="CompanyComInfo" class="weaver.hrm.company.CompanyComInfo" scope="page"/>
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page"/>
<%
    Calendar now = Calendar.getInstance();
    int userid = user.getUID();
    int now_year = now.get(Calendar.YEAR);
    int now_month = now.get(Calendar.MONTH) + 1;
    String start_month = "";
    String end_month = "";
    String end_year = "";
    start_month = now_month + "";
    end_month = now_month + 1 + "";
    end_year = now_year + "";
    if (now_month < 10) {
        start_month = "0" + now_month;
        end_month = now_month + 1 + "";
        if (now_month + 1 < 10) {
            end_month = "0" + (now_month + 1);
        }
    }
    if (now_month == 12) {
        start_month = now_month + "";
        end_month = "01";
        end_year = now_year + 1 + "";
    }
    String startday = "";
    String endday = "";
    String year = Util.null2String(request.getParameter("year"));
    String month = Util.null2String(request.getParameter("month"));
    if ("".equals(year) || "".equals(month)) {
        year = now.get(Calendar.YEAR)+"";
        month = now.get(Calendar.MONTH) + 1 +"";
        startday = now_year + "-" + start_month + "-" + "01";
        endday = end_year + "-" + end_month + "-" + "01";

    } else {
        int selectyear = Util.getIntValue(year);
        int selectmonth = Util.getIntValue(month);
        start_month = selectmonth + "";
        end_month = selectmonth + 1 + "";
        end_year = selectyear + "";
        if (selectmonth < 10) {
            start_month = "0" + selectmonth;
            end_month = selectmonth + 1 + "";
            if (selectmonth + 1 < 10) {
                end_month = "0" + (selectmonth + 1);
            }
        }
        if (selectmonth == 12) {
            start_month = selectmonth + "";
            end_month = "01";
            end_year = selectyear + 1 + "";
        }
        startday = selectyear + "-" + start_month + "-" + "01";
        endday = end_year + "-" + end_month + "-" + "01";
    }
    String WLBM = Util.null2String(request.getParameter("WLBM"));//物料编码
    String WLMC = Util.null2String(request.getParameter("WLMC"));//物料名称
//    String CWNY = Util.null2String(request.getParameter("CWNY"));//财务年月
//    String CKID = Util.null2String(request.getParameter("CKID"));//仓库

    Boolean isAdmin = false;
    String sql = "";
    sql = " select count(id) as num_admin from HrmRoleMembers where roleid=36 and resourceid=" + userid;
    rs.executeSql(sql);
    if (rs.next()) {
        int num_admin = rs.getInt("num_admin");
        if (num_admin > 0) {
            isAdmin = true;
        }
    }

    String leave_pageId = "AAAAAAA";
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
    String titlename = SystemEnv.getHtmlLabelName(21039, user.getLanguage())
            + SystemEnv.getHtmlLabelName(480, user.getLanguage())
            + SystemEnv.getHtmlLabelName(18599, user.getLanguage())
            + SystemEnv.getHtmlLabelName(352, user.getLanguage());
    String needfav = "1";
    String needhelp = "";
%>
<BODY>
<div id="tabDiv">
            <span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>">
            <%=SystemEnv.getHtmlLabelName(20536, user.getLanguage()) %></span>
</div>
<div id="dialog">
    <div id='colShow'></div>
</div>
<input type="hidden" name="pageId" id="pageId" value="<%=leave_pageId%>"/>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
    RCMenu += "{" + SystemEnv.getHtmlLabelName(527, user.getLanguage()) + ",javascript:onBtnSearchClick(),_self} ";
    RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<FORM id=weaver name=weaver method=post action="">
    <table id="topTitle" cellpadding="0" cellspacing="0">
        <tr>
            <td></td>
            <td class="rightSearchSpan" style="text-align:right;">
                        <span id="advancedSearch" class="advancedSearch">
                        <%=SystemEnv.getHtmlLabelName(21995, user.getLanguage())%>
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
            </colgroup>
        </table>
    </div>
    <div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
        <wea:layout type="4col">
            <wea:group context="查询条件">
                <%--<wea:item>财务年月 </wea:item>--%>
                <%--<wea:item>--%>
                <%--<button type="button" class=Calendar id="SelectDate" onclick="gettheDate(CWNY,CWNYspan)"></BUTTON>--%>
                <%--<SPAN id=CWNYspan><%=CWNY%></SPAN>--%>
                <%--<INPUT type="hidden" name="CWNY" value="<%=CWNY%>">--%>
                <%--</wea:item>--%>

                <wea:item>物料代码</wea:item>
                <wea:item>
                    <input type="text" name="WLBM" style='width:80%' value="">
                </wea:item>
                <wea:item>物料名称</wea:item>
                <wea:item>
                    <input type="text" name="WLMC" style='width:80%' value="">
                </wea:item>
                <wea:item>年份</wea:item>
                <wea:item>
                    <select class="e8_btn_top middle" name="year" id="year">
                        <option value="" <%if ("".equals(year)) {%> selected<%} %>><%=""%>
                        </option>
                        <% for (int i = 0; i < 10; i++) {
                            String xzyear = now_year - i + "";
                        %>

                        <option value="<%=xzyear%>" <%if (xzyear.equals(year)) {%> selected<%} %>>
                            <%=xzyear%>
                        </option>
                        <%}%>

                    </select>
                </wea:item>

                <wea:item>月份</wea:item>
                <wea:item>
                    <select class="e8_btn_top middle" name="month" id="month">
                        <option value="" <%if ("".equals(month)) {%> selected<%} %>>
                            <%=""%>
                        </option>
                        <option value="1" <%if ("1".equals(month)) {%> selected<%} %>>
                            <%="1"%>
                        </option>
                        <option value="2" <%if ("2".equals(month)) {%> selected<%} %>>
                            <%="2"%>
                        </option>
                        <option value="3" <%if ("3".equals(month)) {%> selected<%} %>>
                            <%="3"%>
                        </option>
                        <option value="4" <%if ("4".equals(month)) {%> selected<%} %>>
                            <%="4"%>
                        </option>
                        <option value="5" <%if ("5".equals(month)) {%> selected<%} %>>
                            <%="5"%>
                        </option>
                        <option value="6" <%if ("6".equals(month)) {%> selected<%} %>>
                            <%="6"%>
                        </option>
                        <option value="7" <%if ("7".equals(month)) {%> selected<%} %>>
                            <%="7"%>
                        </option>
                        <option value="8" <%if ("8".equals(month)) {%> selected<%} %>>
                            <%="8"%>
                        </option>
                        <option value="9" <%if ("9".equals(month)) {%> selected<%} %>>
                            <%="9"%>
                        </option>
                        <option value="10" <%if ("10".equals(month)) {%> selected<%} %>>
                            <%="10"%>
                        </option>
                        <option value="11" <%if ("11".equals(month)) {%> selected<%} %>>
                            <%="11"%>
                        </option>
                        <option value="12" <%if ("12".equals(month)) {%> selected<%} %>>
                            <%="12"%>
                        </option>
                    </select>
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
        </wea:layout>
    </div>

</FORM>
<%


    String backfields = " t.* ";
    String fromSql = " from (select u.id,'" + year + "-" + month + "' as cwny,w.rkjg,(select dbo.get_some_month1(w.wlmc,w.CKID,'" + startday + "','" + endday + "')) as qcsl,(select dbo.get_some_month_IN1(w.wlmc,w.CKID,'" + startday + "','" + endday + "')) as byrk," +
            " (select a.ckmc from uf_stocks a where a.id=w.CKID) as ckmc,(select dbo.get_some_mont_OUT1(w.wlmc,w.CKID,'" + startday + "','" + endday + "')) as byck,(select dbo.get_some_month_AMONT(w.wlmc,w.CKID,'" + startday + "','" + endday + "')) as je," +
            " u.WLBM,u.WLname,(select b.dw from uf_unitForms b where b.id = u.DW) as DW,(select dbo.get_some_stock_mount1(w.wlmc,w.CKID,'" + startday + "','" + endday + "')) as kykc,convert(varchar(50),u.WLBM)+'&amp;CKID='+convert(varchar(50),w.CKID)  as  WLBMS" +
            " from uf_materialDatas u join (select wlmc,CKID,rkly,rkjg from uf_stock group by wlmc,CKID,rkly,rkjg) w on u.id=w.wlmc where w.rkly=0 ) t ";
    String sqlWhere = "  (t.qcsl>0 or t.byrk>0 or byck>0) ";
    String orderby = "t.id desc";
    String tableString = "";
    String operateString = "";

    //物料编码
    if (!"".equals(WLBM)) {
        sqlWhere += " and WLBM like '%" + WLBM + "%' ";
    }
    //物料名称
    if (!"".equals(WLMC)) {
        sqlWhere += " and WLname like '%" + WLMC + "%' ";
    }
//    String temp = WLBM + ",&amp;CWNY=" + CWNY;
	//out.print("select " + backfields + fromSql + " where " + sqlWhere);

    tableString = " <table tabletype=\"checkbox\" pagesize=\"" + PageIdConst.getPageSize(leave_pageId, user.getUID(), PageIdConst.HRM) + "\" pageId=\"" + leave_pageId + "\">" +
            "      <sql backfields=\"" + backfields + "\" sqlform=\"" + fromSql + "\" sqlwhere=\"" + Util.toHtmlForSplitPage(sqlWhere) + "\"  sqlorderby=\"" + orderby + "\"  sqlprimarykey=\"t.id\" sqlsortway=\"desc\" sqlisdistinct=\"false\" />" +
            operateString +
            "           <head>";
    tableString += "       <col width=\"8%\"  text=\"财务年月\" column=\"cwny\" orderkey=\"cwny\"  />" +
            "       <col width=\"12%\" text=\"仓库\" column=\"ckmc\" orderkey=\"ckmc\" />" +
            "       <col width=\"10%\"  text=\"物料名称\" column=\"WLname\" orderkey=\"WLname\"  />" +
            "       <col width=\"10%\" text=\"物料编码\" column=\"WLBM\" orderkey=\"WLBM\" />" +
            "       <col width=\"10%\" text=\"单位\" column=\"DW\" orderkey=\"DW\" />" +
            "       <col width=\"10%\" text=\"期初数量\" column=\"qcsl\" orderkey=\"qcsl\" />" +
            "       <col width=\"10%\" text=\"本月入库\" column=\"byrk\" orderkey=\"byrk\" />" +
            "       <col width=\"10%\" text=\"本月出库\" column=\"byck\" orderkey=\"byck\" />" +
            "       <col width=\"10%\" text=\"可用库存\" column=\"kykc\" orderkey=\"kykc\" " +
            "       linkvaluecolumn=\"WLBMS\" linkkey=\"WLBM\" otherpara=\"column:ckmc\" " +
            "       href= \"/goodbaby/daisy/stock/stockinfodt_url.jsp?CWNY=" + year + "-" + month + "\" target=\"view_window\"/>" +
            "       <col width=\"10%\" text=\"金额\" column=\"je\" orderkey=\"je\" />" +
            "           </head>" +
            " </table>";

%>
<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" showExpExcel="true"/>
<script type="text/javascript">
    function onShowSubcompanyid1() {
        data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/SubcompanyBrowser.jsp");
        if (data != null) {
            if (data.id != "") {
                jQuery("#subcompanyid1span").html(data.name);
                jQuery("#subcompanyid1").val(data.id);
                makechecked();
            } else {
                jQuery("#subcompanyid1span").html("");
                jQuery("#subcompanyid1").val("");
            }
        }
    }

    function onShowDepartmentid() {
        data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp");
        if (data != null) {
            if (data.id != "") {
                jQuery("#departmentidspan").html(data.name);
                jQuery("#departmentid").val(data.id);
                makechecked();
            } else {
                jQuery("#departmentidspan").html("");
                jQuery("#departmentid").val("");
            }
        }
    }


    function onBtnSearchClick() {
        weaver.submit();
    }


</script>
<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>
</BODY>
</HTML>