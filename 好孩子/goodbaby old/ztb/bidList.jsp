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
int fieldscount = 0;
String b = Util.null2String(request.getParameter("b"));
String aid = Util.null2String(request.getParameter("aid"));
String zbwjbh = Util.null2String(request.getParameter("zbwjbh"));
String resid = Util.null2String(request.getParameter("resid"));
String kbsj = Util.null2String(request.getParameter("kbsj"));
String bj = Util.null2String(request.getParameter("bj"));
String fieldscounts = Util.null2String(request.getParameter("fieldscount"));
int fieldscountsa =Util.getIntValue(fieldscounts, 0); 
String remark = Util.null2String(request.getParameter("remark"));
if(b.equals("1")&&bj.length()>1){
	String  mmaid = "";
	String sql = "insert into  uf_gysbjb(ZBWJBH,zhurid,zirid,zbj,WLBM,kbsj,pp,xh,gg,dw,crsj) select  ZBWJBH,zhurid,zirid,zbj,WLBM,kbsj,pp,xh,gg,dw,crsj from uf_gysbjb where id =(select max(id) from uf_gysbjb where kbsj ='"+kbsj+"' and zirid =(select requestid from formtable_main_250 where id  ='"+aid+"'))";
	rs.executeSql(sql);
	sql = "select max(id) as mmaid from uf_gysbjb where kbsj ='"+kbsj+"' and zirid =(select requestid from formtable_main_250 where id  ='"+aid+"') ";
	
	rs.executeSql(sql);
	if(rs.next()){
		mmaid = Util.null2String(rs.getString("mmaid"));
		
	}
	sql = "update uf_gysbjb set zbj = '"+bj+"' ,crsj=CONVERT(varchar(16),GETDATE(),120)  where id = '"+mmaid+"'";
	rs.executeSql(sql);
	
	sql = "select * from formtable_main_250_dt1 where mainid = '"+aid+"'";
	rs.executeSql(sql);
	int mu = 0;
	while(rs.next()){
		String wlbm = Util.null2String(rs.getString("BM_1"));
		String xh = Util.null2String(rs.getString("XH_1"));
		String gg = Util.null2String(rs.getString("GG_1"));
		String dw = Util.null2String(rs.getString("DW_1"));
		String pp = Util.null2String(rs.getString("PP_1"));
		String sl = Util.null2String(rs.getString("SHUL_1"));
		String mc = Util.null2String(rs.getString("WLMC_1"));
		String mmbj = Util.null2String(request.getParameter("mbj_"+mu));
		sql = "insert into  uf_gysbjb_dt1(BM_1,XH_1,GG_1,DW_1,PP_1,SHUL_1,WLMC_1,mainid,BJJE_1) values ('"+wlbm+"','"+xh+"','"+gg+"','"+dw+"','"+pp+"','"+sl+"','"+mc+"','"+mmaid+"','"+mmbj+"')";
		RecordSet.executeSql(sql);
	}
	
	
	
	// for(int i=0;i<fieldscountsa;i++){
		// String wlbm = Util.null2String(request.getParameter("bm_"+i));
		// String xh = Util.null2String(request.getParameter("xh_"+i));
		// String gg = Util.null2String(request.getParameter("gg_"+i));
		// String dw = Util.null2String(request.getParameter("dws_"+i));
		// String pp = Util.null2String(request.getParameter("pp_"+i));
		// String sl = Util.null2String(request.getParameter("sl_"+i));
		// String mc = Util.null2String(request.getParameter("mc_"+i));
		// String mmbj = Util.null2String(request.getParameter("mbj_"+i));
		// sql = "insert into  uf_gysbjb_dt1(BM_1,XH_1,GG_1,DW_1,PP_1,SHUL_1,WLMC_1,mainid,BJJE_1) values ('"+wlbm+"','"+xh+"','"+gg+"','"+dw+"','"+pp+"','"+sl+"','"+mc+"','"+mmaid+"','"+mmbj+"')";
		// rs.executeSql(sql);
		//out.print("sql----"+sql);
	// }	
	sql = "select xtkh ,zhurid from formtable_main_250 where id  = '"+aid+"'";
	rs.executeSql(sql);
	if(rs.next()){
		String reid = rs.getString("zhurid");
		String xtkh = rs.getString("xtkh");
		String m2id ="";
		String sss= "update formtable_main_200_dt2 set  zbjg='"+bj+"' where  id =(  select a.id from formtable_main_200_dt2 a where a.mainid = (select b.id from formtable_main_200 b where b.requestid='"+reid+"') and a.gysmc='"+xtkh+"')";
		RecordSet.executeSql(sss);	
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
	
	<FORM id="insertInfo" name="insertInfo" action="/goodbaby/ztb/bidList.jsp" method=post>
	
	<input type="hidden" id="fieldscount" name="fieldscount" value="<%=fieldscount%>">
	<div class="zDialog_div_content" id="differencehandle" name="differencehandle">
				<wea:layout type="4col">
				<wea:group context="投标" >
				<wea:item>距离本次开标时间还有</wea:item>
				<wea:item><span name="time" id="time"></span></wea:item>
				<wea:item>开&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;标&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;时&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;间</wea:item>
				<wea:item><span  name="kbsj1" id="kbsj1"><%=kbsj%></span>
				<input type="hidden" name="kbsj" id = "kbsj" value="<%=kbsj%>">
				<input type="hidden" name="aid" id = "aid" value="<%=aid%>">
				<input type="hidden" name="b" id = "b" value="1">
				</wea:item>
				<wea:item>报&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;价</wea:item>
				<wea:item><input type="text" name="bj" id="bj" class="InputStyle" value="<%=bj%>"/></wea:item>

         		<wea:item>备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;说&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;明</wea:item>
				<wea:item>
				<TEXTAREA class=InputStyle ROWS="4" STYLE="width:65%" name="remark" id ="remark" ><%=remark%></TEXTAREA>
				
				</wea:item>
				</wea:group>
				<%
					String mxsql = "select * from formtable_main_250_dt1 where mainid = '"+aid+"'";
					rs.executeSql(mxsql);
					
					while(rs.next()){//1
						if(fieldscount==0)
				%>
						
						<wea:group context="详细数据" >
						
						
						
				<%		String wlbm = Util.null2String(rs.getString("BM_1"));
						String xh = Util.null2String(rs.getString("XH_1"));
						String gg = Util.null2String(rs.getString("GG_1"));
						String dw1 = Util.null2String(rs.getString("DW_1"));
						String dw = "";
						String dwsql = "select * from uf_unitForms where id  = '"+dw1+"'";
						RecordSet.executeSql(dwsql);
						if(RecordSet.next()){
							dw = RecordSet.getString("dw");
						}
						String pp = Util.null2String(rs.getString("PP_1"));
						String sl = Util.null2String(rs.getString("SHUL_1"));
						String mc = Util.null2String(rs.getString("WLMC_1"));				
				%>
				<wea:item>名称</wea:item>
				<wea:item><%=mc%></wea:item>
				<wea:item>编码</wea:item>
				<wea:item><%=wlbm%></wea:item>
				<wea:item>品牌</wea:item>
				<wea:item><%=pp%></wea:item>
				<wea:item>型号</wea:item>
				<wea:item><%=xh%></wea:item>
         		<wea:item>规格</wea:item>
				<wea:item><%=gg%></wea:item>
				<wea:item>数量</wea:item>
				<wea:item><%=sl%></wea:item>
				<wea:item>单位</wea:item>
				<wea:item><%=dw%></wea:item>
				<wea:item>报价</wea:item>
				<wea:item><input type="text" name="mbj_<%=fieldscount%>" id="mbj_<%=fieldscount%>" class="InputStyle" value=""/>
				</wea:item>
				
				<%
						
						
						fieldscount++;	%>
					</wea:group>
					<%
						
					}
				
				%>
				
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
		<tr><th>物料编号</th><th>品牌</th><th>型号</th><th>规格</th><th>单位</th><th>报价</th><th>报价时间</th></tr>
		<%
		String table_name1 = "formtable_main_223";
		String table_name2 = "formtable_main_223_dt1";
		String maxBJJE_1="0";
		String avg ="0";
		String zhurid = "";
		String zrid = "";
		int a = 0;
		// String avgsql = "select isnull(CONVERT(DECIMAL(10,2),AVG(BJJE_1)),0)as avgs from formtable_main_223_dt1 where id in (select  t.mid from "
		// +"( select max(id)as mid , mainid from formtable_main_223_dt1 where  mainid in (select id from formtable_main_223 where ZBWJBH='"+zbwjbh+"') and BJJE_1"+"is not null //group by mainid )t) ";
		String sqt = "select zhurid ,requestid from formtable_main_250 where id ='"+aid+"'";
		rs.executeSql(sqt);
		if(rs.next()){
			zhurid = Util.null2String(rs.getString("zhurid"));
			zrid = Util.null2String(rs.getString("requestid"));
		}
		String avgsql = "select isnull(CONVERT(DECIMAL(10,2),AVG(zbj)),0)as avgs   from uf_gysbjb where id in (select tt.mid from ( select max(id) as mid,zirid from uf_gysbjb"
		+" where  id  in (select id from uf_gysbjb where  zhurid='"+zhurid+"' and kbsj = '"+kbsj+"') group by zirid ) tt)";
		rs.executeSql(avgsql);
		if(rs.next()){
			avg = rs.getString("avgs");
		}
		Float BJJE_vag = Float.parseFloat(avg);
		String zhbjsql  ="select zbj from uf_gysbjb where id in (select max(id) from  uf_gysbjb where zhurid='"+zhurid+"' and kbsj = '"+kbsj+"' and zirid = '"+zrid+"' and zbj is not null and zbj>0) ";
		rs.executeSql(zhbjsql);
		if(rs.next()){
			maxBJJE_1 = rs.getString("zbj");
		}
		Float BJJE = Float.parseFloat(maxBJJE_1);
		Float BJJE1 = (float) (BJJE_vag*0.1+BJJE_vag);
		
		String strsql = "select * from uf_gysbjb where 	zhurid='"+zhurid+"' and kbsj = '"+kbsj+"' and zirid = '"+zrid+"'  order by id desc  ";
		
		// String backfields = "select  d.id as did,d.requestid,b.id as bid ,b.BM_1,b.WLMC_1,b.GG_1+' '+b.XH_1  as GGXH,b.PP_1,b.BJJE_1,d.requestid,c.requestname "; 
		// String fromSql  = " from formtable_main_223 d, workflow_requestbase  c ,formtable_main_223_dt1 b ";
		// String sqlWhere = " where  d.requestid=c.requestid  and c.workflowid = 229 and b.mainid =d.id and b.BJJE_1>0 and d.id = '"+aid+"'";			
		// String orderby = " order by  b.id  " ;
		// String tableString = "";
		// if(!"".equals(zbwjbh)){
			// sqlWhere = sqlWhere + " and b.ZBWJBH like '%"+zbwjbh+"%'";
		// }
		// if(!"".equals(resid)){
			// sqlWhere = sqlWhere + " and  d.xm = "+resid;
		// }
		// String strsql = backfields + fromSql + sqlWhere + orderby; 
		
		//out.print(strsql);
		rs.executeSql(strsql);
		while(rs.next()){
			String dw = "";
			String wlbm = rs.getString("wlbm");
			String xh = rs.getString("xh");
			String gg = rs.getString("gg");
			String dw1 = rs.getString("dw");
			String dwsql = "select * from uf_unitForms where id  = '"+dw1+"'";
			RecordSet.executeSql(dwsql);
			if(RecordSet.next()){
				dw = RecordSet.getString("dw");
			}
			String pp = rs.getString("pp");
			String zbj = rs.getString("zbj");
			String crsj = rs.getString("crsj");
			String wlmc = rs.getString("wlmc");
			
		if(a==0 && BJJE_vag <= BJJE && BJJE < BJJE1){
	%>
			
		<tr style="color:yellow" >	
			<td><%=wlbm%></td><td><%=pp%></td><td><%=xh%></td><td><%=gg%></td><td><%=dw%></td><td><%=zbj%></td><td><%=crsj%></td>
		</tr>		
		<%
		}else if(a==0 && BJJE1 <= BJJE){%>
		
		<tr style="color:orange">	
			<td><%=wlbm%></td><td><%=pp%></td><td><%=xh%></td><td><%=gg%></td><td><%=dw%></td><td><%=zbj%></td><td><%=crsj%></td>
		</tr>		
		<%}else{%>
		
		<tr>	
			<td><%=wlbm%></td><td><%=pp%></td><td><%=xh%></td><td><%=gg%></td><td><%=dw%></td><td><%=zbj%></td><td><%=crsj%></td>
		</tr>
		<%}
			a++;
		}
		%>
		<tr>	
			<td></td><td></td><td></td><td></td><td></td><td></td><td></td>
		</tr>
		</table>
	</div>
	<div style="width:800px;higth:200px;"></div>
	<script type="text/javascript">
	//搜索
	function OnSearch(){
		jQuery("#report").submit();
	}	
	
	function OnSearch2(){
		var startDate=new Date();
		var kbsj_val1 = "<%=kbsj%>";
		if(kbsj_val1.length<10){
			kbsj_val1 = "2018-06-20";
		} 
        var endDate=new Date(kbsj_val1);///开标时间
        var countDown=(endDate.getTime()-startDate.getTime())/1000;
		var time = 15*60;
		if(time<=countDown && countDown>=0){
			alert("距离本次开标时间超过15分钟，目前不可以更改标价！");
			return;
		}else if(countDown<0){
			alert("本次开标已结束！");
			return;
		}
		var bj1 = jQuery("#bj").val();
		if(bj1.length<=0){
			alert("报价未填，请填写报价！");
			return ;
		}		
		document.getElementById("fieldscount").value = "<%=fieldscount%>";
		var r=confirm("是否确认提交新的报价？！");
		if(r==true){
			alert(2);
			jQuery("#insertInfo").submit();
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
            var startDate = new Date();
			var kbsj_val = "<%=kbsj%>";
			if(kbsj_val.length<10){
				kbsj_val = "2018-06-20";
			} 
			var endDate = new Date(kbsj_val);///开标时间
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
			//alert('<%=kbsj%>');	
		})
		
		function resetCondtion2(){
			insertInfo.remark.value = "";
			insertInfo.bj.value = "";
			var ac = "<%=fieldscount%>";
			for(var i=0;i<parseInt(ac);i++){
				var j="mbj_"+i;
				document.getElementById(j).value = "";
				
			}
			
		}
	</script>
</BODY>
</HTML>
