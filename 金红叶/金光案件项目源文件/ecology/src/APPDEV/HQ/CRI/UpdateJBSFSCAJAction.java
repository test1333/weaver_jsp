package APPDEV.HQ.CRI;

import APPDEV.HQ.DECODE.EncodeModeAction;
import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

/**
 * 更新举报是否已创建案件
 * @author Administrator
 *
 */

public class UpdateJBSFSCAJAction extends BaseBean implements Action {
	
	public String execute(RequestInfo requestInfo) {
			
		int billid = Util.getIntValue(requestInfo.getRequestid());
		int modeid = Util.getIntValue(requestInfo.getWorkflowid());
		RecordSet rs = new RecordSet();
		RecordSet rs1 = new RecordSet();
		
		String sql = " select * from uf_hq_cri_noticeoao id = '"+billid+"' ";
		rs.executeSql(sql);
		if(rs.next()){
			String dyjbbh =  Util.null2String(rs.getString("dyjbbh"));    //对应举报编号
			sql = " select * from uf_hq_cri_reporthp where id = '"+dyjbbh+"' ";
			rs.executeSql(sql);
			if(rs.next()){
				sql = " update uf_hq_cri_reporthp set sfycjaj = '0' where id = '"+dyjbbh+"' ";
				rs1.executeSql(sql);
			}
			
		}
		
		EncodeModeAction encodeModeAction = new EncodeModeAction();
		encodeModeAction.doEncodeData(""+modeid,""+billid);
		
		return Action.SUCCESS;
		
	}
}
