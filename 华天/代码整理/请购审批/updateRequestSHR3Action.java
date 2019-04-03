package htkj.materiel;

import weaver.conn.RecordSet;
import weaver.conn.RecordSetDataSource;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

public class updateRequestSHR3Action implements Action{
	//BaseBean log = new BaseBean();
	public String execute(RequestInfo info) {
		//log.writeLog("来时测试");
		String requestid = info.getRequestid();
		String workflow_id = info.getWorkflowid();
		RecordSet rs = new RecordSet();
	    RecordSetDataSource rsd = new RecordSetDataSource("KIN_REQUEST");
		String tableName = "";
		String sql = "Select tablename,id From Workflow_bill Where id=(";
		sql += "Select formid From workflow_base Where id=" + workflow_id + ")";
		rs.executeSql(sql);
		if (rs.next()) {
			tableName = Util.null2String(rs.getString("tablename"));
		}
		String mainId = "";
		String qgdbh ="";
		String shr3 = "";
		String shrq = "";
		sql = "select id,qgdbh,shr3,to_char(sysdate,'yyyy-mm-dd HH24:mi:ss')||'.000' as shrq  from " + tableName + " where requestid= " + requestid;
		//log.writeLog(sql);
		rs.executeSql(sql);
		if (rs.next()) {
			mainId = Util.null2String(rs.getString("id"));
			qgdbh = Util.null2String(rs.getString("qgdbh"));
			shr3 = Util.null2String(rs.getString("shr3"));
			shrq = Util.null2String(rs.getString("shrq"));
		}
		sql="select workcode||' '||lastname as shr3 from hrmresource where id="+shr3;
		//log.writeLog(sql);
		rs.executeSql(sql);
		if (rs.next()) {
			shr3 = Util.null2String(rs.getString("shr3"));
		}
		String th ="";
		String sl ="";
		String fx ="";
		String yt ="";
		String xqrq ="";
		String gx ="";
		String jhy ="";
		String bz = "";
		String qgdxc = "";
		String flag="";
		String qgdxcs="";
		sql="select th,sl,fx,yt,case when xqrq is not null then xqrq||' 00:00:00.000' else xqrq end as xqrq,gx,jhy,bz,qgdxc from "+tableName+"_dt1 where mainid="+mainId;
		rs.executeSql(sql);
		//log.writeLog(sql);
		while(rs.next()){
			th = Util.null2String(rs.getString("th"));
			sl = Util.null2String(rs.getString("sl"));
			fx = Util.null2String(rs.getString("fx"));
			yt = Util.null2String(rs.getString("yt"));
			xqrq = Util.null2String(rs.getString("xqrq"));
			gx = Util.null2String(rs.getString("gx"));
			jhy = Util.null2String(rs.getString("jhy"));
			bz = Util.null2String(rs.getString("bz"));
			qgdxc = Util.null2String(rs.getString("qgdxc"));
			qgdxcs = qgdxcs+flag+qgdxc;
			updateDetailInfo(th,sl,fx,yt,xqrq,gx,jhy,bz,qgdxc,qgdbh);
			flag=",";
		}
		sql="update tblcrequest set 审核人3='"+shr3+"',审核日期3='"+shrq+"',审核标记='3' where 请购单编号='"+qgdbh+"'";
		//log.writeLog(sql);
		rsd.executeSql(sql);
		
		sql="update tblcrequest set 修改标记='3',删除标记='3' where 请购单编号='"+qgdbh+"' and 请购单项次  not in("+qgdxcs+")";
		//log.writeLog(sql);
		rsd.executeSql(sql);
		 
		return SUCCESS;
	}
	
	public void updateDetailInfo(String th,String sl,String fx,String yt,String xqrq,String gx,String jhy,String bz,String qgdxc,String qgdbh){
		RecordSetDataSource rsd = new RecordSetDataSource("KIN_REQUEST");
		String sql="update tblcrequest set 图号='"+th+"',请购数量="+sl+",批准数量="+sl+",方向='"+fx+"',用途='"+yt+"',计划来料日期='"+xqrq+"',工序号='"+gx+"',计划员='"+jhy+"',备注='"+bz+"',删除标记='0'  where 请购单编号='"+qgdbh+"' and 请购单项次='"+qgdxc+"'";
		//log.writeLog(sql);
		rsd.executeSql(sql);
	}

}
