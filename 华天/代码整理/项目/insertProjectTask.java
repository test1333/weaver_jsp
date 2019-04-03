package htkj.project;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

public class insertProjectTask implements Action{

	@Override
	public String execute(RequestInfo info) {
		BaseBean log = new BaseBean();
		String requestid = info.getRequestid();
		String workflow_id = info.getWorkflowid();
		RecordSet rs = new RecordSet();
		String tableName = "";
		String sql = "Select tablename From Workflow_bill Where id=(";
		sql += "Select formid From workflow_base Where id="+workflow_id+")";
		rs.executeSql(sql);
		if (rs.next()) {
			tableName = Util.null2String(rs.getString("tablename"));
		}
		 String id="";
		 String xmmc="";
		 if (!" ".equals(tableName)) {
				sql="Select id, xmmc from "+tableName+" where  requestId="+requestid;
				log.writeLog("sql1 ---------" + sql);
				rs.executeSql(sql);
				if(rs.next()){
					id =  Util.null2String(rs.getString("id"));
					xmmc = Util.null2String(rs.getString("xmmc"));
				}
				sql="select  content ,creator,startdate ,enddate,nvl(to_date(enddate,'yyyy-mm-dd')-to_date(startdate,'yyyy-mm-dd')+1,0) as workday  from "+tableName+"_dt1 where  mainid= "+id;
				rs.execute(sql);
				String sql1="";
				RecordSet rs1=new RecordSet();
				String content="";
				String creator="";
				String startdate="";
				String enddate="";
				String subject="";
				String workday="";
				while(rs.next()){
					content =  Util.null2String(rs.getString("content"));
					creator =  Util.null2String(rs.getString("creator"));
					startdate =  Util.null2String(rs.getString("startdate"));
					enddate =  Util.null2String(rs.getString("enddate"));
					workday = Util.null2String(rs.getString("workday"));
					if("0".equals(content)){
						subject="NPI��ʽ��PDS�ṩ";
					}
					if("1".equals(content)){
						subject="PDS����ʽ�棩����";
					}
					if("2".equals(content)){
						subject="�����ļ�����";
					}
					if("3".equals(content)){
						subject="BOM����";
					}
					if("4".equals(content)){
						subject="�����ļ��ƶ�";
					}
					if("5".equals(content)){
						subject="Die in tray����";
					}
					if("6".equals(content)){
						subject="���ֶ��ձ�";
					}
					if("7".equals(content)){
						subject="��������";
					}
					if("8".equals(content)){
						subject="Tray��ͼֽ";
					}
					if("9".equals(content)){
						subject="Laser Mark����";
					}
					if("10".equals(content)){
						subject="wafer Mapping/mark";
					}
					if("11".equals(content)){
						subject="�ɿ���Ҫ��";
					}
					if("12".equals(content)){
						subject="�ͻ�����Ҫ��";
					}
					if("13".equals(content)){
						subject="�����ͻ���Ʒ�������";
					}
					if("14".equals(content)){
						subject="�ͻ���֤";
					}
					if("15".equals(content)){
						subject="����пͻ�����Ľ���";
					}
					if("16".equals(content)){
						subject="�ͻ�������mapping�����ṩ";
					}
					if("17".equals(content)){
						subject="�����ϴ���mapping�ϴ�";
					}
					if("18".equals(content)){
						subject="MESϵͳ����";
					}
					if("19".equals(content)){
						subject="��ǩ��ӡ";
					}
					
					sql1="insert into Prj_TaskProcess(subject,Hrmid,Prjid,Begindate,enddate,begintime,endtime,actualbegintime,actualendtime,workday) values('"+subject+"','"+creator+"','"+xmmc+"','"+startdate+"','"+enddate+"','00:00','00:00','23:59','23:59',"+workday+")";
					rs1.execute(sql1);
					sql1="update Prj_ProjectInfo set status=5 where id='"+xmmc+"'";
					rs1.execute(sql1);
					
				}
		 }
		return SUCCESS;
	}

}
