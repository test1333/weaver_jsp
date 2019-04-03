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

String id=Util.null2String(request.getParameter("id"));
String bfz = Util.null2String(request.getParameter("bfz"));
String lfrq = Util.null2String(request.getParameter("lfrq"));
String lfr = Util.null2String(request.getParameter("lfr"));
String lfdw = Util.null2String(request.getParameter("lfdw"));
String lfrs = Util.null2String(request.getParameter("lfrs"));
String cphm = Util.null2String(request.getParameter("cphm"));
String lfsjbn = Util.null2String(request.getParameter("lfsjbn"));
String lksjbn = Util.null2String(request.getParameter("lksjbn")); 
String zjh = Util.null2String(request.getParameter("zjh")); 
String fzc = Util.null2String(request.getParameter("fzc")); 

String info = Util.null2String(request.getParameter("idkey")); 

//out.print("info="+info);

String sql="select * from formtable_main_124 where requestid = " + id;
//out.print("sql="+sql);
RecordSet.executeSql(sql);
   	if( RecordSet.next() ) {
	    bfz = Util.null2String(RecordSet.getString("bfz"));
	    lfrq = Util.null2String(RecordSet.getString("lfrq"));
	    lfr = Util.null2String(RecordSet.getString("lfr"));
		lfdw = Util.null2String(RecordSet.getString("lfdw"));
		lfrs = Util.null2String(RecordSet.getString("lfrs"));
		cphm = Util.null2String(RecordSet.getString("cphm"));
        zjh = Util.null2String(RecordSet.getString("zjh"));
		fzc = Util.null2String(RecordSet.getString("fzc"));
		lfsjbn = Util.null2String(RecordSet.getString("lfsjbn"));
		lksjbn = Util.null2String(RecordSet.getString("lksjbn"));
	}
%>
<script language="JavaScript">
	<%if(info!=null && !"".equals(info)){

		if("0".equals(info)){%>
			top.Dialog.alert("登记成功！")
		<%}

		else if("1".equals(info)){%>
			top.Dialog.alert("登记失败,请填写内容！")
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
<form id=frmmain name=frmmain method=post action="doEdit_wev8.jsp">
  <input class=inputstyle type="hidden" name="mid" value="<%=id%>">
<wea:layout type="4col" attributes="{'expandAllGroup':'true'}">
			<wea:group context='来访信息处理'>
				<wea:item>被访者</wea:item>
				<wea:item>
				<%=ResourceComInfo.getLastname(bfz)%>
				</wea:item>
				<wea:item>来访日期</wea:item>
				<wea:item><%=lfrq%></wea:item>
				<wea:item>来访人</wea:item>
				<wea:item><%=lfr%></wea:item>
				<wea:item>来访单位</wea:item>
				<wea:item><%=lfdw%></wea:item>
				<wea:item>来访人数</wea:item>
				<wea:item><%=lfrs%></wea:item>
				<wea:item>车牌号码</wea:item>
				<wea:item><%=cphm%></wea:item>
				<wea:item>证件号</wea:item>
				<wea:item>
						<input class=inputstyle id='zjh' name=zjh value="<%=zjh%>" >
				</wea:item>
				<wea:item>放置处</wea:item>
				<wea:item><input class=inputstyle id='fzc' name=fzc value="<%=fzc%>" ></wea:item>
				<wea:item>来访时间</wea:item>
				<wea:item>
					<button type="button" class="Clock" id="selectmonstarttime1" onclick="onShowTime(monstarttime1Span,monstarttime1)"></button> 
					<SPAN id="monstarttime1Span"><%=lfsjbn%></SPAN> 
					<INPUT class=inputstyle type="hidden" name="monstarttime1" value="<%=lfsjbn%>">
				</wea:item>
				<wea:item>离开时间</wea:item>
				<wea:item>
					<button type="button" class=Clock id="selectmonstarttime2" onclick="onShowTime(monstarttime2Span,monstarttime2)"></button> 
					<SPAN id=monstarttime2Span><%=lksjbn%></SPAN> 
					<INPUT class=inputstyle type="hidden"  name="monstarttime2" value="<%=lksjbn%>">
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
