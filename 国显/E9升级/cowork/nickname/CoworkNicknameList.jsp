<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*"%>
<%@ include file="/systeminfo/init_wev8.jsp"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
 
<%

String sql = "select name from nickname where userid = ?";
rs.executeQuery(sql,user.getUID()+"");
boolean hasnickname = false;
if(rs.getCounts()>0){
	hasnickname = true;
}
if(!hasnickname) {
 	response.sendRedirect("/cowork/nickname/coworknicknameview.jsp?loca=12") ;
  	return ;
}

String sharevalue = new BaseBean().getPropValue("CoworkNickname", "roleid");
List shareroleids =Util.TokenizerString(sharevalue, ",");
rs.executeSql("select resourceid from hrmrolemembers where "+ Util.getSubINClause(sharevalue, "roleid", "IN"));
Set<String> allids = new HashSet<String>();

while(rs.next()){
	String userresourceid=Util.null2String(rs.getString("resourceid"));
	allids.add(userresourceid);
}

if(!(allids.contains(user.getUID()+""))){
	out.print("<script>window.location.href=\"/notice/noright.jsp\"</script>");
    return ;
}
 
%>

<html>
    <head>
        <%
        	String departmentid = Util.null2String(request.getParameter("departmentid"));
        %>
        <script src="/js/tabs/jquery.tabs.extend_wev8.js"></script>
        <link type="text/css" href="/js/tabs/css/e8tabs1_wev8.css" rel="stylesheet" />
        <link rel="stylesheet" href="/css/ecology8/request/searchInput_wev8.css" type="text/css" />
        <script type="text/javascript" src="/js/ecology8/request/searchInput_wev8.js"></script>
        <link rel="stylesheet" href="/css/ecology8/request/seachBody_wev8.css" type="text/css" />
        <link rel="stylesheet" href="/css/ecology8/request/hoverBtn_wev8.css" type="text/css" />
        <script type="text/javascript" src="/js/ecology8/request/hoverBtn_wev8.js"></script>
        <script type="text/javascript" src="/js/ecology8/request/titleCommon_wev8.js"></script>
    </head>

    <body scroll="no">
    	<div class="e8_box demo2" id="rightContent">
    		<div class="e8_boxhead">
    			<div class="div_e8_xtree" id="div_e8_xtree"></div>
                <div class="e8_tablogo" id="e8_tablogo"></div>
                <div class="e8_ultab">
                    <div class="e8_navtab" id="e8_navtab">
                        <span id="objName"></span>
                    </div>
    				<div>
    					<ul class="tab_menu">
                            <!-- 
    						<li class="e8_tree">
    							<a><%=SystemEnv.getHtmlLabelName(455,user.getLanguage()) %></a> 
    						</li>
    						<li class="defaultTab">
    							<a href="" target="tabcontentframe" _datetype="list"><%=SystemEnv.getHtmlLabelName(23669,user.getLanguage())%></a>
    						</li>
                             -->
    					</ul>
    					<div id="rightBox" class="e8_rightBox"></div>
    				</div>
    			</div>
    		</div>
    		<div class="tab_box">
    		    <iframe src="" onload="update()" id="tabcontentframe" name="tabcontentframe" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>
            <div>
    	</div>	
    </body>

    <script type="text/javascript">
        window.notExecute = true;
        var diag= null;
        $(document).ready(function(){
    	    $('.e8_box').Tabs({
    			getLine : 1,
    			iframe : "tabcontentframe",
    			mouldID:"<%=MouldIDConst.getID("cowork")%>",
    	       	staticOnLoad:true,
    	        objName:"协作昵称设置"   
    		});
    		attachUrl();
    		
            /*
    		jQuery("#e8_tablogo").bind("click",function(){
    			if(jQuery("#e8treeArea",parent.document).children().length==0){
        			parent.refreshTree2();
        		}
        	});
            */
    	});
      
      	function attachUrl(){
    	   $("[name='tabcontentframe']").attr("src","/cowork/nickname/CoworkNicknameListChild.jsp?departmentid=<%=departmentid %>");
    	}
    	
    	  function edit(id){
    	 // alert(id);
     diag = new window.Dialog();
 	diag.Title = '昵称修改'; 
	diag.Width = 300;
    diag.Height = 120;
    diag.normalDialog= false;
    diag.URL = "/cowork/nickname/CoworkNicknameEdit.jsp?id="+id;
    diag.show();
    document.body.click();       	 
        }
        
        	  function checklog(id){
     diag = new window.Dialog();
 	diag.Title = '查看修改日志'; 
	diag.Width = 680;
    diag.Height = 500;
    diag.normalDialog= false;
    diag.URL = "/cowork/nickname/CoworkNicknameLogView.jsp?id="+id;
    diag.show();
    document.body.click();       	
    
      
        }

           function MainCallback(){
	diag.close();
var iframe = window.document.getElementById("tabcontentframe"); 
iframe.contentWindow.toreloadtable();
}
    </script>
</html>

