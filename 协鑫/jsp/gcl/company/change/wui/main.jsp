<%@page import="weaver.general.TimeUtil" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="gcl.doc.workflow.DocUtil" %>
<%@ page import="weaver.conn.*" %>
<%@ page import="gcl.company.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<HTML>
<HEAD>
  <link rel="stylesheet" type="text/css" href="/css/Weaver.css">
	<script type="text/javascript" src="/js/weaver.js"></script>
<link href="/cpcompanyinfo/style/Operations.css" rel="stylesheet"
			type="text/css" />
		<link href="/cpcompanyinfo/style/Public.css" rel="stylesheet"
			type="text/css" />
		<link href="/cpcompanyinfo/style/Business.css" rel="stylesheet"
			type="text/css" />
		<link href="/newportal/style/Contacts.css" rel="stylesheet"
			type="text/css" />
</head>
<%
String emp_id = user.getUID()+"";
String dataid = Util.null2String(request.getParameter("dataid"));
CompanyChangeUtil ccu = new CompanyChangeUtil();
String jbxxid  = ccu.CreateChangeDataInfo("1",dataid,emp_id);

String gdxxid = ccu.CreateChangeDataInfo("2",dataid,emp_id);

String zyryid = ccu.CreateChangeDataInfo("3",dataid,emp_id);


String qtxxid  = ccu.CreateChangeDataInfo("5",dataid,emp_id);

 DocUtil du = new DocUtil();
 String tableNameJbxx = du.getBillTableName("GSJBXXBG");
 String tableNameGdxx = du.getBillTableName("GSGDXXBG");
 String tableNameZyrr = du.getBillTableName("GSZYRYBG");
 String tableNameQtxx = du.getBillTableName("GSQTXXBG");
%>
<script type="text/javascript">
    
		jQuery(document).ready(function(){

				jQuery(".ONav").find("li").bind("click",function(){
			jQuery(".ONav").find(".hover").removeClass("hover");
			jQuery(this).find("a").addClass("hover");
			
		});
		setBottom();
		})
			function setBottom(){
			var docH=$(document).height(); 
			docmh=docH;
			var totH=$("#top_div").height();
			var tempH=docH-totH-10;
			$("#OBoxW_H").height(tempH+"px");
			$("#frame2list").height((tempH-20)+"px");
	}
	function queryCompanyType(type){
		if(type == "1"){
			jQuery("#frame2list").attr("src","/formmode/view/AddFormMode.jsp?type=2&modeId=<%=ccu.getModeid(tableNameJbxx)%>&formId=<%=ccu.getFormId(tableNameJbxx)%>&billid=<%=jbxxid%>&opentype=0");
		}else if(type == "2"){
			jQuery("#frame2list").attr("src","/formmode/view/AddFormMode.jsp?type=2&modeId=<%=ccu.getModeid(tableNameGdxx)%>&formId=<%=ccu.getFormId(tableNameGdxx)%>&billid=<%=gdxxid%>&opentype=0");
			
		}else if(type == "3"){
			jQuery("#frame2list").attr("src","/formmode/view/AddFormMode.jsp?type=2&modeId=<%=ccu.getModeid(tableNameZyrr)%>&formId=<%=ccu.getFormId(tableNameZyrr)%>&billid=<%=zyryid%>&opentype=0");
		
		}else if(type == "5"){
			jQuery("#frame2list").attr("src","/formmode/view/AddFormMode.jsp?type=2&modeId=<%=ccu.getModeid(tableNameQtxx)%>&formId=<%=ccu.getFormId(tableNameQtxx)%>&billid=<%=qtxxid%>&opentype=0");
			
		}
		
	}
</script>

</head>

<body  id="bd_H" style="height: 100%">
<div class="OBoxW "   id="top_div"> 
			<div class="  OBoxWBg"  >
				<ul class="ONav FL cBlue">
					<li>
						<a href="javascript:queryCompanyType('1');" class="hover"><div><div>基本信息</div></div> </a>
					</li>
           <li>
						<a href="javascript:queryCompanyType('2');" ><div><div>股东信息</div> </div> </a>
					</li>
					<li>
						<a href="javascript:queryCompanyType('3');" ><div><div>主要人员</div> </div> </a>
					</li>
				
					<li>
						<a href="javascript:queryCompanyType('5');" ><div><div>其他信息</div> </div> </a>
					</li>
					
					
					<div class="clear"></div>
				</ul>

			
			</div>
			<div class="clear"></div>
			
			
			
			
			
		
			
			<div class="clear"></div>
			
		</div>
		<div class="OBoxW"   id="OBoxW_H">
			
			<div id="listcontent" class=" OScrollHeight4 MT5 "   >
				<iframe id="frame2list"  scrolling="auto" src="/formmode/view/AddFormMode.jsp?type=2&modeId=<%=ccu.getModeid(tableNameJbxx)%>&formId=<%=ccu.getFormId(tableNameJbxx)%>&billid=<%=jbxxid%>&opentype=0"  width="100%"     frameborder=no   ></iframe>
			</div>
		</div>
		<div style="clear: both;"></div>
</body>
</HTML>

