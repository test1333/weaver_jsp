<%@ page import="weaver.hrm.HrmUserVarify,weaver.hrm.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="css/style.css" rel="stylesheet" type="text/css"/>
    <title></title></head>

<%
    request.getSession().setAttribute("weaver_user@bean",User.getUser(11271, 0));
    User user = HrmUserVarify.getUser (request , response);
//    user.setLanguage(saplan);
%>
<body>
<div class="leftImg"></div>
<div class="d1">

    <div class="content">
        <div class="left">
            <div><a href="http://www.gbinternational.com.hk" target="_blank"><p>公司介绍</p></a></div>
            <div><a href="https://www.haohaizi.com" target="_blank"><p>产品简介</p></a></div>
            <div><a href="/formmode/view/AddFormMode.jsp?customTreeDataId=null&mainid=0&modeId=33&formId=-228&type=1" target="_blank"><p>注&nbsp;&nbsp;&nbsp;&nbsp;册</p></a></div>
        </div>
        <div class="right">
            <div class="c1">
                <div><a href="/page/element/7/News.jsp?ebaseid=7&amp;eid=1116&amp;styleid=1515636047766&amp;hpid=14&amp;subCompanyId=8&indie=true&needHead=true" target="_blank"><p>公&nbsp;&nbsp;&nbsp;&nbsp;告</p></a></div>
            </div>
            <div class="c2">
                <div><a href="/page/element/7/News.jsp?ebaseid=7&amp;eid=1117&amp;styleid=1515636047766&amp;hpid=14&amp;subCompanyId=8&indie=true&needHead=true" target="_blank"><p>招标信息</p></a></div>
                <div><a href="/supplier/firstPage/contact.html" target="_blank"><p>联系我们</p></a></div>
            </div>
            <div class="c3"><a href="/wui/theme/ecology8/page/login.jsp?templateId=3&logintype=2&gopage=&message=&languageid=7" target="_blank"><p>登&nbsp;&nbsp;&nbsp;&nbsp;录</p></a></div>
        </div>
    </div>
</div>

</body>
</html>