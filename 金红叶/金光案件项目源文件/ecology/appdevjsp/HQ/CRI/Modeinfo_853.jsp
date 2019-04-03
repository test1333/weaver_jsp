<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.*"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%

int formid = Util.getIntValue(request.getParameter("formid"));	
int billid = Util.getIntValue(request.getParameter("billid"));
int types = Util.getIntValue(request.getParameter("type")); 
int dqzt=-1;   
int xmbh=-1;
int hmd=-1;
int jhmd=-1;
int gshmd=-1;
rs.executeSql(" select * from  workflow_billfield where billid ='"+formid+"'  ");
while(rs.next()){
	int fieldid=rs.getInt("id");
	String fieldname=rs.getString("fieldname");
	String detailtable=rs.getString("detailtable");
	if("dqzt".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		dqzt=fieldid;
	}else if("xmbh".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		xmbh=fieldid;
	}else if("hmd".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		hmd=fieldid;
	}else if("jhmd".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		jhmd=fieldid;
	}else if("gshmd".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		gshmd=fieldid;
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
					doSubmit(2445,1);
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
		
		
		//黑名单赋值
		var xmbh = jQuery("#field<%=xmbh%>").val();
		jQuery.get("/appdevjsp/HQ/CRI/Ajax_Modeinfo_853.jsp?time=" + new Date(),{opt:'getHDM',xmbh:xmbh},function(result){
			var jbr = result.dyjbr;        //对应举报人
			var jbrxm = result.jbrxm; 
			var dyjbdx = result.dybjbdx;   //对应举报对象
			var dyjbdxxm = result.jbdxxm;
			var dyzr = result.dyzr;        //对应证人
			var dyzrxm = result.dyzrxm;   
			var xydx = result.xydx;        //嫌疑对象
			var xydxxm = result.xydxxm;   
			var zr = result.zr;            //证人 
			var zrxm = result.zrxm;
			var html1 = "";
			var html2 = "";
			var html3 = "";
			var html4 = "";
			var html5 = "";
			var v1 = "";
			var v2 = "";
			var v3 = "";
			var v4 = "";
			var v5 = "";
			if(jbrxm!=""){
				v1 = jbr+",";
				html1 = "<span class='e8_showNameClass'><a title='"+jbrxm+"'>"+jbrxm+"</a>&nbsp;<span class='e8_delClass' id='"+jbr+"' onclick='del(event,this,1,false,{});' style='opacity: 1; visibility: hidden;'>&nbsp;x&nbsp;</span></span>";
			}
			if(dyjbdxxm!=""){
				v2 = dyjbdx+",";
				html2 = "<span class='e8_showNameClass'><a title='"+dyjbdxxm+"'>"+dyjbdxxm+"</a>&nbsp;<span class='e8_delClass' id='"+dyjbdx+"' onclick='del(event,this,1,false,{});' style='opacity: 1; visibility: hidden;'>&nbsp;x&nbsp;</span></span>";
			}
			if(dyzrxm!=""){
				v3 = dyzr+",";
				html3 = "<span class='e8_showNameClass'><a title='"+dyzrxm+"'>"+dyzrxm+"</a>&nbsp;<span class='e8_delClass' id='"+dyzr+"' onclick='del(event,this,1,false,{});' style='opacity: 1; visibility: hidden;'>&nbsp;x&nbsp;</span></span>";
			}
			if(xydxxm!=""){
				v4 = xydx + ",";
				html4 = "<span class='e8_showNameClass'><a title='"+xydxxm+"'>"+xydxxm+"</a>&nbsp;<span class='e8_delClass' id='"+xydx+"' onclick='del(event,this,1,false,{});' style='opacity: 1; visibility: hidden;'>&nbsp;x&nbsp;</span></span>";
			}
			if(zrxm!=""){
				v5 = zr + ",";
				html5 = "<span class='e8_showNameClass'><a title='"+zrxm+"'>"+zrxm+"</a>&nbsp;<span class='e8_delClass' id='"+zr+"' onclick='del(event,this,1,false,{});' style='opacity: 1; visibility: hidden;'>&nbsp;x&nbsp;</span></span>";
			}
			
			var grhmd = v1 + v2 + v3 + v4 + v5;
			var grhmdstr = grhmd.substring(0,grhmd.length-1);
			var html = html1 + html2 + html3 + html4 + html5;
			jQuery("#field<%=hmd%>").val(grhmdstr);
			jQuery("#field<%=hmd%>span").html(html);
		},'json');
		
		//监控名单 
		jQuery.get("/appdevjsp/HQ/CRI/Ajax_Modeinfo_853.jsp?time=" + new Date(),{opt:'getJKMD',xmbh:xmbh},function(result){
			var jbr = result.dyjbr;        //对应举报人
			var jbrxm = result.jbrxm; 
			var dyjbdx = result.dybjbdx;   //对应举报对象
			var dyjbdxxm = result.jbdxxm;
			var dyzr = result.dyzr;        //对应证人
			var dyzrxm = result.dyzrxm;   
			var xydx = result.xydx;        //嫌疑对象
			var xydxxm = result.xydxxm;   
			var zr = result.zr;            //证人 
			var zrxm = result.zrxm;
			var html1 = "";
			var html2 = "";
			var html3 = "";
			var html4 = "";
			var html5 = "";
			var v1 = "";
			var v2 = "";
			var v3 = "";
			var v4 = "";
			var v5 = "";
			if(jbrxm!=""){
				v1 = jbr+",";
				html1 = "<span class='e8_showNameClass'><a title='"+jbrxm+"'>"+jbrxm+"</a>&nbsp;<span class='e8_delClass' id='"+jbr+"' onclick='del(event,this,1,false,{});' style='opacity: 1; visibility: hidden;'>&nbsp;x&nbsp;</span></span>";
			}
			if(dyjbdxxm!=""){
				v2 = dyjbdx+",";
				html2 = "<span class='e8_showNameClass'><a title='"+dyjbdxxm+"'>"+dyjbdxxm+"</a>&nbsp;<span class='e8_delClass' id='"+dyjbdx+"' onclick='del(event,this,1,false,{});' style='opacity: 1; visibility: hidden;'>&nbsp;x&nbsp;</span></span>";
			}
			if(dyzrxm!=""){
				v3 = dyzr+",";
				html3 = "<span class='e8_showNameClass'><a title='"+dyzrxm+"'>"+dyzrxm+"</a>&nbsp;<span class='e8_delClass' id='"+dyzr+"' onclick='del(event,this,1,false,{});' style='opacity: 1; visibility: hidden;'>&nbsp;x&nbsp;</span></span>";
			}
			if(xydxxm!=""){
				v4 = xydx + ",";
				html4 = "<span class='e8_showNameClass'><a title='"+xydxxm+"'>"+xydxxm+"</a>&nbsp;<span class='e8_delClass' id='"+xydx+"' onclick='del(event,this,1,false,{});' style='opacity: 1; visibility: hidden;'>&nbsp;x&nbsp;</span></span>";
			}
			if(zrxm!=""){
				v5 = zr + ",";
				html5 = "<span class='e8_showNameClass'><a title='"+zrxm+"'>"+zrxm+"</a>&nbsp;<span class='e8_delClass' id='"+zr+"' onclick='del(event,this,1,false,{});' style='opacity: 1; visibility: hidden;'>&nbsp;x&nbsp;</span></span>";
			}
			
			var grhmd = v1 + v2 + v3 + v4 + v5;
			var grhmdstr = grhmd.substring(0,grhmd.length-1);
			var html = html1 + html2 + html3 + html4 + html5;
			jQuery("#field<%=jhmd%>").val(grhmdstr);
			jQuery("#field<%=jhmd%>span").html(html);
		},'json');
		
		
		//公司黑名单 
		jQuery.get("/appdevjsp/HQ/CRI/Ajax_Modeinfo_853.jsp?time=" + new Date(),{opt:'getGSHMD',xmbh:xmbh},function(result){
			var sadw = result.sadw;      
			var sadwmc = result.sadwmc;
			var html1 = "";
			var v1 = "";
			if(sadwmc!=""){
				v1 = sadw;
				html1 = "<span class='e8_showNameClass'><a title='"+sadwmc+"'>"+sadwmc+"</a>&nbsp;<span class='e8_delClass' id="+sadw+"onclick='del(event,this,1,false,{});' style='opacity: 1; visibility: hidden;'>&nbsp;x&nbsp;</span></span>";
			}
			var gshmd = v1;
			var html = html1;
			jQuery("#field<%=gshmd%>").val(gshmd);
			jQuery("#field<%=gshmd%>span").html(html);
		},'json');
		
	})
</script>
