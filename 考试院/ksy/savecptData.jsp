<%@page import="weaver.hrm.User"%>
<%@page import="weaver.hrm.HrmUserVarify"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.JSONArray"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="CapitalComInfo" class="weaver.cpt.capital.CapitalComInfo" scope="page"/>
<jsp:useBean id="PoppupRemindInfoUtil" class="weaver.workflow.msg.PoppupRemindInfoUtil" scope="page"/>
<script language="javascript" src="/wui/theme/ecology8/jquery/js/zDialog_wev8.js"></script>
<%
User user=HrmUserVarify.getUser(request, response);
if(user==null){
	out.print("[]");
	return;
}

String Id = Util.fromScreen(request.getParameter("id"),user.getLanguage());
String contactno = Util.fromScreen(request.getParameter("contactno"),user.getLanguage());
String BuyerID = Util.fromScreen(request.getParameter("BuyerID"),user.getLanguage());
String customerid = Util.fromScreen(request.getParameter("customerid"),user.getLanguage());
String CheckerID = Util.fromScreen(request.getParameter("CheckerID"),user.getLanguage());
String StockInDate_gz = Util.fromScreen(request.getParameter("StockInDate_gz"),user.getLanguage());
String StockInDate = Util.fromScreen(request.getParameter("StockInDate"),user.getLanguage());
String Method = Util.fromScreen(request.getParameter("method"),user.getLanguage());
int totaldetail = Util.getIntValue(request.getParameter("totaldetail"),0);


char separator = Util.getSeparator() ;
String para = "";
String sql = "";



    para = contactno;
    para +=separator+BuyerID;
    para +=separator+customerid;
    para +=separator+CheckerID;
    para +=separator+StockInDate;
	para +=separator+"0";
    RecordSet.executeProc("CptStockInMain_Insert",para);

	RecordSet.next();
	String cptstockinid=""+RecordSet.getInt(1);
	String cpttype="";
	String plannumber="";
	String price="";
    String Invoice="";
    String customerid_dtl="";
    String StockInDate_dtl="";
    String capitalspec="";
    String location="";
	String contractno="";//合同号
    String cptid="";
	int i=0;

	int num = Integer.valueOf(Util.null2String(request.getParameter("num")));
	for(int index=1;index <=num;index++){
				capitalspec= Util.null2String(request.getParameter("ggxh_"+index));
				price= Util.null2String(request.getParameter("dj_"+index));
				plannumber= Util.null2String(request.getParameter("sgsl_"+index));
				Invoice= Util.null2String(request.getParameter("fphm_"+index));
				location= Util.null2String(request.getParameter("cfdd_"+index));
				cpttype= Util.null2String(request.getParameter("name_"+index));
				cptid= Util.null2String(request.getParameter("cptid_"+index));
				customerid_dtl=customerid;
				StockInDate_dtl=StockInDate_gz;
				contractno=contactno;
				
				if(!cpttype.equals("")){
					para = cptstockinid;
					para +=separator+cpttype;
					para +=separator+plannumber;
					para +=separator+"0";
					para +=separator+price;
			        para +=separator+customerid_dtl;
			        para +=separator+StockInDate_dtl;
			        para +=separator+capitalspec;
			        para +=separator+location;
			        para +=separator+Invoice;
					RecordSet.executeProc("CptStockInDetail_Insert",para);
					if(RecordSet.next()){
						String detailid = Util.null2String(RecordSet.getString(1));
						if(!detailid.equals("")&&!detailid.equals("0")){
							RecordSet.executeSql("update CptStockInDetail set contractno = '" + contractno + "' where id = " + detailid);
						}			
					}
					String sql_d = "insert into uf_cptLog(CPTID) values('"+cptid+"')";
					RecordSet.executeSql(sql_d);
			     }
	}		
    PoppupRemindInfoUtil.insertPoppupRemindInfo(Util.getIntValue(CheckerID),11,"0",Util.getIntValue(cptstockinid));

    


%>
<script>
	var pdialog = parent.getDialog(window);//获取窗口对象；
var parentWin = parent.getParentWindow(window);//获取父对象；
 parentWin.location.reload();    
	 pdialog.close();
</script>
