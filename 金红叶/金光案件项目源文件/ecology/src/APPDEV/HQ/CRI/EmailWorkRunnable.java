package APPDEV.HQ.CRI;

import com.weaver.general.TimeUtil;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.SendMail;
import weaver.general.Util;
import weaver.system.SystemComInfo;

public class EmailWorkRunnable implements Runnable {
	private String mailtoaddress = "";
	private String mailobject = "";
	private String mailrequestname = "";
	private String userid = "";

	public EmailWorkRunnable(String paramString1, String paramString2, String paramString3,String userid) {
		this.mailtoaddress = paramString1;
		this.mailobject = paramString2;
		this.mailrequestname = paramString3;
		this.userid = userid;
	}

	public void run() {
		try {
			this.mailtoaddress = this.mailtoaddress.substring(0, this.mailtoaddress.length() - 1);
			SendMail localSendMail = new SendMail();
			SystemComInfo localSystemComInfo = new SystemComInfo();
			String str1 = localSystemComInfo.getDefmailserver();
			String str2 = localSystemComInfo.getDefneedauth();
			String str3 = localSystemComInfo.getDefmailuser();
			String str4 = localSystemComInfo.getDefmailpassword();
			String str5 = localSystemComInfo.getDefmailfrom();
			localSendMail.setMailServer(str1);
			if (str2.equals("1")) {
				localSendMail.setNeedauthsend(true);
				localSendMail.setUsername(str3);
				localSendMail.setPassword(str4);
			} else {
				localSendMail.setNeedauthsend(false);
			}
			String sql = "";
			RecordSet rs = new RecordSet();
			boolean sstmp = localSendMail.sendhtml(str5, this.mailtoaddress, null, null, Util.toHtmlMode(this.mailobject),Util.toHtmlMode(this.mailrequestname), 3, "3");
			BaseBean log = new BaseBean();
		    if(sstmp){
		    	sql = "update uf_hq_emailremind set sendtime = '"+TimeUtil.getCurrentDateString()+"',sendstatus='0' where userid ='"+userid+"' and (sendstatus = '1' or sendstatus is null)";
		    } else {
		    	sql = "update uf_hq_emailremind set sendtime = '"+TimeUtil.getCurrentDateString()+"',sendstatus='1' where userid ='"+userid+"' and (sendstatus = '1' or sendstatus is null)";
		    }
		    log.writeLog("sstmp:"+sstmp+",sql:"+sql);
		    rs.executeSql(sql);
		} catch (Exception localException) {
		}
	}
}
