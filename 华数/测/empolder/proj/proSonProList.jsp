<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="BudgetfeeTypeComInfo" class="weaver.fna.maintenance.BudgetfeeTypeComInfo" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="recordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="recordDetail" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rec" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs_1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="tools" class="tool.tools" scope="page" />
<%
if(!HrmUserVarify.checkUserRight("kbpower:view",user)) {
response.sendRedirect("/notice/noright.jsp") ;
return ;
}
	String id= Util.null2String(request.getParameter("id"));
	
String num = "";
String name = "";
String version = "";
String forLine = "";
String priority = "";
String timeLine = "";
String execution = "";
String overTime = "";
String productManager = "";
String projectManager = "";
String members = "";
String target = "";
	
	if(!"".equals(id)){
		String sql = "select * from projectInfo where id = '"+id+"'";
		rs.executeSql(sql);
		if(rs.next()){
			num = rs.getString("num");
			name = rs.getString("name");
			version =  rs.getString("version");
			forLine =  rs.getString("forLine");
			priority =  rs.getString("priority");
			timeLine =  rs.getString("timeLine");
			execution =  rs.getString("execution");
			overTime =  rs.getString("overTime");
			productManager =  rs.getString("productManager");
			projectManager =  rs.getString("projectManager");
			members =  rs.getString("members");
			target =  rs.getString("target");
		}
	}

%>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
<script language="javascript" type="text/javascript" src="/js/jquery/jquery-1.4.2.min.js"></script>
</head>
<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "产品开发及优化计划看板";
String needfav ="1";
String needhelp ="";
%>
<BODY>
<style type="text/css"> 
<!--
  .table_style td
        {
            border: solid #000 1px;
        }
        .table_style
        {
         border-collapse: collapse;
            border: none;
        }
-->
</style>

<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
	RCMenu += "{导出看板,javascript:toXls(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
<tr>
	<td height="10" colspan="3"></td>
</tr>
<tr>
	<td >
	</td>
	<td valign="top">
	<FORM style="MARGIN-TOP: 0px" name=right method=post action="ProductAddOperation.jsp" >
		<TABLE class=Shadow>
		<tr>
		<td valign="top">
  <input class=inputstyle type="hidden" name="id" value="<%=id%>">
  <input class=inputstyle type="hidden" name="operation" />
  <TABLE class=ViewForm>
    <COLGROUP> <COL width="15%"> <COL width="35%"><COL width="15%"> <COL width="35%"><TBODY> 
    <div>
    	<tr>
    		<td colspan="4">
    <table width=100%  border="1" cellspacing="0" cellpadding="0" class="table_style" id="proXls">
				<tr bgcolor="#F6BEAB" style="height: 70px">
			<td width=4%><strong>编号</strong></td>
			<td width=8%><strong>产品线+版本</strong></td>
			<td width=8%><strong>产品开发项目</strong></td>
			<td width=4%><strong>&nbsp;</strong></td>
			<td width=4%><strong>项目启动</strong></td>
			<td width=4%><strong>产品框架需求确认</strong></td>
			<td width=4%><strong>计划制定</strong></td>
			<td width=4%><strong>产品需求确认</strong></td>
			<td width=4%><strong>技术方案确认</strong></td>
			<td width=4%><strong>页面设计</strong></td>
			<td width=4%><strong>站点建设</strong></td> 
			<td width=4%>&nbsp;<strong>内容准备</strong></td> 
			<td width=4%><strong>终端定版(定版报告)</strong></td>
			<td width=4%><strong>业务支撑就绪</strong></td>
			<td width=4%><strong>技术集成完成(报告及结论)</strong></td>
			<td width=4%><strong>产品策略及定价</strong></td>
			<td width=4%><strong>业务管理规范</strong></td>
			<td width=4%><strong>产品验收及培训</strong></td>
			<td width=4%><strong>产品部署及上线</strong></td>
			<td width=4%><strong>完成情况</strong></td>
		</tr>
			
				 	<%
				 		int i = 0;
				 		String sql = "select * from serviceLine where isShow = '0' order by id";
				 		rs.executeSql(sql);
				 		
				 		while(rs.next()){
				 			i++;
				 	    int flag = 0;
				 	%>
				 	   <tr bgcolor="#FDF6AD">
				 	   		<td colspan="2"><%=i %>、<%=rs.getString("name") %></td>
				 	   		<td></td><td></td><td></td><td></td><td></td>
				 	   		<td></td><td></td><td></td><td></td><td></td><td></td><td></td>
				 	   		<td></td><td></td><td></td><td></td><td></td><td></td>
				 	   </tr>
				 	   <%
// 				 	    String sql_1 = "select * from productProject where forServerLine = '"+rs.getString("id")+"'";
				 	  	String sql_1 = "select * from projectInfo where forLine = '"+rs.getString("id")+"'";
				 	  	recordSet.executeSql(sql_1);
				 	  	while(recordSet.next()){
				 	  		int m = 0;
				 	  		flag++;
				 	  		String projectId = recordSet.getString("id");
				 	  		String projectName = recordSet.getString("name");
// 				 	  		String sql_2 = "select * from Prj_ProjectInfo where productProjectID = '"+
// 											projectId+"' and (overtime is null or substr(overtime, 0,7) = to_char(Sysdate, 'yyyy-MM')) and substr(timeline,0,4) = to_char(sysdate, 'yyyy') order by overTime";
							String sql_2 = "select r.* from Prj_ProjectInfo  r left join productProject pp on (pp.id=r.productprojectid)  where productVersionID = '"+
									projectId+"' and (overtime is null or substr(overtime, 0,7) = to_char(Sysdate, 'yyyy-MM')) and substr(timeline,0,4) = to_char(sysdate, 'yyyy') order by pp.order_o,timeLine,overTime";
				 	  		recordDetail.executeSql(sql_2);
				 	  		int tmp = recordDetail.getCounts();
				 	  		if(tmp < 1) continue;
				 	  		while(recordDetail.next()){
				 	  			String productId = recordDetail.getString("id");
				 	  			m++;
					 	  	%>
					 	  			<tr class=datalight>
					 	  	<%
					 	  		if(m==1){
					 	    %>
					 	   		<td rowspan=<%=2*tmp %>><%=i %>.<%=flag %></td><td rowspan=<%=2*tmp %>><%=tools.getProjectInfoName(projectId) %></td>
					 	    <%
					 	    }
					 	     %>
					 	   	  	
<%-- 					 	   		<td rowspan=2><%=tools.getProjectInfoName(recordDetail.getString("productVersionID"))  %></td> --%>
									<td rowspan=2><%=tools.getProductPorjectName(recordDetail.getString("productProjectID"))  %></td>
					 	   		<td> 计划时间 </td>
					 	   		<%
					 	   			String sql_str = "";
					 	   			String sql_st1 = "SELECT templetTaskId FROM Prj_TemplateTask WHERE templetId = '"+recordDetail.getString("proTemplateId")+"' order by templetTaskId";
					 	   		rec.executeSql(sql_st1);
					 	   		int tmp_flag = 0;
					 	   		while(rec.next()){
					 	   		sql_str = "select enddate from  Prj_TaskProcess where prjid = '"+productId+"' and taskindex = '"+rec.getString("templetTaskId")+"' order by taskIndex";
							 	   	rs_1.executeSql(sql_str);
							 	   	if(rs_1.next()){
							 	   		tmp_flag++;
							 	   		%><td><%=rs_1.getString("enddate") %></td><%
							 	   		
							 	   	}
					 	   		}
					 	   		for(int key=0;key<15-tmp_flag;key++){
					 	   		%><td></td><%
					 	   		}
					 	   		%>
				 	   			<td rowspan=2><%
					 	   			String execution1 = recordDetail.getString("execution");
					 	   			if("0".equals(execution1)){
					 	   				out.print("正常");
					 	   			}else if("1".equals(execution1)){
					 	   				out.print("暂缓");
					 	   			}else if("2".equals(execution1)){
					 	   				out.print("延期");
					 	   			}else if("3".equals(execution1)){
					 	   				out.print("完成");
					 	   			}
					 	   		 %></td>
					 	   </tr>
					 	   <tr class=datadark>
					 	   		<td> 实际时间</td>
					 	   		<%
					 	   			String sql_str_1 = "";
					 	   			String sql_st1_1 = "SELECT templetTaskId FROM Prj_TemplateTask where templetId = '"+recordDetail.getString("proTemplateId")+"' order by templetTaskId";
					 	   			rec.executeSql(sql_st1_1);
					 	   			tmp_flag = 0; 
					 	   			while(rec.next()){
					 	   			
					 	   			sql_str_1 = "select actualenddate from  Prj_TaskProcess where prjid = '"+productId+"' and taskindex = '"+rec.getString("templetTaskId")+"' order by taskIndex";
								 	   	rs_1.executeSql(sql_str_1);
								 	   	if(rs_1.next()){
								 	   		tmp_flag++;
								 	   		%><td><%=rs_1.getString("actualenddate") %> </td><%
								 	   	}
					 	   			}
						 	   		for(int key=0;key<15-tmp_flag;key++){
						 	   		%><td></td><%
						 	   		}
					 	   		%>
					 	   		
					 	   </tr>
				 	   <% 	}
						}
					} %>
				</table>
    		</td>
    	</tr>
    </div>
    </TBODY> 
  </TABLE>
</td>
</tr>
</TABLE>
</FORM>
</td>	
<td>
</td>
</tr>
<tr>
<td height="10" colspan="3"></td>
</tr>
</table>
<Script language=javascript>
						
	function toXls() {
		    var curTbl = document.getElementById("proXls");
		    var oXL = null;   
		    try {  
		        oXL = GetObject("", "Excel.Application");  
		    }catch (E){  
		        try {  
		        	// 客户端自带Excel信息
		            oXL = new ActiveXObject("Excel.Application");  
		        } catch (E2) {  
		            alert("下载警告:\n1、请确保使用IE浏览器(或为IE内核的浏览器)下载\n2、请将该网站设置为信任网站");  
		            return;  
		        }  
		    }     
		    
		    var oWB = oXL.Workbooks.Add();
		    
		    var oSheet = oWB.ActiveSheet;
		    
		    //在此进行样式控制  
//		    oSheet.Rows(1+":"+1).RowHeight =20;//定义行高  
//		    oSheet.Rows(2+":"+2).RowHeight =30;  

		    //定义列宽  
		    // 编号
		    oSheet.Columns('A:A').ColumnWidth = 5;  
		    // 产品开发项目
		    oSheet.Columns('B:B').ColumnWidth = 30;  
		    // 产品线+版本
		    oSheet.Columns('C:C').ColumnWidth = 20;  
		    // 计划时间
		    oSheet.Columns('D:D').ColumnWidth = 7;  
		    // 项目启动
		    oSheet.Columns('E:E').ColumnWidth = 10;  
		    // 产品框架需求确认
		    oSheet.Columns('F:F').ColumnWidth = 10;  
		    // 计划制定
		    oSheet.Columns('G:G').ColumnWidth = 10; 
		    // 产品需求确认 
		    oSheet.Columns('H:H').ColumnWidth = 10;  
		    // 技术方案确认
		    oSheet.Columns('I:I').ColumnWidth = 10;  
		    // 页面设计
		    oSheet.Columns('J:J').ColumnWidth = 10;  
		    // 站点建设
		    oSheet.Columns('L:L').ColumnWidth = 10; 
		    // 内容准备
		    oSheet.Columns('M:M').ColumnWidth = 10; 
		    // 终端定版
		    oSheet.Columns('N:N').ColumnWidth = 10; 
		    // 业务支撑
		    oSheet.Columns('O:O').ColumnWidth = 10; 
		    // 技术集成完成
		    oSheet.Columns('P:P').ColumnWidth = 10; 
		    // 产品策略
		    oSheet.Columns('Q:Q').ColumnWidth = 10; 
		    // 业务管理
		    oSheet.Columns('R:R').ColumnWidth = 10;
		    // 产品验收
		    oSheet.Columns('S:S').ColumnWidth = 10;
		    // 产品部署
		    oSheet.Columns('T:T').ColumnWidth = 10;
		    // 完成情况
		    oSheet.Columns('U:U').ColumnWidth = 10;
		  	
		    var sel = document.body.createTextRange();
		    sel.moveToElementText(curTbl);
		    sel.select();
		    sel.execCommand("Copy");
		    oSheet.Paste();
		    oXL.Visible = true;
		}
						
function onServiceLineBrowser() {
	var id1 = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/empolder/proj/ServiceLineBrowser.jsp");
	                     if (id1) {
				var ids = id1.id;
				var names = id1.name;
				if (ids.length > 0) {
					jQuery("#forLine").val(ids);
					jQuery("#forLinespan").html(names);
				} else {
					jQuery("#forLine").val("");
					jQuery("#forLinespan").html("");
				}
			}
	}
</script>

<script language=vbs>
sub onShowResource()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp")
	if NOT isempty(id) then
	        if id(0)<> "" then
		projectManagerspan.innerHtml = id(1)
		right.projectManager.value=id(0)
		else
		projectManagerspan.innerHtml = ""
		right.projectManager.value=""
		end if
	end if

end sub
sub onShowResource1()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp")
	if NOT isempty(id) then
	        if id(0)<> "" then
		productManagerspan.innerHtml = id(1)
		right.productManager.value=id(0)
		else
		productManagerspan.innerHtml = ""
		right.productManager.value=""
		end if
	end if

end sub

sub ShowMultiResource(spanname,hiddenidname)
    id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp?resourceids="+hiddenidname.value)
	if (Not IsEmpty(id)) then
        If id(0) <> "" and id(0) <> "0" Then
            spanname.innerHtml = Mid(id(1),2,len(id(1)))
            hiddenidname.value= Mid(id(0),2,len(id(0)))
	    else
            spanname.innerHtml = ""
            hiddenidname.value=""
        end if
    end if
end sub
</script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
</BODY>
</HTML>