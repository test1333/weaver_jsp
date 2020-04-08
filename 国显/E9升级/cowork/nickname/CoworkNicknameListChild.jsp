
<%@page import="weaver.hrm.resource.ResourceComInfo"%><%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<%@ page import="weaver.conn.*" %>
<%@ page import="java.io.*" %>
<%@ page import="oracle.sql.CLOB" %>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="CoMainTypeComInfo" class="weaver.cowork.CoMainTypeComInfo" scope="page"/>

<html>
    <head>
        <LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
        <script type="text/javascript" src="/cowork/js/coworkUtil_wev8.js"></script>
        
    </head>

<%
	String userid = user.getUID()+"";
	String depid = ResourceComInfo.getDepartmentID(userid);
	new BaseBean().writeLog(""+depid);
    String imagefilename = "/images/hdHRM_wev8.gif";
    String titlename = SystemEnv.getHtmlLabelName(320,user.getLanguage())+":"+SystemEnv.getHtmlLabelName(17694,user.getLanguage());
    String needfav ="1";
    String needhelp ="";
    
  	//搜索条件参数
    String typename=Util.null2String(request.getParameter("typename"));
    String department = Util.null2String(request.getParameter("department"));
    String principal = Util.null2String(request.getParameter("principal"));
 
    
    String tableString = "";
    int perpage=10;                                 
    String backfields = " a.id,a.userid,a.name,a.registtime,b.departmentid,b.mobile ";
    //String fromSql  = " mailcontroltime ";
    String fromSql = " from nickname a left join HrmResource b on a.userid = b.id";
    String sqlWhere = " 1=1 ";
    String orderby = " a.id ";
   

     
    if(!typename.equals(""))
    	sqlWhere=sqlWhere+" and name like '%"+typename+"%' ";
	if(department.length() >0){
		sqlWhere += " and b.departmentid = "+department ;
	}
	if(!principal.equals("")){
		sqlWhere += " and b.id='"+principal+"'  "; 
	}
    
    tableString = " <table tabletype='none'  pageId=\""+PageIdConst.Cowork_CoworkMine+"\"  pagesize=\""+PageIdConst.getPageSize(PageIdConst.Cowork_CoworkMine,user.getUID(),PageIdConst.COWORK)+"\" >"+
    			
    			  " <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"a.id\" sqlsortway=\"Desc\" sqlisdistinct=\"true\" />"+
                  " <head>"+
                  "	<col width=\"10%\"  text=\""+"昵称"+"\" orderkey=\"name\" column=\"name\" otherpara='column:userid+1' transmethod=\"weaver.hrm.resource.ResourceComInfo.getMulResourceNickname1\" />"+
                  " <col width=\"15%\" text=\""+"OA姓名"+"\" orderkey=\"userid\" column=\"userid\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getMulResourcename1\"/>"+
                  "	<col width=\"20%\" text=\""+SystemEnv.getHtmlLabelName(124,user.getLanguage())+"\" column=\"departmentid\" orderkey=\"departmentid\" transmethod=\"weaver.hrm.company.DepartmentComInfo.getDepartmentname\" linkvaluecolumn=\"departmentid\" linkkey=\"id\" href=\"/hrm/HrmTab.jsp?_fromURL=HrmDepartmentDsp\"/>"+
                  "	<col width=\"10%\"  text=\""+"电话"+"\" orderkey=\"mobile\" column=\"mobile\"   />"+
                  "	<col width=\"10%\"  text=\""+"注册日期"+"\" orderkey=\"registtime\" column=\"registtime\"   />"+
                  "	</head>"+ 
                  " <operates width=\"25%\">"+
                  "     <operate  href=\"javascript:parent.edit()\" text=\""+"修改"+"\" target=\"_self\"  index=\"1\"/>"+
          		  "     <operate  href=\"javascript:parent.checklog()\" text=\""+"查看历史记录"+"\" target=\"_self\"  index=\"1\"/>"+
          		  " </operates>"+
                  "</table>";
%>
        <%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
        <%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
        <%
           
            
        %>
        <%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>

    <body>
        <wea:layout attributes="{layoutTableId:topTitle}">
        	<wea:group context="" attributes="{groupDisplay:none}">
        		<wea:item attributes="{'customAttrs':'class=rightSearchSpan'}">
        		 <input type="text" class="searchInput" name="flowTitle" id="flowTitle" value="<%=typename %>"/>
						<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span><span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>       		 
        		</wea:item>
        	</wea:group>
        </wea:layout>
    
    <!-- 高级搜索 -->
        <div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;" >	
        <form id="mainfrom" action="/cowork/nickname/CoworkNicknameListChild.jsp" method="post">
            <wea:layout type="4col">
            	<wea:group context="" attributes="{'groupDisplay':'none'}">
            		<wea:item>昵称</wea:item>
            		<wea:item>
            			<input class="inputstyle" type="text" name="typename" id="typename" value="<%=typename%>" style="width:150px;" maxlength=25 onkeydown="if(window.event.keyCode==13) return false;">      
            		</wea:item> 
            		
           			<wea:item>用户</wea:item>
			 		<wea:item>
			       <brow:browser viewType="0" name="principal" browserValue="" 
							browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp"
							hasInput="true" isSingle="true" hasBrowser = "true" isMustInput='1'
							completeUrl="/data.jsp" width="205px;" 
							browserSpanValue="">
				   </brow:browser>			       
			  		</wea:item>
            		
            		<wea:item><%=SystemEnv.getHtmlLabelName(124,user.getLanguage())%></wea:item>
					<wea:item>
							<brow:browser viewType="0" name="department"  browserValue=''
						         browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp"
						         isSingle="true" hasBrowser="true"  hasInput="true" isMustInput='1'
						         completeUrl="/data.jsp?type=4" width="60%" 
						         browserSpanValue=''
						         ></brow:browser>
					</wea:item>
						        		

            	</wea:group>
            	
            	<wea:group context="" attributes="{'Display':'none'}">
            		<wea:item type="toolbar">
            			<input type="submit" class="e8_btn_submit" value="<%=SystemEnv.getHtmlLabelName(197,user.getLanguage())%>" id="searchBtn"/>
            			<span class="e8_sep_line">|</span>
            			<input type="button" name="reset" onclick="resetCondtion()" value="<%=SystemEnv.getHtmlLabelName(2022 ,user.getLanguage()) %>" class="e8_btn_cancel"/>
            			<span class="e8_sep_line">|</span>
            			<input type="button" value="<%=SystemEnv.getHtmlLabelName(201,user.getLanguage())%>" class="e8_btn_cancel" id="cancel"/>
            		</wea:item>
            	</wea:group>
            </wea:layout>
        </form>	
    </div>
    <input type="hidden" name="pageId" id="pageId" value="<%=PageIdConst.Cowork_CoworkMine%>">	
    <wea:SplitPageTag  tableString='<%=tableString%>'  mode="run" />
    
    <script>
        var diag ;
        function callback(){
        	if(diag){
        		diag.close();
        	}
        	_table.reLoad();
        	//parent.parent.refreshTree();
        }
        
        function doSearch(){
        	jQuery("#mainfrom").submit();
        }       
    
        function closeDialogcreateLabel(){
	diag.close();
	_table.reLoad();
}
              
        $(document).ready(function(){
        	jQuery("#topTitle").topMenuTitle({searchFn:searchTypeName});
        	jQuery("#hoverBtnSpan").hoverBtn();
        });
         
        function searchTypeName(){ 
	       
        	var searchtypename = jQuery("#flowTitle").val();
        	
        		jQuery("#typename").val(searchtypename);
        	window.mainfrom.action = "/cowork/nickname/CoworkNicknameListChild.jsp?typename="+searchtypename;
        	window.mainfrom.submit();
        } 

		function toreloadtable(){
	_table.reLoad();
		}
        
        
         
      
        </script>
    </body>
</html>
