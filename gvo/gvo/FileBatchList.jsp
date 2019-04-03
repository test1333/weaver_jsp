<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
	
<html>
<head>
<script type="text/javascript" src="/js/weaver.js"></script>
<link rel="stylesheet" type="text/css" href="/css/Weaver.css">
</head>

<%
//if(!HrmUserVarify.checkUserRight("PoscoPerfor:Edit",user)) {
//	response.sendRedirect("/notice/noright.jsp") ;
//	return ;
//}
int emp_id = user.getUID();
int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
int	perpage = 50;

String fromdate = Util.null2String(request.getParameter("fromdate"));  
String enddate = Util.null2String(request.getParameter("enddate"));  
String resourceid = Util.null2String(request.getParameter("resourceid"));  
String file_name = Util.null2String(request.getParameter("file_name"));  

String imagefilename = "/images/hdDOC.gif";
String titlename = "手动归档";
String needfav ="1";
String needhelp ="";
Map<String,String> mainMap_1 = new HashMap<String,String>();
Map<String,String> mainMap_2 = new HashMap<String,String>();
Map<String,String> mainMap_3 = new HashMap<String,String>();

Map<String,String> forMap_1 = new HashMap<String,String>();
Map<String,String> forMap_2 = new HashMap<String,String>();

String sql = "select id,Categoryname from DocMainCategory order by Categoryorder";
rs.executeSql(sql);
while(rs.next()) {
	String tmp_id = rs.getString("id");
	String tmp_name = rs.getString("Categoryname");
	mainMap_1.put(tmp_id,tmp_name);
}
sql = "select id,Categoryname,Maincategoryid from DocSubCategory  order by  Suborder ";
rs.executeSql(sql);
while(rs.next()) {
	String tmp_id = rs.getString("id");
	String tmp_name = rs.getString("Categoryname");
	mainMap_2.put(tmp_id,tmp_name);
	
	String main_1 = rs.getString("Maincategoryid");
	forMap_1.put(tmp_id,main_1);
}
sql = "select id,Categoryname,Subcategoryid from DocSecCategory  order by Secorder  ";
rs.executeSql(sql);
while(rs.next()) {
	String tmp_id = rs.getString("id");
	String tmp_name = rs.getString("Categoryname");
	mainMap_3.put(tmp_id,tmp_name);
	
	String main_2 = rs.getString("Subcategoryid");
	forMap_2.put(tmp_id,main_2);
}
%>
<script type="text/javascript">
	function myselect1(){
		alert(123);
		var select1 = document.getElementById("select1");
		var select2 = document.getElementById("select2");
		var select3 = document.getElementById("select3");
		
		var number2 = select2.options.length;
		for(var j = select2.length-1;j>=0;j--){
			select2.removeChild(select2.childNodes.item(j));
		}

		var number = select3.options.length;
		for(var k = select3.length-1;k>=0;k--){
			select3.removeChild(select3.childNodes.item(k));
		}
		
		var dopt2 = document.createElement("OPTION");
		dopt2.text="请输入市";
		select2.add(dopt2);  
		var dopt3 = document.createElement("OPTION");
		dopt3.text="请输入县";    
		select3.add(dopt3);      
 		<%
			Iterator<String> main_1 = mainMap_1.keySet().iterator();
			while(main_1.hasNext()){
				String tmp_id = main_1.next();
				String tmp_name = mainMap_1.get(tmp_id);
 		%>
 				var tmp_sel_val_1 = "<%=tmp_id%>";
				alert("now_x = "+ tmp_sel_val_1 + " $ " + select1.value);
				if(select1.value == tmp_sel_val_1){
					<%
						Iterator<String> main_2 = mainMap_2.keySet().iterator();
						while(main_2.hasNext()){
							String tmp_id_2 = main_2.next();
							String tmp_name_2 = mainMap_2.get(tmp_id_2);%>
					alert("key1 = <%=tmp_id_2%> $ <%=tmp_name_2%>"  );
					<%
							if(forMap_1.containsKey(tmp_id_2)){
					%>alert("key2 = <%=tmp_id_2%>");
								var opt = document.createElement("OPTION");
								opt.text = "<%=tmp_name_2%>";
								opt.value = "<%=tmp_id_2%>";
								opt.selected=false;
								select2.add(opt); 
						<%} }%>      
				}
		<%}%>
	}
	function myselect2(){
		var select2 = document.getElementById("select2");
		var select3 = document.getElementById("select3");
		var number = select3.options.length;
		for(var k = select3.length-1;k>=0;k--){
			select3.removeChild(select3.childNodes.item(k));
		}
		var dopt3 = document.createElement("OPTION");
		dopt3.text="请输入县";    
		select3.add(dopt3);      
 		<%
			Iterator<String> main_2 = mainMap_2.keySet().iterator();
			while(main_2.hasNext()){
				String tmp_id_2 = main_2.next();
				String tmp_name_2 = mainMap_2.get(tmp_id_2);
 		%>
 				var tmp_sel_val_2 = <%=tmp_id_2%>;
				if(select2.value == tmp_sel_val_2){
					<%
						Iterator<String> main_3 = mainMap_3.keySet().iterator();
						while(main_3.hasNext()){
							String tmp_id_3 = main_3.next();
							String tmp_name_3 = mainMap_3.get(tmp_id_3);
							if(forMap_2.containsKey(tmp_id_3)){
					%>
								var opt = document.createElement("OPTION");
								opt.text = <%=tmp_name_3%>;
								opt.value = <%=tmp_id_3%>;
								opt.selected=false;
								select2.add(opt); 
						<%} }%>      
				}
		<%}%>
	}
</script>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:document.weaver.submit(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{批量归档,javascript:deleteWorkflow(this),_self}" ;
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
	<td ></td>
	<td valign="top">
		<TABLE class=Shadow>
		<tr>
		<td valign="top">
<%
//	out.println("mainMap_1  = " + mainMap_1);
//	out.println("mainMap_2  = " + mainMap_2);
//	out.println("mainMap_3  = " + mainMap_3);
//	out.println("forMap_1  = " + forMap_1);
//	out.println("forMap_2  = " + forMap_2);
%>
<FORM id=weaver name=weaver STYLE="margin-bottom:0" action="" method="post">
	<input type="hidden" name="multiRequestIds" value="">
	<input type="hidden" name="operation" value="">


<table width=100% class=ViewForm>
<colgroup>
<col width="8%"/>
<col width="12%"/><col width="1%"/>
<col width="8%"/>
<col width="12%"/><col width="1%"/>
<col width="8%"/>
<col width="12%"/><col width="1%"/>
<col width="8%"/>
<col width="12%"/>
</colgroup>
<tr>
	 <TD>创建时间段</TD>
        <TD class=field>
	       <BUTTON class=Calendar type="button" id=selectfromdate onclick="getDate(fromdatespan,fromdate)"></BUTTON> 
	       <SPAN id=fromdatespan ><%=fromdate%></SPAN>
	       <input class=inputstyle type="hidden" name="fromdate" value="<%=fromdate%>">
	       -<BUTTON class=Calendar type="button" id=selectenddate onclick="getDate(enddatespan,enddate)"></BUTTON> 
	       <SPAN id=enddatespan ><%=enddate%></SPAN> 
	       <input class=inputstyle type="hidden" name="enddate" value="<%=enddate%>">
        </TD>
        <TD>&nbsp;</TD>
	<td>创建人姓名</td>
		<td class=Field><BUTTON class=Browser type="button" id=SelectManagerID onClick="onShowResourceID('resourceid','resourceidspan')"></BUTTON>
				  <span id=resourceidspan><%=Util.toScreen(ResourceComInfo.getResourcename(resourceid),user.getLanguage())%></span>
				<INPUT class=saveHistory id=resourceid type=hidden name=resourceid value="<%=resourceid%>"></td>
	<td></td>
</tr>
	<tr>
	 <TD>文件名称</TD>
		<td><input class=inputstyle id='file_name' name=file_name size="40" value="<%=file_name%>" ></td>
        <TD>&nbsp;</TD>

</tr>
<tr>
	<td>
	<select id="select1" onChange="myselect1()">
		<option>请选择省份</option>
		<%
		Iterator<String> main_x = mainMap_1.keySet().iterator();
		while(main_x.hasNext()){
				String tmp_id = main_x.next();
				String tmp_name = mainMap_1.get(tmp_id);
 		%>
			<option value="<%=tmp_id%>"><%=tmp_name%></option>
		<%}%>
	</select></td>
	<td>请选择市名：</td>
<td>	<select id="select2" onChange="myselect()"><option value="0">请输入市</option></select></td>
	<td>请选择县名：</td>
	<td><select id="select3"><option value="0">请输入县</option></select></td>
</tr>

<tr style="height:1px;"><td class=Line colspan=11></td></tr>
</table>

</FORM>
		</td>
		</tr>
		</TABLE>
	</td>
	<td></td>
</tr>
<tr>
	<td height="10" colspan="3"></td>
</tr>

</table>


<script type="text/javascript">

function deleteWorkflow(obj){
    if(_xtable_CheckedCheckboxId()!=""){
    	if(window.confirm("确认批量归档EMC?")){
            obj.disabled=true;
            document.weaver.multiRequestIds.value = _xtable_CheckedCheckboxId();
            document.weaver.operation.value='deleteworkflow';
            alert("_xtable_CheckedCheckboxId() = " + _xtable_CheckedCheckboxId());
            document.weaver.action='/gvo/docment/gvoBatchOper.jsp';
            document.weaver.submit();
        }
	}else{
        alert("<%=SystemEnv.getHtmlLabelName(20149,user.getLanguage())%>");
    }
}



function deleteCrm(e){
	//alert(_xtable_CheckedCheckboxId());
	//return false;
	if(_xtable_CheckedCheckboxId()==""){
		alert("<%=SystemEnv.getHtmlLabelName(19689,user.getLanguage())%>");
		return false;
	}
	if(confirm("<%=SystemEnv.getHtmlNoteName(7,user.getLanguage())%>")) {
		callAjax(e.srcElment||e.target);
	}
}
function callAjax(o){
	setMenuDisabled(o);
	/**
	new Ajax.Request("/system/systemmonitor/MonitorOperation.jsp", {
		onSuccess : function(){},
		onFailure : function(){},
		parameters : 
	});	
	*/
	$.ajax(
			{
				url:"/system/systemmonitor/MonitorOperation.jsp?"+"deleteprojid="+_xtable_CheckedCheckboxId()+"&operation=deleteproj",
				async:false,
				success:function(){
					_table.reLoad();setMenuDisabled(o,false);_xtable_CleanCheckedCheckbox();
				},
				error:function(){
					alert("Error!");setMenuDisabled(o,false);
				}
			}
			);
}
function onShowDepartment(datas,e){
    if(datas){
     if(datas.id!=""){
       jQuery("#checkDeptId").val(datas.id.substr(1));
     }else{
       jQuery("#checkDeptId").val(""); 
     }    
  }
}

function onShowBranch(datas,e){
  if(datas){
     if(datas.id!=""){
       jQuery("#subcomid").val(datas.id.substr(1));
     }else{
       jQuery("#subcomid").val(""); 
     }    
  }
}

function onShowResourceID(inputname,spanname){
	var opts={
			_dwidth:'550px',
			_dheight:'550px',
			_url:'about:blank',
			_scroll:"no",
			_dialogArguments:"",
			_displayTemplate:"#b{name}",
			_displaySelector:"",
			_required:"no",
			_displayText:"",
			value:""
		};
	var iTop = (window.screen.availHeight-30-parseInt(opts._dheight))/2+"px"; //获得窗口的垂直位置;
	var iLeft = (window.screen.availWidth-10-parseInt(opts._dwidth))/2+"px"; //获得窗口的水平位置;
	opts.top=iTop;
	opts.left=iLeft;
		
	datas = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp",
	    		"","addressbar=no;status=0;scroll="+opts._scroll+";dialogHeight="+opts._dheight+";dialogWidth="+opts._dwidth+";dialogLeft="+opts.left+";dialogTop="+opts.top+";resizable=0;center=1;");
	if (datas) {
		if (datas.id!= "") {
			
			$("#"+spanname).html("<A href='javascript:openhrm("+datas.id+");' onclick='pointerXY(event);'>"+datas.name+"</A>");

			$("input[name="+inputname+"]").val(datas.id);
		}else{
			$("#"+spanname).html("");
			$("input[name="+inputname+"]").val("");
		}
	}
}
</script>
	<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
</BODY>
</HTML>
