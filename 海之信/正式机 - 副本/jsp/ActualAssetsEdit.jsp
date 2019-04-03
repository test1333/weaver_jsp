
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="weaver.general.Util" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
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
    String idkey = Util.null2String(request.getParameter("idkey"));
    String actualcheck = Util.null2String(request.getParameter("name"));//实际填报数
	String remark = Util.null2String(request.getParameter("desc"));//备注

     //获取对应显示数据值
    String goodscate = "";
    String goodsname = "";
    String goodsno = "";
    String original = "";
    String goodscate_name = "";
    String goods_name = "";
	String sql = "select * from uf_checkrecord_dt1 where id = "+idkey+"";
    rs.executeSql(sql);
    if(rs.next()){
            goodscate = Util.null2String(rs.getString("goodscate"));
            goodsname = Util.null2String(rs.getString("goodsname"));
            goodsno = Util.null2String(rs.getString("goodsno"));
            original = Util.null2String(rs.getString("original"));
        }
    String sql_1 = "select catename from uf_goodscate where id = replace('"+goodscate+"','57_','')";
	rs.executeSql(sql_1);
	if(rs.next()){
	       goodscate_name = Util.null2String(rs.getString("catename"));
	   }
	String sql_2 = "select goodsname from uf_goodsinfo where id = "+goodsname+"";
	rs.executeSql(sql_2);
	if(rs.next()){
	       goods_name = Util.null2String(rs.getString("goodsname"));
	   }
	
%>
<HTML><HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver_wev8.js"></script>
<script language=javascript >

function checkSubmit(){
    //if(check_form(weaver,'name')){
    //    weaver.submit();
    //    parent.getParentWindow(window)._table.reLoad();
	//    parent.getDialog(window).close();
   //     self.opener.location.reload();
   // }
    var actualnum = document.getElementById('name').value;
    if(actualnum==""){
    	alert('警告：实盘数未填写！');
    }else{
    $('#weaver').submit();	
	window.close();
    }
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
   <jsp:param name="navName" value="<%=SystemEnv.getHtmlLabelName(-433,user.getLanguage()) %>"/>
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
	
<FORM id=weaver name="form1" action="AssetsCheckDataWrite.jsp" method=post >
<input type="hidden" name="method" value="edit">
<input type="hidden" name="idkey" value="<%=idkey%>">

<wea:layout>
	<wea:group context="<%= SystemEnv.getHtmlLabelName(1361,user.getLanguage())%>">

        <!--资产类别-->
		<wea:item>资产类别</wea:item>
		<wea:item>
			<% if(canedit) {%><%=goodscate_name%><%} 
			else {%><%=Util.toScreen(RecordSet.getString(3),user.getLanguage())%><%}%>
		</wea:item>

		<!--资产名称-->
		<wea:item>资产名称</wea:item>
		<wea:item>
			<% if(canedit) {%><%=goods_name%><%} 
			else {%><%=Util.toScreen(RecordSet.getString(3),user.getLanguage())%><%}%>
		</wea:item>

		<!--资产编号-->
		<wea:item>资产编号</wea:item>
		<wea:item>
			<% if(canedit) {%><%=goodsno%><%} 
			else {%><%=Util.toScreen(RecordSet.getString(3),user.getLanguage())%><%}%>
		</wea:item>

	    <!--实盘数-->
		<wea:item>实盘数</wea:item>
		<wea:item>
			<wea:required id="nameimage" required="true" value="">
				<% if(canedit) {%>
					<INPUT  maxLength=50 size=45 name="name" style="width: 300px;" id = "name"
						value="<%=actualcheck%>"
						onchange='checkinput("name","nameimage")'
						temptitle="<%=SystemEnv.getHtmlLabelName(-433,user.getLanguage())%>"
						onkeypress="ItemCount_KeyPress()">
					<%} else {%><%=Util.toScreen(RecordSet.getString(2),user.getLanguage())%><%}%>
			</wea:required>
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
