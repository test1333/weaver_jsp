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

	user = (User)session.getAttribute("weaver_user@bean");
	user.setLanguage(7);
	int uid_1 = user.getUID();
if(uid_1!=-10&&uid_1!=1) {
	session.removeAttribute("weaver_user@bean");
	response.sendRedirect("/login/login.jsp") ;
	return ;
}//控制权限
int emp_id = user.getUID();
int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
int	perpage = 10;


String bfz_name = Util.null2String(request.getParameter("bfz_name"));  
String lfr_name = Util.null2String(request.getParameter("lfr_name"));  
String yyh_name = Util.null2String(request.getParameter("yyh_name"));  
String fzc_name = Util.null2String(request.getParameter("fzc_name"));


String imagefilename = "/images/hdDOC.gif";
String titlename = "访客列表";
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
<colgroup><col width="10%"></col><col width="10%"></col><col width="10%"></col><col width="10%"></col><col width="10%"></col><col width="10%"></col><col width="10%"></col><col width="10%"></col><col width="10%"></col><col width="10%"></col></colgroup>
<tr>
	<TD align="center" valign="middle">被访人</TD>
		<td><input class=inputstyle id='bfz_name' name=bfz_name size="20" value="<%=bfz_name%>" ></td>
	<TD align="center" valign="middle">访客姓名</TD>
		<td><input class=inputstyle id='lfr_name' name=lfr_name size="20" value="<%=lfr_name%>" ></td>
    <TD align="center" valign="middle">预约号</TD>
		<td><input class=inputstyle id='yyh_name' name=yyh_name size="20" value="<%=yyh_name%>" ></td>
    <TD align="center" valign="middle">放置处</TD>
		<td><input class=inputstyle id='fzc_name' name=fzc_name size="20" value="<%=fzc_name%>" ></td>
	<TD align="center" valign="middle" >
	       <input type="submit" value="查询当前">
     </TD>
    <TD align="center" valign="middle" >
	       <input type="button" value="查询历史" onClick="window.open('/gvo/visitor/visitorInfoHistory.jsp')">
     </TD>
	 <TD align="center" valign="middle" >
	       <input type="button" value="返回首页" onClick="window.open('/gvo/redirect.jsp')">
     </TD>
</tr>

<tr style="height:1px;"><td class=Line colspan=11></td></tr>
</table>

<TABLE width="100%">
	<tr>
		<td valign="top">
            <%
            String backfields = " za.requestid,za.id,za.bfz,za.bfzlxdh,za.lfdw,za.lfr,za.lfrq,za.lfsj,za.fklx,za.cphm,za.lfsjbn,za.yyh,za.fzc,za.lfrs,"
							  +"za.lksjbn,decode(za.clsfjrcq,0,'是',1,'否','无记录') as sfjrcq,'&lt;img src=&quot;/images/rule_1.jpg&quot; border=&quot;0&quot;/&gt;' as desc_1 ";
            String fromSql  = " from formtable_main_124 za ";
			
            String sqlWhere = " requestid in(select requestid from workflow_requestbase where currentnodetype=3 )"
				
				+" and (za.lfsjbn is NULL or za.lksjbn is NULL) ";
          
		   if(!"".equals(bfz_name)){
				bfz_name = bfz_name.trim();
				sqlWhere += "and za.bfz in (select id from hrmresource where lastname like '%"+bfz_name+"%')";
			}

			
		   if(!"".equals(lfr_name)){
				lfr_name = lfr_name.trim();
				sqlWhere += "and za.lfr like '%"+lfr_name+"%' ";
			}

			if(!"".equals(yyh_name)){
				yyh_name = yyh_name.trim();
				sqlWhere += "and za.yyh ="+yyh_name+" ";
			}

            if(!"".equals(fzc_name)){
				fzc_name = fzc_name.trim();
				sqlWhere += "and za.fzc like '%"+fzc_name+"%' ";
			}
			//if(!"".equals(resourceid)){   
				//sqlWhere += "and za.operateuserid ="+resourceid+" ";
			//}
            
           // out.println("select "+ backfields + fromSql + " where " + sqlWhere);
			//System.out.println(sqlWhere);
            String orderby = " lfrq,yyh,lfsj " ;
            String tableString = "";
            tableString =" <table  tabletype=\"none\" pagesize=\""+perpage+"\" >"+
                           "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"id\" sqlsortway=\"desc\" />"+
                           "			<head>"+
						   " 				<col width=\"5%\" text=\"预约编号\" column=\"yyh\" orderkey=\"yyh\"  />"+
                           " 				<col width=\"18%\" text=\"访客姓名\" column=\"lfr\" orderkey=\"lfr\"  />"+
						   "				<col width=\"5%\" text=\"被访人\" column=\"bfz\" orderkey=\"bfz\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getLastname\" />"+
                           "				<col width=\"6%\" text=\"联系电话\" column=\"bfzlxdh\" orderkey=\"bfzlxdh\"  />"+
						   " 				<col width=\"5%\" text=\"车牌号码\" column=\"cphm\" orderkey=\"cphm\"  />"+
						   " 				<col width=\"5%\" text=\"车辆进入\" column=\"sfjrcq\" orderkey=\"sfjrcq\"  />"+
                           " 				<col width=\"19%\" text=\"来访公司\" column=\"lfdw\" orderkey=\"lfdw\"  />"+
						   " 				<col width=\"5%\" text=\"访客数量\" column=\"lfrs\" orderkey=\"lfrs\"  />"+
                           "				<col width=\"6%\" text=\"来访日期\" column=\"lfrq\" orderkey=\"lfrq\" />"+ 
                           "				<col width=\"5%\" text=\"预计来访\" column=\"lfsj\" orderkey=\"lfsj\"  />"+
						   " 				<col width=\"5%\" text=\"放置处\" column=\"fzc\" orderkey=\"fzc\"  />"+
                           "				<col width=\"6%\" align=\"center\" text=\"来访登记\" column=\"desc_1\" orderkey=\"requestid\" href=\"visitorEdit.jsp\" linkkey=\"id\" linkvaluecolumn=\"id\" target=\"_blank\" />"+ 
						   "				<col width=\"5%\" text=\"实际来访\" column=\"lfsjbn\" orderkey=\"lfsjbn\" />"+ 
						   "				<col width=\"5%\" text=\"实际离开\" column=\"lksjbn\" orderkey=\"lksjbn\" />"+ 
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
