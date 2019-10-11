
<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<!DOCTYPE html>
<html lang="en">
<head>
<%
String dataid = Util.null2String(request.getParameter("dataid"));
%>
  <meta charset="GBK" http-equiv="X-UA-Compatible" content="IE=edge" >   
  <title>股权穿透图</title>
  <link rel="icon" href="img/logo.png">
  <link rel="stylesheet" href="css/font-awesome.min.css?v1">
  <link rel="stylesheet" href="css/jquery.orgchart.css?v=2">
  <link rel="stylesheet" href="css/style.css?v=1">
  <style type="text/css">
    #chart-container { background-color: #eee; }
    .orgchart { background: #fff; }
  </style>
</head>
<body>
  <div id="chart-container"></div>

  <script src="js/jquery.min.js"></script>
  <!-- the following reference is specific for IE -->
  <script type="text/javascript" src="js/es6-promise.auto.js"></script>
  <script type="text/javascript" src="js/html2canvas.min.js"></script>
  <script type="text/javascript" src="js/jspdf.min.js"></script>
  <script type="text/javascript" src="js/jquery.orgchart.js?v=2"></script>
  <script type="text/javascript">
    $(function() {
    var dataid = "<%=dataid%>";
     var datascource;
        $.ajax({
             type: "POST",
             url: "/gcl/company/gqctnew/getgqctlist.jsp",
             data: {'dataid':dataid},
             dataType: "json",
             async:false,
             success: function(data){
                       datascource=data;
                      }
         });
    // var datascource = {
    //   'name': 'Lao Lao',
    //   'title': 'general manager',
    //   'children': [
    //     { 'name': 'Bo Miao', 'title': 'department manager' },
    //     { 'name': 'Su Miao', 'title': 'department manager',
    //       'children': [
    //         { 'name': 'Tie Hua', 'title': 'senior engineer' },
    //         { 'name': 'Hei Hei', 'title': 'senior engineer',
    //           'children': [
    //             { 'name': 'Pang Pang', 'title': 'engineer' },
    //             { 'name': 'Xiang Xiang', 'title': 'UE engineer' }
    //           ]
    //         }
    //       ]
    //     },
    //     { 'name': 'Yu Jie', 'title': 'department manager' },
    //     { 'name': 'Yu Li', 'title': 'department manager' },
    //     { 'name': 'Hong Miao', 'title': 'department manager' },
    //     { 'name': 'Yu Wei', 'title': 'department manager' },
    //     { 'name': 'Chun Miao', 'title': 'department manager' },
    //     { 'name': 'Yu Tie', 'title': 'department manager' }
    //   ]
    // };

    $('#chart-container').orgchart({
      'data' : datascource,
      'visibleLevel': 999,
      'nodeContent': 'title',
      'exportButton': true,
      'exportFilename': '股权穿透图'
    });

  });
  </script>
  </body>
</html>
