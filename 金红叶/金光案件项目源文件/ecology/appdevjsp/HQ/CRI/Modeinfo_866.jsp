<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.*"%>
<%@ page import="weaver.hrm.User"%>
<%@ page import="weaver.hrm.HrmUserVarify"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%

User usertemp = HrmUserVarify.getUser(request,response) ;
int userid=usertemp.getUID();
String dczj = "";
rs.executeSql(" select * from hrmroles t1,hrmrolemembers t2 where t1.id = t2.roleid and t1.id='622' and t2.resourceid = '"+userid+"' ");
if(rs.next()){
	dczj="1";
}else{
	dczj="0";
}

int formid = Util.getIntValue(request.getParameter("formid"));	
int billid = Util.getIntValue(request.getParameter("billid"));
int types = Util.getIntValue(request.getParameter("type")); 
int dqzt=-1;   
int ttrzj=-1;
int zt=-1;
int bb=-1;
rs.executeSql(" select * from  workflow_billfield where billid ='"+formid+"'  ");
while(rs.next()){
	int fieldid=rs.getInt("id");
	String fieldname=rs.getString("fieldname");
	String detailtable=rs.getString("detailtable");
	if("dqzt".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		dqzt=fieldid;
	}else if("ttrzj".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		ttrzj=fieldid;
	}else if("zt".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		zt=fieldid;
	}else if("bb".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		bb=fieldid;
	}
}

%>

<script type="text/javascript">
	jQuery(document).ready(function(){
		var type = "<%=types%>";
		var dczj = "<%=dczj%>";
		if(type=="0"){
			if(dczj=="1"){
				jQuery("#field<%=ttrzj%>").val("1");
			}else{
				jQuery("#field<%=ttrzj%>").val("0");
			}
			jQuery("#disfield<%=zt%>").hide();   //隐藏调查报告状态
			
			var bbval = jQuery("#disfield<%=bb%>").val();
			if(bbval=="0"){
				jQuery("#table2").hide();
				jQuery("#table3").hide();
				jQuery("#table4").hide();
				jQuery("#table5").hide();
				jQuery("#table6").hide();
				jQuery("#table7").hide();
				jQuery("#table8").hide();
				jQuery("#table9").hide();
				jQuery("#table0button").hide();
				jQuery("#table1button").hide();
				jQuery("#fj").hide();
			}else{
				jQuery("#table0button").show();
				jQuery("#table1button").show();
				jQuery("#fj").show();
				jQuery("#table2").show();
				jQuery("#table3").show();
				jQuery("#table4").show();
				jQuery("#table5").show();
				jQuery("#table6").show();
				jQuery("#table7").show();
				jQuery("#table8").show();
				jQuery("#table9").show(); 
			}
		}else if(type=="2"){
			jQuery("#disfield<%=dqzt%>").val("0");
			jQuery("#field<%=dqzt%>").val("0");
			if(dczj=="1"){
				jQuery("#field<%=ttrzj%>").val("1");
				jQuery("#field<%=ttrzj%>span").val("1");
			}else{
				jQuery("#field<%=ttrzj%>").val("0");
			}
			jQuery("#disfield<%=zt%>").hide();
			To_CheckBB();
		}else{
			//版本选择
			jQuery("#field<%=bb%>").unbind("change");
			jQuery("#field<%=bb%>").bind("change", function(){
				To_CheckBB();
			})
			
			var bbval = jQuery("#field<%=bb%>").val();
			if(bbval!=""){
				To_CheckBB();
			}
		}
		setTimeout(function(){
			var objarray=$("#rightMenuIframe").contents().find("button");
			var html=objarray[0].innerHTML;
			if(html=="提交审批"){
				objarray[0].onclick=function(){
					jQuery("#disfield<%=dqzt%>").val("1");
					jQuery("#field<%=dqzt%>").val("1");
					doSubmit(2511,1);							
				}
			}
		},1000)	;
		
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
	
	function To_CheckBB(){
		var bbval = jQuery("#field<%=bb%>").val();
		if(bbval=="1"){
			jQuery("#table0button").show();
			jQuery("#table1button").show();
			jQuery("#fj").show();
			jQuery("#table2").show();
			jQuery("#table3").show();
			jQuery("#table4").show();
			jQuery("#table5").show();
			jQuery("#table6").show();
			jQuery("#table7").show();
			jQuery("#table8").show();
			jQuery("#table9").show();
		}else{
			jQuery("#table2").hide();
			jQuery("#table3").hide();
			jQuery("#table4").hide();
			jQuery("#table5").hide();
			jQuery("#table6").hide();
			jQuery("#table7").hide();
			jQuery("#table8").hide();
			jQuery("#table9").hide();
			jQuery("#table0button").hide();
			jQuery("#table1button").hide();
			jQuery("#fj").hide();
		}
	}
	
</script>
