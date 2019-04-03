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

	//user = (User)session.getAttribute("weaver_user@bean");
	//user.setLanguage(7);
	//int uid_1 = user.getUID();
//if(uid_1!=-10&&uid_1!=1) {
	//session.removeAttribute("weaver_user@bean");
	//response.sendRedirect("/login/login.jsp") ;
	//return ;
//}//控制权限
//int emp_id = user.getUID();

int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
int	perpage = 10;

String resourceid = Util.null2String(request.getParameter("resourceid"));
String gh = Util.null2String(request.getParameter("gh"));


String imagefilename = "/images/hdDOC.gif";
String titlename = "人员系统信息维护";
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
	<TD>员工姓名</TD>
		<td class=Field><BUTTON class=Browser type="button" id=SelectManagerID onClick="onShowResourceID('resourceid','resourceidspan')"></BUTTON>
				  <span id=resourceidspan><%=Util.toScreen(ResourceComInfo.getResourcename(resourceid),user.getLanguage())%></span>
				<INPUT class=saveHistory id=resourceid type=hidden name=resourceid value="<%=resourceid%>"></td>
	<td></td>
	<TD>工号</TD>
		<td><input class=inputstyle id='gh' name=gh size="40" value="<%=gh%>" ></td>

</tr>

<tr style="height:1px;"><td class=Line colspan=11></td></tr>
</table>

<TABLE width="100%">
	<tr>
		<td valign="top">
            <%
            String backfields = " x.id,x.lastname,x.workcode,decode(nvl(x.accounttype,'0'),'1','次帐号','主帐号') as accounttype,x.subcompanyname,x.departmentname,x.leadername as managername,x.jobtitlename,x.loginid ";
            String fromSql  = " from (select h.id,h.status,h.lastname,h.workcode,decode(nvl(h.accounttype,'0'),'1','次帐号','主帐号') as accounttype,hs.subcompanyname, "
            +" hp.departmentname,hr.lastname as leadername,hj.jobtitlename,h.loginid,h.account "
            +" from HrmResource h "
            +" left join hrmsubcompany hs on(hs.id=h.subcompanyid1) "
            +" left join hrmdepartment hp on(hp.id=h.departmentid) "
            +" left join hrmjobtitles hj on(hj.id=h.jobtitle) "
            +" left join hrmresource hr on(hr.id=h.managerid) "
            +" where h.status &lt;4) x ";
			
            String sqlWhere = " 1=1 ";

			if(!"".equals(resourceid)){
				sqlWhere += "and x.id ="+resourceid+" ";
			}
          
            if(!"".equals(gh)){
				gh = gh.trim();
				sqlWhere += "and x.workcode like '%"+gh+"%' ";
			}
            
			String orderby = " lastname " ;
            String tableString = "";
            tableString =" <table  tabletype=\"none\" pagesize=\""+perpage+"\" >"+
                           "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"id\" sqlsortway=\"asc\" />"+
                           "			<head>"+
						   " 				<col width=\"10%\" text=\"账号类型\" column=\"accounttype\" orderkey=\"accounttype\"  />"+
                           " 				<col width=\"10%\" text=\"编号\" column=\"workcode\" orderkey=\"workcode\"  />"+
						   "				<col width=\"10%\" text=\"姓名\" column=\"lastname\" orderkey=\"lastname\"  />"+
                           "				<col width=\"10%\" text=\"分部\" column=\"subcompanyname\" orderkey=\"subcompanyname\"  />"+
						   " 				<col width=\"10%\" text=\"部门\" column=\"departmentname\" orderkey=\"departmentname\"  />"+
						   " 				<col width=\"10%\" text=\"直接上级\" column=\"managername\" orderkey=\"managername\"  />"+
                           " 				<col width=\"20%\" text=\"岗位\" column=\"jobtitlename\" orderkey=\"jobtitlename\"  />"+
						   " 				<col width=\"10%\" text=\"登录名\" column=\"loginid\" orderkey=\"loginid\"  />"+
						   "			</head>"+
						   "                <operates width=\"10%\">" +
                           "                <operate href=\"/gvo/data/AccountUpdateEdit.jsp\" linkkey=\"id\" linkvaluecolumn=\"id\" text=\""+SystemEnv.getHtmlLabelName(15804,user.getLanguage())+"\" target=\"_fullwindow\" index=\"1\"/>" +
                           "     </operates>" +" linkvaluecolumn=\"id\" target=\"_blank\" />"+
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
