<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> <%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<HTML><HEAD>
    <script src="/js/tabs/jquery.tabs.extend_wev8.js"></script>
    <link type="text/css" href="/js/tabs/css/e8tabs1_wev8.css" rel="stylesheet" />
    <link rel="stylesheet" href="/css/ecology8/request/searchInput_wev8.css" type="text/css" />
    <script type="text/javascript" src="/js/ecology8/request/searchInput_wev8.js"></script>

    <link rel="stylesheet" href="/css/ecology8/request/seachBody_wev8.css" type="text/css" />
    <link rel="stylesheet" href="/css/ecology8/request/hoverBtn_wev8.css" type="text/css" />
    <script type="text/javascript" src="/js/ecology8/request/hoverBtn_wev8.js"></script>
    <script type="text/javascript" src="/js/ecology8/request/titleCommon_wev8.js"></script>
    <script type="text/javascript">
        $(function(){
            $('.e8_box').Tabs({
                getLine:1,
                iframe:"tabcontentframe",
                staticOnLoad:true
            });
        });
    </script>
    <%
        String dtid = Util.null2String(request.getParameter("ids"));
        String url_1 = "/xerium/choosebank/editPayBank.jsp?ids=" + dtid;
    %>
</head>
<BODY scroll="no">
<div class="e8_box demo2">
    <%--<div class="e8_boxhead">--%>
        <%--<div class="div_e8_xtree" id="div_e8_xtree"></div>--%>
        <%--<div class="e8_tablogo" id="e8_tablogo" style="margin-left: 6px; background-image: url('/js/tabs/images/nav/mnav0_wev8.png');"></div>--%>
        <%--<div class="e8_ultab">--%>
            <%--<div>--%>
                <%--&lt;%&ndash;<ul class="tab_menu">&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<li class="current">&ndash;%&gt;--%>
                        <%--&lt;%&ndash;<a target="tabcontentframe" href="<%=url_1%>">选择付款银行<span id="allNum_span"></span></a>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;</li>&ndash;%&gt;--%>
                <%--&lt;%&ndash;</ul>&ndash;%&gt;--%>

            <%--</div>--%>
        <%--</div>--%>
    <%--</div>--%>
    <div class="tab_box">
        <div>
            <%--<iframe src="<%=url_3 %>" onload="update()" id="tabcontentframe" name="tabcontentframe" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>--%>
            <iframe src="<%=url_1 %>" onload="update()" id="tabcontentframe" name="tabcontentframe" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>
            <%--<iframe src="<%=url_2 %>" onload="update()" id="tabcontentframe" name="tabcontentframe" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>--%>
        </div>
    </div>
</div>
<!--  -->
<script type="text/javascript">
    function MainCallBack(){
        var dialog = parent.dialog(window);
        var parentWin = parent.getParentWindow(window);
        parentWin.location.reload();
        dialog.closeByHand();
    }
</script>
</BODY>
</HTML>
