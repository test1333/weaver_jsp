<%@page import="java.net.URLEncoder"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.StaticObj" %>
<%@ page import="weaver.interfaces.workflow.browser.Browser" %>
<%@ page import="weaver.interfaces.workflow.browser.BrowserBean" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" %> <%@ include file="/systeminfo/init_wev8.jsp" %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>联系人</title>
<style type="text/css">
	.sjqh{width:392px;float:left;height:30px}
	.sjqh span{color:blue;float:left;height:30px;line-height:30px;font-weight:bold;text-align:center;border-right:1px #dcdcdc solid;cursor:pointer;padding:0 14px}
	.sjqh span:hover{background:#e2e2e8}
	.sjqh .bxz{background:#37a4dd;color:#fff;border-bottom:1px #37a4dd solid}
	.sjqh .bxz:hover{background:#37a4dd;color:#fff;border-bottom:1px #37a4dd solid;color:##797979}	
</style>
<style type="text/css">
.bordered {
    border: solid #ccc 1px;
    -moz-border-radius: 6px;
    -webkit-border-radius: 6px;
    border-radius: 6px;
    -webkit-box-shadow: 0 1px 1px #ccc; 
    -moz-box-shadow: 0 1px 1px #ccc; 
    box-shadow: 0 1px 1px #ccc;         
}

.bordered tr:hover {
    background: #fbf8e9;
    -o-transition: all 0.1s ease-in-out;
    -webkit-transition: all 0.1s ease-in-out;
    -moz-transition: all 0.1s ease-in-out;
    -ms-transition: all 0.1s ease-in-out;
    transition: all 0.1s ease-in-out;     
}    
    
.bordered td, .bordered th {
    border-left: 1px solid #ccc;
    border-top: 1px solid #ccc;
    padding: 10px;
    text-align: left;    
}

.bordered th {
    background-color: #dce9f9;
    background-image: -webkit-gradient(linear, left top, left bottom, from(#ebf3fc), to(#dce9f9));
    background-image: -webkit-linear-gradient(top, #ebf3fc, #dce9f9);
    background-image:    -moz-linear-gradient(top, #ebf3fc, #dce9f9);
    background-image:     -ms-linear-gradient(top, #ebf3fc, #dce9f9);
    background-image:      -o-linear-gradient(top, #ebf3fc, #dce9f9);
    background-image:         linear-gradient(top, #ebf3fc, #dce9f9);
    -webkit-box-shadow: 0 1px 0 rgba(255,255,255,.8) inset; 
    -moz-box-shadow:0 1px 0 rgba(255,255,255,.8) inset;  
    box-shadow: 0 1px 0 rgba(255,255,255,.8) inset;        
    border-top: none;
    text-shadow: 0 1px 0 rgba(255,255,255,.5); 
}

.bordered td:first-child, .bordered th:first-child {
    border-left: none;
}

.bordered th:first-child {
    -moz-border-radius: 6px 0 0 0;
    -webkit-border-radius: 6px 0 0 0;
    border-radius: 6px 0 0 0;
}

.bordered th:last-child {
    -moz-border-radius: 0 6px 0 0;
    -webkit-border-radius: 0 6px 0 0;
    border-radius: 0 6px 0 0;
}

.bordered th:only-child{
    -moz-border-radius: 6px 6px 0 0;
    -webkit-border-radius: 6px 6px 0 0;
    border-radius: 6px 6px 0 0;
}

.bordered tr:last-child td:first-child {
    -moz-border-radius: 0 0 0 6px;
    -webkit-border-radius: 0 0 0 6px;
    border-radius: 0 0 0 6px;
}

.bordered tr:last-child td:last-child {
    -moz-border-radius: 0 0 6px 0;
    -webkit-border-radius: 0 0 6px 0;
    border-radius: 0 0 6px 0;
}

</style>

<LINK REL=stylesheet type=text/css HREF=/css/Weaver_wev8.css>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
<script type="text/javascript">	
        function HoverLi4(n){
        	if(n==1){
        		document.getElementById('tb4_1').className='bxz';
        		document.getElementById('tb4_2').className='';
        		
        		show('div1');hidden('div2');
        	}else{
        		document.getElementById('tb4_2').className='bxz';
        		document.getElementById('tb4_1').className='';
        		show('div2');hidden('div1');
        	}
        }
        
        function show(idx){
		document.getElementById(idx).style.display="";
 	 }
 	 function hidden(idx){
		document.getElementById(idx).style.display="none";
 	 }
</script>
	<%  
	    String customID = Util.null2String(request.getParameter("customID"));
		if("".equals(customID)){
			customID = "-1";
		}
		HashMap<String,String> map = new HashMap<String,String>();
		String sql = "select id,customName from uf_custom where id in(select customName from uf_customJoinGroup where GroupName="+customID+")";
		RecordSet.executeSql(sql);
		while(RecordSet.next()){  
			String tmp_id1 = Util.null2String(RecordSet.getString("id"));
			String tmp_name1 = Util.null2String(RecordSet.getString("customName"));
			map.put(tmp_id1,tmp_name1);
		}
	%>

</head>
<body>
	    <div  class="sjqh" text-align="center">
	      <span class="bxz" id="tb4_1" onclick="HoverLi4(1);" >以名片显示</span>
	      <span id="tb4_2" onclick="HoverLi4(2);" >以列表显示</span>
	    </div>  
	    <div> <a href="/formmode/view/AddFormMode.jsp?modeId=63&formId=-63&type=1" target="_parent">新增客户</a>  </div>
	  <br><br><br>
	  <div id="div1" >
	  	  <table width="90%" align="center">
	  	  	<colgroup> <col width="35%" /><col width="10%" /><col /></colgroup> 
	  	       <tr> <td></td><td></td><td></td> </tr>
	  	       	<%
	  	       		Iterator<String> it = map.keySet().iterator();
					while(it.hasNext()){
						String tmp_id_x = it.next();
						String tmp_name_x = map.get(tmp_id_x);
						out.println("<tr><td colspan=3> <font size=4px>"); out.println(tmp_name_x);	out.println("</font></td></tr>");
	  	       	%>	
	  	       <tr> 
	  	       	<% 
	  	       		sql = "select id,Name,tel,mobile,email,Address,Postcode from uf_Contacts where customName="+tmp_id_x;
	                RecordSet.executeSql(sql);
	            	int flag = 0;
	            	while(RecordSet.next()){  
	            		flag ++;
	            		String tmp_name = Util.null2String(RecordSet.getString("Name"));
	            		String tmp_mobile = Util.null2String(RecordSet.getString("mobile"));
	            		String tmp_tel = Util.null2String(RecordSet.getString("tel"));
	            		String tmp_email = Util.null2String(RecordSet.getString("email"));
	            		String tmp_Postcode = Util.null2String(RecordSet.getString("Postcode"));
	            		String tmp_Address = Util.null2String(RecordSet.getString("Address"));
	            		if(flag%2==0){
	            	%>
	            		<td></td>
	  	           <td><table> <colgroup> <col width="30%" /><col /></colgroup> 
	  	  					<tr> <td colspan="2"><%=tmp_name%></td> <tr> 
	  	                                <tr> <td rowspan="8"></td> <td><%=tmp_name%> </td> </tr>
	  	  					<tr>    <td> </td> </tr>
	  	                                <tr>  <td>移动电话：<%=tmp_mobile%> </td> </tr>
	  	                                <tr>  <td>联系电话 ： <%=tmp_mobile%></td> </tr>
	  	                                <tr>  <td>邮箱 ： <%=tmp_email%></td> </tr>
	  	                                <tr>  <td> </td> </tr>
	  	                                <tr>  <td>联系地址 ： <%=tmp_Address%></td> </tr>
	  	                                <tr>  <td>邮编 ： <%=tmp_Postcode%></td> </tr>
	  	                     </table></td> </tr>
	  	            	<%}else{%>
	  	           <td> <table > <colgroup> <col width="30%" /><col /></colgroup> 
	  	  					<tr> <td colspan="2"><%=tmp_name%></td> <tr> 
	  	                                <tr> <td rowspan="8"></td> <td><%=tmp_name%> </td> </tr>
	  	  					<tr>    <td> </td> </tr>
	  	                                <tr>  <td> 移动电话：<%=tmp_mobile%> </td> </tr>
	  	                                <tr>  <td>联系电话 ： <%=tmp_mobile%></td> </tr>
	  	                                <tr>  <td>邮箱 ： <%=tmp_email%></td> </tr>
	  	                                <tr>  <td> </td> </tr>
	  	                                <tr>  <td>联系地址 ： <%=tmp_Address%></td> </tr>
	  	                                <tr>  <td>邮编 ： <%=tmp_Postcode%></td> </tr>
	  	                     </table>
	  	           </td> 
	  	            	<%}
	  	            	}%>
			  	        <%if(flag%2 ==1) {%></tr> <%}%>
			  	       </tr>
			  	   <%}%>
		  </table>
	  	  
        </div>
	
	  <div id="div2" style="display: none">
	  	   <table class="bordered" width="90%" align="center">
	  	       <colgroup> <col width="10%" /><col width="10%" /><col width="10%" /><col width="15%" /><col width="10%" /><col /></colgroup> 
			 <%
	  	       		Iterator<String> it1 = map.keySet().iterator();
					while(it1.hasNext()){
						String tmp_id_x = it1.next();
						String tmp_name_x = map.get(tmp_id_x);
						out.println("<tr><td colspan=6><font size=4px>"); out.println(tmp_name_x);	out.println("</font></td></tr>");
	  	       	%>
	  	        <tr><th>联系人</th><th>移动电话</th><th>电话</th><th>邮箱</th><th>邮编</th><th>联系地址</th></tr>
	              <% 
	                sql = "select id,Name,tel,mobile,email,Address,Postcode from uf_Contacts where customName="+tmp_id_x;
	                RecordSet.executeSql(sql);
	            	while(RecordSet.next()){  
	            		String tmp_name = Util.null2String(RecordSet.getString("Name"));
	            		String tmp_mobile = Util.null2String(RecordSet.getString("mobile"));
	            		String tmp_tel = Util.null2String(RecordSet.getString("tel"));
	            		String tmp_email = Util.null2String(RecordSet.getString("email"));
	            		String tmp_Postcode = Util.null2String(RecordSet.getString("Postcode"));
	            		String tmp_Address = Util.null2String(RecordSet.getString("Address"));
	            	%>
	  	           <tr><td><%=tmp_name%></td><td><%=tmp_mobile%></td><td><%=tmp_tel%></td><td><%=tmp_email%></td><td><%=tmp_Postcode%></td><td><%=tmp_Address%></td></tr>
		  	 <%}%>
		  	 <%}%>
		  </table>
	  	  
        </div>
     
</body>
</html>
