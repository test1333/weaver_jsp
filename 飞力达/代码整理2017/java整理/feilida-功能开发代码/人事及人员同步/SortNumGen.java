package feilida;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

public class SortNumGen implements Action {
	
	BaseBean log = new BaseBean();//����д����־�Ķ���
	public String execute(RequestInfo info) {
		log.writeLog("---------------SortNum-----------------");
		
		String workflowID = info.getWorkflowid();
		String requestid = info.getRequestid();//��ȡ��������ID��requestIDֵ
		
		RecordSet rs = new RecordSet();
		RecordSet rs_dt = new RecordSet();
		
		String tableName = "";
		String tableNamedt = "";
		String mainID = "";
		//����
		String BH = "";//���
		//��ϸ��
		String ID = "";
		String workflowid = "";
		
		String sql  = " Select tablename From Workflow_bill Where id in ("
				+ " Select formid From workflow_base Where id= "
				+ workflowID + ")";
		
		rs.execute(sql);
		if(rs.next()){
			tableName = Util.null2String(rs.getString("tablename"));
		}
		
		if(!"".equals(tableName)){
			tableNamedt = tableName + "_dt1";
			
			// ��ѯ����
			sql = "select * from "+tableName + " where requestid="+requestid;
			rs.execute(sql);
			if(rs.next()){
				BH = Util.null2String(rs.getString("BH"));
				mainID = Util.null2String(rs.getString("ID"));
			}
			
			//��ѯ��ϸ��
			sql = "select * from " + tableNamedt + " where mainid="+mainID;
			rs_dt.execute(sql);
			log.writeLog("��ѯ��ϸ��:" +sql);
			while(rs_dt.next()){
				ID = Util.null2String(rs_dt.getString("id"));
				
				String sql_up = " update formtable_main_5_dt1 set SQBHC = (select sortnum from (select id,'"+BH+"'||'-'||sort  " +
								" as sortnum from (select id,rownum as sort from formtable_main_5_dt1 where mainid in (select id" +
								" from formtable_main_5 where requestid = '"+requestid+"' ) order by id)) where id = "+ID+")" +
								" where id = "+ID+" ";
				rs.execute(sql_up);
				log.writeLog("��ϸ����Ÿ���:" +sql_up);

	       }
		}else{
			
			return "-1";
		}
		return SUCCESS;
	}

}
