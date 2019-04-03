<!DOCTYPE html>
<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<HTML><HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<LINK href="/wui/theme/ecology8/jquery/js/e8_zDialog_btn_wev8.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
</head>
<%
String id = Util.null2String(request.getParameter("id"));
String mainid = Util.null2String(request.getParameter("mainid"));
String dialog = Util.null2String(request.getParameter("dialog"));
String isclose = Util.null2String(request.getParameter("isclose"));

if(!"1".equals(isclose)&&id.length() < 1){
	return;
}
// 更新操作 操作完关页面
if("1".equals(isclose)){
	String ycxxms_1 = Util.null2String(request.getParameter("ycxxms")); ;  //异常现象描述
	String ycjd_1 = Util.null2String(request.getParameter("ycjd")); ; //异常节点
	String ycrq_1 = Util.null2String(request.getParameter("ycrq")); ; //异常日期
	String djry_1 = Util.null2String(request.getParameter("djry")); ; //RA登记人员
	String ypqzrq_1 = Util.null2String(request.getParameter("ypqzrq")); ; //样品取走日期时间
	String ypqx_1 = Util.null2String(request.getParameter("ypqx")); ;  //异常样品去向
	String jxry_1 = Util.null2String(request.getParameter("jxry")); ; //解析人员
	String bz_1 = Util.null2String(request.getParameter("bz")); ; //备注
	if("-1".equals(ypqx_1)){
		ypqx_1 = "";
	}
	if("-1".equals(ycxxms_1)){
		ycxxms_1 = "";
	}
	
	String sql = "update uf_ycjm_dt1 set ycrq='" + ycrq_1 + "',ycjd='" + ycjd_1 + "',djry='" + djry_1 + "',ypqzrq='" + ypqzrq_1
				+ "',ypqx='" + ypqx_1 + "',jxry='" + jxry_1 + "',bz='" + bz_1 + "' where id in(" + id + ")";
	if(ycxxms_1.length() > 0){
		sql = "update uf_ycjm_dt1 set ycxxms=" + ycxxms_1 + ",ycrq='" + ycrq_1 + "',ycjd='" + ycjd_1 + "',djry='" + djry_1 + "',ypqzrq='" 
			+ ypqzrq_1+ "',ypqx='" + ypqx_1 + "',jxry='" + jxry_1 + "',bz='" + bz_1 +"' where id in(" + id + ")";
	}
	RecordSet.executeSql(sql);
}

String PANEL = "";  //PANEL ID
String bh = ""; //RA 编号
int zt = 0; //状态
int ycxxms= 0;  //异常现象描述
String ycjd = ""; //异常节点
String ycrq = ""; //异常日期
String djry = ""; //RA登记人员
String ypqzrq = ""; //样品取走日期时间
int ypqx = 0;  //异常样品去向
String jxry = ""; //解析人员
String bz = ""; //备注
//	Util.getIntValue(request.getParameter("votingId"),0); 
	
RecordSet.executeSql("select * from uf_ycjm_dt1 where id = " + id);
if(RecordSet.next()){
	PANEL = Util.null2String(RecordSet.getString("PANEL"));
	bh = Util.null2String(RecordSet.getString("bh"));
	zt = Util.getIntValue(RecordSet.getString("zt"),-1); //
	ycxxms = Util.getIntValue(RecordSet.getString("ycxxms"),-1);  //
	ycjd = Util.null2String(RecordSet.getString("ycjd"));
	ycrq = Util.null2String(RecordSet.getString("ycrq"));
	djry = Util.null2String(RecordSet.getString("djry"));
	ypqzrq = Util.null2String(RecordSet.getString("ypqzrq"));
	ypqx = Util.getIntValue(RecordSet.getString("ypqx"),-1);  //
	jxry = Util.null2String(RecordSet.getString("jxry"));
	bz = Util.null2String(RecordSet.getString("bz"));
}

String imagefilename = "/images/hdHRMCard_wev8.gif";
String titlename = "编辑更新";
String needfav ="1";
String needhelp ="";
%>
<BODY style="overflow:hidden;">
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:submitData(),_self} " ;
	RCMenuHeight += RCMenuHeightStep;
	RCMenu += "{取消,javascript:btn_cancle(),_self} " ;
	RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<%if("1".equals(dialog)){ %>
<div class="zDialog_div_content">
<jsp:include page="/systeminfo/commonTabHead.jsp">
   <jsp:param name="mouldID" value="workflow"/>
   <jsp:param name="navName" value="<%=titlename %>"/>
</jsp:include>
<%}%>
<FORM id=weaver name=frmMain action="" method=post>
<table id="topTitle" cellpadding="0" cellspacing="0">
	<tr>
		<td></td>
		<td class="rightSearchSpan" style="text-align:right; width:500px!important">
	    	<input type="button" value="保存" id="zd_btn_submit" class="e8_btn_top" onclick="submitData()">
	    	<input type="button" value="取消" id="zd_btn_cancle"  class="e8_btn_top" onclick="btn_cancle()">				
			<span title="菜单" class="cornerMenu"></span>
		</td>
	</tr>
</table>
<wea:layout type="4col">
    <wea:group context="基本信息">
	
	<wea:item>异常现象描述</wea:item>
    	<wea:item>				      
    			<select name="ycxxms">
    				<option value=-1></option>   
    				<%
    					String sql = "select disorder,name from mode_selectitempagedetail where  mainid in(36)";
					RecordSet.executeSql(sql);
					while(RecordSet.next()){
						String tmp_name = Util.null2String(RecordSet.getString("name"));
						double tmp_val = RecordSet.getDouble("disorder");
    				%>
				<option value=<%=tmp_val%>  <%if(ycxxms==tmp_val){ %>selected<%} %>><%=tmp_name%></option>
				<%}%>
			</select>
	</wea:item>
    	
	<wea:item>异常节点</wea:item>
    	<wea:item><input class="inputstyle" type="type" id="ycjd" name="ycjd" value="<%=ycjd%>"/></wea:item>
    	
	<wea:item>异常日期</wea:item>
    	<wea:item>
			<BUTTON type=button class=calendar id=SelectDate onclick=onShowDate(ycrqSpan,ycrq)></BUTTON>&nbsp;
					    <SPAN id=ycrqSpan ><%=ycrq%></SPAN>
					    <input class="inputstyle" type="hidden" id="ycrq" name="ycrq" value="<%=ycrq%>">
	</wea:item>
    	
	<wea:item>RA登记人员</wea:item>
      <wea:item>	   		
			<brow:browser viewType="0"  name="djry" browserValue="<%=djry %>"
				browserOnClick=""
				browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
				hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
				completeUrl="/data.jsp" width="165px"
				browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(djry),user.getLanguage())%>">
			</brow:browser>
	</wea:item>
	
	<wea:item>样品取走日期时间</wea:item>
    	<wea:item>
			<BUTTON type=button class=calendar id=SelectDate onclick=onShowDate(ypqzrqSpan,ypqzrq)></BUTTON>&nbsp;
					    <SPAN id=ypqzrqSpan ><%=ypqzrq%></SPAN>
					    <input class="inputstyle" type="hidden" id="ypqzrq" name="ypqzrq" value="<%=ypqzrq%>">
	</wea:item>
    	
	<wea:item>异常样品去向</wea:item>
    	<wea:item>				      
    			<select name="ypqx">
				<option value=-1></option>   
				<option value=0  <%if(ypqx==0){ %>selected<%} %>>委测者取走</option>
				<option value=1  <%if(ypqx==1){ %>selected<%} %>>待委测者确认</option>
				<option value=2  <%if(ypqx==2){ %>selected<%} %>>续投</option>
				<option value=3  <%if(ypqx==3){ %>selected<%} %>>FA</option>
			</select>
	</wea:item>
    	
	<wea:item>解析人员</wea:item>
    	<wea:item>	   		
			<brow:browser viewType="0"  name="jxry" browserValue="<%=jxry %>"
				browserOnClick=""
				browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
				hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
				completeUrl="/data.jsp" width="165px"
				browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(jxry),user.getLanguage())%>">
			</brow:browser>
	</wea:item>
    	
	<wea:item>备注</wea:item>
    	<wea:item>
    		<textarea rows="3" cols="40" name="bz"><%=bz%></textarea>
    	</wea:item>
    	
	</wea:group>
</wea:layout>
<input type="hidden" name="id" value="<%=id%>"> 
<input type="hidden" name="isclose" value="1">
 </form>
 <%if("1".equals(dialog)){ %>
 <jsp:include page="/systeminfo/commonTabFoot.jsp"></jsp:include>
</div>
<div id="zDialog_div_bottom" class="zDialog_div_bottom">
	<wea:layout needImportDefaultJsAndCss="false">
		<wea:group context=""  attributes="{\"groupDisplay\":\"none\"}">
			<wea:item type="toolbar">
		    	<input type="button" value="<%=SystemEnv.getHtmlLabelName(309,user.getLanguage())%>" id="zd_btn_cancle"  class="zd_btn_cancle" onclick="dialog.closeByHand()">
			</wea:item>
		</wea:group>
	</wea:layout>
</div>
<%} %>
 <script language="javascript">
	var dialog = parent.getDialog(window);
	var parentWin = parent.getParentWindow(window);
	function btn_cancle(){
		parentWin.closeDialog();
	}

	if("<%=isclose%>"==1){
		btn_cancle();
		var dialog = parent.getDialog(window);
		var parentWin = parent.getParentWindow(window);
//		parentWin.location="/hehui/qa/QAList.jsp?mainid=<%=mainid%>";
		parentWin.closeDialog();	
	}
	

	
	function submitData()
	{
		if (check_form(weaver,'PANEL,bh')){
			if("<%=dialog%>"!="1"){
				enableAllmenu();
			}
			weaver.submit();
	    }
	}
	function doback(){
		if("<%=dialog%>"!="1"){
			enableAllmenu();
		}
	    location.href="/hehui/qa/QAList.jsp?mainid=<%=mainid%>";
	}

	$("#zd_btn_submit").hover(function(){
		$(this).addClass("zd_btn_submit_hover");
	},function(){
		$(this).removeClass("zd_btn_submit_hover");
	});

	$("#zd_btn_cancle").hover(function(){
		$(this).addClass("zd_btn_cancleHover");
	},function(){
		$(this).removeClass("zd_btn_cancleHover");
	});
</script>
	<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
</BODY></HTML>
