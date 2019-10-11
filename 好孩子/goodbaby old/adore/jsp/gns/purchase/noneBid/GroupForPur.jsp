<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea" %>
<%@ taglib uri="/browserTag" prefix="brow" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<HTML>
<HEAD>
    <script src="/js/tabs/jquery.tabs.extend_wev8.js"></script>
    <link type="text/css" href="/js/tabs/css/e8tabs1_wev8.css" rel="stylesheet"/>
    <link rel="stylesheet" href="/css/ecology8/request/searchInput_wev8.css" type="text/css"/>
    <script type="text/javascript" src="/js/ecology8/request/searchInput_wev8.js"></script>

    <link rel="stylesheet" href="/css/ecology8/request/seachBody_wev8.css" type="text/css"/>
    <link rel="stylesheet" href="/css/ecology8/request/hoverBtn_wev8.css" type="text/css"/>
    <script type="text/javascript" src="/js/ecology8/request/hoverBtn_wev8.js"></script>
    <script type="text/javascript" src="/js/ecology8/request/titleCommon_wev8.js"></script>
    <script type="text/javascript">
        $(function () {
            $('.e8_box').Tabs({
                getLine: 1,
                iframe: "tabcontentframe",
                staticOnLoad: true
            });
        });
    </script>

    <%
        int userId = user.getUID();
        Boolean isAdmin = false;
        String sql = "";
        sql = " select count(id) as num_admin from HrmRoleMembers where roleid in(92,94) and resourceid=" + userId;
        rs.executeSql(sql);
        if (rs.next()) {
            int num_admin = rs.getInt("num_admin");
            if (num_admin > 0) {
                isAdmin = true;
            }
        }
        String url_1 = "willOrder.jsp";
        String url_2 = "ordering.jsp";
        String url_3 = "ordered.jsp";
        String url_4 = "contacting.jsp";
        String url_5 = "willContact.jsp";
        String tmpUrl = "";
        if (isAdmin) {
            tmpUrl = url_5;
        } else {
            tmpUrl = url_1;
        }
    %>

</head>
<BODY scroll="no">

<div class="e8_box demo2">
    <div class="e8_boxhead">
        <div class="div_e8_xtree" id="div_e8_xtree"></div>
        <div class="e8_tablogo" id="e8_tablogo"
             style="margin-left: 6px; background-image: url('/js/tabs/images/nav/mnav0_wev8.png');"></div>
        <div class="e8_ultab">
            <div class="e8_navtab" id="e8_navtab">
                <span id="objName">非招投标采购管理</span>
            </div>
            <div>
                <ul class="tab_menu">
                    <%
                        if (isAdmin) {
                    %>
                    <li class="current">
                        <a target="tabcontentframe" href="<%=url_5%>">待合同<span id="allNum_span"></span></a>
                    </li>
                    <li class="">
                        <a target="tabcontentframe" href="<%=url_4%>">合同中</a>
                    </li>
                    <li class="">
                        <a target="tabcontentframe" href="<%=url_1%>">待订单</a>
                    </li>
                    <li class="">
                        <a target="tabcontentframe" href="<%=url_2%>">订单中</a>
                    </li>
                    <li class="">
                        <a target="tabcontentframe" href="<%=url_3%>">待确认/待验收</a>
                    </li>
                    <%
                    } else {
                    %>
                    <li class="current">
                        <a target="tabcontentframe" href="<%=url_1%>">待订单<span id="allNum_span"></span></a>
                    </li>
                    <li class="">
                        <a target="tabcontentframe" href="<%=url_2%>">订单中</a>
                    </li>
                    <li class="">
                        <a target="tabcontentframe" href="<%=url_3%>">待确认/待验收</a>
                    </li>
                    <%
                        }
                    %>
                </ul>
                <div id="rightBox" class="e8_rightBox">
                </div>
            </div>
        </div>
    </div>
    <div class="tab_box">
        <div>
            <iframe src="<%=tmpUrl%>" onload="update()" id="tabcontentframe" name="tabcontentframe" class="flowFrame"
                    frameborder="0" height="100%" width="100%;"></iframe>
        </div>
    </div>
</div>
</BODY>
</HTML>
