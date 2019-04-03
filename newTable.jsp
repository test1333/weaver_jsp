<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.regex.Matcher"%>
<%@ page import="java.util.regex.Pattern"%>
<jsp:useBean id="b64" class="com.cloudstore.api.util.Util_Base64" scope="page" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="initial-scale=1.0, maximum-scale=2.0">
<meta name="description" content="">
<meta name="author" content="">
<title>查询数据</title>
<%@ include file="/cloudstore/page/style1/jspHead.jsp" %><!-- 头文件必须引入 -->
</head>
<body>
<div id="container"></div>
<%!
public static String replaceBlank(String str) {
    String dest = "";
    if (str!=null) {
        Pattern p = Pattern.compile("\\s*|\t|\r|\n");
        Matcher m = p.matcher(str);
        dest = m.replaceAll("");
    }
    return dest;
}
%>
<%
    String tFields = "h.*";
    String tFrom = "hrmresource h";
    String tWhere = "";
    String tOrder = "id";
    try {
        String sql = "select "+tFields+" from "+tFrom+" where "+tWhere+" order by "+tOrder;
        //out.print(sql); //语句进入后台前必须base64
        tFields = replaceBlank(b64.encode(tFields.getBytes()));
        tFrom = replaceBlank(b64.encode(tFrom.getBytes()));
        tWhere = replaceBlank(b64.encode(tWhere.getBytes()));
        tOrder = replaceBlank(b64.encode(tOrder.getBytes()));
    }
    catch(Exception e) {}
%>
<script>
var tableObj = {
    type:"sqlTable", //表格类型
    tableShow:true, //是否显示表格
    tableExportShow:true, //是否启用导出功能
    tableExportPageNum:0, //每页导出数量，0为全部
    sqlParams:{ //sql拼接，
        tFields:"<%=tFields%>",
        tFrom:"<%=tFrom%>",
        tWhere:"<%=tWhere%>",
        tOrder:"<%=tOrder%>"
    },
    tableFixedLeft:"id,lastname", //固定左侧，参数为字段名，多个用逗号隔开
    tableFixedRight:"folk", //固定右侧，参数为字段名，多个用逗号隔开
    tableFixedHead:300, //固定表头，设定高度
    tableThousand:"", //千分位列，参数为字段名，多个用逗号隔开
    tableCheckbox:true, //是否启用checkbox
    columns:[{
        title:"主键",
        dataIndex:"id",
        transMethod:"weaver.hrm.resource.ResourceComInfo.getLastname",
        transMethodParams:[{type:"columns",obj:"id"}]
    },{
        title:"用户名",
        dataIndex:"lastname"
    },{
        title:"生日",
        dataIndex:"birthday"
    },{
        title:"创建日期",
        dataIndex:"createdate"
    },{
        title:"最后修改日期",
        dataIndex:"lastmoddate"
    },{
        title:"地点",
        dataIndex:"nativeplace"
    },{
        title:"民族",
        dataIndex:"folk"
    }]
}
var weaTable = weaCom.initCom(
    "container", //绑定的dom节点
    "WeaTable4Dev", //调用的组件
    {tableObj:tableObj}, //动态参数
    function() { //组件初始化完毕后回调

    }
);

//1、触发excel导出（注意要在异步明细加载后调用）
function doSomething1() {
    weaTable.doExcelOutput();
}

//2、获取所有checkid（注意要在异步明细加载后调用）
function doSomething2() {
    var checkIds = weaTable.doCheckIdsGet();
}
</script>
</body>
</html>