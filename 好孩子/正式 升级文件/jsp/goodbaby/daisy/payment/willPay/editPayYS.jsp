<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.systeminfo.SystemEnv" %>
<%@ page import="weaver.hrm.HrmUserVarify" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="org.json.JSONObject" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>

<%
    String idkey = Util.null2String(request.getParameter("idkey"));
    String requestid = Util.null2String(request.getParameter("requestid"));//排款流程id
    String temp = "";
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
    <script type="text/javascript" src="/wui/common/jquery/jquery.min_wev8.js"></script>
    <script language="javascript" type="text/javascript" src="/FCKEditor/swfobject_wev8.js"></script>
</HEAD>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>

<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
    RCMenu += "{确认,javascript:onSave(),_self} ";
    RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<form id=frmmain name=frmmain method=post>
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
            <wea:group context="付款">
                <wea:item type="groupHead">
                    <input type=button class="middle e8_btn_top_first" onclick="openDialog();" value="查询所有付款明细">
                    <input type=button class="middle e8_btn_top_first" onclick="onSave();" value="提交">
                </wea:item>
                <wea:item attributes="{'isTableList':'true'}">
                    <wea:layout type="table" attributes="{'cols':'5','cws':'20%,20%,20%,20%,20%'}">
                        <wea:group context="" attributes="{'groupDisplay':'none'}">
                            <wea:item type="thead">供应商名称</wea:item>
                            <wea:item type="thead">本次应付金额</wea:item>
                            <wea:item type="thead">本次实付金额</wea:item>
                            <wea:item type="thead">备注</wea:item>
                            <wea:item type="thead">是否付款</wea:item>
                            <%

                                JSONObject js = new JSONObject();
                                String sql = " select * from gb_arrangePayView where requestid = " + requestid;
                                BaseBean log = new BaseBean();
                                RecordSet.executeSql(sql);
                                String flag = "";
                                log.writeLog(sql);
                                while (RecordSet.next()) {
//                                    flag = "";
                                    String sffk = Util.null2String(RecordSet.getString("SFFK"));
                                    String gys = "";
                                    String khh = "";
                                    String lhh = "";
                                    String jgh = "";
                                    String CNAPS = "";
                                    String ZHSK = "";
                                    String yhzh = "";
                                    String id = Util.null2String(RecordSet.getString("id"));//流程明细id
//                                    String requestId = Util.null2String(RecordSet.getString("requestId"));
                                    String GYSMC_NPP = Util.null2String(RecordSet.getString("GYSMC_NPP"));
                                    String pkids = Util.null2String(RecordSet.getString("pkids"));//排款id
                                    String JHFKJE_NPP = Util.null2String(RecordSet.getString("JHFKJE_NPP"));
                                    String SJFKJE_NPP = Util.null2String(RecordSet.getString("SJFKJE_NPP"));
                                    String BZ_NPP = Util.null2String(RecordSet.getString("BZ_NPP"));
                                    String FKQX_NPP = Util.null2String(RecordSet.getString("FKQX_NPP"));
                                    String sqldt = "select * from uf_suppmessForm where id = '" + GYSMC_NPP + "'";
                                    rs.executeSql(sqldt);
                                    if (rs.next()) {
                                        gys = Util.null2String(rs.getString("GYSMC"));
                                        khh = Util.null2String(rs.getString("KHH"));
                                        lhh = Util.null2String(rs.getString("LHH"));
                                        jgh = Util.null2String(rs.getString("JGH"));
                                        CNAPS = Util.null2String(rs.getString("CNAPS"));
                                        ZHSK = Util.null2String(rs.getString("ZHSK"));
                                        yhzh = Util.null2String(rs.getString("YHZH"));
                                    }
                                    log.writeLog("requestid->" + requestid + ",sffk->" + sffk + ",GYSMC_NPP->" + GYSMC_NPP
                                            + ",JHFKJE_NPP->" + JHFKJE_NPP + ",SJFKJE_NPP->" + SJFKJE_NPP
                                            + ",BZ_NPP->" + BZ_NPP + ",pkids->" + pkids + ",gys->" + gys
                                            + ",khh->" + khh + ",lhh->" + lhh + ",jgh->" + jgh  + ",CNAPS->"
                                            + CNAPS + ",ZHSK->" + ZHSK + ",yhzh->" + yhzh);
                                    temp = temp + flag + id;
                                    flag = ",";

                            %>
                            <wea:item><%=gys%>
                            </wea:item>


                            <wea:item><%=JHFKJE_NPP%>
                            </wea:item>
                            <wea:item><%=SJFKJE_NPP%>
                            </wea:item>
                            <wea:item><%=BZ_NPP%>

                            </wea:item>
                            <wea:item>
                                <select name="sffk<%=id%>" value="<%=sffk%>">
                                    <option value="0">是</option>
                                    <option value="1">否</option>
                                </select>
                                <INPUT type="hidden" name="requestId" value="<%=requestid%>">
                                <INPUT type="hidden" name="pkids<%=id%>" value="<%=pkids%>">
                                <INPUT type="hidden" name="fkqx<%=id%>" value="<%=FKQX_NPP%>">
                                <INPUT type="hidden" name="jhfkje<%=id%>" value="<%=JHFKJE_NPP%>">
                                <INPUT type="hidden" name="sjfkje<%=id%>" value="<%=SJFKJE_NPP%>">
                                <INPUT type="hidden" name="gysmc<%=id%>" value="<%=GYSMC_NPP%>">
                                <INPUT type="hidden" name="khh<%=id%>" value="<%=khh%>">
                                <INPUT type="hidden" name="lhh<%=id%>" value="<%=lhh%>">
                                <INPUT type="hidden" name="jgh<%=id%>" value="<%=jgh%>">
                                <INPUT type="hidden" name="CNAPS<%=id%>" value="<%=CNAPS%>">
                                <INPUT type="hidden" name="ZHSK<%=id%>" value="<%=ZHSK%>">
                                <INPUT type="hidden" name="yhzh<%=id%>" value="<%=yhzh%>">
                            </wea:item>
                            <%
                                }
                            %>
                        </wea:group>
                    </wea:layout>
                    <INPUT type="hidden" name="temp" value="<%=temp%>">
                </wea:item>
            </wea:group>
        </div>
    </wea:layout>
</form>
<script language=javascript>
    function onBtnSearchClick() {
        report.submit();
    }

    function onSave() {
        var dialog = parent.getDialog(window)
        var parentWin = parent.getParentWindow(window)
        var requestid = '<%=requestid%>'
        var ids = '<%=temp%>'
        // alert(ids);
        var dataId = ids.split(',')
        var result = updateData(ids, requestid)
        if (result === '0') {
            parentWin.location.reload()
            dialog.closeByHand()
            // parentWin.Dialog.alert('流程创建成功！')
        }
    }

    function openDialog() {
        var dpkids = '<%=temp%>'
        //alert(dpkids);
        var rqid = '<%=requestid%>'
        //alert(dpkid);
        dialog = new window.top.Dialog();
        dialog.currentWindow = window;
        var url = "/goodbaby/daisy/payment/pklcmx/payment-plan-detail-Url.jsp?pklcmxid=" + dpkids + '&pklcid=' + rqid;
        dialog.Title = "付款明细";
        dialog.Width = 800;
        dialog.Height = 500;
        dialog.Drag = true;
        dialog.URL = url;
        dialog.maxiumnable = true;//允许最大化
        dialog.show();
    }

    /**
     * 创建流程
     * @param ids PR明细表id
     * @param userId 当前操作者
     * @returns {string} 结果0创建成功
     */
    function updateData(ids, requestid) {
        var result = '1'
        var a = {
            url: 'saveData.jsp?ids=' + ids + '&requestid=' + requestid,
            data: jQuery('#frmmain').serialize(), // 要发送的是frmmain表单中的数据
            type: 'post',
            async: false,
            success: function (data) {
                data = data.replace(/\n/g, '').replace(/\r/g, '')
                //alert(data)
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
