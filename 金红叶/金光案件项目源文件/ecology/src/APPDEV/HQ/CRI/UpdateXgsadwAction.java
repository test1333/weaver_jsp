package APPDEV.HQ.CRI;

import java.util.ArrayList;

import APPDEV.HQ.DECODE.EncodeModeAction;
import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

/**
 * 涉案单位: 更新相关涉案单位到相关涉案单位
 * @author Administrator
 *
 */

public class UpdateXgsadwAction extends BaseBean implements Action {
	
	public String execute(RequestInfo requestInfo) {
	
		int billid = Util.getIntValue(requestInfo.getRequestid());
		int modeid = Util.getIntValue(requestInfo.getWorkflowid());
		RecordSet rs = new RecordSet();
		RecordSet rs1 = new RecordSet();
		 
		String sadwid = "";       //涉案单位
		String gldw = "";         //关联单位
		
		String sql = "select id,gldw from uf_hq_cri_involcomp where id = "+billid;
		rs.executeSql(sql);
		if(rs.next()) {
			sadwid = rs.getString("id");  
			gldw = rs.getString("gldw");  
		}
		
		//先把涉案单位关联的相关涉案单位清空掉开始
		sql = "select * from uf_hq_cri_involcomp where ','||xgsadw||',' like '%,"+sadwid+",%' ";
		rs.executeSql(sql);
		while(rs.next()){
			int idtmp = rs.getInt("id");
			String xgsadwtmp = rs.getString("xgsadw");
			
			String xgsadwtmps = "";
			ArrayList xgsadwtmplist = Util.TokenizerString(xgsadwtmp, ",");
			if(sadwid.equals(xgsadwtmp) && xgsadwtmplist.size() == 1){  //相关涉案人员只有一个并且跟当前涉案人员相同时
				sql = "update uf_hq_cri_involcomp set xgsadw = null where id = " +idtmp;	
				rs1.executeSql(sql);
			} else { //相关涉案单位有多个					
				for(int j=0; j < xgsadwtmplist.size(); j++){
					String xgsadwtmpstr = (String)xgsadwtmplist.get(j);
					if(!sadwid.equals(xgsadwtmpstr)){
						xgsadwtmps += xgsadwtmpstr + ",";
					}
				}
				if(!"".equals(xgsadwtmps)) {
					sql = "update uf_hq_cri_involcomp set xgsadw = '"+xgsadwtmps.substring(0, xgsadwtmps.length()-1)+"' where id = " +idtmp;
					rs1.executeSql(sql);
				}
			}
		}
		//先把涉案单位关联的相关涉案单位清空掉结束
		
		ArrayList gldwlist = Util.TokenizerString(gldw, ",");
		for(int i=0; i < gldwlist.size(); i++){
			String gldwstr = (String)gldwlist.get(i);
			
			String xgsadw = ""; //历史相关涉案单位
			sql = "select xgsadw from uf_hq_cri_involcomp where id = '"+gldwstr+"'";
			rs.executeSql(sql);
			if(rs.next()){
				xgsadw = Util.null2String(rs.getString(1));
				if(!"".equals(xgsadw)){ //历史相关涉案单位不为空时判断当前涉案单位是否已经存在
					String xgsarytmp = ","+rs.getString(1)+",";
					//writeLog("xgsary1111:"+xgsarytmp.indexOf((","+saryid+",")));
					if(xgsarytmp.indexOf((","+sadwid+",")) < 0 ) {  //如果不存在就加到以前数据后面
						xgsadw = xgsadw + ","+sadwid;
					}
					//writeLog("xgsary2222:"+xgsary);
				} else {  //历史相关涉案单位为空就直接赋值当前涉案单位
					xgsadw = sadwid;
				}		
				//更新当前涉案单位到相关涉案单位字段中
				sql = "update uf_hq_cri_involcomp set xgsadw = '"+xgsadw+"' where id = " +gldwstr;
				rs1.executeSql(sql);
			}						
		}
		
		EncodeModeAction encodeModeAction = new EncodeModeAction();
		encodeModeAction.doEncodeData(""+modeid,""+billid);
		
		return Action.SUCCESS;
	}
	
}
