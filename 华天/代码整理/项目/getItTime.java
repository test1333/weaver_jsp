package htkj.project;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

public class getItTime implements Action{
	BaseBean log = new BaseBean();
	@Override
	public String execute(RequestInfo info) {
		
		String requestid = info.getRequestid();
		String workflow_id = info.getWorkflowid();
		RecordSet rs = new RecordSet();
		String tableName = "";
		String sql = "Select tablename From Workflow_bill Where id=(";
		sql += "Select formid From workflow_base Where id="+workflow_id+")";
		rs.executeSql(sql);
		
		//	rs.executeSql(sql);
			if (rs.next()) {
				tableName = Util.null2String(rs.getString("tablename"));
			}
			 String id="";
			if (!" ".equals(tableName)) {
				sql="Select id from "+tableName+" where  requestId="+requestid;
				log.writeLog("sql1 ---------" + sql);
				rs.executeSql(sql);
				if(rs.next()){
					id =  Util.null2String(rs.getString("id"));
					
				}
				sql="select  enddate  from "+tableName+"_dt1 where content=2 and mainid= "+id;
				rs.executeSql(sql);
				String enddate="";
				if(rs.next()){
					enddate =  Util.null2String(rs.getString("enddate"));
					
				}
				
				if(!"".equals(enddate)){												
						String starttime=enddate;
						int work=0;
						while(work != 2){
							sql="select to_char(to_date('"+starttime+"','yyyy-mm-dd')+1,'yyyy-mm-dd') from dual";
							rs.execute(sql);
							if(rs.next()){
								starttime=Util.null2String(rs.getString(1));
							}
							work=isWorkDate(starttime);
						}
						String end=starttime;
								work=0;
						while(work != 2){
							sql="select to_char(to_date('"+end+"','yyyy-mm-dd')+1,'yyyy-mm-dd') from dual";
							rs.execute(sql);
							if(rs.next()){
								end=Util.null2String(rs.getString(1));
							}
							work=isWorkDate(end);
									
						}
						sql="update "+tableName+"_dt1 set startdate = '"+starttime+"',enddate = '"+end+"' where content=18 and mainid= "+id;
						log.writeLog("updatesql ---------" + sql);
						rs.execute(sql);
					
				}
				
				sql="select  enddate  from "+tableName+"_dt1 where content=4 and mainid= "+id;
				rs.executeSql(sql);
				String enddate1="";
				if(rs.next()){
					enddate1 =  Util.null2String(rs.getString("enddate"));
					
				}
				
				if(!"".equals(enddate1)){												
						String starttime1=enddate1;
						int work=0;
						while(work != 2){
							sql="select to_char(to_date('"+starttime1+"','yyyy-mm-dd')+1,'yyyy-mm-dd') from dual";
							rs.execute(sql);
							if(rs.next()){
								starttime1=Util.null2String(rs.getString(1));
							}
							work=isWorkDate(starttime1);
						}
						String end1=starttime1;
								work=0;
						while(work != 2){
							sql="select to_char(to_date('"+end1+"','yyyy-mm-dd')+1,'yyyy-mm-dd') from dual";
							rs.execute(sql);
							if(rs.next()){
								end1=Util.null2String(rs.getString(1));
							}
							work=isWorkDate(end1);
									
						}
						sql="update "+tableName+"_dt1 set startdate = '"+starttime1+"',enddate = '"+end1+"' where content=19 and mainid= "+id;
						log.writeLog("updatesql ---------" + sql);
						rs.execute(sql);
					
				}
			}
		return SUCCESS;
	}
    public int isWorkDate(String date){
    	RecordSet rs = new RecordSet();
    	String sql="select posco_what_holiday('"+date+"') from dual";
    	log.writeLog("getwork ---------" + sql);
    	rs.execute(sql);
    	int work=0;
    	if(rs.next()){
    		work=rs.getInt(1);
    	}
    	return work;
    }
}
