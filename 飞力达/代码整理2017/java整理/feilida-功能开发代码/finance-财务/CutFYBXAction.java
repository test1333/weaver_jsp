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
     * �۳����ñ���������ϸ��Ʒ�����Ԥ��
     */
	@Override
	public String execute(RequestInfo info) {
		String requestid = info.getRequestid();
		String workflow_id = info.getWorkflowid();
		RecordSet rs = new RecordSet();
		String tableName = "";
		String OADATE = "";// ��������
		String KOSTL = "";// �ɱ�����
		String KSTAR = "";// ��ƿ�Ŀ
		String GSBER = "";// ҵ��Χ
		String ANLKL = "";// �ʲ�����
		String CURRENCY = "";// ����
		String AMOUNT = "";// ���
		String EXECTYPE = "";// ��������
		String OPTTYPE = "1";// �������� 0���ᱨ���루����Ԥ�㣩��1��������루�۳�Ԥ�㣩��2��ȡ�����루����Ԥ�㣩
		String OAKey = "";// ���뵥�ţ�ȫ��Ψһ��S
		String STAFFID = "";// Ա��id
		String COMPID = "";// ��˾id
		String DEPTID = "";// ����id
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
	  //ѭ����ȡ��ϸ���ݵ���webservice���½ӿڿ۳�Ԥ��
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
			log.writeLog("��������"+i+":"+" AMOUNT:"+AMOUNT+" KSTAR:"+KSTAR+" OADATE:"+OADATE+" KOSTL:"+KOSTL+" GSBER:"+GSBER+" OPTTYPE:"+OPTTYPE+" STAFFID:"+STAFFID+" COMPID:"+COMPID+" DEPTID:"+DEPTID+" EXECTYPE:"+EXECTYPE+" ANLKL:"+ANLKL+" OAKey:"+OAKey+" GPKEY:"+GPKEY);
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
		String KOSTL = "";// �ɱ�����
		String KSTAR = "";// ��ƿ�Ŀ
		String GSBER = "";// ҵ��Χ
		String ANLKL = "";// �ʲ�����
		String CURRENCY = "";// ����
		String AMOUNT = "";// ���
        
		String OAKey = "";// ���뵥�ţ�ȫ��Ψһ��S
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
			log.writeLog("��������"+OPTTYPE+i+":"+" AMOUNT:"+AMOUNT+" KSTAR:"+KSTAR+" OADATE:"+OADATE+" KOSTL:"+KOSTL+" GSBER:"+GSBER+" OPTTYPE:"+OPTTYPE+" STAFFID:"+STAFFID+" COMPID:"+COMPID+" DEPTID:"+DEPTID+" EXECTYPE:"+EXECTYPE+" ANLKL:"+ANLKL+" OAKey:"+OAKey+" GPKEY:"+GPKEY);
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
			log.writeLog("��������cut"+i+":"+" WPSQD:"+WPSQD[i]);
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


