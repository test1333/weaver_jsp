<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.*"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%

int formid = Util.getIntValue(request.getParameter("formid"));	
int billid = Util.getIntValue(request.getParameter("billid"));
int types = Util.getIntValue(request.getParameter("type")); 
int dqzt=-1;   
rs.executeSql(" select * from  workflow_billfield where billid ='"+formid+"'  ");
while(rs.next()){
	int fieldid=rs.getInt("id");
	String fieldname=rs.getString("fieldname");
	String detailtable=rs.getString("detailtable");
	if("dqzt".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		dqzt=fieldid;
	}
}

%>

<script type="text/javascript">
	jQuery(document).ready(function(){
		
		var type = "<%=types%>";
		if(type=="2"){
			jQuery("#disfield<%=dqzt%>").val("0");
			jQuery("#field<%=dqzt%>").val("0");
		}
		setTimeout(function(){
			var objarray=$("#rightMenuIframe").contents().find("button");
			var html=objarray[0].innerHTML;
			if(html=="提交审批"){
				objarray[0].onclick=function(){
					jQuery("#disfield<%=dqzt%>").val("1");
					jQuery("#field<%=dqzt%>").val("1");
					doSubmit(2599,1);							
				}
			}
		},1000);
		
		var lastvalue=jQuery("#_DialogBGDiv",window.parent.parent.parent.document).css("display");
		setInterval(function(){
			var _DialogBGDiv=jQuery("#_DialogBGDiv",window.parent.parent.parent.document).css("display");
			if(_DialogBGDiv!=lastvalue){
				jQuery("#disfield<%=dqzt%>").val("0");
				jQuery("#field<%=dqzt%>").val("0");
			}
			lastvalue=_DialogBGDiv;
		},50);
		
		//颜色值
		if(type=="1"||type=="0"||type=="2"){
			var color = jQuery("#disfield<%=dqzt%>").val();
			if(color == "0"){		
				jQuery("#disfield<%=dqzt%>").attr("style","color:red");
			}else{
				jQuery("#disfield<%=dqzt%>").attr("style","color:blue");
			}
		}
		//颜色值
	})
</script>
