package htkj.project;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

public class InsertDetails implements Action {

	@Override
	public String execute(RequestInfo info) {
		BaseBean log = new BaseBean();
		String requestid = info.getRequestid();
		String workflow_id = info.getWorkflowid();
		log.writeLog("insertDetails____Start");
		RecordSet rs = new RecordSet();
		String tableName = "";
		String sql = "Select tablename From Workflow_bill Where id=(";
		sql += "Select formid From workflow_base Where id="+workflow_id+")";
		log.writeLog("sql ---------" + sql);
		rs.executeSql(sql);
		
	//	rs.executeSql(sql);
		if (rs.next()) {
			tableName = Util.null2String(rs.getString("tablename"));
		}
		 String id="";
		 String scfzr="";
		 String npifzr="";
		 String itfzr="";
		if (!" ".equals(tableName)) {
			sql="Select id,lxfzr,npifzr,itfzr from "+tableName+" where  requestId="+requestid;
			log.writeLog("sql1 ---------" + sql);
			rs.executeSql(sql);
			if(rs.next()){
				id =  Util.null2String(rs.getString("id"));
				scfzr =  Util.null2String(rs.getString("lxfzr"));
				npifzr =  Util.null2String(rs.getString("npifzr"));
				itfzr =  Util.null2String(rs.getString("itfzr"));
			}
			sql="insert into  "+tableName+"_dt1(mainid,content,creator,fromwhat) values("+id+",'0','"+npifzr+"','0')";
			log.writeLog("sql2 ---------" + sql);
			rs.executeSql(sql);
			sql="insert into  "+tableName+"_dt1(mainid,content,creator,fromwhat) values("+id+",'1','"+npifzr+"','0')";
			rs.executeSql(sql);
			sql="insert into  "+tableName+"_dt1(mainid,content,creator,fromwhat) values("+id+",'2','"+npifzr+"','0')";
			rs.executeSql(sql);
			sql="insert into  "+tableName+"_dt1(mainid,content,creator,fromwhat) values("+id+",'3','"+npifzr+"','0')";
			rs.executeSql(sql);
			sql="insert into  "+tableName+"_dt1(mainid,content,creator,fromwhat) values("+id+",'4','"+npifzr+"','0')";
			rs.executeSql(sql);
			sql="insert into  "+tableName+"_dt1(mainid,content,creator,fromwhat) values("+id+",'5','"+npifzr+"','0')";
			rs.executeSql(sql);
			sql="insert into  "+tableName+"_dt1(mainid,content,creator,fromwhat) values("+id+",'6','"+npifzr+"','0')";
			rs.executeSql(sql);
			sql="insert into  "+tableName+"_dt1(mainid,content,creator,fromwhat) values("+id+",'7','"+scfzr+"','1')";
			rs.executeSql(sql);
			sql="insert into  "+tableName+"_dt1(mainid,content,creator,fromwhat) values("+id+",'8','"+scfzr+"','1')";
			rs.executeSql(sql);
			sql="insert into  "+tableName+"_dt1(mainid,content,creator,fromwhat) values("+id+",'9','"+scfzr+"','1')";
			rs.executeSql(sql);
			sql="insert into  "+tableName+"_dt1(mainid,content,creator,fromwhat) values("+id+",'10','"+scfzr+"','1')";
			rs.executeSql(sql);
			sql="insert into  "+tableName+"_dt1(mainid,content,creator,fromwhat) values("+id+",'11','"+scfzr+"','1')";
			rs.executeSql(sql);
			sql="insert into  "+tableName+"_dt1(mainid,content,creator,fromwhat) values("+id+",'12','"+scfzr+"','1')";
			rs.executeSql(sql);
			sql="insert into  "+tableName+"_dt1(mainid,content,creator,fromwhat) values("+id+",'13','"+scfzr+"','1')";
			rs.executeSql(sql);
			sql="insert into  "+tableName+"_dt1(mainid,content,creator,fromwhat) values("+id+",'14','"+scfzr+"','1')";
			rs.executeSql(sql);
			sql="insert into  "+tableName+"_dt1(mainid,content,creator,fromwhat) values("+id+",'15','"+scfzr+"','1')";
			rs.executeSql(sql);
			sql="insert into  "+tableName+"_dt1(mainid,content,creator,fromwhat) values("+id+",'16','"+scfzr+"','1')";
			rs.executeSql(sql);
			sql="insert into  "+tableName+"_dt1(mainid,content,creator,fromwhat) values("+id+",'17','"+itfzr+"','2')";
			rs.executeSql(sql);
			sql="insert into  "+tableName+"_dt1(mainid,content,creator,fromwhat) values("+id+",'18','"+itfzr+"','2')";
			rs.executeSql(sql);
			sql="insert into  "+tableName+"_dt1(mainid,content,creator,fromwhat) values("+id+",'19','"+itfzr+"','2')";
			rs.executeSql(sql);
			
		}

		return SUCCESS;
	}

}
