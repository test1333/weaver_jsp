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
String titlename = "��Ʒ�������Ż��ƻ�����";
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
	RCMenu += "{��������,javascript:toXls(),_self} " ;
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
			<td width=4%><strong>���</strong></td>
			<td width=8%><strong>��Ʒ��+�汾</strong></td>
			<td width=8%><strong>��Ʒ������Ŀ</strong></td>
			<td width=4%><strong>&nbsp;</strong></td>
			<td width=4%><strong>��Ŀ����</strong></td>
			<td width=4%><strong>��Ʒ�������ȷ��</strong></td>
			<td width=4%><strong>�ƻ��ƶ�</strong></td>
			<td width=4%><strong>��Ʒ����ȷ��</strong></td>
			<td width=4%><strong>��������ȷ��</strong></td>
			<td width=4%><strong>ҳ�����</strong></td>
			<td width=4%><strong>վ�㽨��</strong></td> 
			<td width=4%>&nbsp;<strong>����׼��</strong></td> 
			<td width=4%><strong>�ն˶���(���汨��)</strong></td>
			<td width=4%><strong>ҵ��֧�ž���</strong></td>
			<td width=4%><strong>�����������(���漰����)</strong></td>
			<td width=4%><strong>��Ʒ���Լ�����</strong></td>
			<td width=4%><strong>ҵ�����淶</strong></td>
			<td width=4%><strong>��Ʒ���ռ���ѵ</strong></td>
			<td width=4%><strong>��Ʒ��������</strong></td>
			<td width=4%><strong>������</strong></td>
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
				 	   		<td colspan="2"><%=i %>��<%=rs.getString("name") %></td>
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
					 	   		<td> �ƻ�ʱ�� </td>
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
					 	   				out.print("����");
					 	   			}else if("1".equals(execution1)){
					 	   				out.print("�ݻ�");
					 	   			}else if("2".equals(execution1)){
					 	   				out.print("����");
					 	   			}else if("3".equals(execution1)){
					 	   				out.print("���");
					 	   			}
					 	   		 %></td>
					 	   </tr>
					 	   <tr class=datadark>
					 	   		<td> ʵ��ʱ��</td>
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
		        	// �ͻ����Դ�Excel��Ϣ
		            oXL = new ActiveXObject("Excel.Application");  
		        } catch (E2) {  
		            alert("���ؾ���:\n1����ȷ��ʹ��IE�����(��ΪIE�ں˵������)����\n2���뽫����վ����Ϊ������վ");  
		            return;  
		        }  
		    }     
		    
		    var oWB = oXL.Workbooks.Add();
		    
		    var oSheet = oWB.ActiveSheet;
		    
		    //�ڴ˽�����ʽ����  
//		    oSheet.Rows(1+":"+1).RowHeight =20;//�����и�  
//		    oSheet.Rows(2+":"+2).RowHeight =30;  

		    //�����п�  
		    // ���
		    oSheet.Columns('A:A').ColumnWidth = 5;  
		    // ��Ʒ������Ŀ
		    oSheet.Columns('B:B').ColumnWidth = 30;  
		    // ��Ʒ��+�汾
		    oSheet.Columns('C:C').ColumnWidth = 20;  
		    // �ƻ�ʱ��
		    oSheet.Columns('D:D').ColumnWidth = 7;  
		    // ��Ŀ����
		    oSheet.Columns('E:E').ColumnWidth = 10;  
		    // ��Ʒ�������ȷ��
		    oSheet.Columns('F:F').ColumnWidth = 10;  
		    // �ƻ��ƶ�
		    oSheet.Columns('G:G').ColumnWidth = 10; 
		    // ��Ʒ����ȷ�� 
		    oSheet.Columns('H:H').ColumnWidth = 10;  
		    // ��������ȷ��
		    oSheet.Columns('I:I').ColumnWidth = 10;  
		    // ҳ�����
		    oSheet.Columns('J:J').ColumnWidth = 10;  
		    // վ�㽨��
		    oSheet.Columns('L:L').ColumnWidth = 10; 
		    // ����׼��
		    oSheet.Columns('M:M').ColumnWidth = 10; 
		    // �ն˶���
		    oSheet.Columns('N:N').ColumnWidth = 10; 
		    // ҵ��֧��
		    oSheet.Columns('O:O').ColumnWidth = 10; 
		    // �����������
		    oSheet.Columns('P:P').ColumnWidth = 10; 
		    // ��Ʒ����
		    oSheet.Columns('Q:Q').ColumnWidth = 10; 
		    // ҵ�����
		    oSheet.Columns('R:R').ColumnWidth = 10;
		    // ��Ʒ����
		    oSheet.Columns('S:S').ColumnWidth = 10;
		    // ��Ʒ����
		    oSheet.Columns('T:T').ColumnWidth = 10;
		    // ������
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