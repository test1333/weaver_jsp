<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.hrm.HrmUserVarify" %>
<%@ page import="weaver.hrm.User" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea" %>
<%@ taglib uri="/browserTag" prefix="brow" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<HTML>
<HEAD>
<%--    <script src="/js/tabs/jquery.tabs.extend_wev8.js"></script>--%>
<%--    <script type="text/javascript" src="/wui/common/jquery/jquery.min_wev8.js"></script>--%>
<%--    <link type="text/css" href="/js/tabs/css/e8tabs1_wev8.css" rel="stylesheet"/>--%>
<%--    <link rel="stylesheet" href="/css/ecology8/request/searchInput_wev8.css" type="text/css"/>--%>
<%--    <script type="text/javascript" src="/js/ecology8/request/searchInput_wev8.js"></script>--%>

<%--    <link rel="stylesheet" href="/css/ecology8/request/seachBody_wev8.css" type="text/css"/>--%>
<%--    <link rel="stylesheet" href="/css/ecology8/request/hoverBtn_wev8.css" type="text/css"/>--%>
<%--    <script type="text/javascript" src="/js/ecology8/request/hoverBtn_wev8.js"></script>--%>
<%--    <script type="text/javascript" src="/js/ecology8/request/titleCommon_wev8.js"></script>--%>

    <script type="text/javascript" src="/cloudstore/resource/pc/jquery/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="/spa/workflow/static4form/pc4mobx/workflowForm/util/windowFun.js"></script>
    <script type="text/javascript" src="/js/odoc/common/DocUtil_e9.js?v=1579587217217"></script>
    <script type="text/javascript" src="/spa/workflow/static4form/pc4mobx/workflowForm/util/formUtil.js"></script>
    <script type="text/javascript"
            src="/spa/workflow/static4form/pc4mobx/workflowForm/components/main/AsyncLoad.js"></script>
    <script type="text/javascript" src="/cloudstore/resource/pc/com/v1/components/_util/loadjs.umd.js"></script>
    <%--    <script type="text/javascript">--%>
    <%--        $(function () {--%>
    <%--            $('.e8_box').Tabs({--%>
    <%--                getLine: 1,--%>
    <%--                iframe: "tabcontentframe",--%>
    <%--                staticOnLoad: true--%>
    <%--            });--%>
    <%--        });--%>
    <%--    </script>--%>

    <%
        String saprequestid = Util.null2String(request.getParameter("requestid"));
        int saplan = Util.getIntValue(request.getParameter("lan"), 7);

        // add by shaw 2018-08-30 14:44:00
        String requestid = "";
        // String pernr_f = "";
        String sql = "select lc_no,pernr_f from zoat00020 where oa_md5='" + saprequestid + "'";
        rs.execute(sql);
        if (rs.next()) {
            requestid = Util.null2String(rs.getString("lc_no"));
            // pernr_f = Util.null2String(rs.getString("pernr_f"));
        }
        if ("".equals(requestid)) {
            sql = "select lc_no,pernr_f from zoat00030 where oa_md5='" + saprequestid + "'";
            rs.execute(sql);
            if (rs.next()) {
                requestid = Util.null2String(rs.getString("lc_no"));
                // pernr_f = Util.null2String(rs.getString("pernr_f"));
            }
        }
//        if ("".equals(requestid)) {
//            response.sendRedirect("/appdevjsp/HQ/SAPOA/noright.jsp?lan=" + saplan);
//            return;
//        }
        request.getSession().setAttribute("weaver_user@bean", User.getUser(Util.getIntValue("11000209"), 0));
        User user = HrmUserVarify.getUser(request, response);
        user.setLanguage(saplan);
        int userid = user.getUID();
        int usertype = 0;
        int workflowid = 0;
        int isbill = 0;
        int formid = 0;
        sql = "select workflowid from workflow_requestbase where requestid='" + requestid + "'";
        rs.execute(sql);
        if (rs.next()) {
            workflowid = rs.getInt("workflowid");
        }
        sql = "select isbill,formid from workflow_base  where id=" + workflowid;
        rs.execute(sql);
        if (rs.next()) {
            isbill = rs.getInt("isbill");
            formid = rs.getInt("formid");
        }
//        String showupload = "";
//        String showdoc = "";
//        String showworkflow = "";
        String reportid = Util.null2String(request.getParameter("reportid"));
        String isfromreport = Util.null2String(request.getParameter("isfromreport"));
        String isfromflowreport = Util.null2String(request.getParameter("isfromflowreport"));
        String iswfshare = Util.null2String(request.getParameter("iswfshare"));

        String urlparam = "workflowid=" + workflowid + "&requestid=" + requestid + "&isbill=" + isbill + "" +
                "&formid=" + formid + "&reportid=" + reportid + "&isfromreport=" + isfromreport + "&isfromflowreport="
                + isfromflowreport + "&iswfshare=" + iswfshare + "&f_weaver_belongto_userid=" + userid + "" +
                " &f_weaver_belongto_usertype=" + usertype;
//        String navName = "";
        String url2 = "/workflow/request/RequestResources.jsp?tabindex=1&" + urlparam;
        String url1 = "/workflow/request/RequestResources.jsp?tabindex=3&" + urlparam;
        // add by shaw 2018-08-30 14:44:23
    %>
    <script type="text/javascript">
        function spckxx () {
            var spckxx = document.getElementById("i");
            // spckxx.src = "/appdevjsp/HQ/SAPOA/WorkflowPictureStatusZOA.jsp?requestid=<%=saprequestid%>&lan=<%=saplan%>";
            spckxx.src = "/appdevjsp/HQ/SAPOA/ViewRequestForwardSPANew.jsp?requestid=<%=requestid%>&ismonitor=1&aaa=yyy";
        }

        function splj () {
            var splj = document.getElementById("i");
            // splj.src = "/appdevjsp/HQ/SAPOA/WorkflowPicE9.jsp?requestid=<%=saprequestid%>&lan=<%=saplan%>";
            splj.src = "/appdevjsp/HQ/SAPOA/ViewRequestForwardSPANew.jsp?requestid=<%=requestid%>&ismonitor=1&aaa=xxx";
            // window.open("/appdevjsp/HQ/SAPOA/ViewRequestForwardSPANew.jsp?requestid=<%=requestid%>&lan=<%=saplan%>")
        }

        function dy () {
            var dy = document.getElementById("i");
            dy.src = "/appdevjsp/HQ/SAPOA/PrintRequestForwardApp.jsp?requestid=<%=saprequestid%>&lan=<%=saplan%>";
        }

        function spjl () {
            var spjl = document.getElementById("i");
            spjl.src = "/appdevjsp/HQ/SAPOA/workflowRemark.jsp?requestid=<%=saprequestid%>&lan=<%=saplan%>";
        }

        function allspjl () {
            var allspjl = document.getElementById("i");
            allspjl.src = "/appdevjsp/HQ/SAPOA/workflowRemarkAll.jsp?requestid=<%=saprequestid%>&lan=<%=saplan%>";
        }

        // add by shaw 2018-08-31 08:37:09
        function xgzy () {
            var xgzy = document.getElementById("i");
            // xgzy.src = "/appdevjsp/HQ/SAPOA/RequestResourcesZOA.jsp?requestid=<%=saprequestid%>&lan=<%=saplan%>";
            xgzy.src = "/appdevjsp/HQ/SAPOA/ViewRequestForwardSPANew.jsp?requestid=<%=requestid%>&ismonitor=1&aaa=zzz";
        }

        // add by shaw 2018-08-31 08:40:29
        function flow () {
            var attached = document.getElementById("i");
            attached.src = "<%=url2%>";
        }

        /**
         * add by shaw 2018-08-30 14:40:27 相关附件
         */
        function attached () {
            var attached = document.getElementById("i");
            attached.src = "<%=url1%>";
        }

        /**
         * 解决IE打印问题，2019-01-16 14:43:52
         */
        function openSignPrint2 () {
            var url = "/workflow/request/PrintRequestForward.jsp";
            // var url = "PrintRequestForwardApp.jsp";
            // 首先创建一个form表单
            var tempForm = document.createElement('form')
            tempForm.id = 'tempForm1'
            // 制定发送请求的方式为post
            tempForm.method = 'post'
            // 此为window.open的url，通过表单的action来实现
            tempForm.action = url
            // 利用表单的target属性来绑定window.open的一些参数（如设置窗体属性的参数等）
            tempForm.target = '_blank'
            // 创建input标签，用来设置参数

            var hideInput1 = document.createElement('input')
            hideInput1.type = 'hidden'
            hideInput1.name = 'requestid'
            hideInput1.value = '<%=requestid%>'
            // hideInput1.value = '720214'
            var hideInput2 = document.createElement('input')
            hideInput2.type = 'hidden'
            hideInput2.name = 'lan'
            hideInput2.value = '<%=saplan%>'
            // 将input表单放到form表单里
            tempForm.appendChild(hideInput1)
            tempForm.appendChild(hideInput2)
            // 将此form表单添加到页面主体body中
            document.body.appendChild(tempForm)
            // 手动触发，提交表单
            tempForm.submit()
            // 从body中移除form表单
            document.body.removeChild(tempForm)
        }
    </script>
</head>
<body style="overflow-y: hidden">

<div>
    <input type="button" value="审批记录" onclick="spjl()"/>
    <input type="button" value="审批路径" onclick="splj()"/>
    <input type="button" value="审批查看信息" onclick="spckxx()"/>
    <input type="button" value="打印" onclick="openSignPrint2()"/>
    <%--    <input type="button" value="打印" onclick="dy()"/>--%>
    <input type="button" value="全部审批记录" onclick="allspjl()"/>
    <%--add by shaw 2018-08-31 08:41:26--%>
    <input type="button" value="相关资源" onclick="xgzy()"/>
    <%--    <input type="button" value="相关流程" onclick="flow()"/>--%>
    <%--    <input type="button" value="相关附件" onclick="attached()"/>--%>
</div>
<iframe id="i" scrolling="auto" style="width: 100%;height: 600px;"
        src="/appdevjsp/HQ/SAPOA/workflowRemark.jsp?requestid=<%=saprequestid%>&lan=<%=saplan%>">
</iframe>
</body>
</HTML>
