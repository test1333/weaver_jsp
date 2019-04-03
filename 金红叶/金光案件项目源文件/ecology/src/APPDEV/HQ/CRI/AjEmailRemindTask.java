package APPDEV.HQ.CRI;

import java.util.ArrayList;

import com.weaver.general.Util;
import com.weaver.general.TimeUtil;
import weaver.conn.RecordSet;
import weaver.formmode.setup.ModeRightInfo;
import weaver.general.BaseBean;
import weaver.hrm.User;
import weaver.hrm.report.schedulediff.HrmScheduleDiffUtil;
import weaver.hrm.resource.ResourceComInfo;
import weaver.interfaces.schedule.BaseCronJob;

/**
 * 案件定时邮件提醒
 * @author Administrator
 *
 */
public class AjEmailRemindTask extends BaseCronJob{

	private String currentdate = TimeUtil.getCurrentDateString();
	BaseBean log = new BaseBean();
	
	public void execute(){
		
		log.writeLog("案件邮件提醒开始");
				
		emialinfo(); //生成邮件数据
		
		sendEmail(); //发送邮件
		
		log.writeLog("案件邮件提醒结束");
	}
	
	/**
	 * 生成邮件数据
	*/
	public void emialinfo(){
		
		RecordSet rs = new RecordSet();
		HrmScheduleDiffUtil gzr = new HrmScheduleDiffUtil();
		
		//案件开放和开发中邮件提醒
		String sql = "select id,xmmc,dcqdrq,fzcd,modedatacreater,dcy,xmbh from uf_hq_cri_casedp where zt in (0,4)";
		rs.executeSql(sql);
		while(rs.next()){
			String xmmc = rs.getString("xmmc");     //项目名称
			String dcqdrq = rs.getString("dcqdrq"); //调查启动日期
			int modedatacreater = rs.getInt("modedatacreater");  //创建人
			String fzcd = rs.getString("fzcd");
			String dcy = rs.getString("dcy");//调查员
			String xmbh = rs.getString("xmbh");//项目编号
			
			User subid = new User(modedatacreater);
			int subpanyid = subid.getUserSubCompany1();
			
			//根据当前日期-调查启动日期 获得案件当前所用到的天数
			String totalworkingdaytmp = gzr.getTotalWorkingDays(dcqdrq,"08:00",currentdate,"08:00",subpanyid);
			int totalworkingday = (int)Util.getDoubleValue(totalworkingdaytmp);
			
			String emailtitle = "案件提醒";
			String emailmsg =  "";
			
			log.writeLog("fzcd:"+fzcd+",xmmc:"+xmmc+",dcy:"+dcy+",totalworkingday:"+totalworkingday+",xmbh:"+xmbh);
			
			if("1".equals(fzcd)){  //简单
				//案件启动后第4天 ,XXX案件已经启动4天，距离奥林匹克日期还剩3天。
				if(totalworkingday == 4){
					emailmsg = xmmc+"案件已经启动4天，距离奥林匹克日期还剩3天";
					sendRemind(dcy, emailtitle, emailmsg);
				}
				
				//案件启动后第11天 ,XXX案件已经启动11天，距离最晚目标日期还剩10天
				if(totalworkingday == 11){
					emailmsg = xmmc+"案件已经启动11天，距离最晚目标日期还剩3天";
					sendRemind(dcy, emailtitle, emailmsg);
				}
				
				//案件启动超过14天后 ,XXX案件已经启动N天，已经超出最晚目标日期XX（N-14）天.
				if(totalworkingday > 14){
					emailmsg = xmmc+"案件已经启动"+totalworkingday+"天，已经超出最晚目标日期"+(totalworkingday - 14)+"天";
					sendRemind(dcy, emailtitle, emailmsg);
				}
			} else {  //复杂
				//案件启动后第43天 ,XXX案件已经启动43天，距离奥林匹克日期还剩7天
				if(totalworkingday == 43){
					emailmsg = xmmc+"案件已经启动"+totalworkingday+"天，距离奥林匹克日期还剩7天";
					sendRemind(dcy, emailtitle, emailmsg);
				}
				
				//案件启动后第63天 ,XXX案件已经启动63天，距离最晚目标日期还剩7天
				if(totalworkingday == 63){
					emailmsg = xmmc+"案件已经启动"+totalworkingday+"天，距离最晚目标日期还剩7天";
					sendRemind(dcy, emailtitle, emailmsg);
				}
				
				//案件启动后第70天后 ,XX案件已经启动N天，已经超出最晚目标日期XX（N-70）天
				if(totalworkingday > 70){
					emailmsg = xmmc+"案件已经启动"+totalworkingday+"天，已经超出最晚目标日期"+(totalworkingday - 70)+"天";
					sendRemind(dcy, emailtitle, emailmsg);
				}
			}			
		}	
		
		//案件追踪结案和结案中邮件提醒,通过案件详情中字段来判断是否需要对4种后续追踪进行提醒：
		//预防损失（估算）、追回损失（估算）如填写数字，就需要追踪提醒。流程缺失、人员处理如选择是，就需要进行追踪提醒。
		//案件追踪页面，已经填写了确定日期，就不需要再提醒了
		sql = "select t1.id,t1.xmmc,t1.dcqdrq,t1.fzcd,t1.modedatacreater,t1.dcy,t1.yfssgs,t1.zhssgs,t1.lcqs,t1.zhssjt,t1.yfssjt,t1.lcqsjt,t1.rycljt,t2.yfqrsj,t2.zhjzsj,t2.xgwcsj "
			  + "from uf_hq_cri_casedp t1,uf_hq_cri_citabapo t2 where t1.xmbh = t2.xmbh and t1.zt in (1,5) ";
		rs.executeSql(sql);
		while(rs.next()){
			String xmmc = rs.getString("xmmc");     //项目名称
			String jasj = rs.getString("jasj"); //结案时间
			int modedatacreater = rs.getInt("modedatacreater");  //创建人
			String dcy = rs.getString("dcy");//调查员
			double yfssgs = Util.getDoubleValue(rs.getString("yfssgs"),0);//预防损失（估算）
			double zhssgs = Util.getDoubleValue(rs.getString("zhssgs"),0);//追回损失（估算）
			String lcqs = rs.getString("lcqs");   //流程缺失
			String rycl = rs.getString("rycl");   //人员处理
			String zhssjt = Util.null2String(rs.getString("zhssjt"));  //追回损失具体承办部门负责人
			String yfssjt = Util.null2String(rs.getString("yfssjt"));  //预防损失具体承办部门负责人
			String lcqsjt = Util.null2String(rs.getString("lcqsjt"));  //流程缺失具体承办部门负责人
			String rycljt = Util.null2String(rs.getString("rycljt"));  //人员处理具体承办部门负责人
			String yfqrsj = Util.null2String(rs.getString("yfqrsj"));  //确认时间
			String zhjzsj = Util.null2String(rs.getString("zhjzsj"));  //进账时间
			String xgwcsj = Util.null2String(rs.getString("xgwcsj"));  //增补、修改完成时间
			
			User subid = new User(modedatacreater);
			int subpanyid = subid.getUserSubCompany1();
			
			//根据当前日期-调查启动日期 获得案件当前所用到的天数
			int totalworkingday = Util.getIntValue(gzr.getTotalWorkingDays(jasj,"00:00",currentdate,"00:00",subpanyid),0);
			
			String emailtitle = "案件追踪提醒";
			String emailmsg =  "";
			
			//预防损失  ,XXX案已经结案3天，请尽快联系具体承办部门负责人完成后续追踪。
			if(yfssgs > 0 && totalworkingday == 3 && "".equals(yfqrsj)){
				emailmsg = xmmc+"案已经结案"+totalworkingday+"天，请尽快联系具体承办部门负责人完成后续追踪";				
				if(!"".equals(yfssjt)) dcy = dcy + ","+yfssjt;
				sendRemind(dcy, emailtitle, emailmsg);
			}
			
			//追回损失 ,XXX案件已经结案15天，请尽快联系具体承办部门负责人完成后续追踪
			if(zhssgs > 0 && totalworkingday == 15 && "".equals(zhjzsj)){
				emailmsg = xmmc+"案已经结案"+totalworkingday+"天，请尽快联系具体承办部门负责人完成后续追踪";
				if(!"".equals(zhssjt)) dcy = dcy + ","+zhssjt;
				sendRemind(dcy, emailtitle, emailmsg);
			}
			
			//SOP流程修改 (流程缺失),XXX案件已经结案30天,请尽快联系具体承办部门负责人完成后续追踪
			if("0".equals(lcqs) && totalworkingday == 30){
				emailmsg = xmmc+"案已经结案"+totalworkingday+"天，请尽快联系具体承办部门负责人完成后续追踪";
				if(!"".equals(lcqsjt)) dcy = dcy + ","+lcqsjt;
				sendRemind(dcy, emailtitle, emailmsg);
			}	
			
			//人员处理,XXX案件已经结案5天，请尽快联系具体承办部门负责人完成后续追踪.
			if("0".equals(rycl) && totalworkingday == 5 && "".equals(xgwcsj)){
				emailmsg = xmmc+"案已经结案"+totalworkingday+"天，请尽快联系具体承办部门负责人完成后续追踪";
				if(!"".equals(rycljt)) dcy = dcy + ","+rycljt;
				sendRemind(dcy, emailtitle, emailmsg);
			}
		}
	}
	
	
	/**
	 * 生成邮件数据
	 * @param touser
	 * @param emailtitle
	 * @param emailmsg
	 */
	public void sendRemind(String touser, String emailtitle, String emailmsg) {
		RecordSet rs = new RecordSet();
		String date = TimeUtil.getCurrentDateString();  
		String time = TimeUtil.getCurrentTimeString();
		time = time.substring(11,time.length());
		ArrayList touserlist = Util.TokenizerString(touser, ",");
		for (int i = 0; i<touserlist.size(); i++) {
			String userid = (String)touserlist.get(i);//人员id
			if(!"".equals(userid)){
				String sql = "insert into uf_hq_emailremind (userid,emailtitle,emailcontent,"
						+ "formmodeid,modedatacreater,modedatacreatertype,modedatacreatedate,modedatacreatetime"
						+ ") values ("
				        +"'"+userid+"','"+emailtitle+"','"+emailmsg+"',"
				        + "'503','1','0','"+date+"','"+time+"')";
				rs.executeSql(sql);
				rs.executeSql(" select max(id) as maxid from uf_hq_emailremind ");
				if(rs.next()){
					int maxid=rs.getInt("maxid");
					ModeRightInfo rightinfo = new ModeRightInfo();
					rightinfo.editModeDataShare(1,503,maxid);
				}	
			}
		}	
	}
	
	/**
	 * 发送邮件
	 * @param touser  邮件接收人
	 * @param title   邮件标题
	 * @param msg     邮件内容
	 */
	public void sendEmail() {
		RecordSet rs = new RecordSet();
		RecordSet rs1 = new RecordSet();
		
		String sql = "select userid from uf_hq_emailremind where (sendstatus = '1' or sendstatus is null) group by userid";
		rs.executeSql(sql);
		while(rs.next()) {
			String touser = rs.getString(1);
			String title = "案件提醒";
			String msg = "";
			sql = "select * from uf_hq_emailremind where userid='"+touser+"' and (sendstatus = '1' or sendstatus is null)";
			rs1.executeSql(sql);
			while(rs1.next()){
				msg += rs1.getString("emailcontent")+" <br> ";
			}			
			if(touser!=null&&touser.length()>0&&msg!=null&&!"".equals(msg)){
				try {				
					ResourceComInfo rci=new ResourceComInfo();
					String emails = rci.getEmail(touser);//邮箱
					log.writeLog("touser:"+touser+",emails:"+emails);
					if(!"".equals(emails)){
						//发送邮件
						log.writeLog("案件发送邮件,emails"+emails+",title:"+title+",msg:"+msg);
						new Thread(new EmailWorkRunnable(emails+",", title, msg,touser)).start();
					}								
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
	}
}
