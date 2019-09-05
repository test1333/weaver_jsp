<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util,
                 weaver.file.Prop,
                 weaver.login.Account,
				 weaver.login.VerifyLogin,
                 weaver.general.GCONST" %>
<%@ page import="java.util.*" %>

<jsp:include page="/cpcompanyinfo/CompanyInfoContainer.jsp" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="ProjectInfoComInfo" class="weaver.proj.Maint.ProjectInfoComInfo" scope="page"/>
<jsp:useBean id="CompanyPermissionService" class="weaver.cpcompanyinfo.CompanyPermissionService" scope="page"/>
<jsp:include page="/cpcompanyinfo/CompanyInfoContainer.jsp" />
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>

<style>
	#loading {
	Z-INDEX: 20001; BORDER-BOTTOM: #ccc 1px solid; POSITION: absolute; BORDER-LEFT: #ccc 1px solid; PADDING-BOTTOM: 8px; PADDING-LEFT: 8px; PADDING-RIGHT: 8px; BACKGROUND: #ffffff; HEIGHT: auto; BORDER-TOP: #ccc 1px solid; BORDER-RIGHT: #ccc 1px solid; PADDING-TOP: 8px; TOP: 40%; LEFT: 45%
}

</style>
</head>

<%
String uid = user.getUID()+"" ;
String companyname="";
String businesstype="";
String companyid = Util.null2String( request.getParameter("companyid") ) ;
if(! CompanyPermissionService.canEditCompany(user,""+Util.getIntValue( companyid,0))){
   response.sendRedirect("/notice/noright.jsp");
   return;
}

rs.executeSql("select * from CPCOMPANYINFO where companyid="+companyid);
if(rs.next()){
	companyname=Util.null2String(rs.getString("companyname"));
    businesstype=Util.null2String(rs.getString("businesstype"));
}

String projManagerId = Util.null2String( request.getParameter("projManagerId") ) ;
String selectedTab = Util.null2String( request.getParameter("selectedTab") ) ;
if("".equals(selectedTab)){
	selectedTab="0";
}


String imagefilename = "/images/hdMaintenance.gif";
String titlename = "";
String needfav ="1";
String needhelp ="";
String newtitlename = "";
%>
<BODY scroll="no">
<DIV style="" id=loading><SPAN><IMG align=absMiddle src="/images/loading2.gif"></SPAN> <SPAN id=loading-msg><%=SystemEnv.getHtmlLabelName(19945,user.getLanguage())%></SPAN> </DIV>
<%

String arrOtherTab="[";

arrOtherTab+="{	title:'"+"児云佚連"+" ',autoScroll : true,url:'/cpcompanyinfo/CompanyInfoMaint.jsp?from=newpage&btnid=editBtn&companyid="+companyid+"',id:'t1361'}";
    if(!"1".equals(businesstype)){

        arrOtherTab+=",{	title:'"+"屬孚"+" ',autoScroll : true,url:'/cpcompanyinfo/CompanyBusinessLicenseSurvey.jsp?from=newpage&companyid="+companyid+"&companyname="+companyname+"&archivenum=001&showOrUpdate=1',id:'t410'}";
        arrOtherTab+=",{	title:'"+"嫗殻"+" ',autoScroll : true,url:'/cpcompanyinfo/CompanyConstitutionMaint.jsp?from=newpage&companyid="+companyid+"&companyname="+companyname+"&showOrUpdate=1',id:'t411'}";
        arrOtherTab+=",{	title:'"+"紘叫氏"+" ',autoScroll : true,url:'/cpcompanyinfo/CompanyShareHolderMaint.jsp?from=newpage&companyid="+companyid+"&showOrUpdate=1',id:'t412'}";
        arrOtherTab+=",{	title:'"+"境並氏"+" ',autoScroll : true,url:'/cpcompanyinfo/CompanyBoardDirectorsMaint.jsp?from=newpage&companyid="+companyid+"&companyname="+companyname+"&showOrUpdate=1',id:'t413'}";
    }

arrOtherTab+="]";
%>

<script language=javascript>
	var arrOtherTab=eval(<%=arrOtherTab%>);
	var tablist="";
	var selectedTab="<%=selectedTab %>";
	var fistTabItem="";
	var iframeList="";
	var iframeList1=" <iframe src='/cpcompanyinfo/CompanyInfoMaint.jsp?from=newpage&btnid=editBtn&companyid=<%=companyid %>'  id='iframepage'  frameBorder=0 scrolling=auto width=100% height='100%' onload=\"loading()\"  style='display:block;'></iframe>";
	for(var item=0;item<arrOtherTab.length;item++){
			tablist+="<li  sid='"+arrOtherTab[item].id+"'   url='"+arrOtherTab[item].url+"&isfromtab=true"+"'><div class=\""+(selectedTab==item?"tab-selected":"")+" tab-item\" ><a  href='javascript:setSelectedTab("+item+")'>"+arrOtherTab[item].title+"</a></div><li>";
	}
	
</script>



<form name=weaver id=weaver method=post action="">
<input type="hidden" name="selectedTab" id="selectedTab" value="<%=selectedTab %>" />
</form>


<table width="100%" style="min-width:820px;height:100%;">
	<colgroup>
		<col width="5">
		<col width="">
		<col width="5">
	</colgroup>
	<tr style="height:1px;">
		<td></td>
		<td>
			
			<table cellpadding="0" cellspacing="0" width="100%" border="0">
			  	<tr>
			  		<td width="6px" height="28px;" style="">
						<div id="tab-left" class="<%="0".equals(selectedTab)?"tab-left-selected":"" %>" style="">
							
						</div>
					</td>
					<td>
						<div id="tab-center" >
							<ul>
								<script>
									document.write(tablist);
								</script>
							</ul>
						</div>
					</td>
					<td width="6px" style="">
						<div id="tab-right" style=""></div>
					</td>
			  	</tr>
	  		</table>
 
		
		</td>
		<td></td>
			
	</tr>
	<tr style="height:100%">
		<td colspan="3" style="height:100%">
			
		  <div id="content" style="height:100%">
						<script>
							document.write(iframeList1);
						</script>
		
		  </div>
		</td>
	</tr>
</table>


<script type="text/javascript" language="javascript">   
	  function loading(){
		  $("#loading").hide();
	 }

	$(function(){
		initMenuWidth();
		initLeftTabCss();
		
		$("#tab-center li").click(function(){
			
			$("#tab-center li .tab-selected").removeClass("tab-selected");
			$(this).children("div").addClass("tab-selected");
			$("#content iframe").css("display","none");
			var temid=$(this).attr("sid");
			if(temid=="t1361"){
				setSelectedTab("0");
				$("#tab-left").removeClass("tab-left-unselected");
				$("#tab-left").addClass("tab-left-selected");
			}else{
				setSelectedTab("1");
				$("#tab-left").removeClass("tab-left-selected");
				$("#tab-left").addClass("tab-left-unselected");
			}
			if($("#"+$(this).attr("sid")).attr("src")==undefined){
			  $("#content").append(	" <iframe src=''  id='"+$(this).attr("sid")+"'  frameBorder=0 onload=\"loading()\" scrolling=auto width='100%'  height='100%' onload='loading();'  style='display:none;'></iframe>");
			  $("#"+$(this).attr("sid")).attr("src",$(this).attr("url")).load(function(){});
				$("#loading").hide();
				$("#loading").show();
			}else{
				$("#loading").hide();
			}
		
			$("#"+$(this).attr("sid")).css("display","block");
		});
		window.onresize=function(){
			var ifms=document.getElementsByTagName("iframe");
			for(var i=0;i<ifms.length;i++ ){
				ifms[i].height=document.body.clientHeight-getElementTop(ifms[i])-3;
			}
		}
	});
	function getElementTop(element){
	　　　　var actualTop = element.offsetTop;
	　　　　var current = element.offsetParent;

	　　　　while (current !== null){
	　　　　　　actualTop += current.offsetTop;
	　　　　　　current = current.offsetParent;
	　　　　}

	　　　　return actualTop;
	　　}
	function initMenuWidth(){
		var tabWidth=0;
		$("#tab-center li").each(function(e,e2){
			tabWidth+=$(e2).width();
		});
		$("#tab-center ul").css("width",tabWidth+10);
	}
	
function setSelectedTab(val){
	$("#selectedTab").val(val);
}
function initLeftTabCss(){
	if(selectedTab==0){
		$("#tab-left").removeClass("tab-left-unselected");
		$("#tab-left").addClass("tab-left-selected");
	}else{
		$("#tab-left").removeClass("tab-left-selected");
		$("#tab-left").addClass("tab-left-unselected");
	}
}
</script>

</BODY>
</HTML>