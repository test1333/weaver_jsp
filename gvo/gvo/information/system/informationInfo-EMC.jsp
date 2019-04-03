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
<link rel="stylesheet" type="text/css" href="/gvo/information/css/css.css">
</head>

<%

int emp_id = user.getUID();
int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
int	perpage = 10;


String sqr_name = Util.null2String(request.getParameter("sqr_name"));  
String sqrbm_name = Util.null2String(request.getParameter("sqrbm_name"));  
String dcr1_name = Util.null2String(request.getParameter("dcr1_name"));  
String sqqrlxfs_name = Util.null2String(request.getParameter("sqqrlxfs_name"));


String imagefilename = "/images/hdDOC.gif";
String titlename = "应用系统";
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
<!--<colgroup><col width="10%"></col><col width="10%"></col><col width="10%"></col><col width="10%"></col><col width="10%"></col><col width="10%"></col><col width="10%"></col><col width="10%"></col><col width="10%"></col><col width="10%"></col></colgroup>
<!--<colgroup><col width="20%"></col><col width="25%"></col><col width="5%"></col><col width="25%"></col><col width="5%"><col width="25%"></col><col width="20"></col></col></colgroup>-->
<!--<tr>
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
	       <input type="button" value="查询历史" onClick="window.open('/gvo/release/releaseInfoHistory.jsp')">
     </TD>
	 <TD class=field>
	       <input type="button" value="返回首页" onClick="window.open('/gvo/redirect.jsp')">
     </TD>
</tr>-->

<tr style="height:1px;"><td class=Line colspan=11></td></tr>
</table><div class="juzhong" style=" text-align:center;">
<div class="juzhong" style="margin:0 auto; width:1200px;">
<table width="1200" height="100%" border="0" cellspacing="0" cellpadding="0"><tr><td align="center" valign="middle"> 
<table width="1200" height="100%" border="0" cellspacing="0" cellpadding="0"><tr><td align="center" valign="middle"> 
<tr><td  valign="top"> 
 <table width="250" border="1" align="left" cellpadding="0" cellspacing="0"><tr><td>
 
 <tr>
   <td>
    <div class="system"><a href="/gvo/information/informationInfosystem.jsp"><img src="/gvo/information/images/strucimgyxt.jpg"></a>
	   <h3>应用系统</h3>
	     <div class="systemleft">
	       <a href="/gvo/information/system/informationInfo-SAP.jsp">SAP ERP</a>
	       <a href="/gvo/information/system/informationInfo-DJERP.jsp">鼎捷 ERP</a>
	       <a href="/gvo/information/system/informationInfo-EMC.jsp">EMC D2</a>
	       <a href="/gvo/information/system/informationInfo-BI.jsp">BI</a>
	       <a href="/gvo/information/system/informationInfo-oledOA.jsp">旧OA</a>
	     </div>
		 <div class="systemright">
	       <a href="/gvo/information/system/informationInfo-Kingdee.jsp">Kingdee ERP</a>
	       <a href="/gvo/information/system/informationInfo-newOA.jsp">泛微OA</a>
	       <a href="/gvo/information/system/informationInfo-HR.jsp">HR</a>
	       <a href="/gvo/information/system/informationInfo-FineReport.jsp">FineReport</a>
	    </div>
	</div>
   </td>
  </tr>
<table width="940" border="1" align="right" cellpadding="0" cellspacing="0"><tr><td>
<TABLE width="100%" >
  
	<tr>
		<td valign="top" width="80%">
            <%
            String backfields = " za.xh,decode(za.type,0,'弱电',1,'运维',2,'应用系统') as leibie,za.details2,decode(za.details2,0,'综合布线',1,'网络',2,'视频系统',3,'考勤门禁',4,'监控系统',5,'电话',6,'桌面支持',7,'服务器',8,'数据库',9,'存储',10,'会务',11,'SAP ERP',12,'Kingdee ERP',13,'鼎捷 ERP',14,'泛微OA',15,'EMC D2',16,'HR',17,'BI',18,'FineReport',19,'旧OA') as new1,za.details3,decode(za.details3,0,'故障恢复方法',1,'根本解决方案',2,'操作手册',3,'管理规程',4,'其他知识') as new2,za.recorddate,za.recorder,za.subject,za.descrip,za.reason,za.solution,za.unsolutioned,za.remark,za.attached ";
			//String backfields = " za.xh,b.selectname as oneclass,a.selectname as twoclass,za.details3,za.recorder,za.subject,za.descrip,za.reason,za.solution,za.unsolutioned,za.remark,za.attached ";
							//  +" '&lt;img src=&quot;/images/rule_1.jpg&quot; border=&quot;0&quot;/&gt;' as desc_1 ";
			String fromSql  = " formtable_main_325 za  ";
            //String fromSql  = " from formtable_main_325 za,workflow_selectitem a,workflow_selectitem b ";
			
            String sqlWhere = " where details2=15 ";
			//String sqlWhere = " where a.fieldid='18415' and a.selectvalue=za.details2 and b.fieldid='18347' and b.selectvalue=za.type and   ";
			//String backfields = " za.requestid,za.id,za.sqr,za.sqrbm,za.sjfxrq,za.sqrq,za.sqqrlxfs,za.dcr1,za.sqfxrq,za.csmc,za.wpmc,za.ggxh,za.dw,za.sl,za.bz,"
							 // +" '&lt;img src=&quot;/images/rule_1.jpg&quot; border=&quot;0&quot;/&gt;' as desc_1 ";
            //String fromSql  = " from (select f2.requestid,f2.id,f2.sqr,f2.sqrbm,f2.sjfxrq,f2.sqrq,f2.sqqrlxfs,f2.dcr1,f2.sqfxrq,f2.csmc,f2.bz,f1.wpmc,f1.ggxh,f1.dw,f1.sl from formtable_main_234_dt1 f1 left join formtable_main_234 f2 on f1.mainid = f2.id) za ";

           // String sqlWhere = " requestid in(select requestid from workflow_requestbase where currentnodetype in (3) ) ";

		   //if(!"".equals(sqr_name)){
				//sqr_name = sqr_name.trim();
				//sqlWhere += "and za.sqr in (select id from hrmresource where lastname like '%"+sqr_name+"%')";
			//}


		  // if(!"".equals(sqrbm_name)){
				//sqrbm_name = sqrbm_name.trim();
				//sqlWhere += "and za.sqrbm in (select id from HrmDepartment where departmentmark like '%"+sqrbm_name+"%')";
			//}

			//if(!"".equals(dcr1_name)){
			//	dcr1_name = dcr1_name.trim();
				//sqlWhere += "and za.dcr1 like '%"+dcr1_name+"%' ";
			//}

           // if(!"".equals(sqqrlxfs_name)){
				//sqqrlxfs_name = sqqrlxfs_name.trim();
				//sqlWhere += "and za.sqqrlxfs like '%"+sqqrlxfs_name+"%' ";
		//	}
            
            //out.println("select "+ backfields + fromSql + " where " + sqlWhere);
			//out.println(sqlWhere);
            String orderby = " recorder,subject " ;
            String tableString = "";
            tableString =" <table  tabletype=\"none\" pagesize=\""+perpage+"\" >"+
                           "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"id\" sqlsortway=\"asc\" />"+
                           "			<head>"+
						   " 				<col width=\"5%\" text=\"记录人\" column=\"recorder\" orderkey=\"sqr\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getLastname\" />"+
						   "				<col width=\"4%\" text=\"类别\" column=\"leibie\" orderkey=\"leibie\"  />"+
						   "				<col width=\"6%\" text=\"二级分类\" column=\"new1\" orderkey=\"new1\"  />"+	
						   "				<col width=\"6%\" text=\"三级分类\" column=\"new2\" orderkey=\"new2\"  />"+	
						   "				<col width=\"6%\" text=\"登记日期\" column=\"recorddate\" orderkey=\"recorddate\"  />"+						   
                           "				<col width=\"8%\" text=\"主题\" column=\"subject\" orderkey=\"subject\"  />"+
                           "				<col width=\"9%\" text=\"问题描述\" column=\"descrip\" orderkey=\"descrip\"  />"+ 
						   "				<col width=\"28%\" text=\"问题发生原因\" column=\"reason\" orderkey=\"reason\"  />"+
                           "				<col width=\"28%\" text=\"解决方案\" column=\"solution\" orderkey=\"solution\"  />"+
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
</td><td></td></tr></table> </td></tr></table> </td></tr></td></tr></table> </table> </div></div>

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
