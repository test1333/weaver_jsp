package mubea.kq;

import java.text.SimpleDateFormat;
import java.util.Date;


import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.SendMail;
import weaver.general.Util;
import weaver.interfaces.schedule.BaseCronJob;
import weaver.system.SystemComInfo;

public class EmailRemind extends BaseCronJob{
	public void execute(){
		BaseBean log = new BaseBean();
		log.writeLog("123");
		sendEmail();
	}
	
	public void sendEmail(){
		SystemComInfo sci = new SystemComInfo();
		String mailip = sci.getDefmailserver();//
		String mailuser = sci.getDefmailuser();
		String password = sci.getDefmailpassword();
		String needauth = sci.getDefneedauth();//是否需要发件认证
		String mailfrom = sci.getDefmailfrom();
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
		String subject = "Attendance Remind:  You attendance records need to check";
		StringBuffer body = new StringBuffer();
		body.append("Dear colleague,<br><br>");
		body.append("This is a kindly reminder to you due to the missing parts of your attendance records.");
		body.append("<br><br>");
		body.append("You can check the detailed information in online system [e- cology]: “XXX – XXX - XXX”");
		body.append("<br><br>");
		body.append("It is highly appreciated that you could finish your applications in time and any queries please contact local HR：");
		body.append("<br><br>");
		body.append("Taicang            赵雨君            ext.7962                    e-mail:Yujun.zhao@mubea.com");
		body.append("<br>");
		body.append("Kunshan            夏玉竹            ext.7756                    e-mail:yuzhu.xia@mubea.com");
		body.append("<br>");
		body.append("Shenyang           张声龙            ext.7735                    e-mail:Shenglong.zhang@mubea.com");
		body.append("<br><br>");
		body.append("This email is sent automatically. Please do not reply.");
		body.append("<br><br>");
		String sql = "select distinct c.id,c.email,c.workcode from mubeaLink.AIS20130117115038.dbo.hm_employees a,mubeaLink.AIS20130117115038.dbo.HR_ATS_EmpAttendTotal b ,hrmresource c"+
					" where a.em_id=b.fempid and a.code=c.workcode and c.status <4 and (b.flateminute>0 or b.flatetimes>0 or b.fearlyminute>0 or b.fearlytimes>0 )"+
					" and left(CONVERT(varchar(100),b.fattendday, 23),7) = '"+nowmonth+"' and CONVERT(varchar(100),b.fattendday, 23)<'"+now+"'";
		rs.executeSql(sql);
		while(rs.next()){
			ryid = Util.null2String(rs.getString("id"));
			email  = Util.null2String(rs.getString("email"));
			workcode = Util.null2String(rs.getString("workcode"));
			if("".equals(email)){
				continue;
			}
			boolean result=sm.sendhtml(mailfrom, email, "", "", subject, body.toString(), 3, "3");
		}
	}
}
