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
    String titlename = "选择组";
    String needfav = "1";
    String needhelp = "";
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
            <td height="10" colspan="2"></td>
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
        <col width="50%"></col>
        <col width="50%"></col>
        <col></col>
    </colgroup>
    <tr>
        <TD align="center" valign="middle">公文标题</TD>
        <td><input class=inputstyle id='wjbt' name=wjbt size="20" value=""></td>

    </tr>
    <tr style="height:1px;">
        <td class=Line colspan=3></td>
    </tr>
</table>
<TABLE width="100%">
    <tr>
        <td valign="top">
            <%
				String 	backfields = "  aa.groupid ,aa.name,aa.zm   ";
                String fromSql = "  (select tt.groupid ,tt.name,tt.name || ' ( ' || to_char(count(tt.groupid)) || ' )'  as zm from (select  hm.userid,hm.usertype,hm.groupid,hg.name,hg.owner,hg.type from hrmgroupmembers hm join  hrmgroup hg on hg.id = hm.groupid and hg.type=0 )tt  where tt.owner = '"+emp_id+"' group by tt.groupid, tt.name )  aa";
                String sqlWhere = " 1=1 ";
                // out.println("select " + backfields + fromSql + " where " + sqlWhere);
                //out.println(sqlWhere);
                String orderby = " aa.groupid ";
                String tableString = "";
                tableString = " <table  tabletype=\"checkbox\" pagesize=\"" + perpage + "\" >" +
                        "	   <sql backfields=\"" + backfields + "\" sqlform=\"" + fromSql + "\" sqlwhere=\"" + Util.toHtmlForSplitPage(sqlWhere) + "\" sqlorderby=\"" + orderby + "\" sqlprimarykey=\"groupid\" sqlsortway=\"asc\" />" +
                        "			<head>" +
						" 	<col width=\"50%\" text=\"编号\" column=\"groupid\" orderkey=\"groupid\"  />" +
                        " 	<col width=\"50%\" text=\"组名\" column=\"zm\" orderkey=\"zm\" linkvaluecolumn=\"groupid\" />" +

                        "			</head>" +
                        "</table>";
            %>

            <wea:SplitPageTag tableString="<%=tableString%>" mode="run" showExpExcel="false"/>
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

    function ycy(id) {
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
<script language="javascript" src="/wui/theme/ecology7/jquery/js/zDialog.js"></script>
<script language="javascript" src="/wui/theme/ecology7/jquery/js/zDrag.js"></script>
</BODY>
</HTML>