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


String sqr_name = Util.null2String(request.getParameter("sqr_name"));  
String sqrbm_name = Util.null2String(request.getParameter("sqrbm_name"));  
String dcr1_name = Util.null2String(request.getParameter("dcr1_name"));  
String sqqrlxfs_name = Util.null2String(request.getParameter("sqqrlxfs_name"));


String imagefilename = "/images/hdDOC.gif";
String titlename = "放行历史记录列表";
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
	<TD>申请人</TD>
		<td><input class=inputstyle id='sqr_name' name=sqr_name size="20" value="<%=sqr_name%>" ></td>
	<TD>申请部门</TD>
		<td><input class=inputstyle id='sqrbm_name' name=sqrbm_name size="20" value="<%=sqrbm_name%>" ></td>
    <TD>带出人</TD>
		<td><input class=inputstyle id='dce1_name' name=dcr1_name size="20" value="<%=dcr1_name%>" ></td>
    <TD>申请人联系方式</TD>
		<td><input class=inputstyle id='sqqrlxfs_name' name=sqqrlxfs_name size="20" value="<%=sqqrlxfs_name%>" ></td>
	<TD class=field>
	       <input type="submit" value="立即查询">
     </TD>
	 <TD class=field>
	       <input type="button" value="返回物品放行首页" onClick="window.open('/gvo/release/releaseInfo.jsp')">
     </TD>
</tr>

<tr style="height:1px;"><td class=Line colspan=11></td></tr>
</table>

<TABLE width="100%">
	<tr>
		<td valign="top">
            <%
            String backfields = " za.requestid,za.id,za.sqr,za.sqrbm,za.sjfxrq,za.sqrq,za.sqqrlxfs,za.dcr1,za.sqfxrq,za.ccyy,za.wpmc,za.ggxh,za.dw,za.sl,za.bz,"
							  +" '&lt;img src=&quot;/images/rule_1.jpg&quot; border=&quot;0&quot;/&gt;' as desc_1 ";
            String fromSql  = " from (select f2.requestid,f2.id,f2.sqr,f2.sqrbm,f2.sjfxrq,f2.sqrq,f2.sqqrlxfs,f2.dcr1,f2.sqfxrq,f2.ccyy,f2.bz,f1.wpmc,f1.ggxh,f1.dw,f1.sl from formtable_main_234_dt1 f1 left join formtable_main_234 f2 on f1.mainid = f2.id) za ";

            String sqlWhere = " requestid in(select requestid from workflow_requestbase where currentnodetype in (1,2,3,4) ) ";

		   if(!"".equals(sqr_name)){
				sqr_name = sqr_name.trim();
				sqlWhere += "and za.sqr in (select id from hrmresource where lastname like '%"+sqr_name+"%')";
			}


		   if(!"".equals(sqrbm_name)){
				sqrbm_name = sqrbm_name.trim();
				sqlWhere += "and za.sqrbm in (select id from HrmDepartment where departmentmark like '%"+sqrbm_name+"%')";
			}

			if(!"".equals(dcr1_name)){
				dcr1_name = dcr1_name.trim();
				sqlWhere += "and za.dcr1 like '%"+dcr1_name+"%' ";
			}

            if(!"".equals(sqqrlxfs_name)){
				sqqrlxfs_name = sqqrlxfs_name.trim();
				sqlWhere += "and za.sqqrlxfs like '%"+sqqrlxfs_name+"%' ";
			}
			//if(!"".equals(resourceid)){   
				//sqlWhere += "and za.operateuserid ="+resourceid+" ";
			//}
            
            //out.println("select "+ backfields + fromSql + " where " + sqlWhere);
			//out.println(sqlWhere);
            String orderby = " sqfxrq,sqr " ;
            String tableString = "";
            tableString =" <table  tabletype=\"none\" pagesize=\""+perpage+"\" >"+
                           "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"id\" sqlsortway=\"asc\" />"+
                           "			<head>"+
						   " 				<col width=\"6%\" text=\"申请人\" column=\"sqr\" orderkey=\"sqr\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getLastname\" />"+
						   "                <col width=\"7%\" text=\"申请日期\" column=\"sqrq\" orderkey=\"sqrq\" />"+ 
                           " 				<col width=\"7%\" text=\"申请部门\" column=\"sqrbm\" orderkey=\"sqrbm\" transmethod=\"weaver.hrm.company.DepartmentComInfo.getDepartmentname\" />"+
						   "				<col width=\"8%\" text=\"申请放行日期\" column=\"sqfxrq\" orderkey=\"sqfxrq\" />"+ 
						   "				<col width=\"6%\" text=\"带出人\" column=\"dcr1\" orderkey=\"dcr1\"  />"+
                           "				<col width=\"13%\" text=\"申请人联系方式\" column=\"sqqrlxfs\" orderkey=\"sqqrlxfs\"  />"+
						   " 				<col width=\"9%\" text=\"物品名称\" column=\"wpmc\" orderkey=\"wpmc\"  />"+
						   " 				<col width=\"13%\" text=\"规格型号\" column=\"ggxh\" orderkey=\"ggxh\"  />"+
                           " 				<col width=\"6%\" text=\"单位\" column=\"dw\" orderkey=\"dw\"  />"+
						   " 				<col width=\"6%\" text=\"数量\" column=\"sl\" orderkey=\"sl\"  />"+ 
						   " 				<col width=\"11%\" text=\"备注\" column=\"bz\" orderkey=\"bz\"  />"+ 
						   "				<col width=\"7%\" text=\"实际放行时间\" column=\"sjfxrq\" orderkey=\"sqfxrq\" />"+ 
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
