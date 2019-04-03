
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ page contentType="text/html; charset=UTF-8"%>

<%@ page import="weaver.hrm.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="weaver.general.Util"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
String saprequestid = Util.null2String(request.getParameter("requestid")) ;
int saplan = Util.getIntValue(request.getParameter("lan"),7) ;
    String requestid="";
	String pernr_f="";
	String sql="select lc_no,pernr_f from zoat00020 where oa_md5='"+saprequestid+"'";
	rs.executeSql(sql);
	if(rs.next()){
		requestid = Util.null2String(rs.getString("lc_no"));
		pernr_f = Util.null2String(rs.getString("pernr_f"));
	}
	if("".equals(requestid)){
		sql="select lc_no,pernr_f from zoat00030 where oa_md5='"+saprequestid+"'";
		rs.executeSql(sql);
		if(rs.next()){
			requestid = Util.null2String(rs.getString("lc_no"));
			pernr_f = Util.null2String(rs.getString("pernr_f"));
		}
	}
	if("".equals(requestid)){
		response.sendRedirect("/appdevjsp/HQ/SAPOA/noright.jsp?lan="+saplan);
		return;
	}
request.getSession().setAttribute("weaver_user@bean", User.getUser(Integer.valueOf("11000209"), 0));
User user = HrmUserVarify.getUser (request , response);
user.setLanguage(saplan);
%>

<script language="javascript" type="text/javascript" src="/FCKEditor/swfobject_wev8.js"></script>
<script type="text/javascript" src="/js/select/script/jquery-1.8.3.min_wev8.js"></script>	 
<script language="vbs" src="/js/string2VbArray.vbs"></script>       
<script type="text/javascript" src="/js/jquery.table_wev8.js"></script>
<script language="javascript" type="text/javascript" src="/js/init_wev8.js"></script>
<script language="javascript"  src="/js/wbusb_wev8.js"></script>
<script type="text/javascript" src="/js/jquery/plugins/client/jquery.client_wev8.js"></script>
<script type="text/javascript" src="/js/ecology8/jNice/jNice/jquery.jNice_wev8.js"></script>
<script type='text/javascript' src='/js/jquery-autoco/wui/common/page/initWui.jspmplete/jquery.autocomplete_wev8.js'></script>
<script type='text/javascript' src='/js/jquery-autocomplete/browser_wev8.js'></script>
<script language=javascript src="/wui/theme/ecology8/jquery/js/zDialog_wev8.js"></script>
<script type="text/javascript" src="/js/ecology8/request/hoverBtn_wev8.js"></script>
<script type="text/javascript" src="/js/ecology8/lang/weaver_lang_7%>_wev8.js"></script>
<script type="text/javascript" src="/js/messagejs/highslide/highslide-full_wev8.js"></script>
<link rel="stylesheet" href="/css/init_wev8.css" type="text/css" />
<script type="text/javascript" src="/wui/common/jquery/plugin/wuiform/jquery.wuiform_wev8.js"></script>

<%
	
	
	String wfi="";
    sql="select workflowid from workflow_requestbase where requestid="+requestid;
	rs.executeSql(sql);
	if(rs.next()){
		wfi=Util.null2String(rs.getString("workflowid"));
	}else{
		response.sendRedirect("/notice/noright.jsp");
		return;
	}
	String workflowid = wfi ;
%>
<% 
	String type = Util.null2String(request.getParameter("type"));
	String workflowId = wfi;
	String dataurl = "/workflow/design/workflowPicDisplayInfo.jsp;jsessionid=" + session.getId() + "?requestid=" + requestid + "&wfid=" + workflowid + "&type=" + type;

//	System.out.println(dataurl);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
	<head>
		<title></title>

		<meta http-equiv="pragma" content="no-cache">
		 <link rel="stylesheet" type="text/css" href="/workflow/design/bin-debug/history/history_wev8.css" />
        <script type="text/javascript" src="/workflow/design/bin-debug/history/history_wev8.js"></script>
            
        <script type="text/javascript" src="/workflow/design/bin-debug/swfobject_wev8.js"></script>
        <script type="text/javascript">
            // For version detection, set to min. required Flash Player version, or 0 (or 0.0.0), for no version detection. 
            var swfVersionStr = "10.2.0";
            // To use express install, set to playerProductInstall.swf, otherwise the empty string. 
            var xiSwfUrlStr = "/workflow/design/bin-debug/playerProductInstall.swf";
            var flashvars = {};
            var params = {};
            params.quality = "high";
            params.bgcolor = "#ffffff";
            params.allowscriptaccess = "sameDomain";
            params.allowfullscreen = "true";
            //params.wmode="transparent";
            params.wmode = "opaque";
            var attributes = {};
            attributes.id = "EAdvanceGrid";
            attributes.name = "EAdvanceGrid";
            attributes.align = "middle";
            swfobject.embedSWF(
                "/workflow/design/bin-debug/EAdvanceGrid.swf", "flashContent", 
                "100%", "100%", 
                swfVersionStr, xiSwfUrlStr, 
                flashvars, params, attributes);
            // JavaScript enabled so display the flashContent div in case it is not replaced with a swf object.
            swfobject.createCSS("#flashContent", "display:block;text-align:left;");
        </script>
		 
		<script type="text/javascript"> 
		</script> 
		
		<script type="text/javascript">
		function getDataUrl() {
			var url = window.location.protocol + "//" + window.location.host + "<%=dataurl%>";
			return url;
		}
				
		function getAppUrl() {
			var url = window.location.protocol + "//" + window.location.host + "/";
			return url;
		}
		
		function getLanguage() {
			var language = "7";
			return language;
		}
		//获取出口条件
		function getOutletConditions(workflowid, nodelinkid){
			var ajaxUrl = '/workflow/design/wfQueryConditions.jsp?nodelinkid='+nodelinkid+'&workflowid='+workflowid+'&timeToken=' + new Date().getTime();
			//alert(ajaxUrl);
			jQuery.ajax({
			    url: ajaxUrl,
			    dataType: "text", 
			    contentType : "charset=UTF-8", 
			    error:function(ajaxrequest){}, 
			    success:function(data){
			    	//alert(data);
			    	jQuery("#Main")[0].flexFunctionNodeLinkCondition(nodelinkid, jQuery.trim(data));
			    }  
		    });
		}
		jQuery(document).ready(function () {
			jQuery("#Main").focus();
			jQuery("#Main").height(jQuery(document.body).height() - 5);
		});
		
		window.onresize = function () {
			jQuery("#Main").height(jQuery(document.body).height() - 5);
		};
		
		function isE8() {
			return true;
		}
		</script>
	</head>
	<body class="" id="" scroll="no" oncontextmenu="return false" onbeforeunload="" style="height:100%;padding:0px!important;margin:0px!important;margin-top:5px!important;overflow:hidden;">
		<DIV style="width:100%;height:100%;" id="editContentArea">
				<!-- <noscript> -->
				
				<!--[if IE]>
				<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="100%" height="100%" id="Main">
	                <param name="movie" value="/workflow/design/bin-debug/Main.swf" />
	                <param name="quality" value="high" />
	                <param value='transparent'>
	                <param name="bgcolor" value="#ffffff" />
	                <param name="allowScriptAccess" value="sameDomain" />
	                <param name="allowFullScreen" value="true" />
	                
	                <!--[if !IE]><!-->
	                <object type="application/x-shockwave-flash" width="100%" height="100%" id="Main" data="/workflow/design/bin-debug/Main.swf">
	                	<param name="movie" value="/workflow/design/bin-debug/Main.swf" />
	                    <param name="quality" value="high" />
	                    <param value='transparent'>
	                    <param name="wmode" value="transparent" />
	                    <param name="bgcolor" value="#ffffff" />
	                    <param name="allowScriptAccess" value="sameDomain" />
	                    <param name="allowFullScreen" value="true" />
	                </object>
		            <!--<![endif]-->
	            </object>
	            <![endif]-->
				<!-- </noscript>  -->
		</DIV>
	</body>
</html>