 <%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
String imagefilename = "/images/hdReport_wev8.gif";
String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
int fieldscount = 0;
String needfav ="1";
String needhelp ="";
Integer lg=(Integer)user.getLanguage();
weaver.general.AccountType.langId.set(lg);
int userid = user.getUID();
String pageID = "AAAAAAAACCCCCeC";
%>
<HTML>
<HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
<script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>
<style>
.checkbox {
	display: none
}
</style>
<style type="text/css">
	.tab {
		width:100%;
		text-align:center;
		border-width: 1px;
		border-style: solid;
		border-color: #a9c6c9;
	}
	
	.zDialog_div_content .ListStyle tr td{
		text-align:center;
		
	}
	
</style>
</head>

<%
	String rid = Util.null2String(request.getParameter("rids"));
	rid = rid.substring(0, rid.length()-1);
	String rrid = rid;
	//out.print("rid-----"+rid);
	
%>
<BODY>
<div id="tabDiv">
	<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
</div>
<div id="dialog">
 <div id='colShow'></div>
</div>
<input type="hidden" name="pageId" id="pageId" value="<%= PageIdConst.HRM_ONLINEUSER %>"/>
	<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
	<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
	<FORM id="insertInfo" name="insertInfo" action="/goodbaby/order/OrderInfo.jsp" method=post>
	<input type="hidden" id="fieldscount" name="fieldscount" value="<%=fieldscount%>">
	<input type="hidden" id="rids" name="rids" value="<%=rid%>">
	<div class="zDialog_div_content" id="differencehandle" name="differencehandle">
				<wea:layout type="4col">				
				<wea:group context="请填写相应的订单数据" attributes="{'samePair':'SetInfo','groupOperDisplay':'none','itemAreaDisplay':'block'}">
					<wea:item attributes="{'colspan':'4','isTableList':'true'}">
					<table class=ListStyle cellspacing=1 border="1">
						<colgroup>
							<col width="18%">
							<col width="18%">
							<col width="16%">
							<col width="16%">
							<col width="16%">
							<col width="16%">
						</colgroup>
						<tr  style="">
							<td  style="text-align:center;">订单编号</td>
							<td style="text-align:center;">物料名称</td>
							<td style="text-align:center;">采购数量</td>
							<td style="text-align:center;">送货数量</td>	
							<td style="text-align:center;">单价</td>
							<!--<td style="text-align:center;">供货商</td>
							<td style="text-align:center;">要求送货时间</td>-->
							<td style="text-align:center;">已出货数量</td>
						</tr>
						<%
							
							String  rids [] =rid.split(",");//订单流程的requestid
							//out.print(rids.length);
							for(int  i=0;i<rids.length;i++){
								String sql = "select a.CGSL,a.DDBH, (select c.name from  crm_customerinfo c where c.id = isnull(a.xtkh,0)) as xtkh,(select WLname from  uf_materialDatas where id = isnull(a.WLMC,0) ) as WLMC,a.YQJHRQ as shsj,a.DJ,isnull((select sum(isnull(d.SJSHSL_1,0)) from  formtable_main_235 c join formtable_main_235_dt1 d on c.id =d.mainid join workflow_requestbase e on c.requestid = e.requestid where d.wlbh_1=a.WLBM and d.cgsqd=a.requestid and e.workflowid ='291' ),0) as zshsl from formtable_main_234 a where requestid ='"+rids[i]+"' ";
								//out.print(sql);
								rs.executeSql(sql);
								while(rs.next()){
									String ddbh = Util.null2String(rs.getString("DDBH"));
									String wlmc = Util.null2String(rs.getString("WLMC"));
									String cgsl = Util.null2String(rs.getString("CGSL"));
									//String shsl = Util.null2String(rs.getString(""));
									String dj = Util.null2String(rs.getString("DJ"));
									String ghs = Util.null2String(rs.getString("xtkh"));
									String yqsj = Util.null2String(rs.getString("shsj"));	
									String zshsl = Util.null2String(rs.getString("zshsl"));
						%>
						<%if(fieldscount%2==1){%><tr><%}%>
						<%if(fieldscount%2==0){%><tr><%}%>
							<td><%=ddbh%></td>
							<td><%=wlmc%></td>
							<td><%=cgsl%></td>
							<td><input type="text" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"
 name="shsl_<%=fieldscount%>" id="shsl_<%=fieldscount%>" value="">
 <input type="hidden" name="zsl_<%=fieldscount%>" id="zsl_<%=fieldscount%>" value="<%=zshsl%>">
 <input type="hidden" name="cg_<%=fieldscount%>" id="cg_<%=fieldscount%>" value="<%=cgsl%>">
 </td>
 
 
 
							<td><%=dj%></td>
							<!--<td><%=ghs%></td>
							<td><%=yqsj%></td>-->
							<td><%=zshsl%></td>
							<%
								
								}
							fieldscount++;
							}%>
						<tr/>
						
					</table>
					
					
					</wea:item>
				</wea:group>				
				<wea:group context="">
					<wea:item type="toolbar">
						<input class="e8_btn_submit" type="button" name="submit_2" onClick="OnSearch2()" value="提交"/>
						<span class="e8_sep_line">|</span>
						<input class="e8_btn_cancel" type="button" name="reset2" onclick="resetCondtion2()" value="重置"/>
					</wea:item>
				</wea:group>
				
				
				</wea:layout>
		</div>
		</FORM>	
	<script type="text/javascript">
		function resetCondtion2(){
			var ac = "<%=fieldscount%>";
			for(var i=0;i<parseInt(ac);i++){
				var j="shsl_"+i;
				document.getElementById(j).value = "";
				
			}
			
		}
		function OnSearch2(){
			var dialog = parent.getDialog(window);
			var parentWin = parent.getParentWindow(window);
			var ac = "<%=fieldscount%>";
			var sls = "";
			
			for(var i=0;i<parseInt(ac);i++){
				var j="#shsl_"+i;
				var k ="#zsl_"+i;
				var m ="#cg_"+i;
				var sl_val = jQuery(j).val();
				var zsl_val = jQuery(k).val();
				var cg_val = jQuery(m).val();
				//alert(sl_val);
				if(sl_val==''){
					Dialog.alert("请填写本次出货数量！");
					return;
				}
				if(sl_val=='0'){
					Dialog.alert("出货数量不能为0！");
					return;
				}
				var su = parseFloat(sl_val)+parseFloat(zsl_val);
				if(parseFloat(su)>parseFloat(cg_val)){
					Dialog.alert("填写本次出货总数量大于采购数量！");
					return;
				}
				if(i==0){
					sls = sl_val;
				}else{
					sls  = sls+","+sl_val;
				}
			}
			//alert("rid--"+"<%=rid%>"+"------sls----"+sls);
			var rrid = "<%=rid%>";
			//alert(rrid);
			var r=confirm("是否确认出货？！");
			if(r==true){
				var xhr = null;
				if (window.ActiveXObject) {//IE浏览器
					xhr = new ActiveXObject("Microsoft.XMLHTTP");
				} else if (window.XMLHttpRequest) {
					xhr = new XMLHttpRequest();
				}
				if (null != xhr) {
					xhr.open("GET","/goodbaby/order/createRequest.jsp?rids="+rrid+"&sls="+sls, false);
					xhr.onreadystatechange = function () {
						if (xhr.readyState == 4) {
							if (xhr.status == 200) {
 								var text = xhr.responseText;
								text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');								
								var aa = text.lastIndexOf("中");
								//alert(aa);
								// if(aa!=-1){
									// Dialog.alert(text);
									
								// }else{
									// Dialog.alert("出货失败");
								// }
							}	
						}
					}
					xhr.send(null);			
				}
				parentWin.location.reload();
				dialog.closeByHand();
				
			}
		}
		
		
		
		
		
		
		
		
		
	</script>
 </BODY>
</HTML>
 