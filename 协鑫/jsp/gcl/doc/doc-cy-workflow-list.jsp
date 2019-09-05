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
    String sub_com = ResourceComInfo.getSubCompanyID("" + emp_id);
    int pagenum = Util.getIntValue(request.getParameter("pagenum"), 1);
    int perpage = 10;
    String cjkc_name = Util.null2String(request.getParameter("cjkc_name"));
    String imagefilename = "/images/hdDOC.gif";
    String titlename = "传阅子流程清单";
    String needfav = "1";
    String needhelp = "";
    String cyid = Util.null2String(request.getParameter("cyid"));
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

    String wjbt = Util.null2String(request.getParameter("wjbt"));
    String gwbh = Util.null2String(request.getParameter("gwbh"));

    String tjren = Util.null2String(request.getParameter("tjren"));
    String StartDateF = Util.null2String(request.getParameter("StartDateF"));
    String EndDateF = Util.null2String(request.getParameter("EndDateF"));

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
        <col width="20%"></col>
        <col width="20%"></col>
        <col width="20%"></col>
        <col width="20%"></col>
        <col></col>
    </colgroup>
    <tr>
        <TD align="center" valign="middle">公文标题</TD>
        <td><input class=inputstyle id='wjbt' name=wjbt size="20" value="<%=wjbt%>"></td>
        <TD align="center" valign="middle">发文编号</TD>
        <td><input class=inputstyle id='gwbh' name=gwbh size="20" value="<%=gwbh%>"></td>
        <%--<TD align="center" valign="middle">传阅流程</TD>--%>
        <%--<td><input class=inputstyle id='requestname' name=requestname size="20" value="<%=requestname%>"></td>--%>

    </tr>
    <tr>
        <TD align="center" valign="middle">流程发起人</TD>
        <td>
            <button class=Browser type="button" onClick="onShowResource()"></button>
            <span id=tjrenspan><%=Util.toScreen(ResourceComInfo.getLastnames(tjren), user.getLanguage())%></span>
            <input class=inputstyle id=tjren type=hidden name=tjren value="<%=tjren%>">
        </td>
        <TD align="center" valign="middle">发起时间</TD>
        <TD>
            <BUTTON type="button" class=calendar id=SelectDate1  onclick="gettheDate(StartDateF,StartDateFspan)"></BUTTON>
            <SPAN id=StartDateFspan ><%=StartDateF%></SPAN>
            <input type="hidden" name="StartDateF" value="<%=StartDateF%>">
            -&nbsp;&nbsp;
            <BUTTON type="button" class=calendar id=SelectDate  onclick="gettheDate(EndDateF,EndDateFspan)"></BUTTON>
            <SPAN id=EndDateFspan ><%=EndDateF%></SPAN>
            <input type="hidden" name="EndDateF" value="<%=EndDateF%>">
        </TD>
    </tr>


    <tr style="height:1px;">
        <td class=Line colspan=11></td>
    </tr>
</table>
<TABLE width="100%">
    <tr>
        <td valign="top">
            <%
                //876094 测试机   1707132  正式机
                String backfields = "wjbt,fwbh,gwbh,"+emp_id+" as ryid,a.requestid,b.requestname,b.creater," +
                        "b.createdate||' '||substr(b.createtime,0,5) as createtime,(select count(1) " +
                        "from workflow_currentoperator c,workflow_flownode d where c.nodeid=d.nodeid and d.nodeid=876094 and " +
                        " c.operatedate is not null and c.requestid=a.requestid)||'/'||" +
                        "(select count(1) from workflow_currentoperator c,workflow_flownode d where c.nodeid=d.nodeid and d.nodeid=876094 and " +
                        " c.operatedate is  null and c.requestid=a.requestid" +
                        ")||'/'||(select count(1) from workflow_currentoperator c,workflow_flownode d where c.nodeid=d.nodeid and d.nodeid=876094 and c.requestid=a.requestid)" +
                        " as ckzt ";
                String fromSql = " from  " + wftablename + " a,workflow_requestbase b ";
                String sqlWhere = " a.requestid=b.requestid and b.currentnodetype=3 and a.sjcyid='" + cyid + "' ";
//                if (!"".equals(wjbt)) {
//                    sqlWhere += " and wjbt like '%" + wjbt + "%'";
//                }
//                if (!"".equals(requestname)) {
//                    sqlWhere += " and requestname like '%" + requestname + "%'";
//                }
                if (!"".equals(gwbh)) {
                    sqlWhere += " and gwbh like '%" + gwbh + "%'";
                }
                if (!"".equals(wjbt)) {
                    sqlWhere += " and wjbt like '%" + wjbt + "%'";
                }
                if (!"".equals(tjren)) {
                    sqlWhere += " and b.creater in (" + tjren + ")";
                }
                if(!"".equals(StartDateF)){
                    sqlWhere +=" and b.createdate>='"+StartDateF+"' ";

                    if(!"".equals(EndDateF)){
                        sqlWhere +=" and b.createdate <='"+EndDateF+"' ";
                    }
                }else {
                    if (!"".equals(EndDateF)) {
                        sqlWhere += " and b.createdate<='" + EndDateF + "' ";
                    }
                }
//                out.println("select "+ backfields + fromSql + " where " + sqlWhere);
                //out.println(sqlWhere);
                String orderby = " a.requestid ";
                String tableString = "";

                tableString = " <table  tabletype=\"none\" pagesize=\"" + perpage + "\" >" +
                        "	   <sql backfields=\"" + backfields + "\" sqlform=\"" + fromSql + "\" sqlwhere=\"" + Util.toHtmlForSplitPage(sqlWhere) + "\" sqlorderby=\"" + orderby + "\" sqlprimarykey=\"a.requestid\" sqlsortway=\"desc\" />" +
                        "			<head>" +
                        " 	<col width=\"15%\" text=\"公文标题\" column=\"wjbt\" orderkey=\"wjbt\" />" +
                        " 	<col width=\"15%\" text=\"发文编号\" column=\"gwbh\" orderkey=\"gwbh\"  />" +
                        "   <col width=\"15%\" text=\"传阅流程\" column=\"requestname\" orderkey=\"requestname\" linkvaluecolumn=\"requestid\" linkkey=\"requestid\" href=\"/workflow/request/ViewRequest.jsp\" target=\"_fullwindow\" />" +
                        " 	<col width=\"15%\" text=\"已查看/未查看/总传阅\" column=\"ckzt\" orderkey=\"ckzt\"  />" +
                        " 	<col width=\"15%\" text=\"流程发起人\" column=\"creater\" orderkey=\"creater\"  transmethod=\"weaver.hrm.resource.ResourceComInfo.getLastname\"" +
                        "   linkvaluecolumn=\"creater\" linkkey=\"id\" href=\"/hrm/resource/HrmResource.jsp\" target=\"_fullwindow\"/>" +
                        " 	<col width=\"15%\" text=\"发起时间\" column=\"createtime\" orderkey=\"createtime\"  />" +
                        " 	<col width=\"10%\" text=\"操作\" column=\"requestid\" orderkey=\"requestid\" otherpara=\"column:ryid\" transmethod=\"gcl.doc.workflow.DocUtil.deleteRequest\" hide=\"true\" />" +


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

    function deleterq(rqid) {
        //alert("id")
        if(confirm("此删除操作不可撤回，请确认！")) {
            var creater = "<%=emp_id%>";
            var result = "";
            $.ajax({
                type: "POST",
                url: "/gcl/doc/docaction.jsp",
                data: {'billid': rqid, 'creater': creater, 'type': 'deleterq'},
                dataType: "text",
                async: false,//同步   true异步
                success: function (data) {
                    data = data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
                    result = data;
                }
            });
            if(result == "-1"){
                alert("删除蓝信消息失败");
                return;
            }
            window.location.reload();
        }else {
            return false;
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
</script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
</BODY>
</HTML>