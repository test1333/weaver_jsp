<%@page import="weaver.general.TimeUtil"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.conn.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> 

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<HTML><HEAD>



</head>
 <script type="text/javascript"> 
 function dcy(){ 
var dcyurl = document.getElementById("i"); 
dcyurl.src = "/gcl/doc/doc-cy-undo-list.jsp"; 
} 
function ycy(){ 
var dcyurl = document.getElementById("i"); 
dcyurl.src = "/gcl/doc/doc-cy-do-list.jsp"; 
} 
</script> 
<style type="text/css"> 
#i{ 
width:100%; 
height:90%;
scrolling:auto;
} 
 $(document.body).css({
   "overflow-y":"hidden";
   "overflow-x":"hidden";
 });
</style> 
</head> 

<body> 
<%--style="background-color: #7ED321;width: 76px;height: 36px;color: #FFFFFF">
                �½�
            </button>
--%>
<div> 
&nbsp;&nbsp;<input type = "button" style="background-color:#CAE8EA" value ="�����Ĺ���" onclick = "dcy()"/>
<input type = "button" style="background-color:#CAE8EA" value ="�Ѵ��Ĺ���" onclick = "ycy()"/>
</div> 
<iframe id = "i" scrolling = "auto" style="overflow-x:hidden; overflow-y:auto;" frameborder="no" border="0" marginwidth="0" marginheight="0" src="/gcl/doc/doc-cy-undo-list.jsp"> 
</iframe> 
</body> 
</HTML>

