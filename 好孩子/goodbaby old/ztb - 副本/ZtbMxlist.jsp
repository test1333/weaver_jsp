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
	String rid = Util.null2String(request.getParameter("rid"));//"12256";//
	//out.print("rid-----"+rid);
	Map<String,String> supplierMap = new HashMap<String,String>();
	List <String> list = new ArrayList<String>(); //  gys ID
	List <String> listBj = new ArrayList<String>();// 报价金额
	List <String> listHj = new ArrayList<String>();//合计金额
	
	// String sql = "select (select c.name from  crm_customerinfo c where c.id =a.gysmc ) as gymc ,d.zbj1,d.zbj,a.gysmc from formtable_main_230_dt2 a join formtable_main_230 b on a.mainid = b.id join formtable_main_231 d on d.zhurid = b.requestid and a.gysmc =d.xtkh where b.requestid ='"+rid+"'  ";
	
	String sql = "select b.zkzbj as zbj1,b.zbj, (select c.name from  crm_customerinfo c where c.id =b.xtkh) as gymc,b.xtkh as gysmc  from  uf_gysbjb b  join  (select max(id) as mid ,xtkh from uf_gysbjb  where zhurid ='"+rid+"' group by  xtkh) m   on m.mid =b.id order by b.zkzbj asc";
	
	
	
	rs.executeSql(sql);
	int tep = 0;
	while(rs.next()){
		list.add(rs.getString("gysmc"));
		supplierMap.put(String.valueOf(tep),rs.getString("gymc"));
		listBj.add(rs.getString("zbj1"));
		listHj.add(rs.getString("zbj"));
		tep++;	
	}
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
	<div class="zDialog_div_content" id="differencehandle" name="differencehandle">
				<wea:layout type="4col">				
				<wea:group context="详细数据" attributes="{'samePair':'SetInfo','groupOperDisplay':'none','itemAreaDisplay':'block'}">
					<wea:item attributes="{'colspan':'4','isTableList':'true'}">
					<a href="#" onclick="javascript:history.back(-1);">返回到上一页</a>
					<table class=ListStyle cellspacing=1 border="1">
						<colgroup>
						<%
							int ver =100/(list.size()*2+4);
							for(int i=0;i<list.size();i++){
						%>
						<col width="<%=ver%>%">
						
						<%}%>
						</colgroup>
						<tr  style="">
							<td rowspan='4' style="text-align:center;">子物料代码</td>
							<td rowspan='4' style="text-align:center;">子物料名称</td>
							<td rowspan='4' style="text-align:center;">子数量</td>
							<td rowspan='4' style="text-align:center;">单位</td>	
						<%
							for(int i=0;i<list.size();i++){
						%>
							<td colspan='2' style="text-align:center;"><%=supplierMap.get(String.valueOf(i))%></td>	
						<%}%>	
						</tr>
						
						<tr >
						<%
							for(int i=0;i<list.size();i++){
						%>
							<td style="text-align:center;">报价总额：</td>
							<td style="text-align:center;"><%=listBj.get(i)%></td>
						<%}%>	
						</tr>
						<tr >
						<%
							for(int i=0;i<list.size();i++){
						%>
							<td style="text-align:center;">合计总额：</td>
							<td style="text-align:center;"><%=listHj.get(i)%></td>
						<%}%>	
						</tr>
						<tr >
						<%
							for(int i=0;i<list.size();i++){
						%>
							<td style="text-align:center;">单价</td>
							<td style="text-align:center;">金额</td>
						<%}%>	
						</tr>
						<%
							int fieldscount = 0;
							sql = " select a.BM_1,a.WLMC_1,a.SHUL_1,(select f.dw from uf_unitForms f where f.id =a.DW_1) as DW  from formtable_main_230_dt1  a  join formtable_main_230 b on a.mainid =b.id where b.requestid ='"+rid+"' ";
							rs.executeSql(sql);
							while(rs.next()){
								String BM_1= rs.getString("BM_1");
								String WLMC_1= rs.getString("WLMC_1");
								String SL_1= rs.getString("SHUL_1");
								String DW= rs.getString("DW");
								String DJ_1= "";
								String JG_1= "";
						
						%>
						<%if(fieldscount%2==1){%><tr ><%}%>
						<%if(fieldscount%2==0){%><tr><%}%>
							<td><%=BM_1%></td>
							<td><%=WLMC_1%></td>
							<td><%=SL_1%></td>
							<td><%=DW%></td>
							<%	
								for(int i=0;i<list.size();i++){
								// String str ="select a.BJJE_1,a.bjje from formtable_main_231_dt1 a join formtable_main_231 b on b.id =a.mainid where b.zhurid = '"+rid+"'  and b.xtkh ='"+list.get(i)+"' and a.BM_1 ='"+BM_1+"'";
								
								
								String str = "select b.BJJE_1,b.bjje from  uf_gysbjb_dt1 b  join  (select max(id) as mid ,xtkh from uf_gysbjb  where zhurid ='"+rid+"' group by  xtkh) m   on m.mid =b.mainid where  m.xtkh ='"+list.get(i)+"' and b.BM_1 ='"+BM_1+"'";
								//out.print(str+"--------");
								
								RecordSet.executeSql(str);
								while(RecordSet.next()){
									DJ_1 = RecordSet.getString("BJJE_1");
									JG_1 = RecordSet.getString("bjje");
								}	
								%>
								<td><%=DJ_1%></td>
								<td><%=JG_1%></td>
								
								
								<%	
									
								}
							%>
							<%}%>
						<tr/>
						
					</table>
					
					
					</wea:item>
				</wea:group>				
				
				
				
				</wea:layout>
		</div>
 </BODY>
</HTML>
 