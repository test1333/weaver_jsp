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
    String poAmount = Util.null2String(request.getParameter("poAmount"));
    String dtId = Util.null2String(request.getParameter("id"));
    dtId += "0";
    int userId = Util.getIntValue(request.getParameter("userId"));
    String sql = "";
    sql = " select id,dataId,WLMC,WLBM,gysId,GYSMC,requestId,SQRXX,needDate,flowNum,PP,XH,GG,DW,SL,YGDJ," +
            " isnull(p.cgsl,0) cgsl from gb_minorPurchaseView v left join gb_poAmount p on v.id = p.dtId " +
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
    <script src="/js/ecology8/jquery_wev8.js"></script>
    <!--checkbox组件-->
    <link href="/js/ecology8/jNice/jNice/jNice_wev8.css" type=text/css rel=stylesheet>
    <script language=javascript src="/js/ecology8/jNice/jNice/jquery.jNice_wev8.js"></script>
    <!-- 下拉框美化组件-->
    <link href="/js/ecology8/selectbox/css/jquery.selectbox_wev8.css" type=text/css rel=stylesheet>
    <script language=javascript src="/js/ecology8/selectbox/js/jquery.selectbox-0.2_wev8.js"></script>
    <!-- 泛微可编辑表格组件-->
    <link rel="stylesheet" href="/wui/theme/ecology8/weaveredittable/css/WeaverEditTable_wev8.css">
    <script src="/wui/theme/ecology8/weaveredittable/js/WeaverEditTable_wev8.js"></script>

</HEAD>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
    RCMenu += "{" + SystemEnv.getHtmlLabelName(86, user.getLanguage()) + ",javascript:onSave(),_self} ";
    RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<div class="groupmain" style="width:100%"></div>
<form id=frmmain name=frmmain method=post action="createPOFlow.jsp">
    <table id="topTitle" cellpadding="0" cellspacing="0">
        <tr>
            <td>
            </td>
            <td class="rightSearchSpan" style="text-align:right;">
                <%if (HrmUserVarify.checkUserRight("AnnualLeave:All", user)) { %>
                <input type=button class="e8_btn_top" onclick="onSave();"
                       value="<%=SystemEnv.getHtmlLabelName(86,user.getLanguage())%>">
                </input>
                <input type=button class="e8_btn_top" onclick="BatchProcess();"
                       value="<%=SystemEnv.getHtmlLabelName(21611,user.getLanguage())%>">
                </input>
                <%}%>
                <span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
            </td>
        </tr>
    </table>
    <wea:layout attributes="{'expandAllGroup':'true'}">
        <div id="TimeDate">
            <wea:group context="<%=SystemEnv.getHtmlLabelName(32765,user.getLanguage())%>">
                <wea:item attributes="{'isTableList':'true'}">
                    <wea:layout type="table" attributes="{'cols':'10','cws':'12%,12%,12%,12%,12%,12%,12%,12%,12%,12%'}">
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
                            <wea:item>
                                <a href=javascript:this.openFullWindowForXtable('/formmode/view/AddFormMode.jsp?type=0&amp;modeId=42&amp;formId=-208&amp;billid=<%=dataId%>')><%=WLMC%>
                                </a></wea:item>
                            <wea:item><%=PP%>
                                <INPUT type="hidden" name="id" value="<%=id%>">
                                <INPUT type="hidden" name="userId" value="<%=userId%>">
                            </wea:item>
                            <wea:item><%=xh%>
                            </wea:item>
                            <wea:item><%=gg%>
                            </wea:item>
                            <wea:item><%=dw%>
                            </wea:item>
                            <wea:item><%=sl%>
                            </wea:item>
                            <wea:item><%=cgsl%>
                            </wea:item>
                            <wea:item>
                                <INPUT class=inputstyle type="text" id="poAmount<%=id%>"
                                       name="poAmount<%=id%>" value="<%=poAmount%>"
                                       onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)">
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
        frmmain.submit();
    }

    function firm () {

        if (confirm("是否确认同步？")) {
            sycal();
        }
        else {

        }
    }

    function BatchProcess () {
        document.frmmain.operation.value = "batchprocess";
        frmmain.submit();
    }

    var items = [

        {width: '10%', colname: '描述信息', itemhtml: "<input type='text' name='descinfo' style='width: 50px'><span class='mustinput'></span>"},

        {width: '15%', colname: '数据库字段', itemhtml: "<input type='text' name='datafield'>"},

        {width: '15%', colname: '字段显示名', itemhtml: "<input type='text' name='datalabel'>"},

        {width: '40%', colname: '字段类型', itemhtml: "<select name='datatype' style='width: 200px;height: 30px'><option value='0'>单行文本框</option><option value='1'>浏览框</option></select><span style='vertical-align: middle'>长度:</span><input name='datalength' type='text' style='width: 100px;vertical-align: middle' ><span class='mustinput'></span><span style='vertical-align: middle'>类型:</span><select name='ctype' style='width: 100px;height: 30px'><option value='0'>文本</option><option value='1'>数据</option></select>"},

        {width: '15%', colname: '顺序', itemhtml: "<input type='text' name='dataorder'>"}]

    // 普通模式使用
    var option = {basictitle: '主字段信息', colItems: items}

    // 基于ajax方式使用
    // var option = {navcolor: '#003399', basictitle: '主字段信息', colItems: items, useajax: true, ajaxurl: '/data/getdatas', ajaxparams: ''}

    // 生成相应的可编辑表格对象
    var group = new WeaverEditTable(option)
    // 将可编辑表格容器附加到dom节点上
    $('.groupmain').append(group.getContainer())

</script>
</BODY>
<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>
</HTML>
