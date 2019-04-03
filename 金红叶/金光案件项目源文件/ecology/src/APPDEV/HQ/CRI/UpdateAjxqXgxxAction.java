package APPDEV.HQ.CRI;

import java.util.ArrayList;

import APPDEV.HQ.DECODE.EncodeModeAction;
import weaver.conn.RecordSet;
import weaver.formmode.setup.ModeRightInfo;
import weaver.general.BaseBean;
import weaver.general.TimeUtil;
import weaver.general.Util;
import weaver.hrm.User;
import weaver.hrm.report.schedulediff.HrmScheduleDiffUtil;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

/**
 * 案件详情：更新涉案人员、涉案单位所对应的相关字段
 * @author Administrator
 *
 */
public class UpdateAjxqXgxxAction extends BaseBean implements Action {
	
public String execute(RequestInfo requestInfo) {
		
		int billid = Util.getIntValue(requestInfo.getRequestid());
		int modeid = Util.getIntValue(requestInfo.getWorkflowid());
		
		RecordSet rs = new RecordSet();
		RecordSet rs1 = new RecordSet();
		 
		String ajid = "";         //案件id
		String sadw = "";         //涉案单位id
		String xmbh = "";         //项目编号
		String xmmc = "";         //项目名称
		String qtglry = "";       //其他关联人员
		String qtgldw = "";       //其他关联单位
		String zt = "";           //状态
		
		String dybjbdx = "";      //对应被举报对象
		String dyjbr = "";        //对应举报人
		String dyzr = "";         //对应证人
		String xydx= "";          //嫌疑对象
		String zr = "";           //证人
		int userid = 0;           //当前用户
		String glaj= "";          //关联案件
		
		String sql = "select * from uf_hq_cri_casedp where id = "+billid;
		rs.executeSql(sql);
		if(rs.next()) {
			ajid = rs.getString("id");  
			sadw = rs.getString("sadw");  
			xmbh = rs.getString("xmbh");  
			xmmc = rs.getString("xmmc");
			qtglry = rs.getString("qtglry");
			qtgldw = rs.getString("qtgldw");
			dybjbdx = rs.getString("dybjbdx");
			dyjbr = rs.getString("dyjbr");
			dyzr = rs.getString("dyzr");
			xydx = rs.getString("xydx");
			zr = rs.getString("zr");
			zt = rs.getString("zt");
			userid = rs.getInt("userid");
			glaj = rs.getString("glaj");
		}
		
		
		//1:先把案件详情关联的涉案单位所对应到的涉案单位中的所属案件清空掉开始
		sql = "select * from uf_hq_cri_involcomp where ','||ssaj||',' like '%,"+ajid+",%' ";
		rs.executeSql(sql);
		while(rs.next()){
			int idtmp = rs.getInt("id");
			String ssajtmp = rs.getString("ssaj");
			String ssajtmps = "";
			ArrayList ssajtmplist = Util.TokenizerString(ssajtmp, ",");
			if(ajid.equals(ssajtmp) && ssajtmplist.size() == 1){  //所属案件只有一个并且和涉案单位相同时
				sql = "update uf_hq_cri_involcomp set ssaj = null where id = " +idtmp;
				rs1.executeSql(sql);
			} else { //所属案件有多个	
				for(int j=0; j < ssajtmplist.size(); j++){
					String ssajtmpstr = (String)ssajtmplist.get(j);
					if(!ajid.equals(ssajtmpstr)){
						ssajtmps += ssajtmpstr + ",";
					}
				}
				if(!"".equals(ssajtmps)) {
					sql = "update uf_hq_cri_involcomp set ssaj = '"+ssajtmps.substring(0, ssajtmps.length()-1)+"' where id = " +idtmp;
					rs1.executeSql(sql);
				}
			}
		}
		//先把案件详情关联的涉案单位所对应到的涉案单位中的所属案件清空掉开始
		
		
		//更新案件详情的涉案单位到涉案单位中的所属案件新增(开始)
		ArrayList sadwlist = Util.TokenizerString(sadw, ",");
		for(int i=0; i < sadwlist.size(); i++){
			String sadwstr = (String)sadwlist.get(i);
			String lsssaj = "";       //历史所属案件
			sql = " select ssaj from uf_hq_cri_involcomp where id = '"+sadwstr+"' ";
			rs.executeSql(sql);
			if(rs.next()){
				lsssaj = Util.null2String(rs.getString(1));
				if(!"".equals(lsssaj)){     //历史所属案件不为空时判断所属案件是否已经存在
					String ssajtmp = ","+rs.getString(1)+",";
					if(ssajtmp.indexOf((","+ajid+",")) < 0 ) {  //如果不存在就加到以前数据后面
						lsssaj = lsssaj + ","+ajid;
					}
				} else {  //历史其他关联人员为空就直接赋值其他关联人员
					lsssaj = ajid;
				}		
				//更新当前人员到涉案单位的其他关联人员字段中
				sql = "update uf_hq_cri_involcomp set ssaj = '"+lsssaj+"' where id = " +sadwstr;
				rs1.executeSql(sql);
			}						
		}
		//更新案件详情的涉案单位到涉案单位中的所属案件新增(结束)
		
		
		//2:先把案件详情关联的 其他关联人员 所对应到的涉案人员中的其他关联案件清空掉开始
		sql = "select * from uf_hq_cri_involpers where ','||qtglaj||',' like '%,"+ajid+",%' ";
		rs.executeSql(sql);
		while(rs.next()){
			int idtmp = rs.getInt("id");
			String qtglajtmp = rs.getString("qtglaj");
			String qtglajtmps = "";
			ArrayList qtglajtmplist = Util.TokenizerString(qtglajtmp, ",");
			if(ajid.equals(qtglajtmp) && qtglajtmplist.size() == 1){  //其他关联案件案件只有一个并且和其他关联案件相同时
				sql = "update uf_hq_cri_involpers set qtglaj = null where id = " +idtmp;
				rs1.executeSql(sql);
			} else { //其他关联案件有多个	
				for(int j=0; j < qtglajtmplist.size(); j++){
					String qtglajtmpstr = (String)qtglajtmplist.get(j);
					if(!ajid.equals(qtglajtmpstr)){
						qtglajtmps += qtglajtmpstr + ",";
					}
				}
				if(!"".equals(qtglajtmps)) {
					sql = "update uf_hq_cri_involpers set qtglaj = '"+qtglajtmps.substring(0, qtglajtmps.length()-1)+"' where id = " +idtmp;
					rs1.executeSql(sql);
				}
			}
		}
		//先把案件详情关联的 其他关联人员 所对应到的涉案人员中的其他关联案件清空掉结束
		
		
		//更新案件详情的 其他关联 到涉案人员中的其他关联案件新增(开始)
		ArrayList qtglrylist = Util.TokenizerString(qtglry, ",");
		for(int i=0; i < qtglrylist.size(); i++){
			String qtglrystr = (String)qtglrylist.get(i);
			String lsqtglaj = "";       //历史其他关联案件
			sql = " select qtglaj from uf_hq_cri_involpers where id = '"+qtglrystr+"' ";
			rs.executeSql(sql);
			if(rs.next()){
				lsqtglaj = Util.null2String(rs.getString(1));
				if(!"".equals(lsqtglaj)){     //历史其他关联案件不为空时判断其他案件是否已经存在
					String qtglajtmp = ","+rs.getString(1)+",";
					if(qtglajtmp.indexOf((","+ajid+",")) < 0 ) {  //如果不存在就加到以前数据后面
						lsqtglaj = lsqtglaj + ","+ajid;
					}
				} else {  //历史其他关联人员为空就直接赋值其他关联人员
					lsqtglaj = ajid;
				}		
				//更新当前人员到涉案单位的其他关联人员字段中
				sql = "update uf_hq_cri_involpers set qtglaj = '"+lsqtglaj+"' where id = " +qtglrystr;
				rs1.executeSql(sql);
			}						
		}
		//更新案件详情的 其他关联人员 到涉案人员中的其他关联案件新增(结束)
		
		

		//3:先把案件详情关联的 其他关联单位 所对应到的涉案单位中的其他关联案件清空掉开始
		sql = "select * from uf_hq_cri_involcomp where ','||qtglaj||',' like '%,"+ajid+",%' ";
		rs.executeSql(sql);
		while(rs.next()){
			int idtmp = rs.getInt("id");
			String qtglajtmp = rs.getString("qtglaj");
			String qtglajtmps = "";
			ArrayList qtglajtmplist = Util.TokenizerString(qtglajtmp, ",");
			if(ajid.equals(qtglajtmp) && qtglajtmplist.size() == 1){  //其他关联案件案件只有一个并且和其他关联案件相同时
				sql = "update uf_hq_cri_involcomp set qtglaj = null where id = " +idtmp;
				rs1.executeSql(sql);
			} else { //其他关联案件有多个	
				for(int j=0; j < qtglajtmplist.size(); j++){
					String qtglajtmpstr = (String)qtglajtmplist.get(j);
					if(!ajid.equals(qtglajtmpstr)){
						qtglajtmps += qtglajtmpstr + ",";
					}
				}
				if(!"".equals(qtglajtmps)) {
					sql = "update uf_hq_cri_involcomp set qtglaj = '"+qtglajtmps.substring(0, qtglajtmps.length()-1)+"' where id = " +idtmp;
					rs1.executeSql(sql);
				}
			}
		}
		//先把案件详情关联的 其他关联单位 所对应到的涉案单位中的其他关联案件清空掉开始
		
		
		//更新案件详情的其他关联单位 到涉案单位中的其他关联案件新增(开始)
		ArrayList qtgldwlist = Util.TokenizerString(qtgldw, ",");
		for(int i=0; i < qtgldwlist.size(); i++){
			String qtglajstr = (String)qtgldwlist.get(i);
			String lsqtglaj = "";       //历史其他关联案件
			sql = " select qtglaj from uf_hq_cri_involcomp where id = '"+qtglajstr+"' ";
			rs.executeSql(sql);
			if(rs.next()){
				lsqtglaj = Util.null2String(rs.getString(1));
				if(!"".equals(lsqtglaj)){     //历史其他关联案件不为空时判断其他案件是否已经存在
					String qtglajtmp = ","+rs.getString(1)+",";
					if(qtglajtmp.indexOf((","+ajid+",")) < 0 ) {  //如果不存在就加到以前数据后面
						lsqtglaj = lsqtglaj + ","+ajid;
					}
				} else {  //历史其他关联人员为空就直接赋值其他关联人员
					lsqtglaj = ajid;
				}		
				//更新当前人员到涉案单位的其他关联人员字段中
				sql = "update uf_hq_cri_involcomp set qtglaj = '"+lsqtglaj+"' where id = " +qtglajstr;
				rs1.executeSql(sql);
			}						
		}
		//更新案件详情的其他关联单位 到涉案单位中的其他关联案件新增(结束)
		
		
		//4、先把案件详情关联的相关关联案件清空掉开始
		sql = "select * from uf_hq_cri_casedp where ','||xgglaj||',' like '%,"+ajid+",%' ";
		rs.executeSql(sql);
		while(rs.next()){
			int idtmp = rs.getInt("id");
			String xgglajtmp = rs.getString("xgglaj");
			String xgglajtmps = "";
			ArrayList xgglajtmplist = Util.TokenizerString(xgglajtmp, ",");
			if(ajid.equals(xgglajtmp) && xgglajtmplist.size() == 1){  //相关关联案件只有一个并且跟当前关联案件相同时
				sql = "update uf_hq_cri_casedp set xgglaj = null where id = " +idtmp;
				rs1.executeSql(sql);
			} else { //相关关联案件有多个
				for(int j=0; j < xgglajtmplist.size(); j++){
					String xgglajtmpstr = (String)xgglajtmplist.get(j);
					if(!ajid.equals(xgglajtmpstr)){
						xgglajtmps += xgglajtmpstr + ",";
					}
				}
				if(!"".equals(xgglajtmps)) {
					sql = "update uf_hq_cri_casedp set xgglaj = '"+xgglajtmps.substring(0, xgglajtmps.length()-1)+"' where id = " +idtmp;
					rs1.executeSql(sql);
				}
			}
		}
		//先把案件详情关联的相关关联案件清空掉结束
		
		//更新案件详情的相关案件到案件详情的相关关联案件新增(开始)
		ArrayList glajlist = Util.TokenizerString(glaj, ",");
		for(int i=0; i < glajlist.size(); i++){
			String glajstr = (String)glajlist.get(i);
			String lsxgglaj = ""; //历史相关关联案件
			sql = " select xgglaj from uf_hq_cri_casedp where id = '"+glajstr+"' ";
			rs.executeSql(sql);
			if(rs.next()){
				lsxgglaj = Util.null2String(rs.getString(1));
				if(!"".equals(lsxgglaj)){ //历史相关关联案件不为空时判断相关案件是否已经存在
					String xgglajtmp = ","+rs.getString(1)+",";
					if(xgglajtmp.indexOf((","+ajid+",")) < 0 ) {  //如果不存在就加到以前数据后面
						lsxgglaj = lsxgglaj + ","+ajid;
					}
				} else {  //历史相关涉案人员为空就直接赋值当前涉案人员
					lsxgglaj = ajid;
				}		
				//更新当前涉案人员到相关涉案人员字段中
				sql = "update uf_hq_cri_casedp set xgglaj = '"+lsxgglaj+"' where id = " +glajstr;
				rs1.executeSql(sql);
			}						
		}		
		//更新案件详情的相关案件到案件详情的相关关联案件新增(结束 )
		
		
		//5、涉案人员所属案件标题拼接
		String xmbhname = "";
		rs.executeSql(" select xmbh from uf_hq_cri_noticeoao where id = '"+xmbh+"' ");
		if(rs.next()){
			xmbhname = Util.null2String(rs.getString("xmbh"));
		}
		
		//对应被举报对象
		BJBDXUpdate(dybjbdx,xmbhname,xmmc,billid);
		
		//对应举报证人
		JBZRUpdate(dyzr,xmbhname,xmmc,billid);
		
		//对应举报人
		JBRUpdate(dyjbr,xmbhname,xmmc,billid);
		
		//嫌疑对象
		XYDBUpdate(xydx,xmbhname,xmmc,billid);
		
		//证人
		ZRUpdate(zr,xmbhname,xmmc,billid);

		//案件后续追踪-对应被举报对象-黑名单
		JBDXHMD(xmbh,dybjbdx);
		
		//案件后续追踪-对应举报证人-黑名单
		JBZRHMD(xmbh,dyzr);
		
		//案件后续追踪-对应举报人-黑名单
		JBRHMD(xmbh,dyjbr);
		
		//案件后续追踪-嫌疑对象-黑名单
		XYDXHMD(xmbh,xydx);
		
		//证人-嫌疑对象-黑名单
		ZRHMD(xmbh,zr);
		
		
		//插入案件记录
		InertAjjl(billid,xmbh,xmmc,zt,userid);
		
		EncodeModeAction encodeModeAction = new EncodeModeAction();
		encodeModeAction.doEncodeData(""+modeid,""+billid);
		
		return Action.SUCCESS;
		
	}

	/**
	 * 证人
	 * @param zr
	 * @param xmbhname
	 * @param xmmc
	 * @param billid
	 */
	public void ZRUpdate(String zr,String xmbhname,String xmmc,int billid){
		RecordSet rs = new RecordSet();
		RecordSet rs1 = new RecordSet();
		String sql = "";
		String xgry = "证人";
		String ssajbtmc = billid + "@@@" + xmbhname + "@@@" + xmmc + "@@@" + xgry;    //所属案件标题
		
		//先把案件详情关联的证人所对应到的涉案人员中的所属案件清空掉开始
		sql = "select * from uf_hq_cri_involpers where ','||ssajbt||',' like '%,"+ssajbtmc+",%' ";
		rs.executeSql(sql);
		while(rs.next()){
			int idtmp = rs.getInt("id");
			String ssajtmp = rs.getString("ssajbt");
			String ssajtmps = "";
			ArrayList ssajtmplist = Util.TokenizerString(ssajtmp, ",");
			if(ssajbtmc.equals(ssajtmp) && ssajtmplist.size() == 1){  //所属案件只有一个并且案件详情相同
				sql = "update uf_hq_cri_involpers set ssajbt = null where id = " +idtmp;
				rs1.executeSql(sql);
			} else { //所属案件有多个	
				for(int j=0; j < ssajtmplist.size(); j++){
					String ssajtmpstr = (String)ssajtmplist.get(j);
					if(!ssajbtmc.equals(ssajtmpstr)){
						ssajtmps += ssajtmpstr + ",";
					}
				}
				if(!"".equals(ssajtmps)) {
					sql = "update uf_hq_cri_involpers set ssajbt = '"+ssajtmps.substring(0, ssajtmps.length()-1)+"' where id = " +idtmp;
					rs1.executeSql(sql);
				}
			}
		}
		//先把案件详情关联的证人所对应到的涉案人员中的所属案件清空掉开始
		
		//更新案件详情的对应证人到涉案人员中的所属案件新增(开始)
		ArrayList dyjbrlist = Util.TokenizerString(zr, ",");
		for(int i=0; i < dyjbrlist.size(); i++){
			String ssajbtstr = (String)dyjbrlist.get(i);
			String lsssaj = "";       //历史所属案件
			sql = " select ssajbt from uf_hq_cri_involpers where id = '"+ssajbtstr+"' ";
			rs.executeSql(sql);
			if(rs.next()){
				lsssaj = Util.null2String(rs.getString(1));
				if(!"".equals(lsssaj)){          //历史所属案件不为空时判断所属案件是否已经存在
					String ssajtmp = ","+rs.getString(1)+",";
					if(ssajtmp.indexOf((","+ssajbtmc+",")) < 0 ) {  //如果不存在就加到以前数据后面
						lsssaj = lsssaj + ","+ssajbtmc;
					}
				} else {  //历史所属案件为空就直接赋值所属案件
					lsssaj = ssajbtmc;
				}		
				//更新所属案件字段  
				sql = " update uf_hq_cri_involpers set ssajbt = '"+lsssaj+"' where id = '"+ssajbtstr+"' ";
				rs1.executeSql(sql);
			}						
		}
		//更新案件详情的对应证人到涉案人员中的所属案件新增(结束)
	}


	/**
	 * 嫌疑对象
	 * @param xydx
	 * @param xmbhname
	 * @param xmmc
	 * @param billid
	 */
	public void XYDBUpdate(String xydx,String xmbhname,String xmmc,int billid){
		RecordSet rs = new RecordSet();
		RecordSet rs1 = new RecordSet();
		String sql = "";
		String xgry = "嫌疑对象";
		String ssajbtmc = billid + "@@@" + xmbhname + "@@@" + xmmc + "@@@" + xgry;    //所属案件标题
		
		//先把案件详情关联的嫌疑对象所对应到的涉案人员中的所属案件清空掉开始
		sql = "select * from uf_hq_cri_involpers where ','||ssajbt||',' like '%,"+ssajbtmc+",%' ";
		rs.executeSql(sql);
		while(rs.next()){
			int idtmp = rs.getInt("id");
			String ssajtmp = rs.getString("ssajbt");
			String ssajtmps = "";
			ArrayList ssajtmplist = Util.TokenizerString(ssajtmp, ",");
			if(ssajbtmc.equals(ssajtmp) && ssajtmplist.size() == 1){  //所属案件只有一个并且案件详情相同
				sql = "update uf_hq_cri_involpers set ssajbt = null where id = " +idtmp;
				rs1.executeSql(sql);
			} else { //所属案件有多个	
				for(int j=0; j < ssajtmplist.size(); j++){
					String ssajtmpstr = (String)ssajtmplist.get(j);
					if(!ssajbtmc.equals(ssajtmpstr)){
						ssajtmps += ssajtmpstr + ",";
					}
				}
				if(!"".equals(ssajtmps)) {
					sql = "update uf_hq_cri_involpers set ssajbt = '"+ssajtmps.substring(0, ssajtmps.length()-1)+"' where id = " +idtmp;
					rs1.executeSql(sql);
				}
			}
		}
		//先把案件详情关联的嫌疑对象所对应到的涉案人员中的所属案件清空掉开始
		
		
		//更新案件详情的对应证人到涉案人员中的所属案件新增(开始)
		ArrayList dyjbrlist = Util.TokenizerString(xydx, ",");
		for(int i=0; i < dyjbrlist.size(); i++){
			String ssajbtstr = (String)dyjbrlist.get(i);
			String lsssaj = "";       //历史所属案件
			sql = " select ssajbt from uf_hq_cri_involpers where id = '"+ssajbtstr+"' ";
			rs.executeSql(sql);
			if(rs.next()){
				lsssaj = Util.null2String(rs.getString(1));
				if(!"".equals(lsssaj)){          //历史所属案件不为空时判断所属案件是否已经存在
					String ssajtmp = ","+rs.getString(1)+",";
					if(ssajtmp.indexOf((","+ssajbtmc+",")) < 0 ) {  //如果不存在就加到以前数据后面
						lsssaj = lsssaj + ","+ssajbtmc;
					}
				} else {  //历史所属案件为空就直接赋值所属案件
					lsssaj = ssajbtmc;
				}		
				//更新所属案件字段  
				sql = " update uf_hq_cri_involpers set ssajbt = '"+lsssaj+"' where id = '"+ssajbtstr+"' ";
				rs1.executeSql(sql);
			}						
		}
		//更新案件详情的对应证人到涉案人员中的所属案件新增(结束)
	}


	/**
	 * 对应被举报对象
	 * @param dybjbdx
	 * @param xmbhname
	 * @param xmmc
	 * @param billid
	 */
	public void BJBDXUpdate(String dybjbdx,String xmbhname,String xmmc,int billid){
		RecordSet rs = new RecordSet();
		RecordSet rs1 = new RecordSet();
		String sql = "";
		String xgry = "被举报对象";
		String ssajbtmc = billid + "@@@" + xmbhname + "@@@" + xmmc + "@@@" + xgry;    //所属案件标题
		
		//先把案件详情关联的对应被举报对象所对应到的涉案人员中的所属案件清空掉开始
		sql = "select * from uf_hq_cri_involpers where ','||ssajbt||',' like '%,"+ssajbtmc+",%' ";
		rs.executeSql(sql);
		while(rs.next()){
			int idtmp = rs.getInt("id");
			String ssajtmp = rs.getString("ssajbt");
			String ssajtmps = "";
			ArrayList ssajtmplist = Util.TokenizerString(ssajtmp, ",");
			if(ssajbtmc.equals(ssajtmp) && ssajtmplist.size() == 1){  //所属案件只有一个并且案件详情相同
				sql = "update uf_hq_cri_involpers set ssajbt = null where id = " +idtmp;
				rs1.executeSql(sql);
			} else { //所属案件有多个	
				for(int j=0; j < ssajtmplist.size(); j++){
					String ssajtmpstr = (String)ssajtmplist.get(j);
					if(!ssajbtmc.equals(ssajtmpstr)){
						ssajtmps += ssajtmpstr + ",";
					}
				}
				if(!"".equals(ssajtmps)) {
					sql = "update uf_hq_cri_involpers set ssajbt = '"+ssajtmps.substring(0, ssajtmps.length()-1)+"' where id = " +idtmp;
					rs1.executeSql(sql);
				}
			}
		}
		//先把案件详情关联的对应被举报对象所对应到的涉案人员中的所属案件清空掉结束
		
		//更新案件详情的对应证人到涉案人员中的所属案件新增(开始)
		ArrayList dyjbrlist = Util.TokenizerString(dybjbdx, ",");
		for(int i=0; i < dyjbrlist.size(); i++){
			String ssajbtstr = (String)dyjbrlist.get(i);
			String lsssaj = "";       //历史所属案件
			sql = " select ssajbt from uf_hq_cri_involpers where id = '"+ssajbtstr+"' ";
			rs.executeSql(sql);
			if(rs.next()){
				lsssaj = Util.null2String(rs.getString(1));
				if(!"".equals(lsssaj)){          //历史所属案件不为空时判断所属案件是否已经存在
					String ssajtmp = ","+rs.getString(1)+",";
					if(ssajtmp.indexOf((","+ssajbtmc+",")) < 0 ) {  //如果不存在就加到以前数据后面
						lsssaj = lsssaj + ","+ssajbtmc;
					}
				} else {  //历史所属案件为空就直接赋值所属案件
					lsssaj = ssajbtmc;
				}		
				//更新所属案件字段  
				sql = " update uf_hq_cri_involpers set ssajbt = '"+lsssaj+"' where id = '"+ssajbtstr+"' ";
				rs1.executeSql(sql);
			}						
		}
		//更新案件详情的对应证人到涉案人员中的所属案件新增(结束)
	}


	/**
	 * 对应举报证人
	 * @param dyzr
	 * @param xmbhname
	 * @param xmmc
	 * @param billid
	 */
	public void JBZRUpdate(String dyzr,String xmbhname,String xmmc,int billid){
		RecordSet rs = new RecordSet();
		RecordSet rs1 = new RecordSet();
		String sql = "";
		String xgry = "举报证人";
		String ssajbtmc = billid + "@@@" + xmbhname + "@@@" + xmmc + "@@@" + xgry;    //所属案件标题
		
		//先把案件详情关联的对应举报证人所对应到的涉案人员中的所属案件清空掉开始
		sql = "select * from uf_hq_cri_involpers where ','||ssajbt||',' like '%,"+ssajbtmc+",%' ";
		rs.executeSql(sql);
		while(rs.next()){
			int idtmp = rs.getInt("id");
			String ssajtmp = rs.getString("ssajbt");
			String ssajtmps = "";
			ArrayList ssajtmplist = Util.TokenizerString(ssajtmp, ",");
			if(ssajbtmc.equals(ssajtmp) && ssajtmplist.size() == 1){  //所属案件只有一个并且案件详情相同
				sql = "update uf_hq_cri_involpers set ssajbt = null where id = " +idtmp;
				rs1.executeSql(sql);
			} else { //所属案件有多个	
				for(int j=0; j < ssajtmplist.size(); j++){
					String ssajtmpstr = (String)ssajtmplist.get(j);
					if(!ssajbtmc.equals(ssajtmpstr)){
						ssajtmps += ssajtmpstr + ",";
					}
				}
				if(!"".equals(ssajtmps)) {
					sql = "update uf_hq_cri_involpers set ssajbt = '"+ssajtmps.substring(0, ssajtmps.length()-1)+"' where id = " +idtmp;
					rs1.executeSql(sql);
				}
			}
		}
		//先把案件详情关联的对应举报证人到的涉案人员中的所属案件清空掉结束
		
		//更新案件详情的对应证人到涉案人员中的所属案件新增(开始)
		ArrayList dyjbrlist = Util.TokenizerString(dyzr, ",");
		for(int i=0; i < dyjbrlist.size(); i++){
			String ssajbtstr = (String)dyjbrlist.get(i);
			String lsssaj = "";       //历史所属案件
			sql = " select ssajbt from uf_hq_cri_involpers where id = '"+ssajbtstr+"' ";
			rs.executeSql(sql);
			if(rs.next()){
				lsssaj = Util.null2String(rs.getString(1));
				if(!"".equals(lsssaj)){          //历史所属案件不为空时判断所属案件是否已经存在
					String ssajtmp = ","+rs.getString(1)+",";
					if(ssajtmp.indexOf((","+ssajbtmc+",")) < 0 ) {  //如果不存在就加到以前数据后面
						lsssaj = lsssaj + ","+ssajbtmc;
					}
				} else {  //历史所属案件为空就直接赋值所属案件
					lsssaj = ssajbtmc;
				}		
				//更新所属案件字段  
				
				sql = " update uf_hq_cri_involpers set ssajbt = '"+lsssaj+"' where id = '"+ssajbtstr+"' ";
				
				rs1.executeSql(sql);
			}						
		}
		//更新案件详情的对应证人到涉案人员中的所属案件新增(结束)
	}


	/**
	 * 对应举报人
	 * @param dyjbr
	 * @param xmbhname
	 * @param xmmc
	 */
	public void JBRUpdate(String dyjbr,String xmbhname,String xmmc,int billid){
		RecordSet rs = new RecordSet();
		RecordSet rs1 = new RecordSet();
		String sql = "";
		String xgry = "举报人";
		String ssajbtmc = billid + "@@@" + xmbhname + "@@@" + xmmc + "@@@" + xgry;
		
		//先把案件详情关联的对应举报人所对应到的涉案人员中的所属案件清空掉开始
		sql = "select * from uf_hq_cri_involpers where ','||ssajbt||',' like '%,"+ssajbtmc+",%' ";
		rs.executeSql(sql);
		while(rs.next()){
			int idtmp = rs.getInt("id");
			String ssajtmp = rs.getString("ssajbt");
			String ssajtmps = "";
			ArrayList ssajtmplist = Util.TokenizerString(ssajtmp, ",");
			if(ssajbtmc.equals(ssajtmp) && ssajtmplist.size() == 1){  //所属案件只有一个并且案件详情相同
				sql = "update uf_hq_cri_involpers set ssajbt = null where id = " +idtmp;
				rs1.executeSql(sql);
			} else { //所属案件有多个	
				for(int j=0; j < ssajtmplist.size(); j++){
					String ssajtmpstr = (String)ssajtmplist.get(j);
					if(!ssajbtmc.equals(ssajtmpstr)){
						ssajtmps += ssajtmpstr + ",";
					}
				}
				if(!"".equals(ssajtmps)) {
					sql = "update uf_hq_cri_involpers set ssajbt = '"+ssajtmps.substring(0, ssajtmps.length()-1)+"' where id = " +idtmp;
					rs1.executeSql(sql);
				}
			}
		}
		//先把案件详情关联的对应举报人所对应到的涉案人员中的所属案件清空掉结束
	
		//更新案件详情的对应举报人到涉案人员中的所属案件新增(开始)
		ArrayList dyjbrlist = Util.TokenizerString(dyjbr, ",");
		for(int i=0; i < dyjbrlist.size(); i++){
			String ssajbtstr = (String)dyjbrlist.get(i);
			String lsssaj = "";       //历史所属案件
			sql = " select ssajbt from uf_hq_cri_involpers where id = '"+ssajbtstr+"' ";
			rs.executeSql(sql);
			if(rs.next()){
				lsssaj = Util.null2String(rs.getString(1));
				if(!"".equals(lsssaj)){          //历史所属案件不为空时判断所属案件是否已经存在
					String ssajtmp = ","+rs.getString(1)+",";
					if(ssajtmp.indexOf((","+ssajbtmc+",")) < 0 ) {  //如果不存在就加到以前数据后面
						lsssaj = lsssaj + ","+ssajbtmc;
					}
				} else {  //历史其他关联人员为空就直接赋值其他关联人员
					lsssaj = ssajbtmc;
				}		
				//更新当前人员到涉案单位的其他关联人员字段中
				sql = "update uf_hq_cri_involpers set ssajbt = '"+lsssaj+"' where id = " +ssajbtstr;
				rs1.executeSql(sql);
			}						
		}
		//更新案件详情的对应举报人到涉案人员中的所属案件新增(结束)
	}
	
	/**
	 * 被举报对象-黑名单&监控名单
	 * @param dybjbdx
	 */
	public void JBDXHMD(String xmbh,String dybjbdx){
		RecordSet rs = new RecordSet();
		RecordSet rs1 = new RecordSet();
		String sql = "";
		writeLog("HXZZ");
		
		//案件后续追踪的历史黑名单
		String lshmd = "";
		String lsjkmd = "";
		sql = " select hmd,jhmd from uf_hq_cri_citabapo where xmbh = '"+xmbh+"' ";
		rs.executeSql(sql);
		if(rs.next()){
			lshmd = Util.null2String(rs.getString(1));    //历史黑名单
			lsjkmd = Util.null2String(rs.getString(2));   //历史监控名单
			
			ArrayList sarylist = Util.TokenizerString(dybjbdx, ",");
			for(int i=0; i < sarylist.size(); i++){
				String sarystr = (String)sarylist.get(i);
				sql = " select hmd,jkmd from uf_hq_cri_involpers where id = '"+sarystr+"' ";
				rs1.executeSql(sql);
				if(rs1.next()){
					String sfhmd = Util.null2String(rs1.getString(1));   //涉案人员是否黑名单
					String sfjkmd = Util.null2String(rs1.getString(2));  //涉案人员是否监控名单
					if("0".equals(sfhmd)){
						if(!"".equals(lshmd)){
							String hmdtemp = ','+rs.getString(1)+',';
							if(hmdtemp.indexOf(','+dybjbdx+',')<0){
								lshmd = lshmd + ',' + dybjbdx;
							}
						}else{
							lshmd = dybjbdx;
						}
						//更新被举报对象到案件后续追踪的黑名单
						sql = " update uf_hq_cri_citabapo set hmd = '"+lshmd+"' where xmbh = '"+xmbh+"' ";
						rs1.executeSql(sql);	
					}
					
					if("0".equals(sfjkmd)){
						if(!"".equals(lsjkmd)){
							String hmdtemp = ','+rs.getString(1)+',';
							if(hmdtemp.indexOf(','+dybjbdx+',')<0){
								lsjkmd = lsjkmd + ',' + dybjbdx;
							}
						}else{
							lsjkmd = dybjbdx;
						}
						//更新被举报对象到案件后续追踪的监控名单
						sql = " update uf_hq_cri_citabapo set jhmd = '"+lsjkmd+"' where xmbh = '"+xmbh+"' ";
						rs1.executeSql(sql);
					}
				}						
			}
		}			
	}
	
	
	/**
	 * 对应举报证人-黑名单&监控名单
	 * @param dybjbdx
	 */
	public void JBZRHMD(String xmbh,String dyzr){
		RecordSet rs = new RecordSet();
		RecordSet rs1 = new RecordSet();
		String sql = "";
		writeLog("HXZZ");
		
		//案件后续追踪的历史黑名单
		String lshmd = "";
		String lsjkmd = "";
		sql = " select hmd,jhmd from uf_hq_cri_citabapo where xmbh = '"+xmbh+"' ";
		rs.executeSql(sql);
		if(rs.next()){
			lshmd = Util.null2String(rs.getString(1));    //历史黑名单
			lsjkmd = Util.null2String(rs.getString(2));   //历史监控名单
			
			ArrayList sarylist = Util.TokenizerString(dyzr, ",");
			for(int i=0; i < sarylist.size(); i++){
				String sarystr = (String)sarylist.get(i);
				sql = " select hmd,jkmd from uf_hq_cri_involpers where id = '"+sarystr+"' ";
				rs1.executeSql(sql);
				if(rs1.next()){
					String sfhmd = Util.null2String(rs1.getString(1));   //涉案人员是否黑名单
					String sfjkmd = Util.null2String(rs1.getString(2));  //涉案人员是否监控名单
					if("0".equals(sfhmd)){
						if(!"".equals(lshmd)){
							String hmdtemp = ','+rs.getString(1)+',';
							if(hmdtemp.indexOf(','+dyzr+',')<0){
								lshmd = lshmd + ',' + dyzr;
							}
						}else{
							lshmd = dyzr;
						}
						//更新被举报对象到案件后续追踪的黑名单
						sql = " update uf_hq_cri_citabapo set hmd = '"+lshmd+"' where xmbh = '"+xmbh+"' ";
						rs1.executeSql(sql);	
					}
					
					if("0".equals(sfjkmd)){
						if(!"".equals(lsjkmd)){
							String hmdtemp = ','+rs.getString(1)+',';
							if(hmdtemp.indexOf(','+dyzr+',')<0){
								lsjkmd = lsjkmd + ',' + dyzr;
							}
						}else{
							lsjkmd = dyzr;
						}
						//更新被举报对象到案件后续追踪的监控名单
						sql = " update uf_hq_cri_citabapo set jhmd = '"+lsjkmd+"' where xmbh = '"+xmbh+"' ";
						rs1.executeSql(sql);
					}
				}						
			}
		}			
	}
	
	
	/**
	 * 对应举报人-黑名单&监控名单
	 * @param dybjbdx
	 */
	public void JBRHMD(String xmbh,String dyjbr){
		RecordSet rs = new RecordSet();
		RecordSet rs1 = new RecordSet();
		String sql = "";
		writeLog("HXZZ");
		
		//案件后续追踪的历史黑名单
		String lshmd = "";
		String lsjkmd = "";
		sql = " select hmd,jhmd from uf_hq_cri_citabapo where xmbh = '"+xmbh+"' ";
		rs.executeSql(sql);
		if(rs.next()){
			lshmd = Util.null2String(rs.getString(1));    //历史黑名单
			lsjkmd = Util.null2String(rs.getString(2));   //历史监控名单
			
			ArrayList sarylist = Util.TokenizerString(dyjbr, ",");
			for(int i=0; i < sarylist.size(); i++){
				String sarystr = (String)sarylist.get(i);
				sql = " select hmd,jkmd from uf_hq_cri_involpers where id = '"+sarystr+"' ";
				rs1.executeSql(sql);
				if(rs1.next()){
					String sfhmd = Util.null2String(rs1.getString(1));   //涉案人员是否黑名单
					String sfjkmd = Util.null2String(rs1.getString(2));  //涉案人员是否监控名单
					if("0".equals(sfhmd)){
						if(!"".equals(lshmd)){
							String hmdtemp = ','+rs.getString(1)+',';
							if(hmdtemp.indexOf(','+dyjbr+',')<0){
								lshmd = lshmd + ',' + dyjbr;
							}
						}else{
							lshmd = dyjbr;
						}
						//更新被举报对象到案件后续追踪的黑名单
						sql = " update uf_hq_cri_citabapo set hmd = '"+lshmd+"' where xmbh = '"+xmbh+"' ";
						rs1.executeSql(sql);	
					}
					
					if("0".equals(sfjkmd)){
						if(!"".equals(lsjkmd)){
							String hmdtemp = ','+rs.getString(1)+',';
							if(hmdtemp.indexOf(','+dyjbr+',')<0){
								lsjkmd = lsjkmd + ',' + dyjbr;
							}
						}else{
							lsjkmd = dyjbr;
						}
						//更新被举报对象到案件后续追踪的监控名单
						sql = " update uf_hq_cri_citabapo set jhmd = '"+lsjkmd+"' where xmbh = '"+xmbh+"' ";
						rs1.executeSql(sql);
					}
				}						
			}
		}			
	}
	
	
	/**
	 * 嫌疑对象-黑名单&监控名单
	 * @param dybjbdx
	 */
	public void XYDXHMD(String xmbh,String xydx){
		RecordSet rs = new RecordSet();
		RecordSet rs1 = new RecordSet();
		String sql = "";
		writeLog("HXZZ");
		
		//案件后续追踪的历史黑名单
		String lshmd = "";
		String lsjkmd = "";
		sql = " select hmd,jhmd from uf_hq_cri_citabapo where xmbh = '"+xmbh+"' ";
		rs.executeSql(sql);
		if(rs.next()){
			lshmd = Util.null2String(rs.getString(1));    //历史黑名单
			lsjkmd = Util.null2String(rs.getString(2));   //历史监控名单
			
			ArrayList sarylist = Util.TokenizerString(xydx, ",");
			for(int i=0; i < sarylist.size(); i++){
				String sarystr = (String)sarylist.get(i);
				sql = " select hmd,jkmd from uf_hq_cri_involpers where id = '"+sarystr+"' ";
				rs1.executeSql(sql);
				if(rs1.next()){
					String sfhmd = Util.null2String(rs1.getString(1));   //涉案人员是否黑名单
					String sfjkmd = Util.null2String(rs1.getString(2));  //涉案人员是否监控名单
					if("0".equals(sfhmd)){
						if(!"".equals(lshmd)){
							String hmdtemp = ','+rs.getString(1)+',';
							if(hmdtemp.indexOf(','+xydx+',')<0){
								lshmd = lshmd + ',' + xydx;
							}
						}else{
							lshmd = xydx;
						}
						//更新被举报对象到案件后续追踪的黑名单
						sql = " update uf_hq_cri_citabapo set hmd = '"+lshmd+"' where xmbh = '"+xmbh+"' ";
						rs1.executeSql(sql);	
					}
					
					if("0".equals(sfjkmd)){
						if(!"".equals(lsjkmd)){
							String hmdtemp = ','+rs.getString(1)+',';
							if(hmdtemp.indexOf(','+xydx+',')<0){
								lsjkmd = lsjkmd + ',' + xydx;
							}
						}else{
							lsjkmd = xydx;
						}
						//更新被举报对象到案件后续追踪的监控名单
						sql = " update uf_hq_cri_citabapo set jhmd = '"+lsjkmd+"' where xmbh = '"+xmbh+"' ";
						rs1.executeSql(sql);
					}
				}						
			}
		}			
	}
	
	
	/**
	 * 证人-黑名单&监控名单
	 * @param dybjbdx
	 */
	public void ZRHMD(String xmbh,String zr){
		RecordSet rs = new RecordSet();
		RecordSet rs1 = new RecordSet();
		String sql = "";
		writeLog("HXZZ");
		
		//案件后续追踪的历史黑名单
		String lshmd = "";
		String lsjkmd = "";
		sql = " select hmd,jhmd from uf_hq_cri_citabapo where xmbh = '"+xmbh+"' ";
		rs.executeSql(sql);
		if(rs.next()){
			lshmd = Util.null2String(rs.getString(1));    //历史黑名单
			lsjkmd = Util.null2String(rs.getString(2));   //历史监控名单
			
			ArrayList sarylist = Util.TokenizerString(zr, ",");
			for(int i=0; i < sarylist.size(); i++){
				String sarystr = (String)sarylist.get(i);
				sql = " select hmd,jkmd from uf_hq_cri_involpers where id = '"+sarystr+"' ";
				rs1.executeSql(sql);
				if(rs1.next()){
					String sfhmd = Util.null2String(rs1.getString(1));   //涉案人员是否黑名单
					String sfjkmd = Util.null2String(rs1.getString(2));  //涉案人员是否监控名单
					if("0".equals(sfhmd)){
						if(!"".equals(lshmd)){
							String hmdtemp = ','+rs.getString(1)+',';
							if(hmdtemp.indexOf(','+zr+',')<0){
								lshmd = lshmd + ',' + zr;
							}
						}else{
							lshmd = zr;
						}
						//更新被举报对象到案件后续追踪的黑名单
						sql = " update uf_hq_cri_citabapo set hmd = '"+lshmd+"' where xmbh = '"+xmbh+"' ";
						rs1.executeSql(sql);	
					}
					
					if("0".equals(sfjkmd)){
						if(!"".equals(lsjkmd)){
							String hmdtemp = ','+rs.getString(1)+',';
							if(hmdtemp.indexOf(','+zr+',')<0){
								lsjkmd = lsjkmd + ',' + zr;
							}
						}else{
							lsjkmd = zr;
						}
						//更新被举报对象到案件后续追踪的监控名单
						sql = " update uf_hq_cri_citabapo set jhmd = '"+lsjkmd+"' where xmbh = '"+xmbh+"' ";
						rs1.executeSql(sql);
					}
				}						
			}
		}			
	}
	
	
	/**
	 * 插入案件记录
	 * @param billid
	 * @param xmbh
	 */
	public void InertAjjl(int billid,String xmbh,String xmmc,String zt,int userid){
		RecordSet rs = new RecordSet();
		RecordSet rs1 = new RecordSet();
		HrmScheduleDiffUtil gzr = new HrmScheduleDiffUtil();
		String currdate = TimeUtil.getCurrentDateString();
		String date = TimeUtil.getCurrentDateString();
		String time = TimeUtil.getCurrentTimeString();
		time = time.substring(11,time.length());
		
		rs.execute("select machine from uf_machine");
		String machine="";
		int formmodeid = 0;
		if(rs.next()){
			machine=Util.null2String(rs.getString("machine"));
		}
		if("DEV".equals(machine)){
			formmodeid = 964;
		} else if("PRO".equals(machine)){
			formmodeid = 503;
		}
		
		String ajjlTable = "uf_hq_cri_ajbgjl";
		String sql = " select * from "+ajjlTable+" where xmbh = '"+xmbh+"' ";
		rs.executeSql(sql);
		if(!rs.next()){
			if(!"0".equals(zt)){
				rs1.executeSql(" insert into "+ajjlTable+" (bgczr,xmbh,xmmc,bgzt,bgrq,formmodeid,modedatacreater,modedatacreatertype,modedatacreatedate,modedatacreatetime) " +
							  " values ('"+userid+"','"+xmbh+"','"+xmmc+"','"+zt+"','"+currdate+"','"+formmodeid+"','1','0','"+date+"','"+time+"') ");
				
				rs1.executeSql(" select max(id) as maxid from "+ajjlTable+" ");
				if(rs1.next()){
					int maxid=rs1.getInt("maxid");
					ModeRightInfo rightinfo = new ModeRightInfo();
					rightinfo.editModeDataShare(1,formmodeid,maxid);
				}
			}
		}else{
			String ajjlzt = "";
			String bgrq = "";  //变更日期
			int modedatacreater = 0;
			sql = " select bgzt,bgrq,modedatacreater from uf_hq_cri_ajbgjl where xmbh = '"+xmbh+"' and id = (select max(id) from uf_hq_cri_ajbgjl)";
			rs.executeSql(sql);
			if(rs.next()){
				ajjlzt = Util.null2String(rs.getString("bgzt"));
				modedatacreater = rs.getInt("modedatacreater");
				bgrq = rs.getString("bgrq");
			}
			
			if(!zt.equals(ajjlzt)){
				
				User subid = new User(modedatacreater);
				int subpanyid = subid.getUserSubCompany1();
				
				//根据当前日期-调查启动日期 获得案件当前所用到的天数
				int totalworkingday = Util.getIntValue(gzr.getTotalWorkingDays(bgrq,"00:00",currdate,"00:00",subpanyid),0);
				
				rs1.executeSql(" insert into "+ajjlTable+" (bgczr,xmbh,xmmc,bgzt,bgrq,formmodeid,modedatacreater,modedatacreatertype,modedatacreatedate,modedatacreatetime,ts) " +
						  " values ('"+userid+"','"+xmbh+"','"+xmmc+"','"+zt+"','"+currdate+"','"+formmodeid+"','1','0','"+date+"','"+time+"','"+totalworkingday+"') ");
			
				rs1.executeSql(" select max(id) as maxid from "+ajjlTable+" ");
				if(rs1.next()){
					int maxid=rs1.getInt("maxid");
					ModeRightInfo rightinfo = new ModeRightInfo();
					rightinfo.editModeDataShare(1,formmodeid,maxid);
				}
			}
		}
		
		EncodeModeAction encodeModeAction = new EncodeModeAction();
		encodeModeAction.doEncodeData(""+formmodeid,""+billid);
	}
	
	
}
