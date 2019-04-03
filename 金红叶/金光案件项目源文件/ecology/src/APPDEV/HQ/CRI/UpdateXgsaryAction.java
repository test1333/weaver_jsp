package APPDEV.HQ.CRI;

import java.util.ArrayList;

import APPDEV.HQ.DECODE.EncodeModeAction;
import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

/**
 * 涉案人员: 更新当前涉案人员到相关涉案人员
 * @author Administrator
 *
 */
public class UpdateXgsaryAction extends BaseBean implements Action {

	public String execute(RequestInfo requestInfo) {
		
		int billid = Util.getIntValue(requestInfo.getRequestid());
		int modeid = Util.getIntValue(requestInfo.getWorkflowid());
		writeLog("billidss:"+billid+",modeid:"+modeid);
		RecordSet rs = new RecordSet();
		RecordSet rs1 = new RecordSet();
		 
		String saryid = "";       //涉案人员
		String glry = "";         //关联人员
		String ssdw = "";         //所属单位
		String qtgldw = "";       //其他关联单位
		
		String ssajbt = "";       //所属案件
		String hmd = "";          //黑名单
		String jkmd = "";         //监控名单
		
		String sql = "select * from uf_hq_cri_involpers where id = "+billid;
		rs.executeSql(sql);
		if(rs.next()) {
			saryid = rs.getString("id");  
			glry = rs.getString("glry");  
			ssdw = rs.getString("ssdw");
			qtgldw = rs.getString("qtgldw");
			ssajbt = rs.getString("ssajbt");
			hmd = rs.getString("hmd");
			jkmd = rs.getString("jkmd");
		}
		
		
		//1:先把涉案人员关联的相关涉案人员清空掉开始
		sql = "select * from uf_hq_cri_involpers where ','||xgsary||',' like '%,"+saryid+",%' ";
		rs.executeSql(sql);
		while(rs.next()){
			int idtmp = rs.getInt("id");
			String xgsarytmp = rs.getString("xgsary");
			String xgsarytmps = "";
			ArrayList xgsarytmplist = Util.TokenizerString(xgsarytmp, ",");	
			if(saryid.equals(xgsarytmp) && xgsarytmplist.size() == 1){  //相关涉案人员只有一个并且跟当前涉案人员相同时
				sql = "update uf_hq_cri_involpers set xgsary = null where id = " +idtmp;
				rs1.executeSql(sql);
			} else { //相关涉案人员有多个					
				for(int j=0; j < xgsarytmplist.size(); j++){
					String xgsarytmpstr = (String)xgsarytmplist.get(j);
					if(!saryid.equals(xgsarytmpstr)){
						xgsarytmps += xgsarytmpstr + ",";
					}
				}
				if(!"".equals(xgsarytmps)) {
					sql = "update uf_hq_cri_involpers set xgsary = '"+xgsarytmps.substring(0, xgsarytmps.length()-1)+"' where id = " +idtmp;
					rs1.executeSql(sql);
				}
			}
		}
		//先把涉案人员关联的相关涉案人员清空掉结束
		
		//关联人员关联的相关涉案人员新增（开始）
		ArrayList glrylist = Util.TokenizerString(glry, ",");
		for(int i=0; i < glrylist.size(); i++){
			String glrystr = (String)glrylist.get(i);
			String xgsary = ""; //历史相关涉案人员
			sql = "select xgsary from uf_hq_cri_involpers where id = '"+glrystr+"'";
			rs.executeSql(sql);
			if(rs.next()){
				xgsary = Util.null2String(rs.getString(1));
				if(!"".equals(xgsary)){ //历史相关涉案人员不为空时判断当前涉案人员是否已经存在
					String xgsarytmp = ","+rs.getString(1)+",";
					if(xgsarytmp.indexOf((","+saryid+",")) < 0 ) {  //如果不存在就加到以前数据后面
						xgsary = xgsary + ","+saryid;
					}
				} else {  //历史相关涉案人员为空就直接赋值当前涉案人员
					xgsary = saryid;
				}		
				//更新当前涉案人员到相关涉案人员字段中
				sql = "update uf_hq_cri_involpers set xgsary = '"+xgsary+"' where id = " +glrystr;
				rs1.executeSql(sql);
			}						
		}
		//关联人员关联的相关涉案人员新增(结束)
		
		
		//2:先把所属单位关联的涉案单位中的所属人员清空掉开始
		sql = "select * from uf_hq_cri_involcomp where ','||ssry||',' like '%,"+saryid+",%' ";
		rs.executeSql(sql);
		while(rs.next()){
			int idtmp = rs.getInt("id");
			String ssrytmp = rs.getString("ssry");
			String ssrytmps = "";
			ArrayList ssrytmplist = Util.TokenizerString(ssrytmp, ",");	
			if(saryid.equals(ssrytmp) && ssrytmplist.size() == 1){  //所属人员只有一个并且跟当前涉案人员相同时
				sql = "update uf_hq_cri_involcomp set ssry = null where id = " +idtmp;
				rs1.executeSql(sql);
			} else { //所属人员有多个	
				for(int j=0; j < ssrytmplist.size(); j++){
					String ssrytmpstr = (String)ssrytmplist.get(j);
					if(!saryid.equals(ssrytmpstr)){
						ssrytmps += ssrytmpstr + ",";
					}
				}
				if(!"".equals(ssrytmps)){
					sql = "update uf_hq_cri_involcomp set ssry = '"+ssrytmps.substring(0, ssrytmps.length()-1)+"' where id = " +idtmp;
					rs1.executeSql(sql);
				}
			}
		}
		//先把所属单位关联的涉案单位中的所属人员清空掉结束
		
		//更新所属单位到涉案单位的所属人员中新增(开始)
		ArrayList ssdwlist = Util.TokenizerString(ssdw, ",");
		for(int i=0; i < ssdwlist.size(); i++){
			String ssdwstr = (String)ssdwlist.get(i);
			String lsssry = "";    //历史所属人员
			sql = "select ssry from uf_hq_cri_involcomp where id = '"+ssdwstr+"'";
			rs.executeSql(sql);
			if(rs.next()){
				lsssry = Util.null2String(rs.getString(1));
				if(!"".equals(lsssry)){ //历史所属人员不为空时判断当前涉案人员是否已经存在
					String lsssrytmp = ","+rs.getString(1)+",";
					if(lsssrytmp.indexOf((","+saryid+",")) < 0 ) {  //如果不存在就加到以前数据后面
						lsssry = lsssry + ","+saryid;
					}
				} else {  //历史所属人员为空就直接赋值当前涉案人员
					lsssry = saryid;
				}		
				//更新当前涉案人员到相关涉案人员字段中
				sql = "update uf_hq_cri_involcomp set ssry = '"+lsssry+"' where id = " +ssdwstr;
				rs1.executeSql(sql);
			}						
		}
		//更新所属单位到涉案单位的所属人员中新增（结束)
		
		
		//3:先把其他关联单位关联到涉案单位里的其他关联人员清空掉开始
		sql = "select * from uf_hq_cri_involcomp where ','||qtglry||',' like '%,"+saryid+",%' ";
		rs.executeSql(sql);
		while(rs.next()){
			int idtmp = rs.getInt("id");
			String qtglrytmp = rs.getString("qtglry");
			String qtglrytmps = "";
			ArrayList qtglrytmplist = Util.TokenizerString(qtglrytmp, ",");	
			if(saryid.equals(qtglrytmp) && qtglrytmplist.size() == 1){  //其他关联人员只有一个并且跟当前涉案人员相同时
				sql = "update uf_hq_cri_involcomp set qtglry = null where id = " +idtmp;
				rs1.executeSql(sql);
			} else { //其他关联人员有多个	
				for(int j=0; j < qtglrytmplist.size(); j++){
					String qtglrytmpstr = (String)qtglrytmplist.get(j);
					if(!saryid.equals(qtglrytmpstr)){
						qtglrytmps += qtglrytmpstr + ",";
					}
				}
				if(!"".equals(qtglrytmps)) {
					sql = "update uf_hq_cri_involcomp set qtglry = '"+qtglrytmps.substring(0, qtglrytmps.length()-1)+"' where id = " +idtmp;
					rs1.executeSql(sql);
				}
			}
		}
		//先把其他关联单位关联到涉案单位里的其他关联人员清空掉结束
		
		
		//更新其他关联单位到涉案单位中的其他关联人员新增(开始)
		ArrayList qtdwlist = Util.TokenizerString(qtgldw, ",");
		for(int i=0; i < qtdwlist.size(); i++){
			String qtdwstr = (String)qtdwlist.get(i);
			String lsqtglry = "";   //历史其他关联人员
			sql = " select qtglry from uf_hq_cri_involcomp where id = '"+qtdwstr+"'";
			rs.executeSql(sql);
			if(rs.next()){
				lsqtglry = Util.null2String(rs.getString(1));
				if(!"".equals(lsqtglry)){     //历史其他关联人员不为空时判断当前关联人员是否已经存在
					String qtglrytmp = ","+rs.getString(1)+",";
					if(qtglrytmp.indexOf((","+saryid+",")) < 0 ) {  //如果不存在就加到以前数据后面
						lsqtglry = lsqtglry + ","+saryid;
					}
				} else {  //历史其他关联人员为空就直接赋值其他关联人员
					lsqtglry = saryid;
				}		
				//更新当前人员到涉案单位的其他关联人员字段中
				sql = "update uf_hq_cri_involcomp set qtglry = '"+lsqtglry+"' where id = " +qtdwstr;
				rs1.executeSql(sql);
			}						
		}
		//更新其他关联单位到涉案单位中的其他关联人员新增（结束)
		
		EncodeModeAction encodeModeAction = new EncodeModeAction();
		encodeModeAction.doEncodeData(""+modeid,""+billid);
		
		return Action.SUCCESS;
	}
}
