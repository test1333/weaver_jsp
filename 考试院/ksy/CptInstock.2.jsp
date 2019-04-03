<%@page import="weaver.filter.XssUtil"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="CptDetailColumnUtil" class="weaver.cpt.util.CptDetailColumnUtil" scope="page"/>
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page"/>
<%
String cptids = Util.null2String(request.getParameter("cptids"));
String isDialog = Util.null2String(request.getParameter("isdialog"));
String isclose = Util.null2String(request.getParameter("isclose"));
String nameQuery = Util.null2String(request.getParameter("nameQuery"));
String from = Util.null2String(request.getParameter("from"));
String applyid = Util.null2String(request.getParameter("applyid"));
String type = Util.null2String(request.getParameter("type"));
 int num =0;

String rightStr = "";
if(!HrmUserVarify.checkUserRight("CptCapital:InStock", user)){
    		response.sendRedirect("/notice/noright.jsp");
    		return;
}else{
	rightStr = "CptCapital:InStock";
	session.setAttribute("cptuser",rightStr);
}

Calendar today = Calendar.getInstance();
String currentdate = Util.add0(today.get(Calendar.YEAR), 4) +"-"+
                     Util.add0(today.get(Calendar.MONTH) + 1, 2) +"-"+
                     Util.add0(today.get(Calendar.DAY_OF_MONTH), 2) ;
String needcheck="BuyerID,CheckerID,StockInDate";


String id = Util.null2String(request.getParameter("id"));//编辑入库单
boolean isOldBill=(Util.getIntValue(id,0)>0);
String BuyerID="";
String StockInDate_gz="";
String CheckerID="";
String StockInDate="";
String contractno="";
String customerid="";
String ischecked="0";

if(isOldBill){
	String sql="select distinct m.*,d.SelectDate,d.contractno,d.customerid from CptStockInMain m,CptStockInDetail d "+
			" where d.cptstockinid=m.id and m.id="+id+" and m.ischecked in(-2,-1) ";
	RecordSet.executeSql(sql);
	if(RecordSet.next()){
		ischecked=RecordSet.getString("ischecked");
		BuyerID=RecordSet.getString("buyerid");
		StockInDate_gz=RecordSet.getString("SelectDate");
		CheckerID=RecordSet.getString("checkerid");
		StockInDate=RecordSet.getString("StockInDate");
		contractno=RecordSet.getString("contractno");
		customerid=Util.getIntValue( RecordSet.getString("customerid"),0)>0?RecordSet.getString("customerid"):"";
	}
	
	
}else{
	BuyerID=""+user.getUID();
	StockInDate_gz=StockInDate=currentdate;
	CheckerID="";
}



%>
<HTML><HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver_wev8.js"></script>
<script language=javascript src="/js/ecology8/request/e8.browser_wev8.js"></script>
<link rel="stylesheet" href="/wui/theme/ecology8/weaveredittable/css/WeaverEditTable_wev8.css">
<script  src="/wui/theme/ecology8/weaveredittable/js/WeaverEditTable_wev8.js"></script>
<SCRIPT language="javascript" src="/cpt/js/validate_wev8.js"></script>
<script src="/cpt/js/myobserver_wev8.js"></script>
<script type="text/javascript">
var parentWin;
if("<%=isDialog %>"=="1"){
	parentWin = parent.parent.getParentWindow(parent);
}
if("<%=isclose%>"=="1"){
	try {
		parentWin._table.reLoad();
		updatecptstockinnum("<%=user.getUID() %>",parentWin);
		//parentWin.closeDialog();
	} catch (e) {
	}
}else{
	try {
		updatecptstockinnum("<%=user.getUID() %>");
	} catch (e) {}
}

</script>
</head>
<%
String imagefilename = "/images/hdHRMCard_wev8.gif";
String titlename = SystemEnv.getHtmlLabelName(751,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(615,user.getLanguage())+",javascript:onSubmit(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<FORM id=weaver name=weaver method=post action="savecptData.jsp" >
<INPUT  type=hidden name="method" value="<%=(isOldBill&&!"-1".equals(ischecked) )?"edit":"add" %>">
<INPUT  type=hidden name="id" value="<%=id %>">
<INPUT  type=hidden name="cptids" value="<%=cptids %>">
<INPUT  type=hidden name="reapplyflag" value="<%="-1".equals(ischecked)?"1":"" %>">
<table id="topTitle" cellpadding="0" cellspacing="0">
	<tr>
		<td>
		</td>
		<td class="rightSearchSpan" style="text-align:right; width:500px!important">
			<input type="button" value="<%=SystemEnv.getHtmlLabelName(615,user.getLanguage()) %>" class="e8_btn_top"  onclick="onSubmit()"/>
			<span id="advancedSearch" class="advancedSearch" style="display:none;"><%=SystemEnv.getHtmlLabelNames("347",user.getLanguage())%></span>
			<span title="<%=SystemEnv.getHtmlLabelNames("23036",user.getLanguage())%>" class="cornerMenu"></span>
		</td>
	</tr>
</table>		
<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
</div>


<wea:layout type="4col">
    <wea:group context='<%=SystemEnv.getHtmlLabelName(1361,user.getLanguage())%>'>
    	<wea:item><%=SystemEnv.getHtmlLabelName(913,user.getLanguage())%></wea:item>
	    <wea:item>
	    	<brow:browser width="150px;" name="BuyerID" browserValue='<%=BuyerID %>' browserSpanValue='<%=Util.toScreen(ResourceComInfo.getResourcename(BuyerID),user.getLanguage())%>' browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp" completeUrl="/data.jsp"  isMustInput="1" viewType="0" browserOnClick=""  hasInput="true"  isSingle="true" hasBrowser = "true" />
	    </wea:item>
    	<wea:item><%=SystemEnv.getHtmlLabelName(16914,user.getLanguage())%></wea:item>
    	<wea:item>
    		<button type=button  class=calendar id=SelectDate onclick="onShowDate(StockInDateSpan_gz,StockInDate_gz)"></BUTTON>&nbsp;
						  <SPAN id="StockInDateSpan_gz" ><%=StockInDate_gz  %></SPAN>
						  <input type="hidden" name="StockInDate_gz" value=<%=StockInDate_gz %>>
    	</wea:item>
    	<wea:item><%=SystemEnv.getHtmlLabelName(901,user.getLanguage())%></wea:item>
    	<wea:item>
    		<brow:browser width="150px;" name="CheckerID" browserValue='<%=CheckerID %>' browserSpanValue='<%=ResourceComInfo.getResourcename(CheckerID) %>' browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp" completeUrl="/data.jsp"  isMustInput="2" viewType="0" browserOnClick=""  hasInput="true"  isSingle="true" hasBrowser = "true" />
    	</wea:item>
    	<wea:item><%=SystemEnv.getHtmlLabelName(753,user.getLanguage())%></wea:item>
    	<wea:item>
    		<button type=button  class=calendar id=SelectDate onclick="onShowDate(StockInDateSpan,StockInDate)"></BUTTON>&nbsp;
						  <SPAN id="StockInDateSpan" ><%=StockInDate%></SPAN>
						  <input type="hidden" name="StockInDate" value=<%=StockInDate%>>
    	</wea:item>
    	<wea:item><%=SystemEnv.getHtmlLabelName(21282,user.getLanguage())%></wea:item>
    	<wea:item>
    		<input class="InputStyle" style="width:160px;" type=text name="contactno" id="contactno" value="<%=contractno %>" />
    	</wea:item>
    	<wea:item><%=SystemEnv.getHtmlLabelName(138,user.getLanguage())%></wea:item>
    	<wea:item>
	    	<%
			String customerbrowurl="/systeminfo/BrowserMain.jsp?url=/CRM/data/CustomerBrowser.jsp?sqlwhere="+new XssUtil().put("where t1.type=2");
			%>
    		<brow:browser  name="customerid" browserValue='<%=customerid %>' browserSpanValue='<%=CustomerInfoComInfo.getCustomerInfoname(customerid) %>' browserUrl='<%=customerbrowurl %>' completeUrl="/data.jsp?type=7"  isMustInput="1" viewType="0" browserOnClick=""  hasInput="true"  isSingle="true" hasBrowser = "true" />
    	</wea:item>
    </wea:group>
</wea:layout>
<wea:layout attributes="{'expandAllGroup':'true'}">
		<wea:item attributes="{'isTableList':'true'}">
		    <wea:layout type="table" attributes="{'cols':'6','cws':'15%,15%,15%,15%,15%,15%'}">
				<wea:group context="入库明细" attributes="{'groupDisplay':'none'}">
				

				<wea:item type="thead">资产资料</wea:item>
				<wea:item type="thead">规格型号</wea:item>
			    <wea:item type="thead">单价</wea:item>
				<wea:item type="thead">数量</wea:item>
				<wea:item type="thead">发票号码</wea:item>
				 <wea:item type="thead">存放地点</wea:item>				 
				
		
		<% 
		
		 String sql="select a.requestid,b.id,a.id as mainid ,a.sqr,a.tbrq,a.bh,b.xqsl,b.hpmc,(select name from cptcapital where id=b.hpmc) as name,(select datatype from cptcapital where id=b.hpmc) as datatype,b.ggxh,b.dw ,(select unitname from LgcAssetUnit where id= b.dw) as dwname,b.sgsl,b.dj,b.je "+
                    "from formtable_main_28 a join formtable_main_28_dt1 b on a.id=b.mainid join workflow_requestbase c on a.requestid = c.requestid "+
                    "where  c.currentnodetype>=3 and b.id in ("+cptids+")";
					out.print(sql);
		 RecordSet rs1 = new RecordSet();
		   rs1.executeSql(sql);
		   String name="";
		   String ggxh="";
		   String dj="";
		   String xqsl="";
		    String datatype = "";
			String cptid = "";
		  while(rs1.next()){
	        name = Util.null2String(rs1.getString("name"));
	        ggxh = Util.null2String(rs1.getString("ggxh"));
	        dj = Util.null2String(rs1.getString("dj"));
	        xqsl = Util.null2String(rs1.getString("xqsl"));
			datatype = Util.null2String(rs1.getString("datatype"));
			cptid = Util.null2String(rs1.getString("id"));
			 num++;
			  %>
			   <wea:item><%=name%> <input name="name_<%=num%>" id="name_<%=num%>"  type="hidden" value="<%=datatype%>" /><input name="cptid_<%=num%>" id="cptid_<%=num%>"  type="hidden" value="<%=cptid%>" /></wea:item>			
			   <wea:item><%=ggxh%><input name="ggxh_<%=num%>" id="ggxh_<%=num%>" type="hidden" value="<%=ggxh%>" /></wea:item>
			   <wea:item><input maxLength=10 size=17 name="dj_<%=num%>" id="dj_<%=num%>" class="InputStyle" value=""  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></wea:item>
			    <wea:item><input maxLength=10 size=17 name="sgsl_<%=num%>" id="sgsl_<%=num%>" class="InputStyle" value="<%=xqsl%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></wea:item>
			   
			  <wea:item><input name="fphm_<%=num%>" id="fphm__<%=num%>" class="InputStyle" type="text" value=""/></wea:item>
			   <wea:item><input name="cfdd_<%=num%>" id="cfdd_<%=num%>" class="InputStyle" type="text" value=""/></wea:item>
			  
				
				
				 
	    <% ;
		
		} 
		
		%>
		   </wea:group>
			</wea:layout>
		</wea:item>


</wea:layout>
<INPUT  type=hidden name="num" value="<%=num %>">

</form>
<script>
var pdialog = parent.getDialog(window);//获取窗口对象；
var parentWin = parent.getParentWindow(window);//获取父对象；
function onSubmit()
{
	var num1=<%=num%>;
	for(var i=1;i<=num1;i++){
		var dj = jQuery("#dj_"+i).val();
		var sgsl = jQuery("#sgsl_"+i).val();
		
		if(dj.length >0 &&Number(dj) >=0){

	    }else{
		alert("单价不能为空");
		return;
	     }
		 if(sgsl.length >0 && Number(sgsl) >0){
	    }else{
		alert("数量不能为空或小于1");
		return;
	     }

	}
	var CheckerID = jQuery("#CheckerID").val();
	if(CheckerID >0){
	
	}else{
		alert("请先填写验收人");
		return;
	}
	var StockInDateSpan_gz = jQuery("#StockInDateSpan_gz").html();
	var StockInDateSpan = jQuery("#StockInDateSpan").html();
	
	if(StockInDateSpan < StockInDateSpan_gz ){
		window.top.Dialog.alert("<%=SystemEnv.getHtmlLabelNames("83582",user.getLanguage())%>");
		return;
	}
	
	document.weaver.submit();
    
		
}
</script>
</BODY>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
</HTML>
