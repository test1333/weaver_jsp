package APPDEV.HQ.DECODE;

import COM.rsa.jsafe.bi;
import weaver.conn.RecordSet;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

public class EncodeModeAction implements Action{

	@Override
	public String execute(RequestInfo info) {
		RecordSet rs = new RecordSet();
		EncodeUtil eu = new EncodeUtil();
		String modeId = info.getWorkflowid();
		String billId = info.getRequestid();
		String mapMainid="";
		String tableName="";
		String sql="select id from uf_des_mapping  where workflowid in (select formid from modeinfo where id='"+modeId+"') and isactive=0";
		rs.executeSql(sql);
		if(rs.next()){
			mapMainid = Util.null2String(rs.getString("id"));
		}
		sql="select b.tablename from modeinfo a,workflow_bill b where a.formid=b.id and a.id="+modeId;
		rs.executeSql(sql);
		if(rs.next()){
			tableName = Util.null2String(rs.getString("tablename"));
		}
		if(!"".equals(tableName)&&!"".equals(mapMainid)){
			sql = "select * from uf_des_mapping_dt1 where mainid = " + mapMainid;
			rs.executeSql(sql);
			while(rs.next()){
				String fieldname = Util.null2String(rs.getString("filedname"));
				String ftype = Util.null2String(rs.getString("ftype"));
				
				if("clob".equalsIgnoreCase(ftype)||"blob".equalsIgnoreCase(ftype)){
					eu.doClob(fieldname,getFiledName(fieldname),tableName,"id",billId);
				}else{
					eu.doOther(fieldname,getFiledName(fieldname),tableName,"id",billId);
				}
			}
		}
		return SUCCESS;
	}
	private String getFiledName(String fieldid){
		RecordSet rs = new RecordSet();
		rs.executeSql("select * from workflow_billfield where id="+fieldid);
		String name = "";
		if(rs.next()){
			name = Util.null2String(rs.getString("fieldname"));
		}
		return name;
	}
	
	public String  doEncodeData(String mode_id,String bill_id){
		RecordSet rs = new RecordSet();
		EncodeUtil eu = new EncodeUtil();
		if("".equals(mode_id)||"".equals(bill_id)){
			return "fail";
		}
		String modeId = mode_id;
		String billId = bill_id;
		String mapMainid="";
		String tableName="";
		String sql="select id from uf_des_mapping  where workflowid in (select formid from modeinfo where id='"+modeId+"') and isactive=0";
		rs.executeSql(sql);
		if(rs.next()){
			mapMainid = Util.null2String(rs.getString("id"));
		}
		sql="select b.tablename from modeinfo a,workflow_bill b where a.formid=b.id and a.id="+modeId;
		rs.executeSql(sql);
		if(rs.next()){
			tableName = Util.null2String(rs.getString("tablename"));
		}
		if(!"".equals(tableName)&&!"".equals(mapMainid)){
			sql = "select * from uf_des_mapping_dt1 where mainid = " + mapMainid;
			rs.executeSql(sql);
			while(rs.next()){
				String fieldname = Util.null2String(rs.getString("filedname"));
				String ftype = Util.null2String(rs.getString("ftype"));
				
				if("clob".equalsIgnoreCase(ftype)||"blob".equalsIgnoreCase(ftype)){
					eu.doClob(fieldname,getFiledName(fieldname),tableName,"id",billId);
				}else{
					eu.doOther(fieldname,getFiledName(fieldname),tableName,"id",billId);
				}
			}
		}
		return "success";
	}
}
