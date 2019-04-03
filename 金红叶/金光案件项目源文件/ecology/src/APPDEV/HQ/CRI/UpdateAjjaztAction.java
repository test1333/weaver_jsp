package APPDEV.HQ.CRI;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.TimeUtil;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

/**
 * 更新案件报告流程的结案状态至调查报告和案件详情的对应结案状态
 * @author Administrator
 *
 */
public class UpdateAjjaztAction extends BaseBean implements Action {
	
	private String hq_cri_sysrole = "";
	private String hq_cri_modeid = "";

	public String getHq_cri_sysrole() {
		return hq_cri_sysrole;
	}

	public String getHq_cri_modeid() {
		return hq_cri_modeid;
	}

	public void setHq_cri_modeid(String hq_cri_modeid) {
		this.hq_cri_modeid = hq_cri_modeid;
	}

	public void setHq_cri_sysrole(String hq_cri_sysrole) {
		this.hq_cri_sysrole = hq_cri_sysrole;
	}
	
	public String execute(RequestInfo request) {
		RecordSet rs = new RecordSet();
		String requestid = request.getRequestid();
		String src = request.getRequestManager().getSrc();
		String formTableName = request.getRequestManager().getBillTableName();
		String currdate = TimeUtil.getCurrentDateString();
		
		if("submit".equals(src)){
			try {
				String sql = " select * from "+formTableName+" where requestid = '"+requestid+"' ";
				rs.executeSql(sql);
				if(rs.next()){
					String xmbh = Util.null2String(rs.getString("xmbh"));       //项目编号
					String ajjazt = Util.null2String(rs.getString("jazt"));     //结案状态
					String risklevel = Util.null2String(rs.getString("risklevel"));//风险等级
					String ajcslb = Util.null2String(rs.getString("ajcslb"));   //案件查实类别
					sql = " update uf_hq_cri_investiga set risklevel='"+risklevel+"',jazt = '"+ajjazt+"',jasj='"+currdate+"',zt='1',ajcslb = '"+ajcslb+"' where xmbh = '"+xmbh+"' "; 
					rs.executeSql(sql);
					sql = " update uf_hq_cri_casedp set risklevel='"+risklevel+"',jazt = '"+ajjazt+"',jasj='"+currdate+"',zt='1',ajcslb='"+ajcslb+"' where xmbh = '"+xmbh+"' ";
					rs.executeSql(sql);
					
					//案件详情等页面在结案后只有CRI的系统管理员能修改，其他人员不可再更改
					if(!"".equals(ajjazt)) {
						sql = "update modedatashare_"+hq_cri_modeid+" set sharelevel = 1 where sourceid = (select id from uf_hq_cri_casedp where xmbh='"+xmbh+"')";
						rs.executeSql(sql);
						sql = "update modedatashare_"+hq_cri_modeid+" set sharelevel = 3 where type = 4 and opuser = '"+hq_cri_sysrole+"' and sourceid = (select id from uf_hq_cri_casedp where xmbh='"+xmbh+"')";
						rs.executeSql(sql);
					}
					
				}
			} catch(Exception e) {
				request.getRequestManager().setMessageid(requestid+"-"+TimeUtil.getCurrentTimeString());  //提醒信息id
				request.getRequestManager().setMessagecontent("更新案件报告流程的结案状态:"+e+",流程不允许 提交到下一个节点");  //提醒信息内容
			}
		}
		return Action.SUCCESS;
	}
}
