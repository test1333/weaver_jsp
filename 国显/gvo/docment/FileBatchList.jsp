<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
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
%>

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
	<%
		String forTime = Util.null2String(request.getParameter("forTime"));
		forTime = "18:09";
	%>
</tr>
	<tr>
	 <TD>文件名称</TD>
		<td><input class=inputstyle id='file_name' name=file_name size="40" value="<%=file_name%>" ></td>
        <TD>&nbsp;</TD>
   	 
   <td> </td>

</tr>
<tr style="height:1px;"><td class=Line colspan=11></td></tr>
</table>

<TABLE width="100%">
	<tr>
		<td valign="top">
            <%
            String backfields = "za.imagefileid,za.filesize,za.imagefilename,za.docid,za.maincategory,za.subcategory,za.seccategory,za.operateuserid,za.oper_time，"
							+"(select Categoryname from DocMainCategory where id=za.maincategory) as main_name,"
							+"(select Categoryname from DocSubCategory where id=za.subcategory) as sec_name,"
							+"(select Categoryname from DocSecCategory where id=za.seccategory) as sub_name,"
							+"decode(za.gvo_encrypt,1,'加密','非加密') as is_en ";
            String fromSql  = " from (select x.imagefileid,x.filesize,x.imagefilename,x.docid,dd.maincategory,dd.subcategory,dd.seccategory, "
							 +" ddl.operateuserid,ddl.operatedate||' '||ddl.operatetime as oper_time,x.gvo_encrypt from ( "
							 +" select im.imagefileid,im.filesize,docid,im.imagefilename,im.gvo_encrypt from  imagefile im "
							 +" join docimagefile df on(df.imagefileid=im.imagefileid) "
							 +" where docid not in(select docid from gvo_emc_file_info) )  x "
							 +" join  DocDetail dd on(x.docid=dd.id) "
							 +" join docdetaillog ddl on(ddl.docid=x.docid)) za ";
			
            String sqlWhere = " 1=1 ";
            
			if(!"".equals(resourceid)){
				sqlWhere += "and za.operateuserid ="+resourceid+" ";
			}
            
			if(!"".equals(file_name)){
				file_name = file_name.trim();
				sqlWhere += "and za.imagefilename like '%"+file_name+"%'";
			}
            
			if(!"".equals(fromdate)){
		    	sqlWhere +=" and za.oper_time>='"+fromdate+" 00:00:00' ";
		    	if(!"".equals(enddate)){
		    		sqlWhere +=" and za.oper_time <='"+enddate+" 23:59:59' ";
		    	}
		    }else{
			    if(!"".equals(enddate)){
			    		sqlWhere +=" and za.oper_time<='"+enddate+" 23:59:59' ";
			    	}
		    }
           // out.println("select "+ backfields + fromSql + " where " + sqlWhere);
			//System.out.println(sqlWhere);
            String orderby = " maincategory,subcategory,seccategory,oper_time " ;
            String tableString = "";
            tableString =" <table instanceid=\"workflowRequestListTable\" tabletype=\"checkbox\" pagesize=\""+perpage+"\" >"+
                           "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"imagefileid\" sqlsortway=\"asc\" />"+
                           "			<head>"+
                           "				<col width=\"25%\" text=\"文档名称\" column=\"imagefilename\" orderkey=\"imagefilename\" />"+ 
                           "				<col width=\"7%\" text=\"文档大小\" column=\"filesize\" orderkey=\"filesize\"  />"+
						   "				<col width=\"8%\" text=\"创建人\" column=\"operateuserid\" orderkey=\"operateuserid\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getLastname\" />"+
                           "				<col width=\"15%\" text=\"创建时间\" column=\"oper_time\" orderkey=\"oper_time\"  />"+
                           " 				<col width=\"12%\" text=\"主目录\" column=\"main_name\" orderkey=\"main_name\"  />"+
               			   " 				<col width=\"12%\" text=\"二级目录\" column=\"sec_name\" orderkey=\"sec_name\"  />"+
               	           " 				<col width=\"12%\" text=\"三级目录\" column=\"sub_name\" orderkey=\"sub_name\"  />"+
			   "			<col width=\"9%\" text=\"加密状态\" column=\"is_en\" orderkey=\"is_en\"  />"+	
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
       jQuery("#forTime").val(datas.id.substr(1));
     }else{
       jQuery("#forTime").val(""); 
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
<SCRIPT language=VBS>
sub onShowMould(tdname,inputename)
	
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp?selectedids="&document.all(inputename).value)
	if NOT isempty(id) then
		document.all(tdname).innerHtml = id(1)
		document.all(inputename).value=id(0)
	end if
end sub

sub onShowTime(spanname,inputename)
	returntime = window.showModalDialog("/systeminfo/Clock.jsp",,"dialogHeight:360px;dialogwidth:275px")
	document.all(spanname).innerHtml = returntime
	document.all(inputename).value=returntime
end sub
</script> 
	<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
</BODY>
</HTML>
