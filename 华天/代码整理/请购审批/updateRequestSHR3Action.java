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
		//log.writeLog("��ʱ����");
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
		sql="update tblcrequest set �����3='"+shr3+"',�������3='"+shrq+"',��˱��='3' where �빺�����='"+qgdbh+"'";
		//log.writeLog(sql);
		rsd.executeSql(sql);
		
		sql="update tblcrequest set �޸ı��='3',ɾ�����='3' where �빺�����='"+qgdbh+"' and �빺�����  not in("+qgdxcs+")";
		//log.writeLog(sql);
		rsd.executeSql(sql);
		 
		return SUCCESS;
	}
	
	public void updateDetailInfo(String th,String sl,String fx,String yt,String xqrq,String gx,String jhy,String bz,String qgdxc,String qgdbh){
		RecordSetDataSource rsd = new RecordSetDataSource("KIN_REQUEST");
		String sql="update tblcrequest set ͼ��='"+th+"',�빺����="+sl+",��׼����="+sl+",����='"+fx+"',��;='"+yt+"',�ƻ���������='"+xqrq+"',�����='"+gx+"',�ƻ�Ա='"+jhy+"',��ע='"+bz+"',ɾ�����='0'  where �빺�����='"+qgdbh+"' and �빺�����='"+qgdxc+"'";
		//log.writeLog(sql);
		rsd.executeSql(sql);
	}

}
