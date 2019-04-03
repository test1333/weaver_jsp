<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />

<%
Integer lg=(Integer)user.getLanguage();
weaver.general.AccountType.langId.set(lg);
%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="AccountType" class="weaver.general.AccountType" scope="page" />
<jsp:useBean id="LicenseCheckLogin" class="weaver.login.LicenseCheckLogin" scope="page" />
<script src="/js/tabs/jquery.tabs.extend_wev8.js"></script>
<link type="text/css" href="/js/tabs/css/e8tabs1_wev8.css" rel="stylesheet" />
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
		<script type="text/javascript">
$(function(){
    $('.e8_box').Tabs({
        getLine:1,
        iframe:"tabcontentframe",

        staticOnLoad:true
    });
}); 
</script>

<style type="text/css"> 
#i{ 
width:100%; 
height:300px; 
} 
</style> 
	</head>
	<%
	int language =user.getLanguage();
	Calendar now = Calendar.getInstance();
	String imagefilename = "/images/hdReport_wev8.gif";
	String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
	String searchyear = Util.null2String(request.getParameter("searchyear"));
    String xm = Util.null2String(request.getParameter("xm"));
	String needfav ="1";
	String needhelp ="";

	int userid = user.getUID();
	String billid="";
		String workcode="";
	String year="";
	String lastname="";
	String startday="";
	String endday=searchyear+"-12-31";
	String kxnxj="";
	String startdate="";
	String jnsynxjss = "";
	String yxnxj="";
	String kxtxj="";
	String yxtxj="";
	String sj="";
	String bj="";
	String tqj="";
	String hj="";
	String cj="";
	String brj="";
	String sangjia="";
	String wc="";
	String pcj="";
	String cjj="";
	String jyssj="";
	String gsj="";
	String sgyynxcj="";
	String sgyywxcj="";
	String jbxs = "";
	String backfields="id,workcode,'"+searchyear+"' as year,lastname,startdate,'"+searchyear+"-01-01' as startday,[dbo].[f_get_holiday_info](id,'1','"+searchyear+"') as kxnxj,[dbo].[f_get_holiday_info](id,'2','"+searchyear+"') as yxnxj,[dbo].[f_get_holiday_info](id,'1','"+searchyear+"') - [dbo].[f_get_holiday_info](id,'2','"+searchyear+"') as jnsynxjss,[dbo].[f_get_holiday_info](id,'3','"+searchyear+"') as kxtxj,[dbo].[f_get_holiday_info](id,'4','"+searchyear+"') as yxtxj,[dbo].[f_get_holiday_info](id,'5','"+searchyear+"') as sj,[dbo].[f_get_holiday_info](id,'6','"+searchyear+"') as bj,[dbo].[f_get_holiday_info](id,'7','"+searchyear+"') as tqj,[dbo].[f_get_holiday_info](id,'8','"+searchyear+"') as hj,[dbo].[f_get_holiday_info](id,'9','"+searchyear+"') as cj,[dbo].[f_get_holiday_info](id,'10','"+searchyear+"') as brj, [dbo].[f_get_holiday_info](id,'11','"+searchyear+"') as sangjia,[dbo].[f_get_holiday_info](id,'12','"+searchyear+"') as wc,"+
					  "[dbo].[f_get_holiday_info](id,'13','"+searchyear+"') as pcj,[dbo].[f_get_holiday_info](id,'14','"+searchyear+"') as cjj,[dbo].[f_get_holiday_info](id,'15','"+searchyear+"') as jyssj,[dbo].[f_get_holiday_info](id,'16','"+searchyear+"') as gsj,[dbo].[f_get_holiday_info](id,'17','"+searchyear+"')as sgyynxcj,[dbo].[f_get_holiday_info](id,'18','"+searchyear+"') as sgyywxcj,[dbo].[f_get_holiday_info](id,'19','"+searchyear+"') as jbxs ";
		String fromSql="  from hrmresource ";
		String sqlWhere=" where id='"+xm+"' ";
String sqlquery="select "+backfields+fromSql+sqlWhere+" order by id asc";
   rs.executeSql(sqlquery);
	if(rs.next()){
		workcode = Util.null2String(rs.getString("workcode"));
		year = Util.null2String(rs.getString("year"));
		lastname = Util.null2String(rs.getString("lastname"));
		startday = Util.null2String(rs.getString("startday"));
		startdate = Util.null2String(rs.getString("startdate"));
		kxnxj = Util.null2String(rs.getString("kxnxj"));
		jnsynxjss = Util.null2String(rs.getString("jnsynxjss"));
		yxnxj = Util.null2String(rs.getString("yxnxj"));
		kxtxj = Util.null2String(rs.getString("kxtxj"));
		yxtxj = Util.null2String(rs.getString("yxtxj"));
		sj = Util.null2String(rs.getString("sj"));
		bj = Util.null2String(rs.getString("bj"));
		tqj = Util.null2String(rs.getString("tqj"));
		hj = Util.null2String(rs.getString("hj"));
		cj = Util.null2String(rs.getString("cj"));
		brj = Util.null2String(rs.getString("brj"));
		sangjia = Util.null2String(rs.getString("sangjia"));
		wc = Util.null2String(rs.getString("wc"));
		pcj = Util.null2String(rs.getString("pcj"));
		cjj = Util.null2String(rs.getString("cjj"));
		jyssj = Util.null2String(rs.getString("jyssj"));
		gsj = Util.null2String(rs.getString("gsj"));
		sgyynxcj = Util.null2String(rs.getString("sgyynxcj"));
		sgyywxcj = Util.null2String(rs.getString("sgyywxcj"));
		jbxs = Util.null2String(rs.getString("jbxs"));
	}
   
   
	%>
 
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
		
		<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="" method=post>
			
		
		<div >
				<wea:layout type="4col">
				<wea:group context="总计可休年假时数统计(单位：小时)" >
				<wea:item>员工工号</wea:item>
				<wea:item><%=workcode%></wea:item>
				<wea:item>员工姓名</wea:item>
				<wea:item><%=lastname%></wea:item>
				<wea:item>年休假开始日期</wea:item>
				<wea:item><%=startday%></wea:item>
				<wea:item>年休假结束日期</wea:item>
				<wea:item><%=endday%></wea:item>
				<wea:item>今年年休假可休时数</wea:item>
				<wea:item><%=kxnxj%></wea:item>
				<wea:item>到职日</wea:item>
				<wea:item><%=startdate%></wea:item>
				<wea:item>今年剩余年休假时数</wea:item>
				<wea:item><%=jnsynxjss%></wea:item>
				<wea:item>今年可休补休假时数</wea:item>
				<wea:item><%=kxtxj%></wea:item>

				</wea:group>		
				<wea:group context="<%=searchyear+"年累计已休假时数统计(单位：小时)"%>" >
				<wea:item>年休假</wea:item>
				<wea:item><%=yxnxj%></wea:item>
				<wea:item>调休假</wea:item>
				<wea:item><%=yxtxj%></wea:item>
				<wea:item>事假</wea:item>
				<wea:item><%=sj%></wea:item>
				<wea:item>病假</wea:item>
				<wea:item><%=bj%></wea:item>
				<wea:item>探亲假</wea:item>
				<wea:item><%=tqj%></wea:item>
				<wea:item>婚假</wea:item>
				<wea:item><%=hj%></wea:item>
				<wea:item>产假及看护假</wea:item>
				<wea:item><%=cj%></wea:item>
				<wea:item>哺乳假</wea:item>
				<wea:item><%=brj%></wea:item>
				<wea:item>丧假</wea:item>
				<wea:item><%=sangjia%></wea:item>
				<wea:item>外出</wea:item>
				<wea:item><%=wc%></wea:item>
				<wea:item>陪产假</wea:item>
				<wea:item><%=pcj%></wea:item>
				<wea:item>产检假</wea:item>
				<wea:item><%=cjj%></wea:item>
				<wea:item>节育手术假</wea:item>
				<wea:item><%=jyssj%></wea:item>
				<wea:item>工伤假</wea:item>
				<wea:item><%=gsj%></wea:item>
				<wea:item>四个月以内小产假</wea:item>
				<wea:item><%=sgyynxcj%></wea:item>
				<wea:item>四个月以外小产假</wea:item>
				<wea:item><%=sgyywxcj%></wea:item>
				</wea:group>				
				</wea:layout>
		</div>

		</FORM>
	<script type="text/javascript">
  
	   function refersh() {
  			window.location.reload();
  		}
 
	</script>
</BODY>
</HTML>