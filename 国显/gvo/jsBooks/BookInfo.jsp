<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
	
<html>
<head>
<script type="text/javascript" src="/js/weaver.js"></script>
<link rel="stylesheet" type="text/css" href="/css/Weaver.css">
</head>

<%

int emp_id = user.getUID();
int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
int	perpage = 20;

String fromdate = Util.null2String(request.getParameter("fromdate"));  
String enddate = Util.null2String(request.getParameter("enddate"));  
String resourceid = Util.null2String(request.getParameter("resourceid"));  
String file_name = Util.null2String(request.getParameter("file_name"));  

String imagefilename = "/images/hdDOC.gif";
String titlename = "我的图书";
String needfav ="1";
String needhelp ="";
%>

<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:document.weaver.submit(),_top} " ;
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

<FORM id=weaver name=weaver STYLE="margin-bottom:0" action="" method="post">
	<input type="hidden" name="multiRequestIds" value="">
	<input type="hidden" name="operation" value="">


<table width=100% class=ViewForm>
<colgroup><col width="10%"></col><col width="40%"></col><col width="10%"></col><col width="40%"></col></colgroup>
<tr>

</tr>
	
<tr style="height:1px;"><td class=Line colspan=11></td></tr>
</table>

<TABLE width="100%">
	<tr>
		<td valign="top">
            <%
            String backfields = " za.id,za.id as bookid,za.oper_name,za.name,za.sqr,za.sqrq,za.jyksrq,za.yjjyjsrq,za.bhname ";
            String fromSql  = " (select fm94.tsmc as id,decode(fm91.id,null,'','归还') as oper_name, "
							  +" (select tsmc from formtable_main_91 where id=fm94.tsmc ) as name,"
							  +" (select tsbh from formtable_main_91 where id=fm94.tsmc ) as bhname,"
							  +" fm94.sqr,sqrq,jyksrq,yjjyjsrq,fm94.csxz "
							  +" from formtable_main_94 fm94 "
							  +" left join formtable_main_91 fm91 on(fm94.sqr=fm91.mqjyr and fm94.tsmc=fm91.id)"
							  +" where fm94.sqr="+emp_id+" and fm94.requestid "
							  +" in(select requestid from workflow_requestbase where currentnodetype=3) "
							  +" and fm94.tsmc in(select id from formtable_main_91) ) za ";
			
            String sqlWhere = "1=1 ";
           
		//	if(!"".equals(resourceid)){   
		//		sqlWhere += "and za.operateuserid ="+resourceid+" ";
		//	}
            
           // out.println("select "+ backfields + fromSql + " where " + sqlWhere);
			//System.out.println(sqlWhere);
            String orderby = " jyksrq,name,oper_name " ;
            String tableString = "";
            tableString =" <table  tabletype=\"none\" pagesize=\""+perpage+"\" >"+
                           "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"id\" sqlsortway=\"desc\" />"+
                           "			<head>"+
                           " 				<col width=\"20%\" text=\"图书名称\" column=\"name\" orderkey=\"name\"  />"+
						   "				<col width=\"20%\" text=\"图书编号\" column=\"bhname\" orderkey=\"bhname\"  />"+
                           "				<col width=\"20%\" text=\"借阅日期\" column=\"jyksrq\" orderkey=\"jyksrq\"  />"+
						   " 				<col width=\"20%\" text=\"操作(无操作为历史记录)\" column=\"oper_name\" orderkey=\"bookid\" href=\"/workflow/request/AddRequest.jsp?workflowid=323\" linkkey=\"bookid\" linkvaluecolumn=\"bookid\" target=\"_blank\"  />"+
                           "			</head>"+
                           "</table>";
         %>
         <wea:SplitPageTag  tableString="<%=tableString%>"  mode="run" />
		</td>
	</tr>
</TABLE>
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
