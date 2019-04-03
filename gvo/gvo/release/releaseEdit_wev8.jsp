<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.conn.RecordSetDataSource"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.general.Util,weaver.file.*" %>
<%@ page import="java.util.*,weaver.hrm.common.*" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="ExcelFile" class="weaver.file.ExcelFile" scope="session"/>
<jsp:useBean id="ProjectInfoComInfo" class="weaver.proj.Maint.ProjectInfoComInfo" scope="page" />

<%
    String info = Util.null2String(request.getParameter("idkey")); 

    String id=Util.fromScreen(request.getParameter("id"),user.getLanguage());
    // message,url_str,mess_name
    String sqr = "";
    String sl = "";
    String sqrq = "";
    String dcr1 = "";
    String sqrbm = "";
    String sqfxrq = "";
    String sqqrlxfs = "";
    String wpmc = "";
    String ggxh = "";
    String dw = "";
    String csmc = "";
    String sjfxrq = "";
    //out.println("id= "+id);
    RecordSet.executeSql(" select f2.sqr,f2.sqrq,f2.dcr1,f2.sqrbm,f2.sqfxrq,f2.sqqrlxfs,f2.sjfxrq,f2.csmc,f1.wpmc,f1.ggxh,f1.dw,f1.sl from formtable_main_234_dt1 f1  left join formtable_main_234 f2 on f1.mainid = f2.id where f2.requestid= " + id);
	
   	if( RecordSet.next() ) {
	    sqr = Util.null2String(RecordSet.getString("sqr"));
	    sqrq = Util.null2String(RecordSet.getString("sqrq"));
	    dcr1 = Util.null2String(RecordSet.getString("dcr1"));
		  sqrbm = Util.null2String(RecordSet.getString("sqrbm"));
		  sqfxrq = Util.null2String(RecordSet.getString("sqfxrq"));
		  sqqrlxfs = Util.null2String(RecordSet.getString("sqqrlxfs"));
      wpmc = Util.null2String(RecordSet.getString("wpmc"));
		  ggxh = Util.null2String(RecordSet.getString("ggxh"));
		  dw = Util.null2String(RecordSet.getString("dw"));
		  sl = Util.null2String(RecordSet.getString("sl"));
		  csmc = Util.null2String(RecordSet.getString("csmc"));
		  sjfxrq = Util.null2String(RecordSet.getString("sjfxrq"));
	  }
	
	String sql = "";
%>
<script language="JavaScript">
	<%if(info!=null && !"".equals(info)){

		if("0".equals(info)){%>
			top.Dialog.alert("登记成功！")
		<%}

		else if("1".equals(info)){%>
			top.Dialog.alert("登记失败,请填写时间！")
		<%}
	}%>
	</script>
<%    
String imagefilename = "/images/hdHRMCard_wev8.gif";
String titlename =SystemEnv.getHtmlLabelName(21590,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<HTML><HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<script language="javascript" src="/js/weaver_wev8.js"></script>
</HEAD>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:onSave(),_self} " ;
RCMenuHeight += RCMenuHeightStep;
/*RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",javascript:doReturn(),_self} " ;
RCMenuHeight += RCMenuHeightStep;*/
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<table id="topTitle" cellpadding="0" cellspacing="0">
	<tr>
		<td>
		</td>
		<td class="rightSearchSpan" style="text-align:right;">
			<input type=button class="e8_btn_top" onclick="onSave(this);" value="<%=SystemEnv.getHtmlLabelName(86,user.getLanguage())%>">
			<input type=button class="e8_btn_top" onclick="doReturn(this);" value="<%=SystemEnv.getHtmlLabelName(1290,user.getLanguage())%>">
			<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
		</td>
	</tr>
</table>
<form id=frmmain name=frmmain method=post action="doRelease_wev8.jsp">
  <input class=inputstyle type="hidden" name="mid" value="<%=id%>">
<wea:layout type="4col" attributes="{'expandAllGroup':'true'}">
			<wea:group context='处理放行信息'>
				<wea:item>申请人</wea:item>
				<wea:item>
				<%=ResourceComInfo.getLastname(sqr)%>
				</wea:item>
				<wea:item>申请日期</wea:item>
				<wea:item><%=sqrq%></wea:item>
				<wea:item>申请人部门</wea:item>
				<wea:item><%=DepartmentComInfo.getDepartmentname(sqrbm)%></wea:item>
				<wea:item>申请人联系方式</wea:item>
				<wea:item><%=sqqrlxfs%></wea:item>
				<wea:item>带出人</wea:item>
				<wea:item><%=dcr1%></wea:item>
				<wea:item>厂商名称</wea:item>
				<wea:item><%=csmc%></wea:item>
				<wea:item>物品名称</wea:item>
				<wea:item><%=wpmc%></wea:item>
				<wea:item>规格型号</wea:item>
				<wea:item><%=ggxh%></wea:item>
        	<wea:item>数量</wea:item>
				<wea:item><%=sl%></wea:item>
				<wea:item>单位</wea:item>
				<wea:item><%=dw%></wea:item>
				<wea:item>申请放行日期</wea:item>
				<wea:item><%=sqfxrq%></wea:item>
				<wea:item>实际放行时间</wea:item>
				<wea:item>
					<button type="button" class=Clock id="selectmonstarttime2" onclick="onShowTime(monstarttime2Span,monstarttime2)"></button> 
					<SPAN id=monstarttime2Span><%=sjfxrq%></SPAN> 
					<INPUT class=inputstyle type="hidden"  name="monstarttime2" value="<%=sjfxrq%>">
				</wea:item>
			</wea:group>
		</wea:layout>
</form>
<script language=javascript>
function onSave(){
	Dialog.confirm("确认登记？", function (){
		
		frmmain.submit();
		
	}, function () {}, 320, 90,false);
}

function doReturn(){
	Dialog.confirm("确认返回？", function (){
		
		frmmain.action="/gvo/visitor/visitorInfo_wev8.jsp";
		frmmain.submit();
		
	}, function () {}, 320, 90,false);
}

</script>
</BODY>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
</HTML>
