package feilida.finance;

import java.math.BigDecimal;

import feilida.cpt.ECologyServiceStub;
import feilida.cpt.ECologyServiceStub.ArrayOfBudgetVO;
import feilida.cpt.ECologyServiceStub.BudgetVO;
import feilida.util.CptBudgetUtilNew;
import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

public class CutFYBXAction implements Action {
    BaseBean log = new BaseBean();
    /**
     * 扣除费用报销单的明细物品申请的预算
     */
	@Override
	public String execute(RequestInfo info) {
		String requestid = info.getRequestid();
		String workflow_id = info.getWorkflowid();
		RecordSet rs = new RecordSet();
		String tableName = "";
		String OADATE = "";// 申请日期
		String KOSTL = "";// 成本中心
		String KSTAR = "";// 会计科目
		String GSBER = "";// 业务范围
		String ANLKL = "";// 资产分类
		String CURRENCY = "";// 币种
		String AMOUNT = "";// 金额
		String EXECTYPE = "";// 报销类型
		String OPTTYPE = "1";// 操作类型 0：提报申请（冻结预算）；1；完成申请（扣除预算）；2：取消申请（返回预算）
		String OAKey = "";// 申请单号（全局唯一）S
		String STAFFID = "";// 员工id
		String COMPID = "";// 公司id
		String DEPTID = "";// 部门id
		String GPKEY = "";
		String xingzhi = "";
		String WPSQD_NEW="";
		String sql = "Select tablename,id From Workflow_bill Where id=(";
		sql += "Select formid From workflow_base Where id=" + workflow_id + ")";
		rs.executeSql(sql);
		if (rs.next()) {
			tableName = Util.null2String(rs.getString("tablename"));
		}
		String mainId = "";
		sql = "select * from " + tableName + " where requestid= " + requestid;
		rs.executeSql(sql);
		log.writeLog("updateBudget"+sql);
		if (rs.next()) {
			mainId = Util.null2String(rs.getString("id"));
			OADATE = Util.null2String(rs.getString("BXRQ"));
			
			DEPTID = Util.null2String(rs.getString("BXRBM"));
			STAFFID = Util.null2String(rs.getString("BZRXM"));
			EXECTYPE = Util.null2String(rs.getString("LX"));
			WPSQD_NEW = Util.null2String(rs.getString("WPSQD_NEW"));
			
		}
		sql="select subcompanyid1 from hrmresource where id="+STAFFID;
		rs.executeSql(sql);
		if(rs.next()){

			COMPID = Util.null2String(rs.getString("subcompanyid1"));
		}
		OAKey = requestid;
		int count=0;
		sql = "select count(1) as count from " + tableName + "_dt1 where mainid=" + mainId;
		rs.executeSql(sql);
		if(rs.next()){
			count = rs.getInt("count");
		}
		if("1".equals(EXECTYPE)){
			updateinfoForCut(WPSQD_NEW,mainId,OADATE,DEPTID,STAFFID,EXECTYPE,COMPID);
			updateinfo(count,tableName,requestid,"0",mainId,OADATE,DEPTID,STAFFID,EXECTYPE,COMPID);
		}
		ArrayOfBudgetVO ab = new ECologyServiceStub.ArrayOfBudgetVO();
		BudgetVO[] bvo = new BudgetVO[count];
		sql = "select * from " + tableName + "_dt1 where mainid=" + mainId;
		rs.executeSql(sql);
	    int i=0;
	  //循环获取明细数据调用webservice更新接口扣除预算
		while (rs.next()) {
			GSBER = Util.null2String(rs.getString("YWFW2"));
			if(!"1".equals(EXECTYPE)){
				KSTAR = Util.null2String(rs.getString("ZZKM1"));
				ANLKL = Util.null2String(rs.getString("ZZKM1"));
			}else{
			KSTAR = Util.null2String(rs.getString("KMID"));
			ANLKL = Util.null2String(rs.getString("KMID"));
			}
			AMOUNT = Util.null2String(rs.getString("JE2"));
			GPKEY = Util.null2String(rs.getString("BSM"));
			
			KOSTL = Util.null2String(rs.getString("CBZX"));
			if("".equals(AMOUNT)){
				AMOUNT = "0";
			}
			if("".equals(COMPID)){
				COMPID = "1";
			}
			if("".equals(DEPTID)){
				DEPTID = "1";
			}
			if("".equals(STAFFID)){
				STAFFID = "1";
			}
			log.writeLog("具体数据"+i+":"+" AMOUNT:"+AMOUNT+" KSTAR:"+KSTAR+" OADATE:"+OADATE+" KOSTL:"+KOSTL+" GSBER:"+GSBER+" OPTTYPE:"+OPTTYPE+" STAFFID:"+STAFFID+" COMPID:"+COMPID+" DEPTID:"+DEPTID+" EXECTYPE:"+EXECTYPE+" ANLKL:"+ANLKL+" OAKey:"+OAKey+" GPKEY:"+GPKEY);
			BudgetVO bv = new ECologyServiceStub.BudgetVO();
			bv.setAMOUNT(new BigDecimal(AMOUNT));
			bv.setKSTAR(KSTAR);
			bv.setOADATE(CptBudgetUtilNew.str2Calendar(OADATE));
			bv.setKOSTL(KOSTL);
			bv.setGSBER(GSBER);
			bv.setOPTTYPE(OPTTYPE);
			bv.setSTAFFID(Integer.parseInt(STAFFID));
			bv.setCOMPID(Integer.parseInt(COMPID));
			bv.setCURRENCY(CURRENCY);
			bv.setDEPTID(Integer.parseInt(DEPTID));
			bv.setEXECTYPE(EXECTYPE);
			bv.setANLKL(ANLKL);
			bv.setOAKey(OAKey);
			bv.setGPKEY(GPKEY);
			bv.setAMOUNT0(new BigDecimal("0"));
			bv.setAMOUNT1(new BigDecimal("0"));
			bv.setAMOUNT2(new BigDecimal("0"));
			bv.setAMOUNT3(new BigDecimal("0"));
			bvo[i]=bv;
			i++;
            
		}
		ab.setBudgetVO(bvo);
		CptBudgetUtilNew cb= new CptBudgetUtilNew();
		try {
			cb.updateBudget(ab);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	public void updateinfo(int count ,String tableName,String requestid,String OPTTYPE,String mainId,String OADATE,String DEPTID,String STAFFID,String EXECTYPE,String COMPID){
		RecordSet rs = new RecordSet();
		String sql="";
		String KOSTL = "";// 成本中心
		String KSTAR = "";// 会计科目
		String GSBER = "";// 业务范围
		String ANLKL = "";// 资产分类
		String CURRENCY = "";// 币种
		String AMOUNT = "";// 金额
        
		String OAKey = "";// 申请单号（全局唯一）S
		String GPKEY = "";
		ArrayOfBudgetVO ab = new ECologyServiceStub.ArrayOfBudgetVO();
		BudgetVO[] bvo = new BudgetVO[count];
		sql = "select * from " + tableName + "_dt1 where mainid=" + mainId;
		rs.executeSql(sql);
	    int i=0;
		while (rs.next()) {
			GSBER = Util.null2String(rs.getString("YWFW2"));
			if(!"1".equals(EXECTYPE)){
				KSTAR = Util.null2String(rs.getString("ZZKM1"));
				ANLKL = Util.null2String(rs.getString("ZZKM1"));
			}else{
			KSTAR = Util.null2String(rs.getString("KMID"));
			ANLKL = Util.null2String(rs.getString("KMID"));
			}
			AMOUNT = Util.null2String(rs.getString("JE2"));
			GPKEY = Util.null2String(rs.getString("BSM"));
			if("2".equals(OPTTYPE)){
			OAKey = Util.null2String(rs.getString("requestid"));
			}else{
				OAKey = requestid;
			}
			KOSTL = Util.null2String(rs.getString("CBZX"));
			if("".equals(AMOUNT)){
				AMOUNT = "0";
			}
			if("".equals(COMPID)){
				COMPID = "1";
			}
			if("".equals(DEPTID)){
				DEPTID = "1";
			}
			if("".equals(STAFFID)){
				STAFFID = "1";
			}
			log.writeLog("具体数据"+OPTTYPE+i+":"+" AMOUNT:"+AMOUNT+" KSTAR:"+KSTAR+" OADATE:"+OADATE+" KOSTL:"+KOSTL+" GSBER:"+GSBER+" OPTTYPE:"+OPTTYPE+" STAFFID:"+STAFFID+" COMPID:"+COMPID+" DEPTID:"+DEPTID+" EXECTYPE:"+EXECTYPE+" ANLKL:"+ANLKL+" OAKey:"+OAKey+" GPKEY:"+GPKEY);
			BudgetVO bv = new ECologyServiceStub.BudgetVO();
			bv.setAMOUNT(new BigDecimal(AMOUNT));
			bv.setKSTAR(KSTAR);
			bv.setOADATE(CptBudgetUtilNew.str2Calendar(OADATE));
			bv.setKOSTL(KOSTL);
			bv.setGSBER(GSBER);
			bv.setOPTTYPE(OPTTYPE);
			bv.setSTAFFID(Integer.parseInt(STAFFID));
			bv.setCOMPID(Integer.parseInt(COMPID));
			bv.setCURRENCY(CURRENCY);
			bv.setDEPTID(Integer.parseInt(DEPTID));
			bv.setEXECTYPE(EXECTYPE);
			bv.setANLKL(ANLKL);
			bv.setOAKey(OAKey);
			bv.setGPKEY(GPKEY);
			bv.setAMOUNT0(new BigDecimal("0"));
			bv.setAMOUNT1(new BigDecimal("0"));
			bv.setAMOUNT2(new BigDecimal("0"));
			bv.setAMOUNT3(new BigDecimal("0"));
			bvo[i]=bv;
			i++;
            
		}
		ab.setBudgetVO(bvo);
		CptBudgetUtilNew cb= new CptBudgetUtilNew();
		try {
			cb.updateBudget(ab);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	
	public void updateinfoForCut(String WPSQD_NEW,String mainId,String OADATE,String DEPTID,String STAFFID,String EXECTYPE,String COMPID){
	
		
		String WPSQD[] = WPSQD_NEW.split(",");
		ArrayOfBudgetVO ab = new ECologyServiceStub.ArrayOfBudgetVO();
		BudgetVO[] bvo = new BudgetVO[WPSQD.length];
		for(int i=0;i<=WPSQD.length;i++){
			
			if("".equals(COMPID)){
				COMPID = "1";
			}
			if("".equals(DEPTID)){
				DEPTID = "1";
			}
			if("".equals(STAFFID)){
				STAFFID = "1";
			}
			log.writeLog("具体数据cut"+i+":"+" WPSQD:"+WPSQD[i]);
			BudgetVO bv = new ECologyServiceStub.BudgetVO();
			bv.setAMOUNT(new BigDecimal("0"));
			bv.setKSTAR("1");
			bv.setOADATE(CptBudgetUtilNew.str2Calendar(OADATE));
			bv.setKOSTL("1");
			bv.setGSBER("1");
			bv.setOPTTYPE("2");
			bv.setSTAFFID(Integer.parseInt(STAFFID));
			bv.setCOMPID(Integer.parseInt(COMPID));
			bv.setCURRENCY("1");
			bv.setDEPTID(Integer.parseInt(DEPTID));
			bv.setEXECTYPE(EXECTYPE);
			bv.setANLKL("1");
			bv.setOAKey(WPSQD[i]);
			bv.setGPKEY("");
			bv.setAMOUNT0(new BigDecimal("0"));
			bv.setAMOUNT1(new BigDecimal("0"));
			bv.setAMOUNT2(new BigDecimal("0"));
			bv.setAMOUNT3(new BigDecimal("0"));
			bvo[i]=bv;
			i++;
            
		}
		ab.setBudgetVO(bvo);
		CptBudgetUtilNew cb= new CptBudgetUtilNew();
		try {
			cb.updateBudget(ab);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}


