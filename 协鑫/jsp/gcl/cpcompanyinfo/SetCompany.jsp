<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" " http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.*"%>
<%@ page import="weaver.login.Account"%>
<%@ include file="/systeminfo/init.jsp"%>
<jsp:useBean id="cu" class="weaver.company.CompanyUtil" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="UsrTemplate"
	class="weaver.systeminfo.template.UserTemplate" scope="page" />
	<jsp:useBean id="departmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<%
	/* if(!user.getLoginid().equalsIgnoreCase("sysadmin")){
		//只有系统管理员才能操作后台
		response.sendRedirect("/notice/noright.jsp");
		return;
	} */
	if(!HrmUserVarify.checkUserRight("License:manager", user)){
    		response.sendRedirect("/notice/noright.jsp");
    		return;
	}
	
/* 	if(!cu.canOperate(user,"3"))//不具有入口权限
	{
		response.sendRedirect("/notice/noright.jsp");
		return;
	}	 */
	UsrTemplate.getTemplateByUID(user.getUID(), user
			.getUserSubCompany1());
	String logo = UsrTemplate.getLogo();
	String logoBottom = UsrTemplate.getLogoBottom();
	String templateTitle = UsrTemplate.getTemplateTitle();
	String strDepartment=departmentComInfo.getDepartmentname(String.valueOf(user.getUserDepartment()));
%>
<html>

	<head>
		<link href="/cpcompanyinfo/style/Operations.css" rel="stylesheet"
			type="text/css" />
		<link href="/cpcompanyinfo/style/Public.css" rel="stylesheet"
			type="text/css" />
		<link href="/cpcompanyinfo/style/Business.css" rel="stylesheet"
			type="text/css" />
		<link href="/newportal/style/Contacts.css" rel="stylesheet"
			type="text/css" />
		<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
		<script type="text/javascript" src="/js/jquery/jquery-1.4.2.min.js"></script>

	<script type="text/javascript">
		jQuery(document).ready(function(){
			setBottom();
			jQuery(".ONav").find("li").bind("click",function(){
				jQuery(".ONav").find(".hover").removeClass("hover");
				jQuery(this).find("a").addClass("hover");
			});
		});
		
		function maintainPage(_type){
			if(_type=="license")jQuery("#frame2page").attr("src","CompanyLicenseMaintain.jsp");
			if(_type=="timeover")jQuery("#frame2page").attr("src","CompanyOvertimeMaintain.jsp");
			if(_type=="allot")jQuery("#frame2page").attr("src","/cpcompanyinfo/protypemanagerTree.jsp");
			if(_type=="comSer")jQuery("#frame2page").attr("src","/cpcompanyinfo/CompanyService.jsp");
			if(_type=="Companyattributable")jQuery("#frame2page").attr("src","/cpcompanyinfo/Companyattributable.jsp");
			if(_type=="Attach")jQuery("#frame2page").attr("src","/cpcompanyinfo/CompanyAttach.jsp");
			
		}
		
		function doLogOut(){
			window.close();
		}
		function setBottom(){
			var docH=$(document).height(); 
			var totH=$("#top_div").height();
			var tempH=docH-totH-20;
			$("#listcontent").height(tempH);
			$("#frame2page").height(tempH);
		}
	</script>
	</head>

	<body>
	
		
		<div class="OBoxW ">
			<div class=" FL OBoxW" id="top_div">
				<ul class="ONav FL cBlue">
					<li>
						<a href="javascript:maintainPage('license');" class="hover"><div>
								<div>
									<%=SystemEnv.getHtmlLabelName(30945,user.getLanguage())  %>
								</div>
							</div> </a>
					</li>
					<li style="display: none;">
						<a href="javascript:maintainPage('allot');"><div>
								<div>
									<%=SystemEnv.getHtmlLabelName(31132,user.getLanguage())  %>
								</div>
							</div> </a>
					</li>
					<li>
						<a href="javascript:maintainPage('timeover');"><div>
								<div>
									<%=SystemEnv.getHtmlLabelName(18818,user.getLanguage())  %>
								</div>
							</div> </a>
					</li>
					
					<li>
						<a href="javascript:maintainPage('comSer');"><div>
								<div>
									<%=SystemEnv.getHtmlLabelName(125906,user.getLanguage())  %>
								</div>
							</div> </a>
					</li>
					<li>
						<a href="javascript:maintainPage('Companyattributable');"><div>
								<div>
									<%=SystemEnv.getHtmlLabelName(125907,user.getLanguage())  %>
								</div>
							</div> </a>
					</li>
					 <!--  
					<li>
						<a href="javascript:maintainPage('Attach');"><div>
								<div>
									<%=SystemEnv.getHtmlLabelName(30985,user.getLanguage())  %>
								</div>
							</div> </a>
					</li>
					-->
					
					<div class="clear"></div>
				</ul>

			</div>
			<div style="clear: both;"></div>
			<div style="height: 2px;background-color: blue;">&nbsp;</div>
			<div id="listcontent" class="OScrollHeight4 MT5" >
				<iframe id="frame2page" src="CompanyLicenseMaintain.jsp" width="100%"  frameborder=no scrolling=no>
				</iframe>
			</div>
			<div class="clear"></div>
		</div>
	</body>
</html>