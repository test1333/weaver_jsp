<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="BudgetfeeTypeComInfo" class="weaver.fna.maintenance.BudgetfeeTypeComInfo" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="recordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rec" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="tools" class="tool.tools" scope="page" />
<%

if(!HrmUserVarify.checkUserRight("kbpower:view",user)) {
response.sendRedirect("/notice/noright.jsp") ;
return ;
}
%>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
<script language="javascript" type="text/javascript" src="/js/jquery/jquery-1.4.2.min.js"></script>
	
</head>
<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "��ƷĿ�꿴��";
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
  <input class=inputstyle type="hidden" name="operation" />
  <TABLE class=ViewForm>
    <COLGROUP> <COL width="15%"> <COL width="35%"><COL width="15%"> <COL width="35%"><TBODY> 
    <div>
    	<tr>
    		<td colspan="4">
    	<table width=100%   border="1" cellspacing="0" cellpadding="0" class="table_style" id="proXls">
			<tr bgcolor="#F6BEAB" >
				<td><strong>���</strong></td>
				<td><strong>��Ʒ��</strong></td>
				<td><strong>��Ʒ�汾</strong></td>
				<td><strong>&nbsp;���ȼ�</strong>(��/��/��)</td>
				<td><strong>����ʱ��</strong></td>
				<td><strong>&nbsp;��Ʒ�汾Ŀ��</strong>����Ʒ���������߷�Χ��</td>
				<td><strong>���ʱ��</strong></td>
				<td><strong>������</strong></td>
				<td><strong>���ڵ����⼰����</strong></td>
				<td><strong>��ƷĿ�꼰���ȱ����¼</strong></td>
				<td><strong>&nbsp;��Ʒ����</strong>(��Ʒ����)</td>
				<td><strong>��Ŀ����</strong></td>
			</tr>
				 	<%
				 		int i = 0;
				 		String sql = "select * from serviceLine where isShow = '0' order by order_o,id";
				 		rs.executeSql(sql);
				 		
				 		while(rs.next()){
				 			i++;
				 	    int flag = 1;
				 	%>
				 	   <tr bgcolor="#FDF6AD">
				 	   		<td colspan="2"><%=i %>��<%=rs.getString("name") %></td>
				 	   		<td></td><td></td><td></td><td></td><td></td>
				 	   		<td></td><td></td><td></td><td></td><td></td>
				 	   		<!-- <td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
				 	   		<td>&nbsp;</td>&nbsp;<td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td> -->
				 	   </tr>
				 	   <%
				 	    String sql_1 = "select * from projectInfo where isShow = '0' and forline = '"+rs.getString("id")+"' and (overtime is null or substr(overtime, 0,7) = to_char(Sysdate, 'yyyy-MM')) and substr(timeline,0,4) = to_char(sysdate, 'yyyy') order by forline,name,version desc,timeLine,overtime";
				 	  	recordSet.executeSql(sql_1);
				 	  	int m = 0;
				 	  	while(recordSet.next()){
				 	  		m++;
				 	  		String tem_str = recordSet.getString("execution");
				 	  		if( m % 2 ==0){
				 	  			%>
				 	  			<tr class=datalight><%
				 	  		}else{
				 	  			%>
				 	  			<tr class=datadark><%
				 	  		}
				 	    %>
					 	   
<%-- 					 	   		<td <%if("2".equals(tem_str)){ %> bgcolor="red" <%} else if("0".equals(tem_str)){ %> bgcolor="green" <%} else if("1".equals(tem_str)){ %> bgcolor="blue" <%} %>><%=i %>.<%=flag++ %></td> --%>
								<td ><%=i %>.<%=flag++ %></td>
					 	   		<td><%=tools.getProductLineName(recordSet.getString("name")) %></td>
					 	   		<td><%=recordSet.getString("version") %></td>
					 	   		<td>
					 	   		
					 	   		<%
					 	   			if("0".equals(recordSet.getString("priority"))){
					 	   				out.print("��");
					 	   			}else if("1".equals(recordSet.getString("priority"))){
					 	   				out.print("��");
					 	   			}else if("2".equals(recordSet.getString("priority"))){
					 	   				out.print("��");
					 	   			}
					 	   		 %>
					 	   		</td>
					 	   		<td><%=recordSet.getString("timeLine") %></td>
					 	   		<td><%=recordSet.getString("target") %></td>
					 	   		<td><%=recordSet.getString("overTime") %></td>
					 	   		
					 	   		<%
							 	   	if("0".equals(tem_str)){
							 	   		%><td><% 
					 	   				out.print("����");
							 	   		%></td><% 
					 	   			}else if("1".equals(tem_str)){
					 	   				%><td bgcolor="#FF2D2D"><%
					 	   				out.print("����");
					 	   				%></td><%
					 	   			}else if("2".equals(tem_str)){
					 	   				%><td bgcolor="#0072E3"><%
					 	   				out.print("�ݻ�");
					 	   				%></td><%
					 	   			}else if("3".equals(tem_str)){
					 	   				%><td bgcolor="#79FF79"><%
					 	   				out.print("���");
					 	   				%></td><%
					 	   			}else{
						 	   			%><td><%
					 	   				%></td><%
					 	   			}
					 	   		 
					 	   		%>
					 	   			<td>
					 	   		<%
					 	   		rec.executeSql("select * from produceQuestion where isOk = '0' and productversionid = '"+recordSet.getString("id")+"'");
					 	   		int k = 0;
					 	   
					 	   		while(rec.next()){
					 	   			k++;
					 	   			%>
					 	   			<%=k%>��<%=rec.getString("description") %><br>
					 	   			<%
					 	   		}
					 	   		%>
					 	   		</td>
					 	   		<td>
					 	   		<%
					 	   		rec.executeSql("select * from Productchange where productversionid = '"+recordSet.getString("id")+"'");
					 	   		int h = 0;
					 	   
					 	   		while(rec.next()){
					 	   			h++;
					 	   			%>
					 	   			<%=h%>��<%=rec.getString("description") %><br>
					 	   			<%
					 	   		}
					 	   		%>
					 	   		</td>
					 	   		<td><%=ResourceComInfo.getResourcename(recordSet.getString("productManager")) %></td>
					 	   		<td><%=ResourceComInfo.getResourcename(recordSet.getString("projectManager")) %></td>
					 	   </tr>
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
		    // ��Ʒ��
		    oSheet.Columns('B:B').ColumnWidth = 30;  
		    // ��Ʒ�汾
		    oSheet.Columns('C:C').ColumnWidth = 7;  
		    // ���ȼ�
		    oSheet.Columns('D:D').ColumnWidth = 5;  
		    // ����ʱ��
		    oSheet.Columns('E:E').ColumnWidth = 10;  
		    // ��Ʒ�汾Ŀ��
		    oSheet.Columns('F:F').ColumnWidth = 50;  
		    // ���ʱ��
		    oSheet.Columns('G:G').ColumnWidth = 5; 
		    // ������ 
		    oSheet.Columns('H:H').ColumnWidth = 5;  
		    // ��������
		    oSheet.Columns('I:I').ColumnWidth = 45;  
		    // �����¼
		    oSheet.Columns('J:J').ColumnWidth = 45;  
		    // ��Ʒ����
		    oSheet.Columns('K:K').ColumnWidth = 7; 
		    // ��Ŀ���� 
		    oSheet.Columns('K:K').ColumnWidth = 7; 
		  	
		    var sel = document.body.createTextRange();
		    sel.moveToElementText(curTbl);
		    sel.select();
		    sel.execCommand("Copy");
		    oSheet.Paste();
		    oXL.Visible = true;
		}
						
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