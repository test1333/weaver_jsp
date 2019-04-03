package APPDEV.HQ.CRI;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;

import APPDEV.HQ.DECODE.EncodeModeAction;
import weaver.conn.RecordSet;
import weaver.formmode.setup.ModeRightInfo;
import weaver.general.BaseBean;
import weaver.general.TimeUtil;
import weaver.general.Util;
import weaver.hrm.User;
import weaver.hrm.report.schedulediff.HrmScheduleDiffUtil;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;


/**
 * 案件交办通知书生成案件详情记录
 * @author Administrator
 *
 */

public class CaseNoticeAction extends BaseBean implements Action {	

	public String execute(RequestInfo requestInfo) {
		
		int billid = Util.getIntValue(requestInfo.getRequestid());		
		int userid =  Util.getIntValue(requestInfo.getCreatorid());

		RecordSet rs = new RecordSet();
		RecordSet rs1 = new RecordSet();
		RecordSet rs2 = new RecordSet();
        String modeajtzTable = "uf_hq_cri_noticeoao";    //案件交办通知书
        String modeajxqTable = "uf_hq_cri_casedp";       //案件详情
        String date = TimeUtil.getCurrentDateString();
		String time = TimeUtil.getCurrentTimeString();
		time = time.substring(11,time.length());
		HrmScheduleDiffUtil gzr = new HrmScheduleDiffUtil();
		User subid = new User(userid);
		int subpanyid = subid.getUserSubCompany1();
		
		rs.execute("select machine from uf_machine");
		String machine="";
		int formmodeid = 0;
		if(rs.next()){
			machine=Util.null2String(rs.getString("machine"));
		}
		if("DEV".equals(machine)){
			formmodeid = 852;
		} else if("PRO".equals(machine)){
			formmodeid = 508;
		}		
		try {			
			//更新举报是否已创建案件
			String sql = " select * from uf_hq_cri_noticeoao where id = '"+billid+"' ";
			rs.executeSql(sql);
			if(rs.next()){
				String dyjbbh =  Util.null2String(rs.getString("dyjbbh"));    //对应举报编号
				sql = " select * from uf_hq_cri_reporthp where id = '"+dyjbbh+"' ";
				rs.executeSql(sql);
				if(rs.next()){
					sql = " update uf_hq_cri_reporthp set sfycjaj = '0' where id = '"+dyjbbh+"' ";
					rs1.executeSql(sql);
				}				
			}
			//更新举报是否已创建案件
			
			rs.executeSql(" select * from  "+modeajtzTable+" where id='"+billid+"' ");
			writeLog("案件通知书查询"+" select * from  "+modeajtzTable+" where id='"+billid+"' ");
			if(rs.next()){
				
				String xmbh = Util.null2String(rs.getString("xmbh"));         //项目编号
				rs1.executeSql(" select id from "+modeajtzTable+" where xmbh = '"+xmbh+"' ");
				if(rs1.next()){
					xmbh = Util.null2String(rs1.getString("id"));
				}
				
				String xmmc = Util.null2String(rs.getString("xmmc"));         //项目名称
				String dyjbbh = Util.null2String(rs.getString("dyjbbh"));     //对应举报编号
				String fzcd = Util.null2String(rs.getString("fzcd"));         //复杂程度
				String jbjsf = Util.null2String(rs.getString("jbjsf"));       //举报接收方
				String dcqdrq = Util.null2String(rs.getString("dcqdrq"));     //调查启动日期
				String dcy = Util.null2String(rs.getString("dcy"));           //调查员
				String mbjarq = Util.null2String(rs.getString("mbjarq"));     //目标结案日期
				String dyjbr = Util.null2String(rs.getString("dyjbr"));       //对应举报人
				String dybjbdx = Util.null2String(rs.getString("dybjbdx"));   //对应被举报对象
				String dyjbzr = Util.null2String(rs.getString("dyjbzr"));     //对应举报证人
				String jbzy = Util.null2String(rs.getString("jbzy"));         //举报摘要
				String sfwjack = Util.null2String(rs.getString("sfwjack"));   //是否为旧案重开
				String jazksf = Util.null2String(rs.getString("jazksf"));     //旧案重开是否复制旧案数据
				String jabh = Util.null2String(rs.getString("jabh"));         //旧案编号
				String rwly = Util.null2String(rs.getString("rwly"));         //任务来源
				
				String sstd = Util.null2String(rs.getString("sstd"));         //所属团队
				String xctd = Util.null2String(rs.getString("xctd"));         //协查团队					
										
				//接案周
				Calendar c = Calendar.getInstance();  
		        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");   
		        Date dates = null;   
		        try{   
		        	dates = sdf.parse(dcqdrq);
		        }catch(Exception e){  

		        }   
		        c.setTime(dates); 
		        dates  = c.getTime();
				int week = TimeUtil.getWeekOfYear(dates);
				String weekstr = "";
				if(week < 10){
					weekstr = "0"+week;
				}else{
					weekstr = ""+week;
				}
				String weekstrjaz = dcqdrq.split("-")[0] + weekstr;
				
				//根据当前日期-调查启动日期 获得案件当前所用到的天数
				String totalworkingdaytmp = gzr.getTotalWorkingDays(dcqdrq,"00:00",date,"00:00",subpanyid);
				int totalworkingday = (int)Util.getDoubleValue(totalworkingdaytmp);
				//计算中途搁置、暂停天数
				int ts = 0;
				sql = "select sum(ts) from uf_hq_cri_ajbgjl where xmbh = '"+xmbh+"'";
				rs1.executeSql(sql);
				if(rs1.next()) ts = Util.getIntValue(rs1.getString(1),0);
				int days = totalworkingday-ts;
				if(days < 0) days = 0;							
				//案件周数
				AjDateAndWeekJsTask ajDateAndWeekJsTask = new AjDateAndWeekJsTask();
				int weeks = ajDateAndWeekJsTask.countTwoDayWeek(dcqdrq,date);					
				rs.executeSql(" select * from "+modeajxqTable+" where xmbh = '"+xmbh+"' ");
				if(rs.next()){
					int creater=rs.getInt("modedatacreater"); 
					int sourceId=rs.getInt("id");
					sql = " update "+modeajxqTable+" set zt = '0',jbqd = '"+rwly+"', alpkrq = '"+mbjarq+"',ajsyzs = '"+weeks+"',jaz = '"+weekstrjaz+"'," +
							" ajsyts = '"+days+"', xmbh = '"+xmbh+"',xmmc = '"+xmmc+"',dcy='"+dcy+"',dcqdrq='"+dcqdrq+"',jbzy='"+jbzy+"',dyjbr='"+dyjbr+"'," +
							" dybjbdx = '"+dybjbdx+"',dyzr = '"+dyjbzr+"',dyjbbh = '"+dyjbbh+"',jbjsf = '"+jbjsf+"',fzcd = '"+fzcd+"',sstd='"+sstd+"',xctd='"+xctd+"' where xmbh = '"+xmbh+"' ";
					rs.executeSql(sql);
					ModeRightInfo rightinfo = new ModeRightInfo();
					rightinfo.rebuildModeDataShareByEdit(creater,formmodeid,sourceId);//更改调查员后重新生成默认共享					
				}else{
					sql = " insert into "+modeajxqTable+" (jbqd,zt,alpkrq,ajsyzs,jaz,ajsyts,xmbh,xmmc,dcy,dcqdrq,jbzy,dyjbr,dybjbdx,dyzr,dyjbbh,jbjsf," +
						      " fzcd,formmodeid,modedatacreater,modedatacreatertype,modedatacreatedate,modedatacreatetime,xctd,sstd) " +
							  " values ('"+rwly+"','0','"+mbjarq+"','"+weeks+"','"+weekstrjaz+"','"+days+"','"+xmbh+"','"+xmmc+"','"+dcy+"','"+dcqdrq+"','"+jbzy+"'," +
							  		" '"+dyjbr+"','"+dybjbdx+"','"+dyjbzr+"','"+dyjbbh+"','"+jbjsf+"','"+fzcd+"','"+formmodeid+"','"+userid+"','0','"+date+"','"+time+"','"+xctd+"','"+sstd+"') ";
					rs.executeSql(sql);
					writeLog("案件插入"+ sql);					
					rs1.executeSql(" select max(id) as maxid from "+modeajxqTable+" ");
					if(rs1.next()){
						int maxid=rs1.getInt("maxid");
						
						//旧案编号不为空并且为旧案重开并且旧案重开是复制旧案数据
						if(!"".equals(jabh) && "0".equals(sfwjack) && "0".equals(jazksf)) {
							String gdgz = "";
							String zasf = "";
							String sadw = "";
							String sasyb = "";
							String qtglry = "";
							String qtgldw = "";
							String glaj = "";
							String xydx = "";
							String zr = "";
							String bz = "";
							int mainid = 0;
							sql = "select * from "+modeajxqTable+" where xmbh = '"+jabh+"'";
							rs2.executeSql(sql);
							if(rs2.next()){
								mainid = rs2.getInt("id");
								gdgz = rs2.getString("gdgz");
								zasf = rs2.getString("zasf");
								sadw = rs2.getString("sadw");
								sasyb = rs2.getString("sasyb");
								qtglry = rs2.getString("qtglry");
								qtgldw = rs2.getString("qtgldw");
								glaj = rs2.getString("glaj");
								xydx = rs2.getString("xydx");
								zr = rs2.getString("zr");
								bz = rs2.getString("bz");
							}		
							sql = "update "+modeajxqTable+" set gdgz='"+gdgz+"',zasf='"+zasf+"',sadw='"+sadw+"',sasyb='"+sasyb+"',qtglry='"+qtglry+"',"
									+ "qtgldw='"+qtgldw+"',glaj='"+glaj+"',xydx='"+xydx+"',zr='"+zr+"',bz='"+bz+"' where id = '"+maxid+"'";
							rs2.executeSql(sql);
							
							sql = "insert into uf_hq_cri_casedp_dt1 (mainid,afddgj,afddqt,afdds) select "+maxid+",afddgj,afddqt,afdds from uf_hq_cri_casedp_dt1 where mainid = '"+mainid+"' ";
							rs2.executeSql(sql);
						}
						
						ModeRightInfo rightinfo = new ModeRightInfo();
						rightinfo.editModeDataShare(userid,formmodeid,maxid);
					}
				}
			}
			
			EncodeModeAction encodeModeAction = new EncodeModeAction();
			encodeModeAction.doEncodeData(""+formmodeid,""+billid);
		
		} catch (Exception e) {
			writeLog(Arrays.toString(e.getStackTrace()));
		}
		return Action.SUCCESS;
	}
	
}
