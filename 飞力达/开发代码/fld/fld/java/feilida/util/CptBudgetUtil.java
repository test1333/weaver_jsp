package feilida.util;

import feilida.util.serviceNew.*;
import feilida.util.serviceNew.ArrayOfBudgetVO;
import feilida.util.serviceNew.BudgetVO;
import feilida.util.serviceNew.ECologyService;

import javax.xml.datatype.DatatypeConfigurationException;
import javax.xml.datatype.DatatypeFactory;
import javax.xml.datatype.XMLGregorianCalendar;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;


/**
 * Created by adore on 2016/12/19.
 * �������ʲ�Ԥ��ӿ�
 * OADATE:��������
 * AMOUNT��Ԥ����Ϣ
 * KOSTL���ɱ�����
 * KSTAR����ƿ�Ŀ
 * GSBER��ҵ��Χ
 * CURRENCY������
 * EXECTYPE����������
 * OPTTYPE:�������ͣ�0���ύ��1��ɣ�2�˻�
 * STAFFID��Ա��id
 * COMPID���ֲ�id
 * DEPTID������id
 *
 * @
 */

public class CptBudgetUtil {
    public List<BudgetVO> getBudgetResponse(String OADATE, String AMOUNT, String KOSTL, String KSTAR, String GSBER, String CURRENCY, String EXECTYPE
            , String OPTTYPE, int STAFFID, int COMPID, int DEPTID, String ANLKL, String OAKEY) {

        ObjectFactory of = new ObjectFactory();
        BudgetVO bv = of.createBudgetVO();
        ArrayOfBudgetVO ab = of.createArrayOfBudgetVO();
        ECologyService es = new ECologyService();
        ECologyServiceSoap ess = es.getECologyServiceSoap();
        BigDecimal amount = new BigDecimal(Double.valueOf(AMOUNT));
        bv.setAMOUNT(amount);
        bv.setKSTAR(KSTAR);
        bv.setOADATE(long2Gregorian(str2Date(OADATE)));
        bv.setKOSTL(KOSTL);
        bv.setGSBER(GSBER);
        bv.setOPTTYPE(OPTTYPE);
        bv.setSTAFFID(STAFFID);
        bv.setCOMPID(COMPID);
        bv.setCURRENCY(CURRENCY);
        bv.setDEPTID(DEPTID);
        bv.setEXECTYPE(EXECTYPE);
        bv.setANLKL(ANLKL);
        bv.setOAKey(OAKEY);

        List<BudgetVO> budgetList = ab.getBudgetVO();
        budgetList.add(bv);

        ArrayOfBudgetVO abResponse = ess.queryBudget(ab);

        List<BudgetVO> budgetListResponse = abResponse.getBudgetVO();

        return budgetListResponse;
    }

    public static Date str2Date(String str) {
        DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Date date = null;
        // StringתDate
        //str = "2007-1-18";
        try {
            date = format.parse(str); // Thu Jan 18 00:00:00 CST 2007
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return date;
    }

    public static XMLGregorianCalendar long2Gregorian(Date date) {
        DatatypeFactory dataTypeFactory;
        try {
            dataTypeFactory = DatatypeFactory.newInstance();
        } catch (DatatypeConfigurationException e) {
            throw new RuntimeException(e);
        }
        GregorianCalendar gc = new GregorianCalendar();
        gc.setTimeInMillis(date.getTime());
        return dataTypeFactory.newXMLGregorianCalendar(gc);
    }

}