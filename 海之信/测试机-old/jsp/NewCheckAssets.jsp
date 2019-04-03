
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="weaver.general.Util" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<% 
boolean canedit = true;
%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="Util" class="weaver.general.Util" scope="page" />
<jsp:useBean id="LanguageComInfo" class="weaver.systeminfo.language.LanguageComInfo" scope="page"/>

<%
	int msgid = Util.getIntValue(request.getParameter("msgid"), -1);
	String isclose = Util.null2String(request.getParameter("isclose"));

	boolean canEdit = true;
	String checkid = Util.null2String(request.getParameter("checkid"));
    String num = Util.null2String(request.getParameter("num"));
    String currency = Util.null2String(request.getParameter("currency"));
    String origin = Util.null2String(request.getParameter("origin"));
    String customer = Util.null2String(request.getParameter("customer"));
	String remark = Util.null2String(request.getParameter("desc"));//备注

    //商品名称
	String goods_name ="";
	String goodsname_x =Util.null2String(request.getParameter("goodsname"));
	String sql2 = "select goodsname from uf_goodsinfo where id = '"+goodsname_x+"'";
	rs.executeSql(sql2);
	if(rs.next()){
	       goods_name = Util.null2String(rs.getString("goodsname"));
	   }
%>
<HTML><HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver_wev8.js"></script>
<script language=javascript >
var parentWin;
try{
parentWin = parent.getParentWindow(window);
}catch(e){}

function checkSubmit(){
	$('#weaver').submit();	
	window.close();

}
if("<%=isclose%>"=="1"){
	parent.getParentWindow(window)._table.reLoad();
	parent.getDialog(window).close();
	
}

jQuery(function(){
	checkinput("name","nameimage");
});
</script>
</HEAD>
<%
String imagefilename = "/images/hdMaintenance_wev8.gif";
String titlename = "";
if (canEdit) 
	titlename = SystemEnv.getHtmlLabelName(93,user.getLanguage())
			+":"+SystemEnv.getHtmlLabelName(462,user.getLanguage())+SystemEnv.getHtmlLabelName(63,user.getLanguage());
else 
	titlename = SystemEnv.getHtmlLabelName(367,user.getLanguage())
			+":"+SystemEnv.getHtmlLabelName(462,user.getLanguage())+SystemEnv.getHtmlLabelName(63,user.getLanguage());

String needfav ="1";
String needhelp ="";
%>
<BODY>

<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
if (canEdit){  
	RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:checkSubmit(),''} " ;
	RCMenuHeight += RCMenuHeightStep ;
}
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>

<jsp:include page="/systeminfo/commonTabHead.jsp">
   <jsp:param name="mouldID" value="customer"/>
   <jsp:param name="navName" value="盘盈新增"/>
</jsp:include>

<wea:layout attributes="{layoutTableId:topTitle}">
	<wea:group context="" attributes="{groupDisplay:none}">
		<wea:item attributes="{'customAttrs':'class=rightSearchSpan'}">
			<%if (canEdit){  %>
			<input class="e8_btn_top middle" onclick="checkSubmit()" type="button"  value="<%=SystemEnv.getHtmlLabelName(86,user.getLanguage()) %>"/>
			<%} %>
			<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
		</wea:item>
	</wea:group>
</wea:layout>

<wea:layout>
	<wea:group context="" attributes="{groupDisplay:none,itemAreaDisplay:none}">
		<%if (msgid != -1) {%>
		<wea:item><FONT color="red" size="2"><%=SystemEnv.getErrorMsgName(msgid,user.getLanguage())%></FONT></wea:item>
		<%}%>
	</wea:group>
</wea:layout>
	
<FORM id=weaver name=weaver action="NewCheckAssetsEdit.jsp" method=post >
<input type="hidden" name="method" value="edit">
<input type="hidden" name="checkid" value="<%=checkid%>">

<wea:layout>
	<wea:group context="<%= SystemEnv.getHtmlLabelName(1361,user.getLanguage())%>">

		<!--资产名称-->
		<wea:item>资产名称</wea:item>
		<wea:item>
			<% if(canedit) {%>
				<brow:browser viewType="0"  name="goodsname" browserValue="<%=goodsname_x %>"
				    browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.goodsinfo"
				    hasInput="true" isSingle="true" hasBrowser = "true" isMustInput='1'
				    completeUrl="/data.jsp?type=4" width="300px"
				    linkUrl=""
				    browserSpanValue="<%=goods_name %>">
				</brow:browser>
			<%} 
			else {%><%=Util.toScreen(RecordSet.getString(3),user.getLanguage())%><%}%>
		</wea:item>

		<wea:item>预估单价</wea:item>
		<wea:item>
		<wea:required id="nameimage2" required="true" value="">
		<% if(canedit) {%>
		<INPUT  maxLength=50 size=45 name="currency" style="width: 300px;" id = "currency"
				value="<%=currency%>" 
				onchange='checkinput("currency","nameimage2")'
				onblur="noNumbers(event,2)">
		<%} else {%><%=Util.toScreen(RecordSet.getString(2),user.getLanguage())%><%}%>
		</wea:required>
		</wea:item>

		<wea:item>入库数量</wea:item>
		<wea:item>
		<wea:required id="nameimage" required="true" value="">
		<% if(canedit) {%>
			<INPUT  maxLength=50 size=45 name="num" style="width: 300px;" id = "name"
				value="<%=num%>"
				onchange='checkinput("num","nameimage")'
				temptitle="<%=SystemEnv.getHtmlLabelName(-433,user.getLanguage())%>"
				onkeypress="ItemCount_KeyPress()">
			<%} else {%><%=Util.toScreen(RecordSet.getString(2),user.getLanguage())%><%}%>
		</wea:required>
		</wea:item>

		<wea:item>来源</wea:item>
		<wea:item>
		<select class="e8_btn_top middle" name="origin" id="origin" width="300px"> 
		<option value="" <%if("".equals(origin)){%> selected<%} %>>
			<%=""%></option>
		<option value="0" <%if("0".equals(origin)){%> selected<%} %>>
					<%="拆分"%></option>
		<option value="2" <%if("2".equals(origin)){%> selected<%} %>>
			<%="赠送"%></option>
		<option value="3" <%if("3".equals(origin)){%> selected<%} %>>
			<%="采购"%></option>
		<option value="4" <%if("4".equals(origin)){%> selected<%} %>>
			<%="托管"%></option>
		<option value="7" <%if("7".equals(origin)){%> selected<%} %>>
			<%="随机配件"%></option>
		</select>
		</wea:item>

		<wea:item>客户</wea:item>
		<wea:item>
		<brow:browser viewType="0"  name="customer" browserValue="<%=customer %>" 
		browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.Custom"
		hasInput="true" isSingle="true" hasBrowser = "true" isMustInput='1'
		completeUrl="/data.jsp" width="300px"
		linkUrl=""
		browserSpanValue="">
		</brow:browser>
		</wea:item>

        <!--备注说明-->
		<wea:item>备注说明</wea:item>
		<wea:item>
			<% if(canedit) {%><TEXTAREA class=InputStyle ROWS="4" STYLE="width:65%" name="desc" value="<%=remark%>"></TEXTAREA><%} 
			else {%><%=Util.toScreen(RecordSet.getString(3),user.getLanguage())%><%}%>
		</wea:item>

	</wea:group>
</wea:layout>

<div id="zDialog_div_bottom" class="zDialog_div_bottom">
	<wea:layout>
		<wea:group context="" attributes="{groupDisplay:none}">
			<wea:item type="toolbar">
				<input type="button" value="<%=SystemEnv.getHtmlLabelName(309,user.getLanguage()) %>" id="zd_btn_cancle"  class="zd_btn_cancle" onclick="parent.getDialog(window).close();">
	    </wea:item>
		</wea:group>
	</wea:layout>
</div>
<jsp:include page="/systeminfo/commonTabFoot.jsp"></jsp:include>  
</FORM>
</BODY>

</HTML>
