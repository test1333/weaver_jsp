
<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>jOrgChart�첽����</title>
     <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <link rel="stylesheet" href="css/jquery.jOrgChart.css"/>
    <link rel="stylesheet" href="css/custom.css"/>
    <link href="css/prettify.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="prettify.js"></script>
    <script type="text/javascript" src="jquery.min.js"></script>
    <script type="text/javascript" src="jquery-ui.min.js"></script>
    <script src="jquery.jOrgChart.js"></script>
    <style>
        a {
            text-decoration: none;
            color: #fff;
            font-size: 12px;
        }
        .jOrgChart .node {
            width: 120px;
            height: 50px;
            line-height: 50px;
            border-radius: 4px;
            margin: 0 8px;
        }
    </style>
</head>
<body>
<!--��ʾ��֯�ܹ�ͼ-->
<div id='jOrgChart'></div>


<script type='text/javascript'>
    $(function(){
        //���ݷ���
        alert("123");
        $.ajax({
            url: "test.json",
            type: 'GET',
            dataType: 'JSON',
            data: {action: 'org_select'},
            success: function(result){
                var showlist = $("<ul id='org' style='display:none'></ul>");
                showall(result.data, showlist);
                $("#jOrgChart").append(showlist);
                $("#org").jOrgChart( {
                    chartElement : '#jOrgChart',//ָ����ĳ��dom����jorgchart
                    dragAndDrop : false //�����Ƿ���϶�
                });

            }
        });
    });

    function showall(menu_list, parent) {
        $.each(menu_list, function(index, val) {
            if(val.childrens.length > 0){

                var li = $("<li></li>");
                li.append("<a href='javascript:void(0)' onclick=getOrgId("+val.id+");>"+val.name+"</a>").append("<ul></ul>").appendTo(parent);
                //�ݹ���ʾ
                showall(val.childrens, $(li).children().eq(1));
            }else{
                $("<li></li>").append("<a href='javascript:void(0)' onclick=getOrgId("+val.id+");>"+val.name+"</a>").appendTo(parent);
            }
        });

    }

</script>
</body>
</html>

