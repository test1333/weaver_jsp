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
Integer lg=(Integer)user.getLanguage();
weaver.general.AccountType.langId.set(lg);
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
</style>
</head>
<%
String imagefilename = "/images/hdReport_wev8.gif";
String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
String needfav ="1";
String needhelp ="";
String goods_name ="";
String goodsno="";
String num="";
String b = Util.null2String(request.getParameter("b"));
String aid = Util.null2String(request.getParameter("aid"));
String zbwjbh = Util.null2String(request.getParameter("zbwjbh"));
String resid = Util.null2String(request.getParameter("resid"));
String kbsj = Util.null2String(request.getParameter("kbsj"));
String bj = Util.null2String(request.getParameter("bj"));
String remark = Util.null2String(request.getParameter("remark"));
if(aid.length()>1&&b.equals("1")&&bj.length()>1){
	String sql = "insert into formtable_main_223_dt1(BM_1,PP_1,XH_1,GG_1,SHUL_1,DW_1,JQ_1,SHUIL_1,SHUIL_1,YTJLB_1,GYSBM,GYSMC,WLMC_1,WLLX_1,mainid)  select  BM_1,PP_1,XH_1,GG_1,SHUL_1,DW_1,JQ_1,SHUIL_1,SHUIL_1,YTJLB_1,GYSBM,GYSMC,WLMC_1,WLLX_1,mainid from formtable_main_223_dt1  where id =(select max(f.id) from formtable_main_223_dt1 f where f.mainid = '"+aid+"' )";
	rs.executeSql(sql);
	String mid = "";
	sql = "select max(id) as mid from formtable_main_223_dt1 where f.mainid = '"+aid+"'";  
	rs.executeSql(sql);
	if(rs.next()){
		mid = Util.null2String(rs.getString("mid"));		
	}
	if(bj.length()>0){
		sql = "update formtable_main_223_dt1 set BJJE_1 ='"+bj+"' where id  = '"+mid+"'";
		rs.executeSql(sql);
	}
		
}



int userid = user.getUID();
String pageID = "AAAAAAAAAAAA";
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
<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onBtnSearchClick(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<FORM id=report name=report action="/goodbaby/ztb/bidList.jsp" method=post>
	<input type="hidden" name="multiIds" value="">
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>
				<td>
					</td>
					<td class="rightSearchSpan" style="text-align:right;">
						<span id="advancedSearch" class="advancedSearch" style="display:;"><%=SystemEnv.getHtmlLabelNames("347",user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelNames("23036",user.getLanguage())%>" class="cornerMenu"></span>
					</td>
			</tr>
		</table>


	<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">

<wea:layout type="4col">
	<wea:group context="<%=SystemEnv.getHtmlLabelNames("15774",user.getLanguage()) %>">
	
	    <wea:item>招标文件编号</wea:item>
		<wea:item>
			<input type="text" name="zbwjbh" id="zbwjbh" class="InputStyle" value="<%=zbwjbh%>"/>
		</wea:item>
		 <wea:item>姓名</wea:item>
		<wea:item>
			<brow:browser viewType="0"  id ="resid" name="resid" browserValue="<%=resid%>" 
			browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp"
			hasInput="true" isSingle="true" hasBrowser = "true" isMustInput='1'
			completeUrl="/data.jsp" width="120px"
			browserSpanValue="<%=resid%>">
			</brow:browser>
		</wea:item>

	</wea:group>
	
	<wea:group context="">
		<wea:item type="toolbar">
			<input class="e8_btn_submit" type="submit" name="submit_1" onClick="OnSearch()" value="<%=SystemEnv.getHtmlLabelName(197, user.getLanguage()) %>"/>
			<span class="e8_sep_line">|</span>
			<input class="e8_btn_cancel" type="button" name="reset" onclick="resetCondtion()" value="<%=SystemEnv.getHtmlLabelName(2022, user.getLanguage())%>"/>
			<span class="e8_sep_line">|</span>
			<input type="button" value="<%=SystemEnv.getHtmlLabelName(31129,user.getLanguage())%>" class="e8_btn_cancel" id="cancel"/>
		</wea:item>
	</wea:group>
	
</wea:layout>

</div>
	</FORM>
	
	
	
	<FORM id="insertInfo" name="insertInfo" action="/goodbaby/ztb/bidList.jsp" method=post>
	<div class="zDialog_div_content" id="differencehandle" name="differencehandle">
				<wea:layout type="2col">
				<wea:group context="投标" >
				<wea:item>距离本次开标时间还有</wea:item>
				<wea:item><span name="time" id="time"></span></wea:item>
				<wea:item>开&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;标&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;时&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;间</wea:item>
				<wea:item><span  name="kbsj" id="kbsj"><%=kbsj%></span>
				
				<input type="hidden" name="aid" id = "aid" value="<%=aid%>">
				<input type="hidden" name="b" id = "b" value="1">
				</wea:item>
				<wea:item>报&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;价</wea:item>
				<wea:item><input type="text" name="bj" id="bj" class="InputStyle" value="<%=bj%>"/></wea:item>

         		<wea:item>备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;说&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;明</wea:item>
				<wea:item>
				<TEXTAREA class=InputStyle ROWS="4" STYLE="width:65%" name="remark" value="<%=remark%>"></TEXTAREA>
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
	<div >
		<table class = "tab">
		<tr><th>流程名称</th><th>物料编号</th><th>物料名称</th><th>供应商编号</th><th>供应商名称</th><th>规格型号</th><th>品牌</th><th>供应商含税单价</th></tr>
		<%
		String table_name1 = "formtable_main_223";
		String table_name2 = "formtable_main_223_dt1";
		String maxBJJE_1="0";
		String avg ="0";
		int a = 0;
		String avgsql = "select isnull(CONVERT(DECIMAL(10,2),AVG(BJJE_1)),0) as avgs from (select MAX(id) as aid ,GYSBM,BJJE_1  from ("+"select h.BJJE_1 ,h.id ,h.GYSBM  from formtable_main_223_dt1 h where   GYSBM is not null and BJJE_1 is not null " +" group by GYSBM,h.id ,h.BJJE_1 ) a  group by GYSBM,id ,BJJE_1) b ";
		rs.executeSql(avgsql);
		if(rs.next()){
			avg = rs.getString("avgs");
		}
		Float BJJE_vag = Float.parseFloat(avg);
		String zhbjsql  ="select BJJE_1 from formtable_main_223_dt1 where id in (select max(id) from  formtable_main_223_dt1 where mainid ='"+aid+"' and BJJE_1 is not null) ";
		rs.executeSql(zhbjsql);
		if(rs.next()){
			maxBJJE_1 = rs.getString("maxBJJE_1");
		}
		Float BJJE = Float.parseFloat(maxBJJE_1);
		Float BJJE1 = (float) (BJJE_vag*0.1+BJJE_vag);
		String backfields = "select  d.id as did,d.requestid,b.id as bid ,b.BM_1,b.WLMC_1,b.GYSBM,b.GYSMC,b.GG_1+' '+b.XH_1  as GGXH,b.PP_1,b.BJJE_1,d.requestid,c.requestname "; 
		String fromSql  = " from formtable_main_223 d, workflow_requestbase  c ,formtable_main_223_dt1 b ";
		String sqlWhere = " where  d.requestid=c.requestid  and c.workflowid = 229 and b.mainid =d.id and b.BJJE_1>0";			
		String orderby = " order by  bid  " ;
		String tableString = "";
		if(!"".equals(zbwjbh)){
			sqlWhere = sqlWhere + " and b.ZBWJBH like '%"+zbwjbh+"%'";
		}
		if(!"".equals(resid)){
			sqlWhere = sqlWhere + " and  d.xm = "+resid;
		}
		String strsql = backfields + fromSql + sqlWhere + orderby;
		rs.executeSql(strsql);
		while(rs.next()){
			String requestname =  rs.getString("requestname");
			String BM_1 = rs.getString("BM_1");
			String WLMC_1 = rs.getString("WLMC_1");
			String GYSBM = rs.getString("GYSBM");
			String GYSMC = rs.getString("GYSMC");
			String GGXH = rs.getString("GGXH");
			String PP_1 = rs.getString("PP_1");
			String BJJE_1 = rs.getString("BJJE_1");
			
		if(a==0 && BJJE_vag <= BJJE && BJJE < BJJE1){
	%>
			
		<tr style="color:yellow" >	
			<td ><%=BM_1%></td><td><%=WLMC_1%></td><td><%=GYSBM%></td><td><%=GYSMC%></td><td><%=GGXH%></td><td><%=PP_1%></td><td><%=BJJE_1%></td>
		</tr>		
		<%
		}else if(a==0 && BJJE1 <= BJJE){%>
		
		<tr style="color:orange">	
			<td ><%=BM_1%></td><td><%=WLMC_1%></td><td><%=GYSBM%></td><td><%=GYSMC%></td><td><%=GGXH%></td><td><%=PP_1%></td><td><%=BJJE_1%></td>
		</tr>		
		<%}else{%>
		
		<tr>	
			<td ><%=BM_1%></td><td><%=WLMC_1%></td><td><%=GYSBM%></td><td><%=GYSMC%></td><td><%=GGXH%></td><td><%=PP_1%></td><td><%=BJJE_1%></td>
		</tr>
		<%}
		}
		%>
		</table>
	</div>
	<script type="text/javascript">
	//搜索
	function OnSearch(){
		jQuery("#report").submit();
	}	
	
	function OnSearch2(){
		var startDate=new Date();
        var endDate=new Date('2018-06-20 22:15:00');///开标时间
        var countDown=(endDate.getTime()-startDate.getTime())/1000;
		var time = 15*60;
		if(time<=countDown && countDown>=0){
			alert("距离本次开标时间超过15分钟，目前不可以更改标价！");
			return;
		}
		var bj1 = jQuery("#bj").val();
		if(bj1.length<=0){
			alert("报价未填，请填写报价！");
			return ;
		}		
		var r=confirm("是否确认提交新的报价？！");
		if(r==true){
			alert(2);
			//jQuery("#insertInfo").submit();
		}
		
	}	
	function onShowSubcompanyid1(){
		data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/SubcompanyBrowser.jsp");
		if (data!=null){
			if (data.id!= ""){
				jQuery("#subcompanyid1span").html(data.name);
				jQuery("#subcompanyid1").val(data.id);
				makechecked();
			}else{
				jQuery("#subcompanyid1span").html("");
				jQuery("#subcompanyid1").val("");
			}
		}
	}
	
	
		function makechecked() {
			if ($GetEle("subcompanyid1").value != "") {
				$($GetEle("chkSubCompany")).css("display", "");
				$($GetEle("lblSubCompany")).css("display", "");
			} else {
				$($GetEle("chkSubCompany")).css("display", "none");
				$($GetEle("chkSubCompany")).attr("checked", "");
				$($GetEle("lblSubCompany")).css("display", "none");
			}
			jQuery("body").jNice();
		}
		function onBtnSearchClick() {
			report.submit();
		}
		function setCheckbox(chkObj) {
			if (chkObj.checked == true) {
				chkObj.value = 1;
			} else {
				chkObj.value = 0;
			}
		}
		function doEditById(aid){	
			if(aid=="") return ;
			window.location="/";
		}
		  //1.前面补0
        function p(n){
            return n<10?'0'+n:n;
        }
		
		        //2.倒计时
        function getMyTime(){
            var startDate=new Date();
            var endDate=new Date('2018-06-20 22:15');
            var countDown=(endDate.getTime()-startDate.getTime())/1000;
            var day=parseInt(countDown/(24*60*60));
            var h=parseInt(countDown/(60*60)%24);
            var m=parseInt(countDown/60%60);
            var s=parseInt(countDown%60);
			jQuery("#time").text(day+'天'+p(h)+'时'+p(m)+'分'+p(s)+'秒');
            //document.getElementById('time').innerHTML=day+'天'+p(h)+'时'+p(m)+'分'+p(s)+'秒';
            setTimeout('getMyTime()',200);
            if(countDown<=0){
                jQuery("#time").text("开标结束");
            }
        }
		
		jQuery(document).ready(function () {
			getMyTime();			
		})
		
		
	</script>
</BODY>
</HTML>
