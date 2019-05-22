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
    String com = Util.null2String(request.getParameter("com"));
    String fkqx = Util.null2String(request.getParameter("fkqx"));
    String bz = Util.null2String(request.getParameter("bz"));
    String gysmc = Util.null2String(request.getParameter("gysmc"));
    String late_pageId = "paydtList00001";
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
    // RCMenu += "{" + SystemEnv.getHtmlLabelName(527, user.getLanguage()) + ",javascript:onBtnSearchClick(),_self} ";
    // RCMenuHeight += RCMenuHeightStep;
//    RCMenu += "{发起流程,javascript:openDialog(),_self} ";
//    RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<FORM id=report name=report action="" method=post>
    <table id="topTitle" cellpadding="0" cellspacing="0">
        <tr>
            <td></td>
            <td class="rightSearchSpan" style="text-align:right;">
                <%--<input type=button class="e8_btn_top" onclick="openDialog();" value="发起流程">--%>

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
                <wea:item>付款期限</wea:item>
                <wea:item>
                    <button type="button" class=Calendar id="SelectDate" onclick="gettheDate(fkqx,fkqxspan)"></BUTTON>
                    <SPAN id=fkqxspan><%=fkqx%></SPAN>
                    <INPUT type="hidden" name="fkqx" value="<%=fkqx%>">
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
    String backfields = " t.* ";
    //表单中的字段
    String fromSql = " from (select isnull(b.sfpk,'1') as sfpk,b.id,b.gysmc,b.fph,b.fkqx,b.company,b.bz,b.jeyb,b.jermb,a.GYSMC as gys,a.YHZH,a.LHH,"
            + "    a.KHH,a.JGH,a.CNAPS,b.fkid,(select d.selectname from workflow_billfield e, workflow_bill c,workflow_selectitem d where e.billid=c.id"
            + "    and d.fieldid=e.id  and c.tablename='uf_suppmessForm' and e.fieldname='ZHSK' and d.cancel=0 and d.selectvalue = a.ZHSK) as ZHSK"
            + "    from uf_payinternal b join uf_suppmessForm a on a.id =b.gysmc where a.id not in (select gys from uf_ztpkgys ) and b.fph not in"
            + "    (select fphm from  uf_ztpkfp )) t ";//sql查询的表
    String sqlWhere = " t.sfpk='1' and fkqx<= '" + fkqx + "' and bz = '" + bz + "' and gysmc = " + gysmc;//where条件
    if (!"".equals(com)) {
        sqlWhere += " and company like '%" + com + "%'";
    }
//    out.println("select " + backfields + fromSql + "where" + sqlWhere);
    String orderby = " id ";//排序关键字
    String tableString = "";

    tableString = " <table tabletype=\"checkbox\" pagesize=\"" + PageIdConst.getPageSize(late_pageId, user.getUID(), PageIdConst.HRM) + "\" pageId=\"" + late_pageId + "\">" +
            "	   <sql backfields=\"" + backfields + "\" sqlform=\"" + fromSql + "\" sqlwhere=\"" + Util.toHtmlForSplitPage(sqlWhere) + "\"  sqlorderby=\"" + orderby + "\" " +
            " sqlprimarykey=\"id\" sqlsortway=\"asc\" sqlisdistinct=\"false\"  sumColumns=\"jeyb\" showCountColumn=\"true\" decimalFormat=\"%,.2f\"/>\"+/>" +
            "	<head>";
    tableString += "   <col width=\"8%\" text=\"发票号\" column=\"fph\" orderkey=\"fph\" " +
            "   transmethod=\"goodbaby.daisy.payment.OpenDialog.getVoice\" />" +
            "	<col width=\"7%\" text=\"发票金额\" column=\"jeyb\" orderkey=\"jeyb\" />" +
            "	<col width=\"5%\" text=\"币种\" column=\"bz\" orderkey=\"bz\" " +
            "   transmethod=\"goodbaby.price.ChangeCurrency.getLinkType\" " +
            "   linkvaluecolumn=\"bz\" linkkey=\"billid\" " +
            "   href=\"/formmode/view/AddFormMode.jsp?type=0&amp;modeId=2&amp;formId=-50\" target=\"_fullwindow\" />" +
            "   <col width=\"10%\" text=\"公司\" column=\"company\" orderkey=\"company\" />" +
            "   <col width=\"10%\" text=\"供应商名称\" column=\"gys\" orderkey=\"gys\" " +
            "   linkvaluecolumn=\"gysmc\" linkkey=\"billid\" " +
            "   href=\"/formmode/view/AddFormMode.jsp?type=0&amp;modeId=36&amp;formId=-195\" target=\"_fullwindow\" />" +
            "	<col width=\"8%\" text=\"付款期限\" column=\"fkqx\" orderkey=\"fkqx\" />" +
            "	<col width=\"10%\" text=\"付款流程\" column=\"fkid\" orderkey=\"fkid\" " +
            "   transmethod=\"weaver.workflow.request.RequestComInfo.getRequestname\" " +
            "   linkvaluecolumn=\"fkid\" linkkey=\"requestid\"" +
            "   href=\"/workflow/request/ViewRequest.jsp\" target=\"_fullwindow\" />" +
            "	</head>" +
            " </table>";
%>
<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run"  showExpExcel="true"/>
<script type="text/javascript">
    function onBtnSearchClick() {
        report.submit();
    }

    /**
     * 发起流程
     * @returns {boolean}
     */
    function createWorkflow() {
        var ids = _xtable_CheckedCheckboxId()
        var userId = '<%=userId%>'
        alert("ids=" + ids);
        if (ids === '') {
            Dialog.alert('<%=SystemEnv.getHtmlLabelName(19689,user.getLanguage())%>')
            return false
        }
        Dialog.confirm('确定发起流程', function () {
            report.action = ''
            report.submit()
        }, function () {
        }, 320, 90, false)
    }

    // 在其子页面中，调用此方法打开相应的界面
    function openDialog() {
        var ids = _xtable_CheckedCheckboxId()
        if (ids === '') {
            Dialog.alert('<%=SystemEnv.getHtmlLabelName(19689,user.getLanguage())%>')
            return false
        }
        var fkqx = '<%=fkqx%>'
        var userId = '<%=userId%>'
        var dlg = new window.top.Dialog()// 定义Dialog对象
        dlg.currentWindow = window
        dlg.Model = true
        dlg.Width = 1080// 定义长度
        dlg.Height = 720
        dlg.URL = ''
        dlg.Title = '编辑付款金额'
        dlg.show()
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
