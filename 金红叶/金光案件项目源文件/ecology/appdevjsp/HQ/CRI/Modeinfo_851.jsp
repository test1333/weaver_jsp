<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.*"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%
String durrdate = TimeUtil.getCurrentDateString();

int formid = Util.getIntValue(request.getParameter("formid"));	
int billid = Util.getIntValue(request.getParameter("billid"));
int types = Util.getIntValue(request.getParameter("type")); 	
String xmbh = Util.null2String(request.getParameter("xmbh"));
String xmbhmc = "";
String jblbstr = "";
String rwlystr = "";
String dybjbdxstr = "";
String jbzystr = "";
String dyjbrstr = "";
String dyjbzrstr = "";
String xmmcstr = "";

rs.executeSql(" select * from uf_hq_cri_noticeoao where id = '"+xmbh+"' ");
if(rs.next()){
	xmbhmc = rs.getString("xmbh");
	xmmcstr = rs.getString("xmmc");
	jblbstr = rs.getString("jblb");
	rwlystr = rs.getString("rwly");
	dybjbdxstr = rs.getString("dybjbdx");
	jbzystr = rs.getString("jbzy");
	dyjbrstr = rs.getString("dyjbr");
	dyjbzrstr = rs.getString("dyjbzr");
}

int fzcd=-1;   
int mbjarq=-1;
int dqzt=-1;
int sfwjack=-1;
int xmmc=-1;
int jazksf=-1;

int jblb=-1;
int rwly=-1;
int dybjbdx=-1;
int jbzy=-1;
int dyjbr=-1;
int dyjbzr=-1;
int jabh=-1;
int dyjbbh=-1;

rs.executeSql(" select * from  workflow_billfield where billid ='"+formid+"'  ");
while(rs.next()){
	int fieldid=rs.getInt("id");
	String fieldname=rs.getString("fieldname");
	String detailtable=rs.getString("detailtable");
	if("fzcd".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		fzcd=fieldid;
	}else if("mbjarq".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		mbjarq=fieldid;
	}else if("dqzt".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		dqzt=fieldid;
	}else if("sfwjack".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		sfwjack=fieldid;
	}else if("xmmc".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		xmmc=fieldid;
	}else if("jazksf".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		jazksf=fieldid;
	}else if("jblb".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		jblb=fieldid;
	}else if("rwly".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		rwly=fieldid;
	}else if("dybjbdx".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		dybjbdx=fieldid;
	}else if("jbzy".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		jbzy=fieldid;
	}else if("dyjbr".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		dyjbr=fieldid;
	}else if("dyjbzr".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		dyjbzr=fieldid;
	}else if("jabh".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		jabh=fieldid;
	}else if("dyjbbh".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		dyjbbh=fieldid;
	}
}


%>

<script type="text/javascript">

	jQuery(document).ready(function(){

		var type = "<%=types%>";
		if(type=="2"){
			jQuery("#disfield<%=dqzt%>").val("0");
			jQuery("#field<%=dqzt%>").val("0");
			var sfjack = jQuery("#field<%=sfwjack%>").val();
			if(sfjack == "1"){
				jQuery("#xjym").hide();
				input_must_a("field<%=jazksf%>","");
			}
		}else if(type=="1"){ //新建页面
			jQuery("#xjym").hide();
			input_must_a("field<%=jazksf%>","");
			if("<%=xmbh%>"!=""){
				jQuery("#disfield<%=sfwjack%>").val("0");
				jQuery("#field<%=sfwjack%>").val("0");
				jQuery("#xjym").show();
				jQuery("#field<%=jazksf%>").val("0");
				jQuery("#field<%=jazksf%>").unbind("change");
				jQuery("#field<%=jazksf%>").bind("change", function(){
					JACK();
				}) 
			}
		} 
		
		if("<%=xmbh%>"!=""){		//名称加TWO	
			jQuery("#field<%=xmmc%>").bind("change", function(){
				var xmmc = jQuery("#field<%=xmmc%>").val();
				if(xmmc!=""){
					if(xmmc.indexOf("_two")<0){						
						jQuery("#field<%=xmmc%>").val(xmmc+"_two");
					}
				}
			})
		}
		
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
		
		
		//提交
		setTimeout(function(){
			var objarray=$("#rightMenuIframe").contents().find("button");
			var html=objarray[0].innerHTML;
			if(html=="提交审批"){
				objarray[0].onclick=function(){
					jQuery("#disfield<%=dqzt%>").val("1");
					jQuery("#field<%=dqzt%>").val("1");
					doSubmit(2401,1);							
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
		//提交
		
		
		//复杂程度日期计算
		jQuery("#field<%=fzcd%>").unbind("change");
		jQuery("#field<%=fzcd%>").bind("change", function(){
			To_FZCD();
		})
		
		function To_FZCD(){
			var fzcd = jQuery("#field<%=fzcd%>").val();
			if(fzcd != ""){			
				jQuery.get("/appdevjsp/HQ/CRI/Ajax_Modeinfo_851.jsp?time=" + new Date(),{opt:'getJARQ',fzcd:fzcd},function(result){
					var v1 = result.resultdate;
					jQuery("#field<%=mbjarq%>").val(v1);
					jQuery("#field<%=mbjarq%>span").html(v1);
				},'json');
			}else{
				jQuery("#field<%=mbjarq%>").val("<%=durrdate%>");
				jQuery("#field<%=mbjarq%>span").html("<%=durrdate%>");
			}
		}
		//复杂程度日期计算
		
		
		//是否为旧案重开
		jQuery("#field<%=sfwjack%>").unbind("change");
		jQuery("#field<%=sfwjack%>").bind("change", function(){
			SFWJACK();
		}) 
		//是否为旧案重开
		
		
		//旧案编号
		var jabh = "<%=xmbh%>";
		var jabhstr = document.getElementById("field<%=jabh%>");
		jabhstr.setAttribute("jabh_val",jabh);
		
		//判断举报编号是否已被占用
		all_browse_bind("#field<%=dyjbbh%>", function(){
			CheckJBBH();
		})
		//判断举报编号是否已被占用
		
	})

	
function CheckJBBH(){
	var jbbh = jQuery("#field<%=dyjbbh%>").val();
	if(jbbh!=""){
		jQuery.ajax({
			url:"/appdevjsp/HQ/CRI/Ajax_Modeinfo_851.jsp",
			type:"post",
			data:{opt:'optJBBH',jbbh:jbbh},
			async:false,
			dataType:"json",
			success:function(data){
				var jbh = data.result;
				if(jbh == "500"){
					alert("该举报编号已被占用!");
					jQuery("#field<%=dyjbbh%>").val("");
					jQuery("#field<%=dyjbbh%>span").html("");
				}
			}
		},'json');
	}
}
	
function SFWJACK(){
	var sfjack = jQuery("#field<%=sfwjack%>").val();
	if(sfjack=="1"){
		jQuery("#field<%=jabh%>").val("");
		jQuery("#jaid").hide();
		jQuery("#field<%=jabh%>span").html("");
	}else{
		jQuery("#jaid").show();
		var getjabh =document.getElementById("field<%=jabh%>");
		var jabhvalue =getjabh.getAttribute("jabh_val");
		jQuery("#field<%=jabh%>").val(jabhvalue);
		var xmbhmc = "<%=xmbhmc%>";
		var html = "<span class='e8_showNameClass'><a title='' href='/formmode/view/AddFormMode.jsp?type=0&amp;modeId=851&amp;formId=-150&amp;billid="+jabhvalue+"' target='_blank'>"+xmbhmc+"</a>&nbsp;<span class='e8_delClass' id='"+jabhvalue+"' onclick='del(event,this,1,false,{});' style='opacity: 1; visibility: hidden;'>&nbsp;x&nbsp;</span></span> ";
		jQuery("#field<%=jabh%>span").html(html);
		jQuery("#field<%=jazksf%>").val("0");
	}
}

	
function JACK(){
	var sfja = jQuery("#field<%=jazksf%>").val();
	if(sfja=="1"){
		jQuery("#field<%=jblb%>").val("");
		jQuery("#field<%=jblb%>span").html("");
		input_must_aa("field<%=jblb%>","add");
		jQuery("#field<%=rwly%>").val("");
		jQuery("#field<%=rwly%>span").html("");
		input_must_aa("field<%=rwly%>","add");
		jQuery("#field<%=dybjbdx%>").val("");
		jQuery("#field<%=dybjbdx%>span").html("");
		input_must_aa("field<%=dybjbdx%>","add");
		jQuery("#field<%=jbzy%>").val("");
		jQuery("#field<%=jbzy%>span").html("");
		input_must_a("field<%=jbzy%>","add");
		jQuery("#field<%=dyjbr%>").val("");
		jQuery("#field<%=dyjbr%>span").html("");
		input_must_aa("field<%=dyjbr%>","add");
		jQuery("#field<%=dyjbzr%>").val("");
		jQuery("#field<%=dyjbzr%>span").html("");
		input_must_aa("field<%=dyjbzr%>","add");
		jQuery("#field<%=xmmc%>").val("");
		jQuery("#field<%=xmmc%>span").html("");
		input_must_a("field<%=xmmc%>","add");
	}else if(sfja=="0"){
		/* var xmmcstr = "<%=xmmcstr%>";
		var jblbstr = "<%=jblbstr%>";
		var rwlystr = "<%=rwlystr%>";
		var dybjbdxstr = "<%=dybjbdxstr%>";
		var jbzystr = "<%=jbzystr%>";
		var dyjbrstr = "<%=dyjbrstr%>";
		var dyjbzrstr = "<%=dyjbzrstr%>";*/
		
		jQuery("#field<%=sfwjack%>").val("");
		input_must_a("field<%=sfwjack%>","add");	
	}
}


function input_must_aa(id,opt){
    var needcheck = jQuery("input[name='needcheck']").val();       
    var dis_id = ","+id;
	if( document.getElementById("dis"+id) ){
        id = "dis"+id;
    }
	if(opt=="add"){
		var shtml= "<img align='absMiddle' src='/images/BacoError_wev8.gif' complete='complete'/>";
		if(needcheck.indexOf(dis_id)<0){             
			needcheck=needcheck+dis_id;
		}
		if(jQuery("#"+id).val()==""){
			jQuery("#"+id+"spanimg").html(shtml);
		}
		jQuery("input[name='needcheck']").val(needcheck); 
	}else{
		if(needcheck.indexOf(dis_id)>0){             
			needcheck=needcheck.replace(dis_id,"");
		}
		jQuery("#"+id+"spanimg").html("");
		jQuery("input[name='needcheck']").val(needcheck); 
	}	
}

function input_must_a(id,opt){
    var needcheck = jQuery("input[name='needcheck']").val();       
    var dis_id = ","+id;
	if( document.getElementById("dis"+id) ){
        id = "dis"+id;
    }
	if(opt=="add"){
		var shtml= "<img align='absMiddle' src='/images/BacoError_wev8.gif' complete='complete'/>";
		if(needcheck.indexOf(dis_id)<0){             
			needcheck=needcheck+dis_id;
		}
		if(jQuery("#"+id).val()==""){
			jQuery("#"+id+"span").html(shtml);
		}
		jQuery("input[name='needcheck']").val(needcheck); 
	}else{
		if(needcheck.indexOf(dis_id)>0){             
			needcheck=needcheck.replace(dis_id,"");
		}
		jQuery("#"+id+"span").html("");
		jQuery("input[name='needcheck']").val(needcheck); 
	}	
}

function all_browse_bind( id ,func_browse)
{	
    var id_val_last=jQuery(id).val();
    setInterval(function()
    {
        var id_val = jQuery(id).val();
        if( id_val != id_val_last)
        {
           func_browse();
        }
        id_val_last = id_val;
    },50);
}

</script>
