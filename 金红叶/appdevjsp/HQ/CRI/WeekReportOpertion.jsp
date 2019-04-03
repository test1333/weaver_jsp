<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.*"%>
<%@ page import="weaver.formmode.setup.ModeRightInfo"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="weaver.hrm.User"%>
<%@ page import="weaver.hrm.HrmUserVarify"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs2" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs3" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs4" class="weaver.conn.RecordSet" scope="page" />

<%

rs.execute("select machine from uf_machine ");
String machine="";
int modeId = 0;

if(rs.next()){
	machine=Util.null2String(rs.getString("machine"));
}
if("DEV".equals(machine)){
	modeId = 867;	
} else if("PRO".equals(machine)){
	modeId = 512;
}

User usertemp = HrmUserVarify.getUser(request,response) ;
int userid=usertemp.getUID();

String durrdate = TimeUtil.getCurrentDateString();
String year = durrdate.split("-")[0];
String time = TimeUtil.getCurrentTimeString();
time = time.substring(11,time.length());

Calendar c = Calendar.getInstance();  
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");   
Date date = null;   
try{   
	date = sdf.parse(durrdate);
}catch(Exception e){  

}   
c.setTime(date);  
date  = c.getTime();
int week = TimeUtil.getWeekOfYear(date);
int week1 = week -1;
String week11 = year + String.valueOf(week1);
int week2 = week;
String week22 = year + String.valueOf(week2);
int week3 = week +1;
String week33 = year + String.valueOf(week3);
//这个sql和前台的sql是一致的吗  , 这个sql的目的就是保证后台能取到和前台一致的每一个项目编号，多了少了都不行。
rs.executeSql(" SELECT t2.xmbh,t1.xmmc,t1.dcy,t1.xmbh from uf_hq_cri_casedp t1 ,uf_hq_cri_noticeoao t2 where  t1.xmbh=t2.id and t1.zt = '0' ORDER BY t1.xmbh desc ");
//out.print(" SELECT t2.xmbh,t1.xmmc,t1.dcy,t1.xmbh from uf_hq_cri_casedp t1 ,uf_hq_cri_noticeoao t2 where  t1.xmbh=t2.id and t1.zt = '0' ORDER BY t1.xmbh desc ");
while(rs.next()){
	String xmbh=rs.getString(1);
	String xmmc=rs.getString(2);
	String dcy=rs.getString(3);
	String xmid=rs.getString(4);
	String dcqdrq=rs.getString("dcqdrq");
	String text1 = Util.null2String(request.getParameter("row"+xmbh+"_col1")) ;	
	String text2 = Util.null2String(request.getParameter("row"+xmbh+"_col2")) ;	
	String text3 = Util.null2String(request.getParameter("row"+xmbh+"_col3")) ;	
	String text4 = Util.null2String(request.getParameter("row"+xmbh+"_col4")) ;	
	String text5 = Util.null2String(request.getParameter("row"+xmbh+"_col5")) ;	
	String text6 = Util.null2String(request.getParameter("row"+xmbh+"_col6")) ;	
	
	int detailid = 0;
	rs1.executeSql(" select * from uf_hq_cri_weeklytra where xmbh = '"+xmid+"' ");
	if(rs1.next()){
		detailid = rs1.getInt("id");
	}else{
		rs2.executeSql(" insert into uf_hq_cri_weeklytra (xmbh,xmmc,jddcy,dcqdrq,formmodeid,modedatacreater,modedatacreatertype,modedatacreatedate,modedatacreatetime) values ('"+xmid+"','"+xmmc+"','"+dcy+"','"+dcqdrq+"','"+modeId+"','"+userid+"','0','"+durrdate+"','"+time+"') ");
		rs2.executeSql(" select max(id) as maxid from uf_hq_cri_weeklytra ");
		if(rs2.next()){
			detailid = rs2.getInt("maxid");
			ModeRightInfo rightinfo = new ModeRightInfo();
			rightinfo.editModeDataShare(userid,modeId,detailid);
		}				
	} 
	
	rs3.executeSql("delete from uf_hq_cri_weeklytra_dt1 where mainid = "+detailid+" and zs='"+week11+"'");
	rs3.executeSql("delete from uf_hq_cri_weeklytra_dt1 where mainid = "+detailid+" and zs='"+week22+"'");
	rs3.executeSql("delete from uf_hq_cri_weeklytra_dt1 where mainid = "+detailid+" and zs='"+week33+"'");
	
    rs3.executeSql(" insert into uf_hq_cri_weeklytra_dt1 (mainid,zs,bzwc,xzjh,nz) values ('"+detailid+"','"+week11+"','"+text1+"','"+text2+"','"+week1+"') ");
	rs3.executeSql(" insert into uf_hq_cri_weeklytra_dt1 (mainid,zs,bzwc,xzjh,nz) values ('"+detailid+"','"+week22+"','"+text3+"','"+text4+"','"+week2+"') ");
	rs3.executeSql(" insert into uf_hq_cri_weeklytra_dt1 (mainid,zs,bzwc,xzjh,nz) values ('"+detailid+"','"+week33+"','"+text5+"','"+text6+"','"+week3+"') ");
} 
response.sendRedirect("WeekReport.jsp");

%>
