<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.lang.Integer"%>
<%@ page import="weaver.general.Util,weaver.file.*" %>
<%@ page import="java.util.*,weaver.hrm.common.*" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="ExcelFile" class="weaver.file.ExcelFile" scope="session"/>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<%!
	public String getdocName(String sid){
		String reName = "";
		String flag="";
		String sql="";
		RecordSet recordSet = new RecordSet();
		 String[] ids = sid.split(",");
		 for(String id:ids){
		   reName=reName+flag;
		   sql= "select docsubject from DocDetail where id ="+id;
		   recordSet.executeSql(sql);
		   if(recordSet.next()) {
		   	reName = reName+Util.null2String(recordSet.getString("docsubject"));			
		   }
		   flag=",";
		 }         		
		flag="";
		return reName;
	}
%>
<%!
	public String getdocRead(String sid){
		String reName = "";
		String sql="";
		RecordSet recordSet = new RecordSet();
		 String[] ids = sid.split(",");
		 for(String id:ids){		   
		   sql= "select docsubject from DocDetail where id ="+id;
		   recordSet.executeSql(sql);
		   if(recordSet.next()) {
		    reName=reName+"<a href=\"javascript:opendoc("+id+")\">"+Util.null2String(recordSet.getString("docsubject"))+"</a>     ";		   			
		   }
		   
		 }      
		return reName;
	}
%>
<%!
	public String getSupplierName(String sid){
		String reName = "";
		RecordSet recordSet = new RecordSet();
		String sql = "select gyshmch from  uf_cgcgbd  where id='"+sid+"'";
		recordSet.executeSql(sql);
		if(recordSet.next()) {
			reName = Util.null2String(recordSet.getString("gyshmch"));
		}
		return reName;
	}
%>
<%!
	public String getSupplierNameRead(String sid){
		String reName = "";
		RecordSet recordSet = new RecordSet();
		String sql = "select gyshmch from  uf_cgcgbd  where id='"+sid+"'";
		recordSet.executeSql(sql);
		if(recordSet.next()) {
			reName ="<a href=\"javascript:openSupplier("+sid+")\">"+Util.null2String(recordSet.getString("gyshmch"))+"</a>"; 
		}else{
			reName = "<br/>";
		}
		return reName;
	}
%>
<%!
	public String getProName(String sid){
		String reName = "";
		RecordSet recordSet = new RecordSet();
		String sql = "select name from cptcapital where id='"+sid+"'";
		recordSet.executeSql(sql);
		if(recordSet.next()) {
			reName = Util.null2String(recordSet.getString("name"));
		}
		return reName;
	}
%>

<%  
BaseBean jspLog = new BaseBean();  
String imagefilename = "/images/hdHRMCard_wev8.gif";
String titlename =SystemEnv.getHtmlLabelName(21590,user.getLanguage());
String deRemark =  (String)session.getAttribute("deRemark");
String nodeid =  (String)session.getAttribute("nodeid");
int xjr =  Integer.parseInt(session.getAttribute("xjr").toString());
int roleID = Integer.parseInt(session.getAttribute("roleID").toString());
//out.print("nodeid"+nodeid+"xjr"+xjr+"roleID"+roleID);
int userid  = user.getUID();

String reID ="";
String pro_name="";
String gys1 = "";
String gys2 = "";
String gys3 = "";
String jg1 = "";
String jg2 = "";
String jg3 = "";
String selCheck1 = "";
String selCheck2 = "";
String selCheck3 = "";
String bz1 = "";
String bz2 = "";
String bz3 = "";

boolean isUpdate = false;
String tmp_sql = "select count(id) as count_cc from uf_inquiryPrice where deRemark="+deRemark;
RecordSet.executeSql(tmp_sql);
if(RecordSet.next()) {
	int flag_s = RecordSet.getInt("count_cc");
	if(flag_s > 0) isUpdate = true;
}
if(isUpdate){
	String mainid="";
	String sql = "select * from uf_inquiryPrice where deRemark="+deRemark;
	RecordSet.executeSql(sql);
	if(RecordSet.next()) {
	   reID = Util.null2String(RecordSet.getString("reID"));
	   mainid = Util.null2String(RecordSet.getString("id"));
	   pro_name = Util.null2String(RecordSet.getString("name"));
	}
	sql="select * from uf_inquiryPrice_dt1 where mainid="+mainid;
	RecordSet.executeSql(sql);
	String seqno="";
	while(RecordSet.next()){
        seqno = Util.null2String(RecordSet.getString("seqno"));
		if("1".equals(seqno)){
			 gys1 = Util.null2String(RecordSet.getString("gys"));
			 jg1 = Util.null2String(RecordSet.getString("jg"));
			 bz1 = Util.null2String(RecordSet.getString("bz"));
			 selCheck1 = Util.null2String(RecordSet.getString("selcheck"));
		}
		if("2".equals(seqno)){
			 gys2 = Util.null2String(RecordSet.getString("gys"));
			 jg2 = Util.null2String(RecordSet.getString("jg"));
			 bz2 = Util.null2String(RecordSet.getString("bz"));
			 selCheck2 = Util.null2String(RecordSet.getString("selcheck"));
		}
		if("3".equals(seqno)){
			 gys3 = Util.null2String(RecordSet.getString("gys"));
			 jg3 = Util.null2String(RecordSet.getString("jg"));
			 bz3 = Util.null2String(RecordSet.getString("bz"));
			 selCheck3 = Util.null2String(RecordSet.getString("selcheck"));
		}
	}
}else{
  String sql = " select a.requestid,b.mch from formtable_main_23 a,  formtable_main_23_dt1 b where a.id=b.mainid and b.val="+deRemark;
	RecordSet.executeSql(sql);
	if(RecordSet.next()) {
		pro_name = Util.null2String(RecordSet.getString("mch"));
		reID = Util.null2String(RecordSet.getString("requestId"));
	}
}
String recipient = "";
String needfav ="1";
String needhelp ="";
%>
<HTML><HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<style>
.btn_2k3
{
    border-right: #002D96 1px solid;
    padding-right: 2px;
    border-top: #002D96 1px solid;
    padding-left: 2px;
    font-size: 12px;
    FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0,  StartColorStr=#FFFFFF,  EndColorStr=#9DBCEA);
    border-left: #002D96 1px solid;
    cursor: hand;
    color: black;
    padding-top: 2px;
    border-bottom: #002D96 1px solid;
}

</style>
<style type="text/css"> 
	body,table{ 
		font-size:12px; 
	} 
	table{ 
		table-layout:fixed; 
		empty-cells:show; 
		border-collapse: collapse; 
		margin:0 auto; 
	} 
	td{ 
		height:30px; 
	} 
	h1,h2,h3{ 
		font-size:12px; 
		margin:0; 
		padding:0; 
	} 
	.table{ 
		border:1px solid #cad9ea; 
		color:#666; 
	} 
	.table th { 
		background-repeat:repeat-x; 
		height:30px; 
		background-color:rgb(231, 243, 252);
	} 
	.table td,.table th{ 
		border:1px solid #cad9ea; 
		padding:0 1em 0; 
	} 
	.table tr.alter{ 
		background-color:rgb(231,243,252); 
	} 
</style> 	

<script language="javascript" src="/js/weaver_wev8.js"></script>
</HEAD>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%

	RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:onSave(),_self} " ;
	RCMenuHeight += RCMenuHeightStep;
	RCMenu += "{保存并返回,javascript:onSave1(),_self} " ;
	RCMenuHeight += RCMenuHeightStep;

RCMenu += "{返回,javascript:onSave2(),_self} " ;
RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<form id=frmmain name=frmmain method=post action="supplierPriceOper.jsp">
	<input id="classDesc" type="hidden" name="deRemark" value="<%=deRemark%>" />
	<input id="classDesc" type="hidden" name="reID" value="<%=reID%>" />
	<input id="classDesc" type="hidden" name="savaType" />
	<input id="classDesc" type="hidden" name="roleID" value="<%=roleID%>" />
	<input id="classDesc" type="hidden" name="nodeid" value="<%=nodeid%>" />
	<input id="classDesc" type="hidden" name="xjr" value="<%=xjr%>" />
<table id="topTitle" cellpadding="0" cellspacing="0">
	<tr>
		<td>
		</td>
		<td class="rightSearchSpan" style="text-align:right;">
		    <%if(roleID == 1){%>
     		<input type="button" value="保存" class="e8_btn_top_first" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis; max-width: 100px;width:70px;height:30px;font-size:15px;" onclick="onSave();"/>
	 		<input type="button" value="保存并返回" class="e8_btn_top" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis;  max-width: 100px;width:100px;height:30px;font-size:15px;" onclick="onSave1();"/>
			<%}%>
			<input type="button" value="返回" class="e8_btn_top" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis;  max-width: 100px;width:70px;height:30px;font-size:15px;" onclick="onSave2();"/>
			<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
		</td>
	</tr>
</table>

<wea:layout type="4col" attributes="{'cw1':'16%','cw2':'28%','cw3':'28%','cw4':'28%'}">
	<wea:group context="商品信息" attributes="{'class':'e8_title e8_title_1'}">
		<wea:item>商品名称</wea:item>
		<wea:item><%=getProName(pro_name)%><input id="classDesc" type="hidden" name="pro_name" value="<%=pro_name%>" />	</wea:item>
	</wea:group>
</wea:layout>

<wea:layout type="twoCol" attributes="{'expandAllGroup':'true'}">
	<wea:group context="供应商1" attributes="{'class':'e8_title'}">
	<wea:item>供应商名称(1)	</wea:item>
	<%if(roleID == 1){%>
		<wea:item><brow:browser viewType="0"  name="gys1" browserValue="<%=gys1 %>"
							browserOnClick=""
							linkUrl="javascript:openSupplier($id$)"
							browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.gysh"
							hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
							completeUrl="/data.jsp" width="165px"
							browserSpanValue="<%=Util.toScreen(getSupplierName(gys1),user.getLanguage())%>">
						</brow:browser><br/>
		
		</wea:item>
	<%}%>
	<%if(roleID == 11 || roleID == 6  || roleID == 16 ){%>
		<wea:item>
			<font size="2px"><%=Util.toScreen(getSupplierNameRead(gys1),user.getLanguage())%></font>
			
		</wea:item>
	<%}%>
   	 

		<wea:item>供应商单价(1)</wea:item>
		<%if(roleID == 1){%>
		<wea:item>
			<table width=100% class="table">
				<colgroup><col width="10%"/><col width="25%"/><col width="10%"/><col width="55%"/></colgroup>
				<tr>
					<td>价格</td>
					<td><input class=inputstyle maxLength=10 size=30 name="jg1" value="<%=jg1%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></td>
				    <td>详情</td>
					<td ><textarea class=inputstyle rows=2 cols=40 name="bz1"><%=bz1%></textarea></td>
				    
				</tr>								
			</table>	
		</wea:item>
		<%}%>
		<%if(roleID == 11 || roleID == 6  || roleID == 16 ){%>
			<wea:item><table width=100% class="table">
				<colgroup><col width="10%"/><col width="25%"/><col width="10%"/><col width="55%"/></colgroup>
				<tr>					
					<td>价格</td>
					<td><%=jg1%></td>
					<td >详情</td>
					<td ><%=bz1%></td>
				</tr>
			
			</table></wea:item>
		<%}%>
   	 	
		<wea:item>选择该供应商(1)</wea:item><!-- 是否启用 -->
		<%if(roleID == 1){%>
		<wea:item>
				<input class="inputstyle" type=checkbox tzCheckbox='true' id="selCheck1" name="selCheck1" value="1" <%if(selCheck1.equals("1"))out.println("checked"); %>>
		</wea:item>
		<%}%>
		<%if(roleID == 11 || roleID == 6  || roleID == 16 ){%><wea:item><%if(selCheck1.equals("1"))out.println("选中");%></wea:item><%}%>
   	 	
	</wea:group>
</wea:layout>
					
<wea:layout type="twoCol" attributes="{'expandAllGroup':'true'}">
	<wea:group context="供应商2" attributes="{'class':'e8_title e8_title_1'}">
		<wea:item>供应商名称(2)	</wea:item>
		<%if(roleID == 1){%>
		<wea:item><brow:browser viewType="0"  name="gys2" browserValue="<%=gys2 %>"
							browserOnClick=""
							linkUrl="javascript:openSupplier($id$)"
							browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.gysh"
							hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
							completeUrl="/data.jsp" width="165px"
							browserSpanValue="<%=Util.toScreen(getSupplierName(gys2),user.getLanguage())%>">
						</brow:browser>
						
			
			</wea:item>
		<%}%>
		<%if(roleID == 11 || roleID == 6  || roleID == 16 ){%><wea:item><font size="2px"><%=Util.toScreen(getSupplierNameRead(gys2),user.getLanguage())%></font>
			
			
				</wea:item><%}%>
   	 
		<wea:item>供应商单价(2)</wea:item>
		<%if(roleID == 1){%>
		<wea:item>
			<table width=100% class="table">
				<colgroup><col width="10%"/><col width="25%"/><col width="10%"/><col width="55%"/></colgroup>
				<tr>
					<td>价格</td>
					<td><input class=inputstyle maxLength=10 size=30 name="jg2" value="<%=jg2%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></td>
				    <td>详情</td>
					<td ><textarea class=inputstyle rows=2 cols=40 name="bz2"><%=bz2%></textarea></td>
				    
				</tr>								
			</table>
		</wea:item>
		<%}%>
		<%if(roleID == 11 || roleID == 6  || roleID == 16 ){%>
				<wea:item><table width=100% class="table">
				<colgroup><col width="10%"/><col width="25%"/><col width="10%"/><col width="55%"/></colgroup>
				<tr>					
					<td>价格</td>
					<td><%=jg2%></td>
					<td >详情</td>
					<td ><%=bz2%></td>
				</tr>
			
			</table></wea:item><%}%>
		
		
		
		<wea:item>选择该供应商(2)</wea:item><!-- 是否启用 -->
		<%if(roleID == 1){%>
		<wea:item>
				<input class="inputstyle" type=checkbox tzCheckbox='true' id="selCheck2" name="selCheck2" value="1" <%if(selCheck2.equals("1"))out.println("checked"); %>>
		</wea:item>
		<%}%>
		<%if(roleID == 11 || roleID == 6  || roleID == 16 ){%><wea:item><%if(selCheck2.equals("1"))out.println("选中");%></wea:item><%}%>
		</wea:group>
</wea:layout>
			
		
<wea:layout type="twoCol" attributes="{'expandAllGroup':'true'}">
	<wea:group context="供应商3" attributes="{'class':'e8_title e8_title_1'}">
		<wea:item>供应商名称(3)	</wea:item>
		<%if(roleID == 1){%>
		<wea:item><brow:browser viewType="0"  name="gys3" browserValue="<%=gys3 %>"
							browserOnClick=""
							linkUrl="javascript:openSupplier($id$)"
							browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.gysh"
							hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
							completeUrl="/data.jsp" width="165px"
							browserSpanValue="<%=Util.toScreen(getSupplierName(gys3),user.getLanguage())%>">
						</brow:browser>	
				
		</wea:item>
		<%}%>
		<%if(roleID == 11 || roleID == 6  || roleID == 16 ){%><wea:item><font size="2px"><%=Util.toScreen(getSupplierNameRead(gys3),user.getLanguage())%></font>	
			</wea:item><%}%>
		

		<wea:item>供应商单价(3)</wea:item>
		<%if(roleID == 1){%>
		<wea:item>
			<table width=100% class="table">
				<colgroup><col width="10%"/><col width="25%"/><col width="10%"/><col width="55%"/></colgroup>
				<tr>
					<td>价格</td>
					<td><input  class=inputstyle maxLength=10 size=30 name="jg3" value="<%=jg3%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></td>
				    <td>详情</td>
					<td ><textarea class=inputstyle rows=2 cols=40 name="bz3"><%=bz3%></textarea></td>
				    
				</tr>								
			</table>
		</wea:item>
		<%}%>
		<%if(roleID == 11 || roleID == 6  || roleID == 16 ){%>
			<wea:item><table width=100% class="table">
				<colgroup><col width="10%"/><col width="25%"/><col width="10%"/><col width="55%"/></colgroup>
				<tr>					
					<td>价格</td>
					<td><%=jg3%></td>
					<td >详情</td>
					<td ><%=bz3%></td>
				</tr>
			
			</table></wea:item>
			<%}%>
		
			
		<wea:item>选择该供应商(3)</wea:item><!-- 是否启用 --> 
		<%if(roleID == 1){%>
		<wea:item>
				<input class="inputstyle" type=checkbox tzCheckbox='true' id="selCheck3" name="selCheck3" value="1" <%if(selCheck3.equals("1"))out.println("checked"); %>>
		</wea:item>
		<%}%>
		<%if(roleID == 11 || roleID == 6  || roleID == 16 ){%><wea:item><%if(selCheck3.equals("1"))out.println("选中");%></wea:item><%}%>
		</wea:group>
</wea:layout>
</form>
<script language=javascript>
	function onSave(){
		if(checkselect()){
		frmmain.submit();
	    }
	}
	
	function onSave1(){
		
		document.frmmain.savaType.value="sr";
	    if(checkselect()){
		frmmain.submit();
	    }
		
	}
	function onSave2(){
		document.frmmain.savaType.value="re";
	    frmmain.submit();
	}

    function checkselect(){
		var roleid=<%=roleID%>;
		var selCheck1 ="";
		var selCheck2="";
		var selCheck3="";
		if (roleid == "1"){
		 selCheck1  = document.getElementById('selCheck1');
		 selCheck2  = document.getElementById('selCheck2');
		 selCheck3  = document.getElementById('selCheck3');
		}
		
		
		if(selCheck1.checked){
			if(selCheck2.checked|| selCheck3.checked){
				alert("您本次采购只能选择一个商家作为本次询价的供应商，目前您选择了多个供应商，不符合询价规则，请检查后提交。");
				return false;
			}
		}else if(selCheck2.checked && selCheck3.checked){
            alert("您本次采购只能选择一个商家作为本次询价的供应商，目前您选择了多个供应商，不符合询价规则，请检查后提交。");
				return false;
		}
		return true;
		 
	}

	function BatchProcess(){
	    document.frmmain.operation.value="batchprocess";
	    frmmain.submit();
	}
	function openSupplier(id){
		var title = "";
		var url = "";
		 
		title = "供应商";
		url="/formmode/view/ViewMode.jsp?type=0&modeId=1&formId=-13&opentype=0&customid=76&viewfrom=fromsearchlist&mainid=0&billid="+id;
		
		
		if(window.top.Dialog){
		diag_vote = new window.top.Dialog();
	    } else {
		    diag_vote = new Dialog();
	    };
	    diag_vote.currentWindow = window;
		diag_vote.Width = 800;
		diag_vote.Height = 600;
		diag_vote.maxiumnable = true;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.show("");
	}
	

	

</script>
</BODY>
<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
<SCRIPT language="javascript" src="/seahonor/copytime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/seahonor/attend/copytime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>
</HTML>
