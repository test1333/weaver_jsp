<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.systeminfo.SystemEnv" %>
<%@ page import="weaver.hrm.HrmUserVarify" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>

<%
    //if(!HrmUserVarify.checkUserRight("AnnualLeave:All", user)){
    // response.sendRedirect("/notice/noright.jsp");
    //return;
//}
    String idkey = Util.null2String(request.getParameter("idkey"));
    String dtId = Util.null2String(request.getParameter("id"));
    dtId += "0";
    int userId = Util.getIntValue(request.getParameter("userId"));
    String sql = "";
    sql = " select id,dataId,WLMC,WLBM,gysId,GYSMC,requestId,SQRXX,needDate,flowNum,PP,XH,GG,DW,SL,YGDJ," +
            " isnull(p.cgsl,0) cgsl from gb_noneBidPurchaseView v left join gb_poAmount p on v.id = p.dtId " +
            " where id in(" + dtId + ") ";
%>

<%
    String imagefilename = "/images/hdHRMCard_wev8.gif";
    String titlename = SystemEnv.getHtmlLabelName(21590, user.getLanguage());
    String needfav = "1";
    String needhelp = "";
%>
<HTML>
<HEAD>
    <LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
    <script language="javascript" src="/js/weaver_wev8.js"></script>
</HEAD>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
    RCMenu += "{提交,javascript:onSave(),_self} ";
    RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<form id=frmmain name=frmmain method=post action="editPOAmount.jsp">
    <table id="topTitle" cellpadding="0" cellspacing="0">
        <tr>
            <td>
            </td>
            <td class="rightSearchSpan" style="text-align:right;">
                <span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
            </td>
        </tr>
    </table>
    <wea:layout attributes="{'expandAllGroup':'true'}">
        <div id="TimeDate">
            <wea:group context="填写采购数量">
                <wea:item attributes="{'isTableList':'true'}">
                    <wea:layout type="table" attributes="{'cols':'10','cws':'10%,10%,10%,10%,10%,10%,10%,10%,10%,10%'}">
                        <wea:group context="" attributes="{'groupDisplay':'none'}">
                            <wea:item type="thead">物料名称</wea:item>
                            <wea:item type="thead">品牌</wea:item>
                            <wea:item type="thead">型号</wea:item>
                            <wea:item type="thead">规格</wea:item>
                            <wea:item type="thead">单位</wea:item>
                            <wea:item type="thead">申请数量</wea:item>
                            <wea:item type="thead">已采购数量</wea:item>
                            <wea:item type="thead">本次采购数量</wea:item>
                            <wea:item type="thead">供应商</wea:item>
                            <wea:item type="thead">交期</wea:item>
                            <%
                                RecordSet.executeSql(sql);
                                while (RecordSet.next()) {
                                    String poAmount = "";
                                    String id = Util.null2String(RecordSet.getString("id"));
                                    String dataId = Util.null2String(RecordSet.getString("dataId"));
                                    String WLMC = Util.null2String(RecordSet.getString("WLMC"));
                                    String WLBM = Util.null2String(RecordSet.getString("WLBM"));
                                    String GYSMC = Util.null2String(RecordSet.getString("GYSMC"));
                                    String PP = Util.null2String(RecordSet.getString("PP"));
                                    String xh = Util.null2String(RecordSet.getString("xh"));
                                    String gg = Util.null2String(RecordSet.getString("gg"));
                                    String dw = Util.null2String(RecordSet.getString("dw"));
                                    String sl = Util.null2String(RecordSet.getString("sl"));
                                    String cgsl = Util.null2String(RecordSet.getString("cgsl"));
                                    String needDate = Util.null2String(RecordSet.getString("needDate"));
                            %>
                            <wea:item><%=WLMC%>
                            </wea:item>
                            <wea:item><%=PP%>
                                <INPUT type="hidden" name="id" value="<%=dtId%>">
                                <INPUT type="hidden" name="userId" value="<%=userId%>">
                            </wea:item>
                            <wea:item><%=xh%>
                            </wea:item>
                            <wea:item><%=gg%>
                            </wea:item>
                            <wea:item><%=dw%>
                            </wea:item>
                            <wea:item><%=sl%>
                                <input type="hidden" name="sl" id="sl<%=id%>" value="<%=sl%>">
                            </wea:item>
                            <wea:item><%=cgsl%>
                                <input type="hidden" name="cgsl" id="cgsl<%=id%>" value="<%=cgsl%>">
                            </wea:item>
                            <wea:item type="toolbar">
                                <wea:required id="poAmount" required="true" value="<%=poAmount%>">
                                    <INPUT class=inputstyle type="text" id="poAmount<%=id%>"
                                           name="poAmount<%=id%>" value="<%=poAmount%>"
                                           onKeyPress="ItemDecimal_KeyPress(this.name,15,2)"
                                           onBlur="checknumber1(this)">
                                </wea:required>
                            </wea:item>
                            <wea:item><%=GYSMC%>
                            </wea:item>
                            <wea:item><%=needDate%>
                            </wea:item>
                            <%
                                }
                            %>
                        </wea:group>
                    </wea:layout>
                </wea:item>
            </wea:group>
        </div>
    </wea:layout>
</form>
<script language=javascript>
    function onSave () {
        var dialog = parent.getDialog(window)
        var parentWin = parent.getParentWindow(window)
        var ids = '<%=dtId%>'
        var userId = '<%=userId%>'
        var dataId = ids.split(',')
        for (var i = 0; i < dataId.length; i++) {
            if (dataId[i] !== '0') {
                var sl = jQuery('#sl' + dataId[i]).val()
                var cgsl = jQuery('#cgsl' + dataId[i]).val()
                var amount = jQuery('#poAmount' + dataId[i]).val()
                if (Number(amount) === 0) {
                    Dialog.alert('请填写采购数量！')
                    return false
                }
                // alert('sl=' + sl + '|cgsl=' + cgsl + '|amount=' + amount)
                if (Number(sl) < Number(cgsl) + Number(amount)) {
                    Dialog.alert('数量超出,请检查！')
                    return false
                }
            }
        }
        Dialog.confirm('确定发起流程？', function () {
            // frmmain.action = 'createPOFlow.jsp?id=' + ids + '&userId=' + userId
            // frmmain.submit()
            var result = createPOFlow(ids, userId)
            if (result === '0') {
                parentWin.location.reload()
                dialog.closeByHand()
                // parentWin.Dialog.alert('流程创建成功！')
            }
        }, function () {}, 320, 90, false)

    }

    /**
     * 创建流程
     * @param ids PR明细表id
     * @param userId 当前操作者
     * @returns {string} 结果0创建成功
     */
    function createPOFlow (ids, userId) {
        var result = '1'
        var a = {
            url: 'createPOFlow.jsp?id=' + ids + '&userId=' + userId,
            data: jQuery('#frmmain').serialize(), // 要发送的是frmmain表单中的数据
            type: 'post',
            async: false,
            success: function (data) {
                data = data.replace(/\n/g, '').replace(/\r/g, '')
                if (data === '0') {
                    result = '0'
                }
            }
        }
        jQuery.ajax(a)
        return result
    }

</script>
</BODY>
<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>
</HTML>
