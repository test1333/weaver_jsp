<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import="com.javen.Util.Util"%>
<%@ include file="/jsp/quality/systeminfo/init.jsp" %>
<jsp:include page="/jsp/quality/roles/checkRoles.jsp">
	<jsp:param name="cd" value="3" />
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
<style type="text/css">

	
	
</style>
</head>
<%
String queryCondition = Util.null2String(request.getParameter("queryCondition"));

queryCondition = URLEncoder.encode(queryCondition,"UTF-8");
%>
<body>
		<div class="table-responsive">
		<table id="fytable" class="table text-nowrap" style="word-break:break-all; word-wrap:break-word;font-size:12px;">
		
		</table>
		</div>
	
	<script src="/static/jquery-3.3.1/jquery-3.3.1.min.js"></script>
	<script src="/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

<script src="/static/bootstrap-3.3.7-dist/js/bootstrap-table.min.js"></script> 
<!-- 引入中文语言包 -->
<script src="/static/bootstrap-3.3.7-dist/js/bootstrap-table-zh-CN.min.js"></script> 
<script src="/static/bootstrap-3.3.7-dist/js/bootstrap-table-export.js"></script> 
<script src="/static/bootstrap-3.3.7-dist/js/tableExport.js"></script> 
<script src="/static/bootstrap-3.3.7-dist/js/xlsx.core.min.js"></script> 
<script src="/static/bootstrap-3.3.7-dist/js/FileSaver.min.js"></script> 

	<script type="text/javascript">
	var queryCondition = "<%=queryCondition%>";
	//var $table;
    //初始化bootstrap-table的内容
   // function InitMainTable () {
        //记录页面bootstrap-table全局变量$table，方便应用
       // var queryUrl = '/jsp/quality/action/getfydata.jsp?type=khminnew&rnd=' + Math.random()
      $('#fytable').bootstrapTable({
            url: '/jsp/quality/action/getfydata.jsp?type=ksfy&queryCondition='+queryCondition,//请求后台的URL（*）
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
            showExport: true,                     //是否显示导出
            exportDataType: "all", 
            exportTypes:['xlsx'],
            exportOptions:{  
                //ignoreColumn: [0,0],            //忽略某一列的索引  
                fileName: '数据导出',              //文件名称设置  
                worksheetName: 'Sheet1',          //表格工作区名称  
                tableName: '商品数据表',  
                excelstyles: ['background-color', 'color', 'font-size', 'font-weight'],  
                //onMsoNumberFormat: DoOnMsoNumberFormat  
            },
            queryParams : function (params) {
                //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                var temp = {   
                    rows: params.limit,                         //页面大小
                    pagestart: params.offset,   //页码
                    sort: params.sort,      //排序列名  
                    sortOrder: params.order, //排位命令（desc，asc） 
                };
                return temp;
            },
            columns: [[{
				title: '序号',
				field: 'xh',
				width:50,
				align: 'center',
				valign: 'middle',
				colspan: 1,
				rowspan: 2
			},{
				title: '客诉编号',
				field: 'ksbh',
				align: 'center',
				valign: 'middle',
				width:100,
				colspan: 1,
				rowspan: 2
			},{
				title: '申请人',
				field: 'sqr',
				align: 'center',
				valign: 'middle',
				width:100,
				colspan: 1,
				rowspan: 2
			},{
				title: '顾客信息',
				field: '',
				align: 'center',
				valign: 'middle',
				width:600,
				colspan: 3
			},{
				title: '抱怨信息',
				field: '',
				align: 'center',
				valign: 'middle',
				width:1300,
				colspan: 13
			},{
				title: '客服基本调查',
				field: '',
				align: 'center',
				valign: 'middle',
				width:900,
				colspan: 9
			},{
				title: '客服处理过程记录',
				field: '',
				align: 'center',
				valign: 'middle',
				width:400,
				colspan: 4
			},{
				title: '紧急处理措施',
				field: '',
				align: 'center',
				valign: 'middle',
				width:200,
				colspan: 2
			},{
				title: '分析并验证根因',
				field: '',
				align: 'center',
				valign: 'middle',
				width:400,
				colspan: 4
			},{
				title: '制定\执行、验证纠正和预防措施',
				field: '',
				align: 'center',
				valign: 'middle',
				width:300,
				colspan: 3
			},{
				title: '标准化',
				field: '',
				align: 'center',
				valign: 'middle',
				width:200,
				colspan: 2
			},{
				title: '是否涉及QIT',
				field: 'sfsjQIT',
				align: 'center',
				valign: 'middle',
				width:100,
				colspan: 1,
				rowspan: 2
			},{
				title: 'QIT是否结案',
				field: 'QITsfja',
				align: 'center',
				valign: 'middle',
				width:100,
				colspan: 1,
				rowspan: 2
			},{
				title: '责任部门/责任人',
				field: 'zrr',
				align: 'center',
				valign: 'middle',
				width:150,
				colspan: 1,
				rowspan: 2
			},{
				title: '相同客诉累计<br/>发生次数<br/>(预警邮件)',
				field: 'fscs',
				align: 'center',
				valign: 'middle',
				width:150,
				colspan: 1,
				rowspan: 2
			},{
				title: '结案日期',
				field: 'jarq',
				align: 'center',
				valign: 'middle',
				width:100,
				colspan: 1,
				rowspan: 2
			},{
				title: '是否结案',
				field: 'sfja',
				align: 'center',
				valign: 'middle',
				width:100,
				colspan: 1,
				rowspan: 2
			},{
				title: '8D报告',
				field: 'bgsc8d',
				align: 'center',
				valign: 'middle',
				width:100,
				colspan: 1,
				rowspan: 2
			}],[{
				title: '顾客名称',
				field: 'khmc',
				align: 'center',
				width:100,
				valign: 'middle'
			},{
				title: '抱怨人/抱怨部门/电话/邮箱',
				field: 'byrinfo',
				align: 'center',
				width:400,
				valign: 'middle'
			},{
				title: '抱怨日期',
				field: 'bysj',
				align: 'center',
				width:100,
				valign: 'middle'
			},{
				title: '抱怨种类',
				field: 'by_byzl',
				align: 'center',
				width:100,
				valign: 'middle'
			},{
				title: '严重度',
				field: 'by_yzd',
				align: 'center',
				width:100,
				valign: 'middle'
			},{
				title: '不良名称',
				field: 'blmc',
				align: 'center',
				width:100,
				valign: 'middle'
			},{
				title: '产品名称',
				field: 'by_cpmc',
				align: 'center',
				width:100,
				valign: 'middle'
			},{
				title: '产品型号',
				field: 'by_cpxh',
				align: 'center',
				width:100,
				valign: 'middle'
			},{
				title: '不良率',
				field: 'bll',
				align: 'center',
				width:100,
				valign: 'middle'
			},{
				title: '缺口数量',
				field: 'by_qksl',
				align: 'center',
				width:100,
				valign: 'middle'
			},{
				title: '计划交期',
				field: 'by_jhjq',
				align: 'center',
				width:100,
				valign: 'middle'
			},{
				title: '实际交期',
				field: 'by_sjjq',
				align: 'center',
				width:100,
				valign: 'middle'
			},{
				title: '延期影响',
				field: 'by_yqyx',
				align: 'center',
				width:100,
				valign: 'middle'
			},{
				title: '问题描述',
				field: 'by_wtms',
				align: 'center',
				width:100,
				valign: 'middle'
			},{
				title: '客户诉求',
				field: 'by_khsq',
				align: 'center',
				width:100,
				valign: 'middle'
			},{
				title: '不良照片或其它资料',
				field: 'by_blzp',
				align: 'center',
				width:100,
				valign: 'middle'
			},{
				title: '处理日期',
				field: 'clrq',
				align: 'center',
				width:100,
				valign: 'middle'
			},{
				title: '产品名称',
				field: 'kfcpmc',
				align: 'center',
				width:100,
				valign: 'middle'
			},{
				title: '产品型号',
				field: 'kfcpxh',
				align: 'center',
				width:100,
				valign: 'middle'
			},{
				title: '发生地点',
				field: 'blfszd',
				align: 'center',
				width:100,
				valign: 'middle'
			},{
				title: '产品状态',
				field: 'cpzt',
				align: 'center',
				width:100,
				valign: 'middle'
			},{
				title: '产品阶段',
				field: 'cpjd',
				align: 'center',
				width:100,
				valign: 'middle'
			},{
				title: '生产厂区',
				field: 'proarea',
				align: 'center',
				width:100,
				valign: 'middle'
			},{
				title: '硬屏/柔性屏',
				field: 'yprxp',
				align: 'center',
				width:100,
				valign: 'middle'
			},{
				title: '责任判定',
				field: 'zrpd',
				align: 'center',
				width:100,
				valign: 'middle'
			},{
				title: '客诉处理过程记录',
				field: 'khjl',
				align: 'left',
				width:100,
				valign: 'middle'
			},{
				title: '阶段/耗时',
				field: 'jd',
				align: 'center',
				width:100,
				valign: 'middle'
			},{
				title: '预警次数',
				field: 'yjcs',
				align: 'center',
				width:100,
				valign: 'middle'
			},{
				title: '累计延期',
				field: 'ljyq',
				align: 'center',
				width:100,
				valign: 'middle'
			},{
				title: '紧急处理措施',
				field: 'jjclcs',
				align: 'center',
				width:100,
				valign: 'middle'
			},{
				title: '附件',
				field: 'jjclcsfj',
				align: 'center',
				width:100,
				valign: 'middle'
			},{
				title: '根因调查分析',
				field: 'fxbyzwtgy',
				align: 'center',
				width:100,
				valign: 'middle'
			},{
				title: '流出原因分析',
				field: 'lcyyfx',
				align: 'center',
				width:100,
				valign: 'middle'
			},{
				title: '附件',
				field: 'fxbyzwtgyfj',
				align: 'center',
				width:100,
				valign: 'middle'
			},{
				title: '责任判定',
				field: 'zrpd',
				align: 'center',
				width:100,
				valign: 'middle'
			},{
				title: '产生根因纬度',
				field: 'csgywd',
				align: 'center',
				width:100,
				valign: 'middle'
			},{
				title: '流出原因纬度',
				field: 'lcgywd',
				align: 'center',
				width:100,
				valign: 'middle'
			},{
				title: '附件',
				field: 'bgfj',
				align: 'center',
				width:100,
				valign: 'middle'
			},{
				title: '标准化',
				field: 'bzh',
				align: 'center',
				width:100,
				valign: 'middle'
			},{
				title: '附件',
				field: 'bzhfj',
				align: 'center',
				width:100,
				valign: 'middle'
			}]],
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