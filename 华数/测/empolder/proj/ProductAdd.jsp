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

String userID = String.valueOf(user.getUID());

boolean isDel = true;

String num = "";
String name = "";
String namev = tools.getProductLineName(name);
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
	
boolean isD = true;
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
		sql = "select * from prj_projectinfo where productversionid = '"+id+"'";
		rs.executeSql(sql);
		if(rs.next()){
			isDel = false;
		}
	}

	
	boolean isTrue = false;
	if(userID.equals(projectManager)){
		isTrue = true;
	}
	
	
	String isDis = "style='display: none;'";//�����ǰ��¼���ǲ�Ʒ������ǲ鿴��Ա������Ŀ���⼰�����ʾ(������Ŀ)
	String isDisM = "";//�����ǰ��¼���ǲ鿴��Ա����Ŀ����ʾ
	
	String isEdit = "";//�������Ŀ������ֻ�ܱ༭���ʱ���������
	String isEdit_1 = "";//�������Ŀ������ֻ�ܱ༭���ʱ���������
	
	if(userID.equals(productManager) || userID.equals(projectManager)){
		isDis = "";
	}else if(members.indexOf(userID)>-1){
		isDisM = "style='display: none;'";
		isEdit = "style='display: none;'";
		isEdit_1 = "readonly='readonly'";
		isD = false;
	}
	if(userID.equals(projectManager)){
		isEdit = "style='display: none;'";
		isEdit_1 = "readonly='readonly'";
		isD = false;
	}
	if(userID.equals(productManager) && userID.equals(projectManager)){
		isTrue = true;
		isEdit = "";
		isEdit_1 = "";
		isD = false;
	}
%>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
<script language="javascript" type="text/javascript" src="/js/jquery/jquery-1.4.2.min.js"></script>
</head>
<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "��ƷĿ��ά��";
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:submitData(this),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
if(!"".equals(id) && isDel &&"".equals(isDis)){
	RCMenu += "{"+SystemEnv.getHtmlLabelName(91,user.getLanguage())+",javascript:doDelete(this),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
}
RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",javascript:window.history.back(),_self}";
RCMenuHeight += RCMenuHeightStep;
if("".equals(isDis)){
	RCMenu += "{�༭��Ŀ����,/empolder/proj/ProductQuestionAdd.jsp?&productVersionID="+id+",_self}";
	RCMenuHeight += RCMenuHeightStep;

	RCMenu += "{������Ŀ���,/empolder/proj/ProductChangeAdd.jsp?productVersionID="+id+",_self}";
	RCMenuHeight += RCMenuHeightStep;
}
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
    <TR class=Title>
      <TH colSpan=4>��ƷĿ��ά��</TH>
    </TR>
    <TR class=Spacing> 
      <TD class=Line1 colSpan=4></TD>
    </TR>
    <TR><TD class=Line colSpan=4></TD></TR> 
    <Tr>
<!-- 	    <td>���</td> -->
<!-- 	  	<td class=field>  -->
<%--   			<input type=text name="num" id="num" value="<%=num%>"> --%>
<!--   		</td> -->
  		 <td>��Ʒ������</td>
	      <td class=field colspan="3"> 
	       <BUTTON class=Browser id=ServiceLineBrowser onClick="onProductLineBrowser()" <%=isEdit %>></BUTTON> <span 
            id=namespan><%if("".equals(name)){ %><IMG src='/images/BacoError.gif' align=absMiddle><%}else{ %><%=tools.getProductLineName(name)%><%} %></span>
			<input type=hidden name="name" id="name" value="<%=name%>">
	      </td>
    </tr>
    <TR><TD class=Line colSpan=4></TD></TR> 
    <tr> 
      <td>��Ʒ�汾</td>
      <td class=Field>
		<input type=text name="version" id="version" value="<%=version%>" onchange="checkinput('version','versionSpan')" <%=isEdit_1 %>><span id="versionSpan"><%if("".equals(version)){ %><IMG src='/images/BacoError.gif' align=absMiddle><%} %></span>
      </td>
      <td>����ҵ����</td>
      <td class=field>
      <BUTTON class=Browser id=ServiceLineBrowser onClick="onServiceLineBrowser()" <%=isEdit %>></BUTTON> <span 
            id=forLinespan><%if("".equals(forLine)){ %><IMG src='/images/BacoError.gif' align=absMiddle><%}else{ %><%=tools.getServiceLineName(forLine)%><%} %></span> 
              <INPUT class=inputstyle type=hidden name="forLine" id="forLine" value="<%=forLine %>">
      </td>
    </tr>
    <TR><TD class=Line colSpan=4></TD></TR> 
    <tr> 
      <td>���ȼ�</td>
      <td class=Field>
      <%if(!isD){ %>
      <input name="priority" value="<%=priority%>" type="hidden">
			<% if("0".equals(priority)){
					 	   				out.print("��");
					 	   			}else if("1".equals(priority)){
					 	   				out.print("��");
					 	   			}else if("2".equals(priority)){
					 	   				out.print("��");
					 	   			}
		}else{ %>
		<select name="priority" onchange="checkinput('priority','prioritySpan')">
			<option></option>
			<option value="0" <%if("0".equals(priority)){ %> selected="selected" <%} %>>��</option>
			<option value="1" <%if("1".equals(priority)){ %> selected="selected" <%} %>>��</option>
			<option value="2" <%if("2".equals(priority)){ %> selected="selected" <%} %>>��</option>
		</select>
		<span id="prioritySpan"><%if("".equals(priority)){ %><IMG src='/images/BacoError.gif' align=absMiddle><%} %></span>
		<%} %>
      </td>
      <td>�ƻ�����ʱ��</td>
      <td class=field>
      <button type=button class=calendar id=SelectDate onClick="getDate(timeLinespan,timeLine)" <%=isEdit %>></button>
		<span id=timeLinespan ><%if("".equals(timeLine)){ %><IMG src='/images/BacoError.gif' align=absMiddle><%}else{%><%=timeLine %><%} %></span>
		<input type="hidden" name="timeLine" value="<%=timeLine %>">
      </td>
    </tr>
    <TR><TD class=Line colSpan=4></TD></TR> 
    <tr> 
      <td>������</td>
      <td class=Field>
      <%if(!"".equals(id) && isTrue){ %>
		<select name="execution">
			<option></option>
			<option value="0" <%if("0".equals(execution)){ %> selected="selected" <%} %>>����</option>
			<option value="1" <%if("1".equals(execution)){ %> selected="selected" <%} %>>����</option>
			<option value="2" <%if("2".equals(execution)){ %> selected="selected" <%} %>>�ݻ�</option>
			<option value="3" <%if("3".equals(execution)){ %> selected="selected" <%} %>>���</option>
		</select>
		<%}else{ %>
		<input name="execution" value="<%=execution%>" type="hidden">
			<% if("0".equals(execution)){
					 	   				out.print("����");
					 	   			}else if("1".equals(execution)){
					 	   				out.print("����");
					 	   			}else if("2".equals(execution)){
					 	   				out.print("�ݻ�");
					 	   			}else if("3".equals(execution)){
					 	   				out.print("���");
					 	   			}
		} %>
      </td>
      <td>���ʱ��</td>
      <td class=field>
      <%if(!"".equals(id) && isTrue){ %>
      <button type=button class=calendar id=SelectDate onClick="getDate(overTimespan,overTime)"></button>
      <%}else{ %>
      <button type=button class=calendar id=SelectDate onClick="getDate(overTimespan,overTime)" disabled="disabled"></button>
      <%} %>
		<span id=overTimespan ><%=overTime %></span>
		<input type="hidden" name="overTime" value="<%=overTime %>">
      </td>
    </tr>
    <TR><TD class=Line colSpan=4></TD></TR> 
    <tr> 
      <td>��Ʒ����</td>
      <%if(!"".equals(id)){ %>
      <td class=Field>
      	<BUTTON class=Browser id=SelectManagerID onClick="onShowResource1()" <%=isEdit %>></BUTTON> 
      	<span id=productManagerspan><%if("".equals(productManager)){ %><IMG src='/images/BacoError.gif' align=absMiddle><%}else{ %><%=ResourceComInfo.getLastname(productManager)%><%} %></span> 
              <INPUT class=inputstyle type=hidden name="productManager" value="<%=productManager %>">
      	
      </td>
      <%}else{
    	  %>
    	  <td class=Field>
    	  <span><%=ResourceComInfo.getLastname(userID)%></span> 
              <INPUT class=inputstyle type=hidden name="productManager" value="<%=userID %>">
           </td>
    	  <%
      } %>
      <td>��Ŀ����</td>
      <td class=field>
      <BUTTON class=Browser id=ManagerID onClick="onShowResource()" <%=isEdit %>></BUTTON> <span 
            id=projectManagerspan><%if("".equals(projectManager)){ %><IMG src='/images/BacoError.gif' align=absMiddle><%}else{ %><%=ResourceComInfo.getLastname(projectManager)%><%} %></span> 
              <INPUT class=inputstyle type=hidden name="projectManager" value="<%=projectManager %>">
      </td>
    </tr>
    <TR><TD class=Line colSpan=4></TD></TR> 
    <tr> 
      <td>�鿴��Ա</td>
      <td class=Field colspan="3">
      <button type=button  class=Browser onClick="ShowMultiResource(membersspan,members)" <%=isEdit %>></BUTTON>
      <span id=membersspan><%if("".equals(members)){%><IMG src='/images/BacoError.gif' align=absMiddle><%}else{%><%=ResourceComInfo.getMulResourcename(members) %><%} %></span> 
              <INPUT class=inputstyle type=hidden id="members" name="members" value="<%=members%>">
      </td>
    </tr>
    <TR><TD class=Line colSpan=4></TD></TR> 
    <tr> 
      <td>��Ʒ�汾Ŀ��(��Ʒ���������߷�Χ)</td>
      <td class=Field colspan="3">
      	<textarea rows="10" cols="150" name="target" <%=isEdit_1 %>><%=target.replaceAll("<br>", "") %></textarea>
      </td>
    </tr>
    <TR><TD class=Line colSpan=4></TD></TR> 
    <%if(!"".equals(id)){ %>
    <div>
    	<tr>
    		<td colspan="4">
    			<table width="100%" class=ListStyle cellspacing=1>
    			<COLGROUP> 
				    <col width="25%">
				    <col width="25%">
				    <col width="25%">
				    <col width="25%">
				  <THEAD> 
				  <tr class=Title height="25">
    					<td colspan="4" align="center"><strong>��Ŀ��ƷĿ�꼰���ȱ����¼</strong></td>
    				</tr>
				  <TR class=Header>
				  <th>�������</th>
				  <th>��ϸ����</th>
				  <th>�����</th>
				  <th>���ʱ��</th>        
				  </tr>
				  <TR class=Line><TD colspan="4" ></TD></TR> 
<!-- 				  <tr> -->
				  <%
						recordSet.executeSql("select * from Productchange where productVersionID = '"+id+"' and isShow = '0' order by id");
						int yy = 0;
						while(recordSet.next()){
							yy++;

						if(yy % 2 == 0){
							%>
							<TR class = datalight>
							<%
						}else{
							%>
							<TR class = datadark>
							<%
						}
						%>
<%-- 					        <TD class=Field><input name="description2" size="60" value="<%=recordSet.getString("description1")%>" <%=isdes %> /><input type="hidden" name="chanid" value="<%=recordSet.getString("id")%>"/></TD> --%>
							<TD class=Field><%=recordSet.getString("description")%></TD>
					        <TD class=Field><%=recordSet.getString("content")%></TD>
					        <TD class=Field><%=ResourceComInfo.getResourcename(recordSet.getString("changeUSER")) %></TD>
					        <TD class=Field><%=recordSet.getString("changeData")%></TD>
					        </TR>
					        <%} %>
<!-- 				  </tr> -->
				  </THEAD>
				  
    			</table>
    		</td>
    	</tr>
    </div>
    <div>
    	<tr>
    		<td colspan="4">
    			<table width="100%" class=ListStyle cellspacing=1>
    			<COLGROUP> 
				    <col width="25%">
				    <col width="25%">
				    <col width="25%">
				    <col width="25%">
				  <THEAD> 
				  <tr class=Title height="25">
    					<td colspan="4" align="center"><strong>��Ŀ���ڵ����⼰����</strong></td>
    				</tr>
				  <TR class=Header>
				  <th>��������</th>
				  <th>��������</th>
				  <th>�Ƿ���</th>
				  <th>����취</th>        
				  </tr>
				  <TR class=Line><TD colspan="4" ></TD></TR>
				  <tr>
				  <%
						recordSet.executeSql("select * from produceQuestion where  productVersionID = '"+id+"' and isshow = '0'  order by id");
						int kk = 0;
						while(recordSet.next()){
							kk++;

						if(kk % 2 == 0){
							%>
							<TR class = datalight>
							<%
						}else{
							%>
							<TR class = datadark>
							<%
						}
						%>
<%-- 					        <TD class=Field><input name="description1" size="60" value="<%=recordSet.getString("description1")%>" <%=isdes %> /><input type="hidden" name="quesid" value="<%=recordSet.getString("id")%>"/></TD> --%>
					        <TD class=Field><%=recordSet.getString("description")%></TD>
					        <TD class=Field><%=recordSet.getString("statDate")%></TD>
					        <TD class=Field><%if("0".equals(recordSet.getString("isOK"))){%>δ���<%}else if("1".equals(recordSet.getString("isOK"))){ %>�ѽ��<%} %></TD>
					        <TD class=Field><%=recordSet.getString("terms")%></TD>
					        </TR>
					        <%} %> 
				  </tr>
				  </THEAD>
				  
    			</table>
    		</td>
    	</tr>
    </div>
    <tr <%=isDis %>>
    	<Td colspan="4">
    	<DIV align="right" >
            <a  style="cursor:pointer" onclick="show()" id="myD1">��ʾ����Ŀ������⼰���</a>&nbsp; 
            <a  style="cursor:pointer; display: none;" onclick="notShow()" id="myD2">��������Ŀ������⼰���</a>&nbsp;	
          </DIV>
          </Td>
    </tr>
    	<tr id="myDiv" style="display: none;">
    		<td colspan="4">
    			<table width="100%" class=ListStyle cellspacing=1 <%=isDisM %>>
    			<COLGROUP> 
				    <col width="25%">
				    <col width="25%">
				    <col width="25%">
				    <col width="25%">
				  <THEAD> 
				  <tr class=Title height="25">
    					<td colspan="4" align="center"><strong>����Ŀ��ƷĿ�꼰���ȱ����¼</strong></td>
    				</tr>
				  <TR class=Header>
				  <th>�������</th>
				  <th>��ϸ����</th>
				  <th>�����</th>
				  <th>���ʱ��</th>        
				  </tr>
				  <TR class=Line><TD colspan="4" ></TD></TR> 
<!-- 				  <tr> -->
				  <%
						recordSet.executeSql("select * from changeInfo where productVersionID = '"+id+"' order by id");
						int y = 0;
						while(recordSet.next()){
							y++;

						if(y % 2 == 0){
							%>
							<TR class = datalight>
							<%
						}else{
							%>
							<TR class = datadark>
							<%
						}
						%>
					        <TD class=Field><%=recordSet.getString("description")%></TD>
					        <TD class=Field><%=recordSet.getString("content")%></TD>
					        <TD class=Field><%=ResourceComInfo.getResourcename(recordSet.getString("changeUSER")) %></TD>
					        <TD class=Field><%=recordSet.getString("changeData")%></TD>
					        </TR>
					        <%} %>
<!-- 				  </tr> -->
				  </THEAD>
				  
    			</table>
    		</td>
    	</tr>
    	<tr id="myDiv2" style="display: none;">
    		<td colspan="4">
    		<table width="100%" class=ListStyle cellspacing=1 <%=isDisM %>>
    			<COLGROUP> 
				    <col width="25%">
				    <col width="25%">
				    <col width="25%">
				    <col width="25%">
				  <THEAD> 
				  <tr class=Title height="25">
    					<td colspan="4" align="center"><strong>����Ŀ���ڵ����⼰����</strong></td>
    				</tr>
				  <TR class=Header>
				  <th>��������</th>
				  <th>��������</th>
				  <th>�Ƿ���</th>
				  <th>����취</th>        
				  </tr>
				  <TR class=Line><TD colspan="4" ></TD></TR>
<!-- 				  <tr> -->
				  <%
						recordSet.executeSql("select * from questionInfo where  productVersionID = '"+id+"' order by id");
						int k = 0;
						while(recordSet.next()){
							k++;

						if(k % 2 == 0){
							%>
							<TR class = datalight>
							<%
						}else{
							%>
							<TR class = datadark>
							<%
						}
						%>
					        <TD class=Field><%=recordSet.getString("description")%></TD>
					        <TD class=Field><%=recordSet.getString("statDate")%></TD>
					        <TD class=Field><%if("0".equals(recordSet.getString("isOK"))){%>δ���<%}else if("1".equals(recordSet.getString("isOK"))){ %>�ѽ��<%} %></TD>
					        <TD class=Field><%=recordSet.getString("terms")%></TD>
					        </TR>
					        <%} %> 
<!-- 				  </tr> -->
				  </THEAD>
				  
    			</table>
    		</td>
    	</tr>
    <%} %>
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
function show(){
	document.getElementById("myD1").style.display="none";
	document.getElementById("myD2").style.display="block";
	document.getElementById("myDiv").style.display="block";
	document.getElementById("myDiv2").style.display="block";
}

function notShow(){
	document.getElementById("myD1").style.display="block";
	document.getElementById("myD2").style.display="none";
	document.getElementById("myDiv").style.display="none";
	document.getElementById("myDiv2").style.display="none";
}

function submitData(obj) {
        if(check_form(right,"name,version,forline,priority,timeLine,projectManager,members")){
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
function onProductLineBrowser() {
	var id1 = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/empolder/proj/ProductLineBrowser.jsp");
	                     if (id1) {
				var ids = id1.id;
				var names = id1.name;
				var cid = id1.cid;
				var cname = id1.cname;
				if (ids.length > 0) {
					jQuery("#name").val(ids);
					jQuery("#namespan").html(names);
					jQuery("#forLine").val(cid);
					jQuery("#forLinespan").html(cname);
				} else {
					jQuery("#name").val("");
					jQuery("#namespan").html("");
					jQuery("#forLine").val("");
					jQuery("#forLinespan").html("<IMG src='/images/BacoError.gif' align=absMiddle>");
				}
			}
	}
	
	
	jQuery(document).ready(function(){
	
<%-- 		var pid = <%=id%>; --%>
		var version = jQuery("#version").val();
		var name = jQuery("#name").val();
		var namev = jQuery("#namespan").html();
// 		alert(name);
// 		alert(namev);
// 		alert(version);
// 		alert(pid);
		jQuery("#name").bind("propertychange",function(){
// 			alert(jQuery(this).val());
			var nval = jQuery(this).val();
			var vval = jQuery("#version").val();
// 			alert(nval+"---");
// 			alert(name+"---");
// 			alert(vval+"---");
// 			alert(version+"---");
			if(nval != name || vval != version){
				if(nval != "" && vval != "" ){
					jQuery.post("/empolder/proj/checkSame.jsp",{'nameID':nval,'vval':vval},function(data){
	// 					alert(data);
						data = data.replace(/\n/g,"").replace(/\r/g,"");
		                eval('var obj ='+data);
		                var isHave = obj.isHave;
		                if(isHave != ""){
// 		                	if(nval != name && vval != version){
			                	alert("�˲�Ʒ�ߵİ汾�Ѵ��ڣ����ʵ��")
// 		                	}
		                	if(version !=""){
			                	jQuery("#version").val(version);
		                		jQuery("#name").val(name);
			                	jQuery("#namespan").html(namev);
		                	}else{
			                	jQuery("#name").val("");
			                	jQuery("#namespan").html("");
			                	jQuery("#version").val("");
		                	}
		                }
					});
				}
				
			}
			
		});
		jQuery("#version").bind("change",function(){
// 			alert(jQuery(this).val());
			var nval = jQuery("#name").val();
			var vval = jQuery(this).val();
// 			alert(vval+"---++");
// 			alert(version+"---++");
			if(version != vval){
				if(nval != "" && vval != ""){
					jQuery.post("/empolder/proj/checkSame.jsp",{'nameID':nval,'vval':vval},function(data){
	// 					alert(data);
						data = data.replace(/\n/g,"").replace(/\r/g,"");
		                eval('var obj ='+data);
		                var isHave = obj.isHave;
		                if(isHave != ""){
		                	alert("�˲�Ʒ�ߵİ汾�Ѵ��ڣ����ʵ��")
		                	if(version !=""){
// 		                		jQuery("#name").val(name);
// 			                	jQuery("#namespan").html(namev);
			                	jQuery("#version").val(version);
		                	}else{
			                	jQuery("#name").val("");
			                	jQuery("#namespan").html("");
			                	jQuery("#version").val("");
		                	}
		                } 
					});
				}
			}
		});
	});
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