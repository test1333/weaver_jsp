<%@ page import="weaver.general.Util" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.general.SendMail" %>
<%@ page import="weaver.general.BaseBean;" %>
<%@ page import="weaver.system.SystemComInfo" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%!
	public void sendEmail(){
		BaseBean log = new BaseBean();
		log.writeLog("kaishiceshi:sendEmail");
		SystemComInfo sci = new SystemComInfo();
		String mailip = sci.getDefmailserver();//
		String mailuser = sci.getDefmailuser();
		String password = sci.getDefmailpassword();
		String needauth = sci.getDefneedauth();//是否需要发件认证
		String mailfrom = sci.getDefmailfrom();
		log.writeLog("kaishiceshi:aaa");
		SendMail sm = new SendMail();
		sm.setMailServer(mailip);//邮件服务器IP
		if (needauth.equals("1")) {
			sm.setNeedauthsend(true);
			sm.setUsername(mailuser);//服务器的账号
			sm.setPassword(password);//服务器密码
		} else {
			sm.setNeedauthsend(false);
		}
		SimpleDateFormat sf= new SimpleDateFormat("yyyy-MM-dd");
		String now = sf.format(new Date());
		String nowmonth=now.substring(0, 7);
		RecordSet rs = new RecordSet();
		String ryid="";
		String email = "";
		String workcode = "";
		String subject = "Attendance Remind:  Your attendance records need to be checked";
		StringBuffer body = new StringBuffer();
		body.append("Dear colleague,<br><br>");
		body.append("This is a kindly reminder to you due to the missing parts of your attendance records.");
		body.append("<br><br>");
		body.append("You can check the detailed information in online system [e- cology]: “<a style='text-decoration: underline; color: blue;cursor:hand'  target='_blank' href=\"http://10.163.0.50/mubea/kq/mubea-employee-kq-Url.jsp\" >click here</a>”");
		body.append("<br><br>");
		body.append("It is highly appreciated that you could finish your applications in time and any queries please contact local HR：");
		body.append("<br><br>");
		body.append("Taicang            赵雨君            ext.7817                    e-mail:Yujun.Zhao@mubea.com");
		body.append("<br>");
		body.append("Kunshan            夏玉竹            ext.7756                    e-mail:Yuzhu.Xia@mubea.com");
		body.append("<br>");
		body.append("Shenyang           张声龙            ext.7735                    e-mail:Shenglong.Zhang@mubea.com");
		body.append("<br><br>");
		body.append("This email is sent automatically. Please do not reply.");
		body.append("<br><br>");
			String sql = "select distinct c.id,c.email,c.workcode from mubeaLink.AIS20130117115038.dbo.hm_employees a,mubeaLink.AIS20130117115038.dbo.HR_ATS_EmpAttendTotal b ,hrmresource c,mubeaLink.AIS20130117115038.dbo.HM_EmployeesAddInfo d"+
					" where a.em_id=b.fempid and a.code=c.workcode and a.em_id=d.em_id and d.HRMS_Userfield_60='IDL - Normal Office' and c.status <4 and (b.flateminute>0  or b.fearlyminute>0  or b.FAbsentHour>0 )"+
					" and left(CONVERT(varchar(100),b.fattendday, 23),7) = '"+nowmonth+"' and CONVERT(varchar(100),b.fattendday, 23)<'"+now+"' and c.id=3008";
			log.writeLog("kaishiceshi:sql"+sql);
		rs.executeSql(sql);
		while(rs.next()){
			ryid = Util.null2String(rs.getString("id"));
			email  = Util.null2String(rs.getString("email"));
			email="Gary.zhou@mubea.com";
			workcode = Util.null2String(rs.getString("workcode"));
			if("".equals(email)){
				continue;
			}
			boolean result= sm.sendhtml(mailfrom, email, "", "", subject, body.toString(), 3, "3");
			log.writeLog("kaishiceshi result:"+result);
		}
	}
%>
<%
out.print("222");
sendEmail();
out.print("123");
%>
