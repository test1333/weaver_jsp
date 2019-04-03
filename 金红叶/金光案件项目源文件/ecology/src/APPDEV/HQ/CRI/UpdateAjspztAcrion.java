package APPDEV.HQ.CRI;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.TimeUtil;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

/**
 * 更新案件详情触发流程后审批完成即更新案件详情、案件记录对应状态
 * @author Administrator
 *
 */
public class UpdateAjspztAcrion extends BaseBean implements Action {
	
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
		RecordSet rs1 = new RecordSet();
		String requestid = request.getRequestid();
		String src = request.getRequestManager().getSrc();
		String formTableName = request.getRequestManager().getBillTableName();
		
		if("submit".equals(src)){
			try {
				String sql = " select * from "+formTableName+" where requestid = '"+requestid+"' ";
				rs.executeSql(sql);
				if(rs.next()){
					String xmbh = Util.null2String(rs.getString("xmbh"));       //项目编号
					String zt = Util.null2String(rs.getString("zt"));           //状态
					
					sql = " update uf_hq_cri_casedp set zt = '"+zt+"' where xmbh = '"+xmbh+"' ";
					rs1.executeSql(sql);
					
					sql = " update uf_hq_cri_ajbgjl set bgzt = '"+zt+"' where xmbh = '"+xmbh+"' and id = (select max(id) from uf_hq_cri_ajbgjl) ";
					rs1.executeSql(sql);
					
					//案件详情等页面在结案后只有CRI的系统管理员能修改，其他人员不可再更改
					if("1".equals(zt)) {
						sql = "update modedatashare_"+hq_cri_modeid+" set sharelevel = 1 where sourceid = (select id from uf_hq_cri_casedp where xmbh='"+xmbh+"')";
						rs1.executeSql(sql);
						sql = "update modedatashare_"+hq_cri_modeid+" set sharelevel = 3 where type = 4 and opuser = '"+hq_cri_sysrole+"' and sourceid = (select id from uf_hq_cri_casedp where xmbh='"+xmbh+"')";
						rs1.executeSql(sql);
					}					
				}
			} catch(Exception e) {
				request.getRequestManager().setMessageid(requestid+"-"+TimeUtil.getCurrentTimeString());  //提醒信息id
				request.getRequestManager().setMessagecontent("更新案件详情触发流程后审批完成即更新案件详情对应状态:"+e+",流程不允许 提交到下一个节点");  //提醒信息内容
			}
		}
		return Action.SUCCESS;
	}
	
}
