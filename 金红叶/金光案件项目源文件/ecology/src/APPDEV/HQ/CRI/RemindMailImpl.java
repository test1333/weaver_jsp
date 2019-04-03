package APPDEV.HQ.CRI;

import java.util.Set;

import weaver.email.EmailWorkRunnable;
import weaver.general.BaseBean;
import weaver.hrm.resource.ResourceComInfo;

/**
 * 邮件发送公用方法
 * @author Administrator
 *
 */
public class RemindMailImpl extends BaseBean{

	/**
	 * 发送邮件
	 * @param touser  邮件接收人
	 * @param title   邮件标题
	 * @param msg     邮件内容
	 */
	public void sendRemind(Set<String> touser,String title, String msg) {
		if(touser!=null&&touser.size()>0&&msg!=null&&!"".equals(msg)){
			try {
				if(title==null||"".equals(title)){
					if(msg.length()>15){
						title=msg.substring(0,10)+"...";
					}else{
						title=msg;
					}
				}
				ResourceComInfo rci=new ResourceComInfo();
		        String emails="";
		        String temp="";
				for (String hrmid:touser) {
					temp= rci.getEmail(hrmid);//邮箱
		        	if("".equals(temp)) continue;
		        	emails+="".equals(emails)?temp:","+temp;
				}
				if(!"".equals(emails)){
					//发送邮件
					new Thread(new EmailWorkRunnable(emails+",", title, msg)).start();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
	}
}
