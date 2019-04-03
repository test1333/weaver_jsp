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

public class FreezeFYBXAction implements Action {
    BaseBean log = new BaseBean();
    /**
     * 冻结费用报销单的明细物品申请的预算
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
		String OPTTYPE = "0";// 操作类型 0：提报申请（冻结预算）；1；完成申请（扣除预算）；2：取消申请（返回预算）
		String OAKey = "";// 申请单号（全局唯一）
		String STAFFID = "";// 员工id
		String COMPID = "";// 公司id
		String DEPTID = "";// 部门id
		String GPKEY = "";
		String xingzhi = "";
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
			
		}
		if("1".equals(EXECTYPE)){
			return SUCCESS;
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
		ArrayOfBudgetVO ab = new ECologyServiceStub.ArrayOfBudgetVO();
		BudgetVO[] bvo = new BudgetVO[count];
		sql = "select * from " + tableName + "_dt1 where mainid=" + mainId;
		rs.executeSql(sql);
	    int i=0;
	    //循环获取明细数据调用webservice更新接口冻结预算
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

}
