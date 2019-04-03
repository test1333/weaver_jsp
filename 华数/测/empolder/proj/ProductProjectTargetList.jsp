<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="BudgetfeeTypeComInfo" class="weaver.fna.maintenance.BudgetfeeTypeComInfo" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="recordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="tools" class="tool.tools" scope="page" />
<%
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
String titlename = "产品目标看板";
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
// RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:submitData(this),_self} " ;
// RCMenuHeight += RCMenuHeightStep ;
// if(!"".equals(id)){
// 	RCMenu += "{"+SystemEnv.getHtmlLabelName(91,user.getLanguage())+",javascript:doDelete(this),_self} " ;
// 	RCMenuHeight += RCMenuHeightStep ;
// }
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
    			<table border="1" width="150%">
		<tr bgcolor="#F6BEAB" style="height: 70px">
			<td style="width: 50px"><strong>序号</strong></td>
			<td style="width: 105px"><strong>产品开发项目</strong></td>
			<td style="width: 130px"><strong>产品线+版本</strong></td>
			<td style="width: 80px"><strong>上线时间</strong></td>
			<td style="width: 195px"><strong>&nbsp;产品版本目标</strong><br/>（产品特征、上线范围）</td>
			<td style="width: 195px"><strong>&nbsp;技术目标</strong><br/>（技术能力、服务能力、<br/>运维功能等）</td>
			<td style="width: 80px"><strong>完成时间</strong></td>
			<td style="width: 80px"><strong>完成情况</strong></td>
			<td style="width: 160px"><strong>存在的问题及风险</strong></td>
			<td style="width: 210px"><strong>目标及进度变更记录</strong></td> 
			<td style="width: 120px">&nbsp;<strong>业务负责</strong><br/>(业务部门)</td> 
			<td style="width: 140px"><strong>&nbsp;产品负责</strong><br/>(产品管理部)</td>
			<td style="width: 80px"><strong>项目经理</strong></td>
			<td style="width: 80px"><strong>技术经理</strong></td>
		</tr>
	 	<%
	 	    for(int i=0;i<2;i++){ 
	 	    int flag = 0;
	 	%>
	 	   <tr bgcolor="#FDF6AD">
	 	   		<td colspan="2"><%=i+1 %>、xxxx</td>
	 	   		<td></td><td></td><td></td><td></td><td></td>
	 	   		<td></td><td></td><td></td><td></td><td></td><td></td><td></td>
	 	   </tr>
	 	   <%
	 	   	for(int j=0;j<2;j++){
	 	   	flag++;
	 	   	int tmp = 2;   // 项目下有几个子项目
	 	    %>
	 	       <% for(int k=0;k<tmp;k++){%>
	 	       		<tr>
	 	       		<%if(k==0){ %>
		 	   		<td rowspan=<%=tmp %>><%=i+1 %>.<%=flag %></td><td rowspan=<%=tmp %>></td>
		 	   		<%} %>
		 	   		<td>产品线+版本</td><td></td><td></td>
		 	   		<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td>&nbsp;</td>
		 	   		</tr>
	 	       <%} %>
	 	       
		 	   
	 	   <% }%>
	 		
	 	<%} %>
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
function submitData(obj) {
        if(check_form(right,"name")){
            right.submit();
            obj.disabled=true;
        }
}
function doDelete(obj){
	if(confirm("<%=SystemEnv.getHtmlNoteName(7,user.getLanguage())%>")) {
		right.operation.value="delete";
		right.submit();
    }
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