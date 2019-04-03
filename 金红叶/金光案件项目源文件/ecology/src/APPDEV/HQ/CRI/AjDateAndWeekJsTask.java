package APPDEV.HQ.CRI;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import com.weaver.general.TimeUtil;
import com.weaver.general.Util;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.hrm.User;
import weaver.hrm.report.schedulediff.HrmScheduleDiffUtil;
import weaver.interfaces.schedule.BaseCronJob;

public class AjDateAndWeekJsTask extends BaseCronJob{

	BaseBean log = new BaseBean();
	
	public void execute(){
		
		log.writeLog("案件计算天数周数开始");
		
		RecordSet rs = new RecordSet();
		RecordSet rs1 = new RecordSet();
		HrmScheduleDiffUtil gzr = new HrmScheduleDiffUtil();
		String currentdate = TimeUtil.getCurrentDateString();
		
		//案件开放和开发中邮件提醒
		String sql = "select id,xmmc,dcqdrq,fzcd,modedatacreater,dcy,xmbh from uf_hq_cri_casedp where zt in (0,4) order by id desc";
		rs.executeSql(sql);
		while(rs.next()){
			String dcqdrq = rs.getString("dcqdrq"); //调查启动日期
			int modedatacreater = rs.getInt("modedatacreater");  //创建人
			String xmbh = rs.getString("xmbh");//项目编号
			
			User subid = new User(modedatacreater);
			int subpanyid = subid.getUserSubCompany1();
			
			//根据当前日期-调查启动日期 获得案件当前所用到的天数
			String totalworkingdaytmp = gzr.getTotalWorkingDays(dcqdrq,"00:00",currentdate,"00:00",subpanyid);
			int totalworkingday = (int)Util.getDoubleValue(totalworkingdaytmp);
			//计算中途搁置、暂停天数
			int ts = 0;
			sql = "select sum(ts) from uf_hq_cri_ajbgjl where xmbh = '"+xmbh+"'";
			rs1.executeSql(sql);
			if(rs1.next()) ts = Util.getIntValue(rs1.getString(1),0);
			int ajsyts = totalworkingday-ts;
			if(ajsyts < 0) ajsyts = 0;
						
			//案件周数
			int weekcount = countTwoDayWeek(dcqdrq,currentdate);
			
			log.writeLog("dcqdrq"+dcqdrq+",currentdate:"+currentdate+",totalworkingday:"+totalworkingday+",ts:"+ts+",xmbh:"+xmbh+",subpanyid:"+subpanyid);			
			
			//更新案件天数、周数
			sql = "update uf_hq_cri_casedp set ajsyts = '"+ajsyts+"',ajsyzs='"+weekcount+"' where xmbh='"+xmbh+"'";
			log.writeLog("更新案件天数、周数sql:"+sql);
			rs1.executeSql(sql);
		}	
		
		log.writeLog("案件计算天数周数结束");
	}
	
	/**
	 * 计算两个日期之间的周数
	 * @param startDate
	 * @param endDate
	 * @return
	 */
	public int countTwoDayWeek(String startDate, String endDate){
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");//小写的mm表示的是分钟  
		Date start = null;
		Date end = null;
		try {
			start = sdf.parse(startDate);
			end = sdf.parse(endDate);
		} catch (ParseException e) {
			e.printStackTrace();
		} 		
		Calendar cal = Calendar.getInstance();
		cal.setTime(start);
		long time1 = cal.getTimeInMillis();
		cal.setTime(end);
		long time2 = cal.getTimeInMillis();
		long between_days = (time2-time1)/(1000*3600*24);
		Double days = Double.parseDouble(String.valueOf(between_days));
		if((days/7)>0 && (days/7) <= 1){
			//不满一周的按一周算
			return 1;
		}else if(days/7>1){
			int day=days.intValue();
			if(day%7>0){
				return day/7+1;
			}else{
				return day/7;
			}
		}else if((days/7)==0){
			return 0;
		}else{
			//负数返还null
			return 0;
		}
	}
	
}
