package APPDEV.HQ.CRI;

import APPDEV.HQ.DECODE.EncodeModeAction;
import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.hrm.resource.ResourceComInfo;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

/**
 * 更新案件后续追踪处理结果和时间到对应的涉案人员
 * @author Administrator
 *
 */
public class UpdateAjhxzzjgAction extends BaseBean implements Action{

	public String execute(RequestInfo requestInfo) {
		
		int billid = Util.getIntValue(requestInfo.getRequestid());
		int modeid = Util.getIntValue(requestInfo.getWorkflowid());
		writeLog("billidss:"+billid+",modeid:"+modeid);		
		RecordSet rs = new RecordSet();
		RecordSet rs1 = new RecordSet();
		RecordSet rs2 = new RecordSet();
		String mainTable = "uf_hq_cri_citabapo";
		String detailTable = "uf_hq_cri_citabapo_dt1";
		String saryTable = "uf_hq_cri_involpers";
		String detailTable2 = "uf_hq_cri_involpers_dt2";
		String ajhxwork = "formtable_main_181";		
		String sql = " select * from "+mainTable+" where id = '"+billid+"' ";
		rs.executeSql(sql);
		int mainid = 0;
		String xmbh = "";
		String modedatacreater="";
		if(rs.next()){
			mainid = rs.getInt("id");
			xmbh = Util.null2String(rs.getString("xmbh"));
			modedatacreater=Util.null2String(rs.getString("modedatacreater"));
		}	
		String syslanguageid="";
		try {
			ResourceComInfo resourceComInfo=new ResourceComInfo();
			syslanguageid=resourceComInfo.getSystemLanguage(modedatacreater);//   7中文简体  8 英文  9中文繁体
		} catch (Exception e) {
			e.printStackTrace();
		}
		sql = " select * from "+ajhxwork+" where xmbh = '"+xmbh+"' ";
		rs.executeSql(sql);
		if(rs.next()){
			sql = " select * from "+detailTable+" where mainid = '"+mainid+"' ";
			rs.executeSql(sql);
			while(rs.next()){
				String xm = Util.null2String(rs.getString("xm"));
				String zzcljg = Util.null2String(rs.getString("zzcljg"));//备注
				String StaffDisciplined = Util.null2String(rs.getString("StaffDisciplined"));
				String cllx="";//处理类型
				String selectname="";// ~`~`7 协议离职`~`8 Cessation of Employment by Mutual Agreement`~`9 協議離職`~`~
				rs2.executeSql(" select t1.selectname from workflow_selectitem t1 , workflow_billfield t2 where t2.detailtable='"+detailTable+"' and t2.fieldname='StaffDisciplined' and t1.fieldid=t2.id and t1.selectvalue='"+StaffDisciplined+"' ");
				if(rs2.next()){
					selectname=rs2.getString("selectname");
				}
				if(!"".equals(selectname)){
					String[] array=selectname.split("`~`");
					if("7".equals(syslanguageid)){
						String name=array[1];
						cllx=(name.substring(2,name.length()));
					}
					if("8".equals(syslanguageid)){
						String name=array[2];		
						cllx=(name.substring(2,name.length()));
					}
					if("9".equals(syslanguageid)){
						String name=array[3];					
						cllx=(name.substring(2,name.length()));
					}
				}					
				sql = " select * from "+saryTable+" where id = '"+xm+"' ";
				rs1.executeSql(sql);
				int sarymainid = 0;
				if(rs1.next()){
					sarymainid = rs1.getInt("id");
					sql = " insert into "+detailTable2+" (mainid,grbljl,nr) values ('"+sarymainid+"','0','"+cllx+"+"+zzcljg+"') ";
					rs2.executeSql(sql);
				}
			}
		}		
		EncodeModeAction encodeModeAction = new EncodeModeAction();
		encodeModeAction.doEncodeData(""+modeid,""+billid);	
		return Action.SUCCESS;
	}
}
