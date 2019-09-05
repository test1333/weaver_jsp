<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="gcl.doc.workflow.DocUtil" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page"/>
<html>
<head>
    <script type="text/javascript" src="/js/weaver.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/Weaver.css">
</head>
<%
    int emp_id = user.getUID();

//    if (!HrmUserVarify.checkUserRight("CirculationEfficiency:Report", user)) {
//        response.sendRedirect("/notice/noright.jsp");
//        return;
//    }
    String requestid = Util.null2String(request.getParameter("requestid"));
    String id = Util.null2String(request.getParameter("id"));
//    out.print("id="+id);
    String sub_com = ResourceComInfo.getSubCompanyID("" + emp_id);
    int pagenum = Util.getIntValue(request.getParameter("pagenum"), 1);
    int perpage = 10;
    String cjkc_name = Util.null2String(request.getParameter("cjkc_name"));
    String imagefilename = "/images/hdDOC.gif";
    String titlename = "下下级传阅效率列表";
    String needfav = "1";
    String needhelp = "";
    DocUtil du = new DocUtil();
    String tablename = du.getBillTableName("CY");
    String wftablename = du.getWfTableName("CY");
    String tablenamemj = du.getBillTableName("MJ");
    String tablenamejjcd = du.getBillTableName("JJCD");
    String formid = "";
    String modeid = "";
    String sql = "select id from workflow_bill where tablename='" + tablename + "'";
    rs.executeSql(sql);
    if (rs.next()) {
        formid = Util.null2String(rs.getString("id"));
    }
    sql = "select id from modeinfo where  formid=" + formid;
    rs.executeSql(sql);
    if (rs.next()) {
        modeid = Util.null2String(rs.getString("id"));
    }
    String flag = "";
    String cylcid = "";//传阅子流程
    StringBuffer sb = new StringBuffer();
    sql = "select * from " + wftablename + " where SJCYID = " + id;
    rs.executeSql(sql);
    while (rs.next()) {
        cylcid = Util.null2String(rs.getString("requestid"));
//        cylcid = Util.null2String(rs.getString("cylcid"));
        sb.append(flag);
        sb.append(cylcid);
        flag = ",";
    }
//    out.print("cylcid = " + cylcid);

    String sjzzcyr = Util.null2String(request.getParameter("sjzzcyr"));
    String bcjzzcyr = Util.null2String(request.getParameter("bcjzzcyr"));
    String requestname2 = Util.null2String(request.getParameter("requestname2"));
    String wjbt = Util.null2String(request.getParameter("wjbt"));
    String requestname = Util.null2String(request.getParameter("requestname"));
    String gwbh = Util.null2String(request.getParameter("gwbh"));

    String fwzt = Util.null2String(request.getParameter("fwzt"));

    String tjren = Util.null2String(request.getParameter("tjren"));
    String tjrfb = Util.null2String(request.getParameter("tjrfb"));
    String mj = Util.null2String(request.getParameter("mj"));
    String jjcd = Util.null2String(request.getParameter("jjcd"));
    String mjname = "";
    sql = "select mj from " + tablenamemj + " where id=" + mj;
    rs.executeSql(sql);
    if (rs.next()) {
        mjname = Util.null2String(rs.getString("mj"));
    }
    String jjcdname = "";
    sql = "select jjcd from " + tablenamejjcd + " where id=" + jjcd;
    rs.executeSql(sql);
    if (rs.next()) {
        jjcdname = Util.null2String(rs.getString("jjcd"));
    }
//    out.print("mj="+mjname);
//    String tjrq = Util.null2String(request.getParameter("tjrq"));

    String StartDateF = Util.null2String(request.getParameter("StartDateF"));
    String EndDateF = Util.null2String(request.getParameter("EndDateF"));
    String StartDateF1 = Util.null2String(request.getParameter("StartDateF1"));
    String EndDateF1 = Util.null2String(request.getParameter("EndDateF1"));
    String StartDateF2 = Util.null2String(request.getParameter("StartDateF2"));
    String EndDateF2 = Util.null2String(request.getParameter("EndDateF2"));
    String StartDateF3 = Util.null2String(request.getParameter("StartDateF3"));
    String EndDateF3 = Util.null2String(request.getParameter("EndDateF3"));
    String StartDateF4 = Util.null2String(request.getParameter("StartDateF4"));
    String EndDateF4 = Util.null2String(request.getParameter("EndDateF4"));
    String cllx = Util.null2String(request.getParameter("cllx"));
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
    RCMenu += "{" + SystemEnv.getHtmlLabelName(197, user.getLanguage()) + ",javascript:document.weaver.submit(),_top} ";
    RCMenuHeight += RCMenuHeightStep;
    RCMenu += "{刷新,javascript:refresh(),_top} ";
    RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
    <colgroup>
        <col width="10">
        <col width="">
        <col width="10">
        <tr>
            <td height="10" colspan="3"></td>
        </tr>
        <tr>
            <td></td>
            <td valign="top">
                <TABLE class=Shadow>
                    <tr>
                        <td valign="top">
                            <FORM id=weaver name=weaver STYLE="margin-bottom:0" action="" method="post">
                                <input type="hidden" name="multiRequestIds" value="">
                                <input type="hidden" name="operation" value="">
                                <table width=100% class=ViewForm>
    <colgroup>
        <col width="15%"></col>
        <col width="15%"></col>
        <col width="15%"></col>
        <col width="15%"></col>
        <col width="15%"></col>
        <col width="15%"></col>
        <col></col>
    </colgroup>
    <tr>
        <TD align="center" valign="middle">公文标题</TD>
        <td><input class=inputstyle id='wjbt' name=wjbt size="20" value="<%=wjbt%>"></td>
        <%--<TD align="center" valign="middle">流程标题</TD>--%>
        <%--<td><input class=inputstyle id='requestname' name=requestname size="20" value="<%=requestname%>">--%>
        <%--</td>--%>
        <TD align="center" valign="middle">发文编号</TD>
        <td><input class=inputstyle id='gwbh' name=gwbh size="20" value="<%=gwbh%>"></td>
        <TD align="center" valign="middle">处理类型</TD>
        <td>
            <select class="e8_btn_top middle" name="cllx" id="cllx">
                <option value="" <%if ("".equals(cllx)) {%> selected<%} %>>
                    <%=""%>
                </option>
                <option value="0" <%if ("0".equals(cllx)) {%> selected<%} %>>
                    <%="未传阅"%>
                </option>
                <option value="1" <%if ("1".equals(cllx)) {%> selected<%} %>>
                    <%="已传阅"%>
                </option>
            </select>
        </td>
    </tr>
    <tr>
        <TD align="center" valign="middle">发文主体</TD>
        <td><input class=inputstyle id='fwzt' name=fwzt size="20" value="<%=fwzt%>"></td>
        <TD align="center" valign="middle">密级</TD>
        <TD class=fvalue>
            <BUTTON class=Browser type="button" onClick="onShowBrowser2()">
            </BUTTON>
            <SPAN id=mjspan><%=mjname%></SPAN><INPUT id=mj type=hidden name=mj temptitle="密级" viewtype="0"
                                                     value="<%=mj%>">
        </TD>
        <TD align="center" valign="middle">紧急程度</TD>
        <TD class=fvalue>
            <BUTTON class=Browser type="button" onClick="onShowBrowser()">
            </BUTTON>
            <SPAN id=jjcdspan><%=jjcdname%></SPAN><INPUT id=jjcd type=hidden name=jjcd temptitle="紧急程度" viewtype="0"
                                                         value="<%=jjcd%>">
        </TD>


    </tr>
    <tr>
        <TD align="center" valign="middle">发文提交人</TD>
        <td>
            <button class=Browser type="button" onClick="onShowResource()"></button>
            <span id=tjrenspan><%=Util.toScreen(ResourceComInfo.getLastnames(tjren), user.getLanguage())%></span>
            <input class=inputstyle id=tjren type=hidden name=tjren value="<%=tjren%>">
        </td>
        <TD align="center" valign="middle">发文提交分部</TD>
        <td>
            <button class=Browser type="button" onClick="onShowSubcompany()"></button>
            <span id=tjrfbspan><%=Util.toScreen(SubCompanyComInfo.getMoreSubCompanyname(tjrfb), user.getLanguage())%></span>
            <input class=inputstyle id=tjrfb type=hidden name=tjrfb value="<%=tjrfb%>">
        </td>
        <TD align="center" valign="middle">发文提交日期</TD>
        <TD>
            <BUTTON type="button" class=calendar id=SelectDate1
                    onclick="gettheDate(StartDateF,StartDateFspan)"></BUTTON>
            <SPAN id=StartDateFspan><%=StartDateF%></SPAN>
            <input type="hidden" name="StartDateF" value="<%=StartDateF%>">
            -&nbsp;&nbsp;
            <BUTTON type="button" class=calendar id=SelectDate onclick="gettheDate(EndDateF,EndDateFspan)"></BUTTON>
            <SPAN id=EndDateFspan><%=EndDateF%></SPAN>
            <input type="hidden" name="EndDateF" value="<%=EndDateF%>">
        </TD>
    </tr>
    <%--<tr>--%>
    <%--<TD align="center" valign="middle">上级组织传阅人</TD>--%>
    <%--<td>--%>
    <%--<button class=Browser type="button" onClick="onShowResource1()"></button>--%>
    <%--<span id=sjzzcyrspan><%=Util.toScreen(ResourceComInfo.getLastnames(sjzzcyr),user.getLanguage())%></span>--%>
    <%--<input class=inputstyle id=sjzzcyr type=hidden name=sjzzcyr value="<%=sjzzcyr%>">--%>
    <%--</td>--%>
    <%--<TD align="center" valign="middle">上级组织接收时间</TD>--%>
    <%--<TD>--%>
    <%--<BUTTON type="button" class=calendar id=SelectDate2  onclick="gettheDate(StartDateF1,StartDateF1span)"></BUTTON>--%>
    <%--<SPAN id=StartDateF1span ><%=StartDateF1%></SPAN>--%>
    <%--<input type="hidden" name="StartDateF1" value="<%=StartDateF%>">--%>
    <%---&nbsp;&nbsp;--%>
    <%--<BUTTON type="button" class=calendar id=SelectDate3  onclick="gettheDate(EndDateF1,EndDateF1span)"></BUTTON>--%>
    <%--<SPAN id=EndDateF1span ><%=EndDateF1%></SPAN>--%>
    <%--<input type="hidden" name="EndDateF1" value="<%=EndDateF1%>">--%>
    <%--</TD>--%>
    <%--<TD align="center" valign="middle">上级组织传阅时间</TD>--%>
    <%--<TD>--%>
    <%--<BUTTON type="button" class=calendar id=SelectDate4  onclick="gettheDate(StartDateF2,StartDateF2span)"></BUTTON>--%>
    <%--<SPAN id=StartDateF2span ><%=StartDateF2%></SPAN>--%>
    <%--<input type="hidden" name="StartDateF2" value="<%=StartDateF2%>">--%>
    <%---&nbsp;&nbsp;--%>
    <%--<BUTTON type="button" class=calendar id=SelectDate5  onclick="gettheDate(EndDateF2,EndDateF2span)"></BUTTON>--%>
    <%--<SPAN id=EndDateF2span ><%=EndDateF2%></SPAN>--%>
    <%--<input type="hidden" name="EndDateF2" value="<%=EndDateF2%>">--%>
    <%--</TD>--%>

    <%--</tr>--%>
    <%--<tr>--%>
    <%--<TD align="center" valign="middle">本层级组织传阅办理人</TD>--%>
    <%--<td>--%>
    <%--<button class=Browser type="button" onClick="onShowResource2()"></button>--%>
    <%--<span id=bcjzzcyrspan><%=Util.toScreen(ResourceComInfo.getLastnames(bcjzzcyr),user.getLanguage())%></span>--%>
    <%--<input class=inputstyle id=bcjzzcyr type=hidden name=bcjzzcyr value="<%=bcjzzcyr%>">--%>
    <%--</td>--%>
    <%--<TD align="center" valign="middle">本层级组织接收时间</TD>--%>
    <%--<TD>--%>
    <%--<BUTTON type="button" class=calendar id=SelectDate6  onclick="gettheDate(StartDateF3,StartDateF3span)"></BUTTON>--%>
    <%--<SPAN id=StartDateF3span ><%=StartDateF3%></SPAN>--%>
    <%--<input type="hidden" name="StartDateF3" value="<%=StartDateF3%>">--%>
    <%---&nbsp;&nbsp;--%>
    <%--<BUTTON type="button" class=calendar id=SelectDate7  onclick="gettheDate(EndDateF3,EndDateF3span)"></BUTTON>--%>
    <%--<SPAN id=EndDateF3span ><%=EndDateF3%></SPAN>--%>
    <%--<input type="hidden" name="EndDateF3" value="<%=EndDateF3%>">--%>
    <%--</TD>--%>
    <%--<TD align="center" valign="middle">本层级组织传阅时间</TD>--%>
    <%--<TD>--%>
    <%--<BUTTON type="button" class=calendar id=SelectDate8  onclick="gettheDate(StartDateF4,StartDateF4span)"></BUTTON>--%>
    <%--<SPAN id=StartDateF4span ><%=StartDateF4%></SPAN>--%>
    <%--<input type="hidden" name="StartDateF4" value="<%=StartDateF4%>">--%>
    <%---&nbsp;&nbsp;--%>
    <%--<BUTTON type="button" class=calendar id=SelectDate9  onclick="gettheDate(EndDateF4,EndDateF4span)"></BUTTON>--%>
    <%--<SPAN id=EndDateF4span ><%=EndDateF4%></SPAN>--%>
    <%--<input type="hidden" name="EndDateF4" value="<%=EndDateF4%>">--%>
    <%--</TD>--%>
    <%--</tr>--%>

    <tr style="height:1px;">
        <td class=Line colspan=11></td>
    </tr>
</table>
<TABLE width="100%">
    <tr>
        <td valign="top">
            <%

                //V_GCL_PROJINFO formtable_main_2471
                String backfields = " id,requestid,(select selectname from workflow_selectitem where selectvalue=a.cllx and FIELDID=1678143) " +
                        "as cylx,(select requestname from workflow_requestbase where " +
                        "requestid=a.requestid) as requestname,gwbh,fwbh,fwrq,wjbt,fwzt,tjbm,tjrfb,tjren,tjrq,bcjzzcyfb,bcjzzcybm,cllx," +
                        "(select mj from " + tablenamemj + " where id=a.mj) as mjname,mj,mjts,(select jjcd from " +
                        tablenamejjcd + " where id=a.jjcd) as jjcdname,jjcd,jjcdts,sjzzcyr,sjzzcyrq,sjzzjsrq,sjzzcyrq||' '||sjzzcysj as sjzzcysj," +
                        " sjzzjsrq||' '||sjzzjssj as sjzzjssj,bcjzzcyr,bcjzzjsrq||' '||bcjzzjssj as bcjzzjssj, bcjzzcyrq||' '||bcjzzcysj as" +
                        " bcjzzcysj,(select count(1) from " + wftablename + " b,workflow_requestbase c where b.sjcyid=a.id " +
                        "and c.currentnodetype=3 and b.requestid=c.requestid) as countnum,case " +
                        "when bcjzzcyrq is null then 0 else round((to_date(bcjzzcyrq||' '||bcjzzcysj,'yyyy-mm-dd " +
                        "HH24:mi:ss')-to_date(bcjzzjsrq||' '||bcjzzjssj,'yyyy-mm-dd HH24:mi:ss'))*24,2) end as hs";
                String fromSql = " from  " + tablename + " a ";
                StringBuffer where = new StringBuffer();
                where.append("( ");
                //处理SQL 使用in的条件中超过1000条数据报 ORA-01795:列表中的最大表达式数为1000 问题
                String[] idss = sb.toString().split(",");
                int count = idss.length / 1000;//循环数(相当于分页的页数)
                int remainder = idss.length % 1000;//余数
                if (remainder == 0){
                    //余数为0直接取结果
                    count = idss.length / 1000;
                }else{
                    //有余数进1
                    count = idss.length / 1000 + 1;
                }
                //参数 1000相当于每页显示1000行
                for (int i = 0; i < count; i++){
                    Set<String> set = new HashSet<String>();
                    for (int j = (i * 1000); j < 1000 * (i + 1); j++){
                        //不能超过总页数
                        if (j + 1 > idss.length)
                            break;
                        set.add(idss[j]);
                    }
                    String setIds = set.toString().replace("[", "(").replace("]", ")");
                    if (i == 0){
                        where.append("REQUESTID IN " + setIds + " \n");
                    }else{
                        where.append("OR REQUESTID IN " + setIds + " \n");
                    }
                }
                 where.append(" )");

                String sqlWhere = where.toString();
                if (!"".equals(cllx)) {
                    sqlWhere += " and cllx = '" + cllx + "'";
                }
                if (!"".equals(gwbh)) {
                    sqlWhere += " and gwbh like '%" + gwbh + "%'";
                }
                if (!"".equals(wjbt)) {
                    sqlWhere += " and wjbt like '%" + wjbt + "%'";
                }
//                if (!"".equals(fwzt)) {
//                    sqlWhere += " and fwzt like '%" + fwzt + "%'";
//                }
                if (!"".equals(mj)) {
                    sqlWhere += " and mj =" + mj;
                }
                if (!"".equals(jjcd)) {
                    sqlWhere += " and jjcd =" + jjcd;
                }
                if (!"".equals(tjrfb)) {
                    sqlWhere += " and tjrfb in (" + tjrfb + ")";
                }
                if (!"".equals(tjren)) {
                    sqlWhere += " and tjren in (" + tjren + ")";
                }
//                if (!"".equals(sjzzcyr)) {
//                    sqlWhere += " and sjzzcyr in (" + sjzzcyr + ")";
//                }
                if (!"".equals(bcjzzcyr)) {
                    sqlWhere += " and bcjzzcyr in (" + bcjzzcyr + ")";
                }
                if (!"".equals(StartDateF)) {
                    sqlWhere += " and fwrq>='" + StartDateF + "' ";

                    if (!"".equals(EndDateF)) {
                        sqlWhere += " and fwrq <='" + EndDateF + "' ";
                    }
                } else {
                    if (!"".equals(EndDateF)) {
                        sqlWhere += " and fwrq<='" + EndDateF + "' ";
                    }
                }

//                out.println("select " + backfields + fromSql + " where " + sqlWhere);
                //out.println(sqlWhere);
                String orderby = " bcjzzjssj desc ";
                String tableString = "";

                tableString = " <table  tabletype=\"none\" pagesize=\"" + perpage + "\" >" +
                        "	   <sql backfields=\"" + backfields + "\" sqlform=\"" + fromSql + "\" sqlwhere=\"" + Util.toHtmlForSplitPage(sqlWhere) + "\" sqlorderby=\"" + orderby + "\" sqlprimarykey=\"id\" sqlsortway=\"desc\" />" +
                        "			<head>" +
                        " 	<col width=\"6%\" text=\"公文标题\" column=\"wjbt\" orderkey=\"wjbt\" />" +
                        " 	<col width=\"6%\" text=\"发文编号\" column=\"gwbh\" orderkey=\"gwbh\"  />" +
                        " 	<col width=\"6%\" text=\"发文提交人\" column=\"tjren\" orderkey=\"tjren\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getLastname\"" +
                        "   linkvaluecolumn=\"tjren\" linkkey=\"id\" href=\"/hrm/resource/HrmResource.jsp\" target=\"_fullwindow\"/>" +
                        " 	<col width=\"6%\" text=\"发文提交分部\" column=\"tjrfb\" orderkey=\"tjrfb\" transmethod=\"weaver.hrm.company.SubCompanyComInfo.getSubCompanyname\" " +
                        "   linkvaluecolumn=\"tjrfb\" linkkey=\"id\" href=\"/hrm/company/HrmSubCompanyDsp.jsp\" target=\"_fullwindow\"/>" +
                        " 	<col width=\"6%\" text=\"发文提交日期\" column=\"fwrq\" orderkey=\"fwrq\" />" +
                        " 	<col width=\"6%\" text=\"密级\" column=\"mjname\" orderkey=\"mjname\"  />" +
                        " 	<col width=\"6%\" text=\"紧急程度\" column=\"jjcdname\" orderkey=\"jjcdname\"  />" +

                        " 	<col width=\"6%\" text=\"本层级传阅处理人\" column=\"sjzzcyr\" orderkey=\"sjzzcyr\"  transmethod=\"weaver.hrm.resource.ResourceComInfo.getLastname\"" +
                        "   linkvaluecolumn=\"sjzzcyr\" linkkey=\"id\" href=\"/hrm/resource/HrmResource.jsp\" target=\"_fullwindow\"/>" +
                        " 	<col width=\"6%\" text=\"本层级传阅时间\" column=\"sjzzcysj\" orderkey=\"sjzzcysj\" />" +

                        " 	<col width=\"6%\" text=\"下级组织传阅办理人\" column=\"bcjzzcyr\" orderkey=\"bcjzzcyr\"  transmethod=\"weaver.hrm.resource.ResourceComInfo.getLastname\"" +
                        "   linkvaluecolumn=\"bcjzzcyr\" linkkey=\"id\" href=\"/hrm/resource/HrmResource.jsp\" target=\"_fullwindow\"/>" +
                        " 	<col width=\"6%\" text=\"下级组织传阅分部\" column=\"bcjzzcyfb\" orderkey=\"bcjzzcyfb\" transmethod=\"weaver.hrm.company.SubCompanyComInfo.getSubCompanyname\"" +
                        "   linkvaluecolumn=\"bcjzzcyfb\" linkkey=\"id\" href=\"/hrm/company/HrmSubCompanyDsp.jsp\" target=\"_fullwindow\"/>" +
                        " 	<col width=\"6%\" text=\"下级组织传阅部门\" column=\"bcjzzcybm\" orderkey=\"bcjzzcybm\" transmethod=\"weaver.hrm.company.DepartmentComInfo.getDepartmentname\" />" +
                        "   linkvaluecolumn=\"bcjzzcybm\" linkkey=\"id\" href=\"/hrm/company/HrmDepartmentDsp.jsp\" target=\"_fullwindow\"/>" +
                        " 	<col width=\"6%\" text=\"下级组织接收时间\" column=\"bcjzzjssj\" orderkey=\"bcjzzjssj\" />" +
                        " 	<col width=\"6%\" text=\"下级组织传阅时间\" column=\"bcjzzcysj\" orderkey=\"bcjzzcysj\" />" +
                        " 	<col width=\"5%\" text=\"耗时(h)\" column=\"hs\" orderkey=\"hs\"  />" +
                        " 	<col width=\"5%\" text=\"传阅次数\" column=\"countnum\" orderkey=\"countnum\" linkvaluecolumn=\"id\" linkkey=\"cyid\" href=\"/gcl/doc/doc-cy-workflow-list.jsp\" target=\"_fullwindow\" />" +

                        " 	<col width=\"6%\" text=\"处理类型\" column=\"cylx\" orderkey=\"cylx\" />" +

                        "			</head>" +
                        "</table>";
                //showExpExcel="true"
            %>
            <wea:SplitPageTag tableString="<%=tableString%>" mode="run" showExpExcel="true"/>
        </td>
    </tr>
</TABLE>
</FORM>
</td>
</tr>
</TABLE>
</td>
<td></td>
</tr>
<tr>
    <td height="10" colspan="3"></td>
</tr>
</table>
<script type="text/javascript">
    function refresh() {
        window.location.reload();
    }

    function cy(id) {
        //alert("id")
        var creater = "<%=emp_id%>";
        var rqid = "";
        var result = "";
        $.ajax({
            type: "POST",
            url: "/gcl/doc/docaction.jsp",
            data: {'billid': id, 'creater': creater, 'type': 'check'},
            dataType: "text",
            async: false,//同步   true异步
            success: function (data) {
                data = data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
                result = data;
            }
        });
        //alert(result);
        if (result == "1") {
            alert("有未提交的传阅子流程");
            return;
        }

        $.ajax({
            type: "POST",
            url: "/gcl/doc/docaction.jsp",
            data: {'billid': id, 'creater': creater, 'type': 'cw'},
            dataType: "text",
            async: false,//同步   true异步
            success: function (data) {
                data = data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
                rqid = data;
            }
        });
        //alert(rqid);
        if (rqid == "-1") {
            alert("创建传阅流程失败");
            return;
        }

        openFullWindowForXtable('/workflow/request/ViewRequest.jsp?requestid=' + rqid);
    }

    function shownext(requestid, id) {
        var obj = new Object();
        obj.keyid = id;
        var iTop = (window.screen.availHeight - 30 - parseInt(300)) / 2 + "px"; //获得窗口的垂直位置;
        var iLeft = (window.screen.availWidth - 10 - parseInt(500)) / 2 + "px"; //获得窗口的水平位置
        var k = window.showModalDialog("/gcl/doc/editRemark.jsp",
            obj, "addressbar=no;status=0;scroll=no;dialogHeight=300px;dialogWidth=500px;dialogLeft=" + iLeft + ";dialogTop=" + iTop + ";resizable=0;center=1;");
        if (k == 1) {//判断是否刷新
            window.location.reload();
        }
    }

    function downloadxml() {
    }

    function onShowResourceID(inputname, spanname) {
        var opts = {
            _dwidth: '550px',
            _dheight: '550px',
            _url: 'about:blank',
            _scroll: "no",
            _dialogArguments: "",
            _displayTemplate: "#b{name}",
            _displaySelector: "",
            _required: "no",
            _displayText: "",
            value: ""
        };
        var iTop = (window.screen.availHeight - 30 - parseInt(opts._dheight)) / 2 + "px"; //获得窗口的垂直位置;
        var iLeft = (window.screen.availWidth - 10 - parseInt(opts._dwidth)) / 2 + "px"; //获得窗口的水平位置;
        opts.top = iTop;
        opts.left = iLeft;
        datas = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp",
            "", "addressbar=no;status=0;scroll=" + opts._scroll + ";dialogHeight=" + opts._dheight + ";dialogWidth=" + opts._dwidth + ";dialogLeft=" + opts.left + ";dialogTop=" + opts.top + ";resizable=0;center=1;");
        if (datas) {
            if (datas.id != "") {
                $("#" + spanname).html("<A href='javascript:openhrm(" + datas.id + ");' onclick='pointerXY(event);'>" + datas.name + "</A>");
                $("input[name=" + inputname + "]").val(datas.id);
            } else {
                $("#" + spanname).html("");
                $("input[name=" + inputname + "]").val("");
            }
        }
    }


    function onShowSubcompany() {
        data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/MutiSubcompanyBrowser.jsp?selectedids=" + jQuery("#tjrfb").val());
        if (data != null) {
            if (data.id != "") {
                ids = data.id.split(",");
                names = data.name.split(",");
                sHtml = "";
                for (var i = 0; i < ids.length; i++) {
                    if (ids[i] != "") {
                        sHtml = sHtml + names[i] + "&nbsp;&nbsp;";
                    }
                }
                jQuery("#tjrfbspan").html(sHtml);
                jQuery("input[name=tjrfb]").val(data.id.substr(1));
            } else {
                jQuery("#tjrfbspan").html("");
                jQuery("input[name=tjrfb]").val("");
            }
        }
    }

    function onShowBrowser() {
        data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.jjcd&selectedids=" + jQuery("#jjcd").val());
        if (data != null) {
            // alert(data.id);
            // alert(data.name);
            if (data.id != "") {
                jQuery("#jjcdspan").html(data.name);
                jQuery("input[name=jjcd]").val(data.id);
            } else {
                jQuery("#jjcdspan").html("");
                jQuery("input[name=jjcd]").val("");
            }
        }
    }

    function onShowBrowser2() {
        data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.mj&selectedids=" + jQuery("#mj").val());
        if (data != null) {
            // alert(data.id);
            // alert(data.name);
            if (data.id != "") {
                jQuery("#mjspan").html(data.name);
                jQuery("input[name=mj]").val(data.id);
            } else {
                jQuery("#mjspan").html("");
                jQuery("input[name=mj]").val("");
            }
        }
    }

    function onShowResource() {
        data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp?selectedids=" + jQuery("#tjren").val());
        if (data != null) {
            if (data.id != "") {
                ids = data.id.split(",");
                names = data.name.split(",");
                sHtml = "";
                for (var i = 0; i < ids.length; i++) {
                    if (ids[i] != "") {
                        sHtml = sHtml + names[i] + "&nbsp;&nbsp;";
                    }
                }
                jQuery("#tjrenspan").html(sHtml);
                jQuery("input[name=tjren]").val(data.id.substr(1));
            } else {
                jQuery("#tjrenspan").html("");
                jQuery("input[name=tjren]").val("");
            }
        }
    }

    function onShowResource1() {
        data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp?selectedids=" + jQuery("#sjzzcyr").val());
        if (data != null) {
            if (data.id != "") {
                ids = data.id.split(",");
                names = data.name.split(",");
                sHtml = "";
                for (var i = 0; i < ids.length; i++) {
                    if (ids[i] != "") {
                        sHtml = sHtml + names[i] + "&nbsp;&nbsp;";
                    }
                }
                jQuery("#sjzzcyrspan").html(sHtml);
                jQuery("input[name=sjzzcyr]").val(data.id.substr(1));
            } else {
                jQuery("#sjzzcyrspan").html("");
                jQuery("input[name=sjzzcyr]").val("");
            }
        }
    }

    function onShowResource2() {
        data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp?selectedids=" + jQuery("#sjzzcyr").val());
        if (data != null) {
            if (data.id != "") {
                ids = data.id.split(",");
                names = data.name.split(",");
                sHtml = "";
                for (var i = 0; i < ids.length; i++) {
                    if (ids[i] != "") {
                        sHtml = sHtml + names[i] + "&nbsp;&nbsp;";
                    }
                }
                jQuery("#bcjzzcyrspan").html(sHtml);
                jQuery("input[name=bcjzzcyr]").val(data.id.substr(1));
            } else {
                jQuery("#bcjzzcyrspan").html("");
                jQuery("input[name=bcjzzcyr]").val("");
            }
        }
    }
</script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
</BODY>
</HTML>