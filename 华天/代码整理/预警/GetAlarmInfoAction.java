package htkj.alarm;

import weaver.conn.RecordSet;
import weaver.conn.RecordSetDataSource;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.schedule.BaseCronJob;

public class GetAlarmInfoAction extends BaseCronJob{
	
	public void execute() { 
		String result= getInfo();
	}
	
	public String getInfo(){
		BaseBean log = new BaseBean();
		log.writeLog("开始定时获取预警信息");
		RecordSetDataSource rsd = new RecordSetDataSource("EMC_HOLD");
		RecordSet rs= new RecordSet();
		String wheresystem="MES";
		String aramid="";
		String remark="";
		String gxbh="";
		String pc="";
		String lh="";
		String sbbh="";
		String ygxm="";
		String status="0";
		String sql_dt="";
		String sql=" SELECT DISTINCT lw.waferscribenumber as WAFERID, "+
				"                 '' as remark, "+
				"                 wc.workcentername || '(' || wc.description || ')' WORKCENTERNAME, "+
				"                 a.firstname, "+
				"                 PB.PRODUCTNAME, "+
				"                 A.MOVEINUSERNAME AS USERNAME, "+
				"                 al.customername, "+
				"                 lw.WAFERNUMBER AS WAFER_LOT, "+
				"                 a.ONHOLDDATE, "+
				"                 trunc(sysdate - a.ONHOLDDATE, 2) as holdDay, "+
				"                 hol.description "+
				"   FROM CONTAINER A "+
				"  inner join CURRENTSTATUS B "+
				"     on A.CurrentStatusId = B.CurrentStatusId "+
				"  inner join SPEC S "+
				"     on B.SpecId = S.SpecId "+
				"    and S.ObjectCategory = 'WIP' "+
				"  inner join A_SCHEDULEDATA SD "+
				"     on A.ScheduleDataId = SD.ScheduleDataId "+
				"    and SD.ObjectType = 'WAFER' "+
				"  inner join PRODUCT P "+
				"     on A.ProductId = P.ProductId "+
				"    and P.objecttype = 'PN' "+
				"  inner join PRODUCTBASE PB "+
				"     on P.PRODUCTBASEID = PB.PRODUCTBASEID "+
				"  inner join SPECBASE SB "+
				"     on S.SpecBaseId = SB.SpecBaseId "+
				"  inner join A_LOTWAFERS lw "+
				"     on a.CONTAINERID = lw.CONTAINERID "+
				"  inner join OPERATION op "+
				"     on s.OPERATIONID = op.OPERATIONID "+
				"  inner join WORKCENTER wc "+
				"     on op.WORKCENTERID = wc.WORKCENTERID "+
				"  inner join A_LotAttributes al "+
				"     on a.CONTAINERID = al.CONTAINERID "+
				"  inner join mfgorder mfg "+
				"     on a.mfgorderid = mfg.mfgorderid "+
				"  inner join HOLDREASON hol "+
				"     on hol.holdreasonid = a.holdreasonid "+
				"  WHERE A.Status = 1 "+
				"    and a.holdreasonid is not null "+
				"    and a.currentholdcount > 0 "+
				"    and LW.WAFERSCRIBENUMBER like '%' "+
				"    and al.customername like '%' ";
		rsd.executeSql(sql);
		while(rsd.next()){
			aramid = Util.null2String(rsd.getString("WAFERID"));
			remark = Util.null2String(rsd.getString("remark"));
			gxbh = Util.null2String(rsd.getString("WORKCENTERNAME"));
			pc = Util.null2String(rsd.getString("firstname"));
			lh = Util.null2String(rsd.getString("PRODUCTNAME"));
			ygxm = Util.null2String(rsd.getString("USERNAME"));
			int count=0;
			sql_dt="select count(1) as count from uf_alarm_info where aramid='"+aramid+"'";
			rs.executeSql(sql_dt);
			if(rs.next()){
				count = rs.getInt("count");
			}
			if(count > 0){
				continue;
			}
			sql_dt ="insert into uf_alarm_info(wheresystem,aramid,remark,gxbh,pc,lh,sbbh,ygxm,status) "
					+ "values('"
					+ wheresystem
					+ "','"
					+ aramid
					+ "','"
					+ remark
					+ "','"
					+ gxbh
					+ "','"
					+ pc
					+ "','"
					+ lh
					+ "','"
					+ sbbh
					+ "','"
					+ ygxm + "','" + status + "')";
			
			rs.executeSql(sql_dt);
			
		}
		return "SUCCESS";
	}
			
	
}
