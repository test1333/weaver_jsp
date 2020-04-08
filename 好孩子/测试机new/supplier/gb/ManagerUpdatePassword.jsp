<%@ page import="weaver.general.BaseBean" %>
<%@ page import="weaver.general.Util" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<jsp:useBean id="recordGet" class="weaver.conn.RecordSet" scope="page" />
<HTML>
<head>
	<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
	<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
	<script src="/wui/common/jquery/jquery_wev8.js" type="text/javascript"></script>
	<script type="text/javascript" src="/wui/theme/ecology8/jquery/js/zDrag_wev8.js"></script>
		<script type="text/javascript" src="/wui/theme/ecology8/jquery/js/zDialog_wev8.js"></script>
</head>
<body>



<%
	BaseBean log = new BaseBean();
	String userID = ""+user.getUID();
	String type = Util.null2String(request.getParameter("type"));//type为manager表示客户经理操作，type为customer表示为客户操作
	String crmid = Util.null2String(request.getParameter("crmid"));//客户人员主键值
	String prepassword = null;//之前的密码
	String state = Util.null2String(request.getParameter("state"));//1表示为门户申请
	if(!"manager".equals(type)){
		String sql = "SELECT PortalPassword FROM CRM_CustomerInfo WHERE id ="+ userID;
		recordGet.executeSql(sql);
		recordGet.next();
		prepassword = recordGet.getString("PortalPassword");//修改之前的旧密码
	}
	RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:saveInfo(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	
%>	

<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<jsp:include page="/systeminfo/commonTabHead.jsp">
   <jsp:param name="mouldID" value="customer"/>
   <jsp:param name="navName" value='<%=SystemEnv.getHtmlLabelNames("409",user.getLanguage()) %>'/>
</jsp:include>

<table id="topTitle" cellpadding="0" cellspacing="0">
	<tr>
		<td></td>
		<td class="rightSearchSpan" style="text-align:right;">
			<input class="e8_btn_top middle" onclick="saveInfo()" type="button"  value="<%=SystemEnv.getHtmlLabelName(86,user.getLanguage()) %>"/>
			<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
		</td>
	</tr>
</table>

<FORM id="weaver" name="weaver"  action="" method="post">
<wea:layout>
	<wea:group context='<%=SystemEnv.getHtmlLabelName(1361,user.getLanguage())%>'>
		<%if(!"manager".equals(type)){%>
			<wea:item>
				<%=SystemEnv.getHtmlLabelName(409,user.getLanguage())%>: <%=SystemEnv.getHtmlLabelName(502,user.getLanguage())%>
			</wea:item>
			<wea:item>
				<wea:required id="passwordoldSpan" required="true">
					<INPUT class="inputstyle" type="password" id="passwordold" name="passwordold"
					 	onchange='checkinput("passwordold","passwordoldSpan")'>
				</wea:required>
			</wea:item>
		<%}%>
		<%if("manager".equals(type)){%>
			<wea:item><%=SystemEnv.getHtmlLabelName(409,user.getLanguage())%>: </wea:item>
		<%}else{%>
			<wea:item><%=SystemEnv.getHtmlLabelName(27303,user.getLanguage())%>: </wea:item>
		<%}%>
		
		<wea:item>
			<wea:required id="passwordnewSpan" required="true">
				<INPUT class="inputstyle"  type="password" id="passwordnew" name="passwordnew"
				 	onchange='checkinput("passwordnew","passwordnewSpan")'> 
			</wea:required>
		</wea:item>
		
		<wea:item><%=SystemEnv.getHtmlLabelName(501,user.getLanguage())%></wea:item>
		<wea:item>
			<wea:required id="confirmpasswordSpan" required="true">
				<INPUT class="inputstyle" type="password" id="confirmpassword" name="confirmpassword"
				 	onchange='checkinput("confirmpassword","confirmpasswordSpan")'>
			</wea:required>
		</wea:item>
		
		<wea:item>
			<span id=confirmpasswordimage><img src="/images/BacoError_wev8.gif" align=absMiddle></span>
			<span><%=SystemEnv.getHtmlLabelName(15168, user.getLanguage())%>:
			1、<%=SystemEnv.getHtmlLabelName(31864, user.getLanguage())%>;</span><br/>
			<span style="padding-left: 30px;">2、<%=SystemEnv.getHtmlLabelName(31862, user.getLanguage())%>.</span>
		</wea:item>
	</wea:group>
</wea:layout>
</FORM>

<jsp:include page="/systeminfo/commonTabFoot.jsp"></jsp:include> 
<script type="text/javascript">
	
	var type = "<%=type%>";//type为manager表示客户经理操作，type为customer表示为客户操作
	var prepassword = '<%=prepassword%>';
	jQuery(function(){
		checkinput("passwordold","passwordoldSpan");
		checkinput("passwordnew","passwordnewSpan");
		checkinput("confirmpassword","confirmpasswordSpan");
	});
	
	
	function saveInfo(){
		if(checkpassword()){
			jQuery.post("/CRM/data/CustomerOperation.jsp",
				{"method":"updatePassword","crmid":<%=userID%>,"passwordnew":weaver.passwordnew.value},
				function(){
                    alert("密码修改成功");
                    window.location='/login/Logout.jsp';
					if("<%=state%>" == "1"){
						parent.getParentWindow(window).applyPortalManagerInfo();
					}else{
						prepassword = jQuery('#passwordnew').val();
//						parent.getDialog(window).close();
					}

				});
		}
	}
	
	function checkpassword() {
		if(weaver.passwordnew.value.length<6){
		    alert("<%=SystemEnv.getHtmlLabelName(20172,user.getLanguage())+6+SystemEnv.getHtmlLabelName(17081,user.getLanguage())%>"); 
			return false;
	    }
	    if(weaver.passwordnew.value.length>20){ 
		    alert("<%=SystemEnv.getHtmlLabelName(31865,user.getLanguage())+20+SystemEnv.getHtmlLabelName(17081,user.getLanguage())%>");
			return false;
	    }
	    
	   ;

	    var passwordold = jQuery('#passwordold').val();
	    //验证输入的旧密码与之前的旧密码是否相同
	    if("manager" != type && prepassword != passwordold){
	    	alert("<%=SystemEnv.getHtmlNoteName(17,user.getLanguage())%>");
	    	return false;
	    }
		if(weaver.passwordnew.value != weaver.confirmpassword.value) {
		    alert("<%=SystemEnv.getHtmlNoteName(16,user.getLanguage())%>");
		    return false;
		}
        if(weaver.passwordnew.value	== weaver.passwordold.value) {
            alert("修改的密码不能与旧密码相同");
            return false;
        }
        if(weaver.passwordnew.value	== "123456") {
            alert("此密码为初始登录密码，重新修改");
            return false;
        }
		var complexity = /^[0-9a-zA-Z]+$/;
		var passwordnew = jQuery("#passwordnew").val();
		if(!complexity.test(passwordnew)){
			alert("<%=SystemEnv.getHtmlLabelName(31863, user.getLanguage())%>");
			return false;
		}
		jQuery("#verifyFlag").val("1");
		return true;
	}

	
	
</script>
</body>
</HTML>
