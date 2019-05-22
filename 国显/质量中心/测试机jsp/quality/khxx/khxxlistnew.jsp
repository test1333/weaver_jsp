<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ include file="/jsp/quality/systeminfo/init.jsp" %>
<jsp:include page="/jsp/quality/roles/checkRoles.jsp">
	<jsp:param name="cd" value="13" />
</jsp:include>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" type="image/x-icon" href="/static/images/favicon.ico" />
<title>CS系统</title>
<link rel="stylesheet"
	href="/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="/static/bootstrap-3.3.7-dist/css/bootstrap-theme.min.css" />
<link rel="stylesheet"
	href="/static/bootstrap-3.3.7-dist/css/bootstrap-table.min.css" />

</head>
<body>
	<table id="fytable" class="table"></table>
	<script src="/static/jquery-3.3.1/jquery-3.3.1.min.js"></script>
	<script src="/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

<script src="/static/bootstrap-3.3.7-dist/js/bootstrap-table.min.js"></script> 
<!-- 引入中文语言包 -->
<script src="/static/bootstrap-3.3.7-dist/js/bootstrap-table-zh-CN.min.js"></script> 

	<script type="text/javascript">
	//var $table;
    //初始化bootstrap-table的内容
   // function InitMainTable () {
        //记录页面bootstrap-table全局变量$table，方便应用
       // var queryUrl = '/jsp/quality/action/getfydata.jsp?type=khminnew&rnd=' + Math.random()
      $('#fytable').bootstrapTable({
            url: '/jsp/quality/action/getfydata.jsp?type=khminnew',                      //请求后台的URL（*）
            method: 'GET',                       //是否显示行间隔色
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
            sortable: true,                     //是否启用排序
            sortOrder: "desc",       
            sortName: 'id',//排序方式
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            paginationLoop: false,
            pageNumber: 1,                      //初始化加载第一页，默认第一页,并记录
            pageSize: 10,                     //每页的记录行数（*）
            pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
            search: false,                      //是否显示表格搜索
            strictSearch: false,
            showColumns: true,                  //是否显示所有的列（选择显示的列）
            showRefresh: true,                  //是否显示刷新按钮
            minimumCountColumns: 2,             //最少允许的列数
            clickToSelect: false,                //是否启用点击选中行
            //height: 500,                      //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
           // uniqueId: "id",                     //每一行的唯一标识，一般为主键列
            showToggle: false,                   //是否显示详细视图和列表视图的切换按钮
            cardView: false,                    //是否显示详细视图
            detailView: false,                  //是否显示父子表
            striped: true,
            //得到查询的参数
            queryParams : function (params) {
                //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                var temp = {   
                    rows: params.limit,                         //页面大小
                    pagestart: params.offset,   //页码
                    sort: params.sort,      //排序列名  
                    sortOrder: params.order //排位命令（desc，asc） 
                };
                return temp;
            },
            columns: [{
                checkbox: false,  
                visible: false                  //是否显示复选框  
            }, {
                field: 'infono',
                title: '信息编号',
                width: '15%',
                sortable: true
            }, {
                field: 'cus_name',
                title: '客户名称',
                width: '15%',
                sortable: true
            }, {
                field: 'infotype',
                title: '信息种类',
                width: '15%',
                sortable: true,
            }, {
                field: 'cus_des',
                width: '55%',
                title: '信息描述',
            }],
            onLoadSuccess: function () {
            },
            onLoadError: function () {
                showTips("数据加载失败！");
            },
            //onDblClickRow: function (row, $element) {
            //    var id = row.ID;
            //    EditViewById(id, 'view');
            //},
        });
	</script>

</body>
</html>