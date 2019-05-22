
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="javax.script.ScriptEngine" %>
<%@ page import="javax.script.ScriptEngineManager" %>
<%@ page import="javax.script.ScriptException" %>
<jsp:useBean id="recordGet" class="weaver.conn.RecordSet" scope="page" />
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="SearchClause" class="weaver.search.SearchClause" scope="session" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page"/>
<jsp:useBean id="requestutil" class="weaver.workflow.request.todo.RequestUtil" scope="page" />
<html>
<head>
    <title></title>
    <style type="text/css">
        html, body {
            width: 100%;
        }

        html, div, p, body {
            margin: 0px;
            padding: 0px;
            position: relative;
            font-family:”微软雅黑”
        }

        #mainDiv {
            margin: 0px;
            width: 99.8%;
            background: url("/supplier/gb/images/logo.jpg") no-repeat;
            background-size: 100%;
            margin-top: -12px;
            z-index: 1;
            position: absolute;
            /*border:1px solid red*/;

        }

        #mainDiv .imgDiv {
            border: 1px solid hsla(0, 0%, 90%, .5);
            /* background: #bbb; */
            background-clip: padding-box;
            width: 10%;
            height: 100px;
            margin-left: 10px;
            margin-top: 10px;
        }

        #mainDiv .imgDiv img {
            width: 100%;
            height: 100%;
        }

        #mainDiv .leftDiv {
            margin-top: 10px;
            margin-left: 27%;
            width: 25%;
            border: 1px solid hsla(0, 0%, 90%, .5);
            /* background: #bbb; */
            background-clip: padding-box;
            height: 160px;
        }

        #mainDiv .leftDiv_0 {
            margin-top: 10px;
            margin-left: 27%;
            width: 25%;
            /* border:1px solid red; */
            height: 160px;
        }

        /* #mainDiv .leftDiv_1{
            height:95px;
            width:12%;

        } */
        #mainDiv .leftDiv_1 {
            height: 95px;
            width: 12%;
            background: rgba(7, 138, 169, 0.85);
        }


        #mainDiv .leftDiv_1_1 img {
            width: 100%;
            height: 100%;
        }

        #mainDiv .leftDiv_1_1 {
            margin-top: 12px;
            margin-left: 11%;
            width: 31px;
            /* border: 1px solid red; */
            height: 40px;
        }

        #mainDiv .leftDiv_1_2 {
            margin-top: -36px;
            margin-left: 37%;
            width: 89px;
            /* border: 1px solid hsla(0,0%,90%,.5); */
            /* background: #bbb; */
            /* background-clip: padding-box; */
            height: 61px;
        }

        #mainDiv .leftDiv_2 {
            margin-top: -97px;
            margin-left: 40%;
            width: 12%;
            height: 95px;

        }

        #mainDiv .rightDiv {
            margin-top: -214px;
            margin-left: 53%;
            width: 18%;
            border: 1px solid hsla(0, 0%, 90%, .5);
            /* background: #bbb; */
            background-clip: padding-box;
            height: 100px;

        }
        #mainDiv .dialogInfo{
            margin-top: -83px;
            margin-left: 46%;
            width: 12%;
            border: 1px solid hsla(0, 0%, 90%, .5);
            background: #BC0;
            background-clip: padding-box;
            height: 100px;
        }
        #mainDiv .rightDiv_1 {
            margin-top: -440px;
            background-color: rgb(15, 200, 220);
        }

        #mainDiv .rightDiv_1_1 {
            margin-top: 35px;
            margin-left: 14%;
            width: 42px;
            /* border: 1px solid hsla(0,0%,90%,.5); */
            /* background: #bbb; */
            /* background-clip: padding-box; */
            height: 40px;
        }

        #mainDiv .rightDiv_1_1 img {
            width: 100%;
            height: 100%;
        }

        #mainDiv .rightDiv_1_2 {
            margin-top: -42px;
            margin-left: 37%;
            width: 109px;
            /* border: 1px solid hsla(0,0%,90%,.5); */
            /* background: #bbb; */
            /* background-clip: padding-box; */
            height: 67px;
        }

        #mainDiv .rightDiv_2 {
            margin-top: 10px;
            background-color: rgb(69, 122, 235);

        }

        #mainDiv .rightDiv_2_2 {
            margin-top: -42px;
            margin-left: 39%;
            width: 133px;
            /* border: 1px solid red; */
            /* background-color: rgb(20,215,250); */
            height: 70px;
        }

        #mainDiv .rightDiv_3 {
            margin-top: 10px;
            background-color: rgb(235, 169, 46);
        }

        #mainDiv .rightDiv_4 {
            margin-top: 10px;
            background-color: rgba(154, 194, 11, 0.932);
        }

        .leftDiv {
            text-align: center;
            line-height: 95px;
            font-size: 30px;
            color: white;
            background: rgb(40, 161, 128);
            padding-bottom: 0px;
        }

        .leftDiv p {
            height: 10px;
            font-size: 25px;
            margin-top: -40px;
        }

        .leftDiv_0 {
            text-align: center;
            line-height: 95px;
            font-size: 30px;
            color: white;
            background: rgb(6, 156, 194);
            padding-bottom: 0px;
        }

        .leftDiv_0 p {
            height: 10px;
            font-size: 25px;
            margin-top: -40px;
        }

        .leftDiv_1_2 {
            text-align: center;
            line-height: 38px;
            font-size: 28px;
            color: white;
            /* background: rgb(40,161,128); */
            padding-bottom: 0px;
        }

        .leftDiv_1_2 p {
            height: 0px;
            font-size: 23px;
            margin-top: -7px;
        }

        .rightDiv_1_2 {
            text-align: center;
            line-height: 38px;
            font-size: 26px;
            color: white;
            /* background: rgb(40,161,128); */
            padding-bottom: 0px;
        }

        .rightDiv_1_2 p {
            height: 0px;
            font-size: 23px;
            margin-top: -7px;
        }

        .rightDiv_2_2 {
            text-align: center;
            line-height: 38px;
            font-size: 26px;
            color: white;
            /* background: rgb(40,161,128); */
            padding-bottom: 0px;
        }
        .dialogDiv li{
            height:40px;
            vertical-align:middle;
            text-align: center;
            line-height: 50px;
            font-size: 22px;
            color: white;
            /* background: rgb(40,161,128); */
            padding-bottom: 0px;
        }
        .rightDiv_2_2 p {
            height: 0px;
            font-size: 23px;
            margin-top: -7px;
        }
        a:link {
            color: rgb(255, 255, 255);
            text-decoration: none;
        }

        /* 未访问的链接 */
        a:visited {
            color: rgb(255, 255, 255);
            text-decoration: none
        }

        /* 已访问的链接 */
        a:hover {
            color: rgb(255, 255, 255);
            text-decoration: none
        }

        /* 鼠标移动到链接上 */
        a:active {
            color: rgb(255, 255, 255);
            text-decoration: none
        }
        .dialogInfoDiv{
            z-index: 999;
            margin:0px auto;
            color:red;
            width:40%;
            position: absolute;
            left:50%;
            background-color:rgb(232,232,232);
            margin-left: -21%;
            margin-top:8%;
            height:400px;
            border-radius: 10px;
            border-top-left-radius:15px;
            border-top-right-radius:15px;
            border-bottom-right-radius:15px;
            border-bottom-left-radius:15px;
        }
        .dialogInfoDiv .dialogInfo_title{
            width:100%;
            position:absolute;
            height:35px;
            background-color: rgb(248,248,248);
            font-weight:bold;
            border-top-left-radius:15px;
            border-top-right-radius:15px;
        }
        .dialogInfoDiv .dialogInfo_content{
            width:100%;
            position:absolute;
            height:365px;
            bottom: 0px;
            font-weight:bold;
            border-bottom-right-radius:15px;
            border-bottom-left-radius:15px;
            opacity: 0.4;
        }
        .dialogInfo_title .dialogInfo_title_left{
            height:35px;
            line-height: 35px;
            float:left;
            margin-left:10px;
            letter-spacing:3px;
            color:black;
        }
        .dialogInfo_title .dialogInfo_title_right{
            height:35px;
            line-height: 35px;
            float:right;
            margin-right:10px;
            color:#AAAAAA;

        }
        .dialogInfo_content .dialogInfo_content_menu{
            margin:10% auto;
            left:50%;
            /*border:1px solid red;*/
            width:50%;
            list-style-type: none;
        }
        .dialogInfo_content .dialogInfo_content_menu li{
            float:left;
            margin-left: 20px;
            /*border:1px solid red;*/
            height:80px;
            width:80px;
            border-radius: 50%;
            line-height: 80px;
            margin-top:5px;
            text-align: center;
            background-color: rgb(3,70,65);
            color:rgb(255,255,255);


        }
    </style>

</head>
<%
    String userID = ""+user.getUID();
    BaseBean log = new BaseBean();
    String type = Util.null2String(request.getParameter("type"));//type为manager表示客户经理操作，type为customer表示为客户操作
    String crmid = Util.null2String(request.getParameter("crmid"));//客户人员主键值
    String prepassword = null;//之前的密码
    String state = Util.null2String(request.getParameter("state"));//1表示为门户申请
    if(!"manager".equals(type)){
        String sql = "SELECT PortalPassword FROM CRM_CustomerInfo WHERE id ="+ userID;

        recordGet.executeSql(sql);
        recordGet.next();
        prepassword = recordGet.getString("PortalPassword");//修改之前的旧密码
    }

    int count = 0;
    String sql = "";
	//待办事宜
    sql = "select count(1) as count from workflow_requestbase t1,workflow_currentoperator t2 " +
            " where  (t1.deleted <> 1 or t1.deleted is null or t1.deleted='') and " +
            " t1.requestid = t2.requestid and t2.userid = " + userID + " and t2.usertype=1 and " +
            " (t1.deleted=0 or t1.deleted is null) and ((t2.isremark='0' and "+
            " (t2.takisremark is null or t2.takisremark=0 )) or t2.isremark in('1','5','8','9','7'))"+
            " and (t1.deleted=0 or t1.deleted is null) and t2.islasttimes=1 and"+
            " (isnull(t1.currentstatus,-1) = -1 or (isnull(t1.currentstatus,-1)=0"+
            " and t1.creater in (" + userID + ")))" ;
    rs.executeSql(sql);
    if (rs.next()) {
        count = rs.getInt("count");
    }
	//已办事宜
    int num = 0;
    sql = " select count(1) as num from workflow_requestbase t1,workflow_currentoperator t2 where"+
            " (t1.deleted <> 1 or t1.deleted is null or t1.deleted='') and t1.requestid = t2.requestid"+
            " and t2.userid = " + userID + " and t2.usertype=1 and (t1.deleted=0 or t1.deleted is null) and (t2.isremark in('2','4')"+
            " or (t2.isremark=0 and t2.takisremark =-2)) and (t1.deleted=0 or t1.deleted is null) and t2.islasttimes=1"+
            " and (isnull(t1.currentstatus,-1) = -1 or (isnull(t1.currentstatus,-1)=0 and t1.creater in (" + userID + ")))";
    rs.executeSql(sql);
    if (rs.next()) {
        num = rs.getInt("num");
    }
    int no = 0;
    String gyssql = "select  count(d.id) as no from formtable_main_250 d, workflow_requestbase c  where "+
    "d.requestid=c.requestid and c.workflowid = 229 and (d.zbj>0 or d.zbj1>0) and d.xtkh= '"+userID+"'" ;
    rs.executeSql(gyssql);
    if (rs.next()) {
        no = rs.getInt("no");
    }
	int number = 0;
	String crksql ="select count(t.id) as number from (select a.id ,a.xtkh from formtable_main_240 a,"+ 
	"workflow_requestbase b where a.requestid=b.requestid and b.workflowid = 232 and b.currentnodetype >= 3)t where t.xtkh = '"+userID+"'" ;
	rs.executeSql(crksql);
    if (rs.next()) {
        number = rs.getInt("number");
    }
%>
<body>
<div id="mainDiv">
    <div class="imgDiv">
        <img src="/supplier/gb/images/2.jpg"/>
        <input class="inputstyle" type="hidden" id="password" value=<%=prepassword%>>
    </div>
    <div class="leftDiv">
        <a href="/workflow/request/RequestView.jsp" target="_blank">待办事项</a><br/>
        <p><%=count%></p>
    </div>
    <div class="leftDiv leftDiv_0">
        <a href="/workflow/request/RequestHandled.jsp" target="_blank">已办事项</a><br/>
        <p><%=num%></p>
    </div>
    <div class="leftDiv leftDiv_1">
        <div class="leftDiv_1_1"><img src="./images/calender.png"/></div>
        <div class="leftDiv_1_2">
            <a href="/goodbaby/ztb/InfoUrl.jsp" target="_blank">招投标</a><br/>
            <p><%=no%></p>
            <!--<a href="#" target="_blank">招投标</a><br/>
            <p>0</p>-->
        </div>
    </div>
    <div class="leftDiv leftDiv_2">
        <div class="leftDiv_1_1"><img src="./images/complaint.png"/></div>
        <div class="leftDiv_1_2">
            <a href="/goodbaby/order/Orderurl.jsp" target="_blank">出入库</a><br/>
            <p><%=number%></p>
        </div>
    </div>
    <div class="rightDiv rightDiv_1">
        <div class="rightDiv_1_1"><img src="./images/note.png"/></div>
        <div class="rightDiv_1_2">
            <a href="/page/element/7/News.jsp?ebaseid=7&amp;eid=1120&amp;styleid=1515636047766&amp;hpid=14&amp;subCompanyId=8&indie=true&needHead=true" target="_blank">公&nbsp;&nbsp;&nbsp;告</a>
        </div>
    </div>
    <div class="rightDiv rightDiv_2"  id = "dialogInfo">
        <div class="rightDiv_1_1"><img src="./images/comm.png"/></div>
        <div class="rightDiv_2_2">
            <a href="#">信息维护</a>
            <%--<a href="http://10.171.53.58:8089/workflow/request/AddRequest.jsp?workflowid=206&isagent=0&beagenter=0&f_weaver_belongto_userid=" target="_blank">信息维护</a>--%>
        </div>
    </div>
    <div class="rightDiv rightDiv_3">
        <div class="rightDiv_1_1"><img src="./images/set.png"/></div>
        <div class="rightDiv_2_2">
            <a href="#">报表统计</a>
        </div>
    </div>
    <div class="rightDiv rightDiv_4">
        <div class="rightDiv_1_1"><img src="./images/logout.png"/></div>
        <div class="rightDiv_2_2" >
            <a href="/login/Logout.jsp">退&nbsp;&nbsp;&nbsp;出</a>
        </div>
    </div>
</div>
<div class="dialogInfoDiv" >
    <div class = "dialogInfo_title">
        <div class = "dialogInfo_title_left">信息维护</div>
        <div class = "dialogInfo_title_right">关闭</div>
    </div>
    <div class = "dialogInfo_content">
        <ul class = "dialogInfo_content_menu">
            <!-- http://10.171.53.58:8089/supplier/gb/ManagerUpdatePassword.jsp -->
            <li>信息修改</li>
            <li>密码修改</li>
            <li>投诉</li>
            <li>维护发票</li>
            <li>合同查询</li>
        </ul>
    </div>
</div>
<script type="text/javascript">
    autodivheight();

    function autodivheight() { //函数：获取尺寸
        //获取浏览器窗口高度
        var winHeight = 0;
        if (window.innerHeight)
            winHeight = window.innerHeight;
        else if ((document.body) && (document.body.clientHeight))
            winHeight = document.body.clientHeight;
        //通过深入Document内部对body进行检测，获取浏览器窗口高度
        if (document.documentElement && document.documentElement.clientHeight)
            document.getElementById("mainDiv").style.height = window.innerHeight - 10 + "px";
    }

    window.onresize = autodivheight; //浏览器窗口发生变化时同时变化DIV高度
    function logout() {
        top.Dialog.confirm("确定要退出系统吗？", function () {
            window.location = '/login/Logout.jsp';
        });
    }
    setTimeout(checklog(),3000);
    function checklog() {
//        alert(jQuery("#password").val());
        if(jQuery("#password").val()=="123456"){
            var con = confirm("首次登录必须修改密码");
            if(con==true){
                window.location='/supplier/gb/ManagerUpdatePassword.jsp';
            }else{
                window.location='/login/Logout.jsp';
            }
        }
    }

</script>
<script type="text/javascript" src = "./jQuery.js"></script>
<script type="text/javascript">
    jQuery(document).ready(function () {
        var dialogInfo = "#dialogInfo";//对话框
        var dialogInfoDiv = ".dialogInfoDiv";//对话框DIV
        var dialogClose = ".dialogInfo_title_right";//对话框关闭按钮
        var ul = ".dialogInfo_content_menu"//弹出页面菜单
        jQuery(dialogInfoDiv).hide();
        jQuery(dialogInfo).click(function(){//对话框弹出事件
            jQuery(dialogInfoDiv).show(500);
        })

        jQuery(dialogClose).click(function(){//对话框关闭事件
            jQuery(dialogInfoDiv).hide(200);
        });
        jQuery(".dialogInfo_content_menu li").eq(0).click(function(){
            jQuery(dialogInfoDiv).hide();
            window.open("/workflow/request/AddRequest.jsp?workflowid=206&isagent=0&beagenter=0&f_weaver_belongto_userid=");

        });
        jQuery(".dialogInfo_content_menu li").eq(1).click(function(){
            window.open("/supplier/gb/ManagerUpdatePassword.jsp");
            jQuery(dialogInfoDiv).hide();
        });
		jQuery(".dialogInfo_content_menu li").eq(3).click(function(){
            window.open("/goodbaby/whfp/PurchaseUrl.jsp");
            jQuery(dialogInfoDiv).hide();
        });

    })
</script>
</body>
</html>