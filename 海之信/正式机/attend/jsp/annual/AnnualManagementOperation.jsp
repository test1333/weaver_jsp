<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.TimeUtil" %>
<%@ page import="java.util.*" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="SysMaintenanceLog" class="weaver.systeminfo.SysMaintenanceLog" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="HrmAnnualManagement" class="weaver.hrm.schedule.HrmAnnualManagement" scope="page" />

<%
String operation = Util.null2String(request.getParameter("operation"));
String subcompanyid = Util.null2String(request.getParameter("subCompanyId"));
String departmentid = Util.null2String(request.getParameter("departmentid"));
String annualyear = Util.null2String(request.getParameter("annualyear"));

//add by shaw 20160517 start 
String validDate = annualyear+"-12-31";
out.print("validDate="+validDate);
//add by shaw 20160517 end
String sql="";

if(operation.equals("edit")){
   if(!HrmUserVarify.checkUserRight("AnnualLeave:All", user)){
      response.sendRedirect("/notice/noright.jsp");
      return;
   }
      
   String resourceid[] = request.getParameterValues("resourceid");
   String annualdays[] = request.getParameterValues("annualdays");
  
  /*edit by shaw 20160517
   if(resourceid!=null){
     for(int i=0;i<resourceid.length;i++){
         String tempresourceid = resourceid[i];
		     String tempannualdays = annualdays[i].equals("")?"0":annualdays[i];
         sql = "delete from hrmannualmanagement where resourceid = " + tempresourceid + " and annualyear = " + annualyear;
         RecordSet.executeSql(sql);
         sql = "insert into hrmannualmanagement (resourceid,annualyear,annualdays,status) values ('"+tempresourceid+"','"+annualyear+"','"+tempannualdays+"',1)";
         RecordSet.executeSql(sql);
     }
   }
   //edit by shaw 20160517*/
    if(resourceid!=null){
     for(int i=0;i<resourceid.length;i++){
         int num_annual=0;
         int dataid=0;
         String tempresourceid = resourceid[i];
		     String tempannualdays = annualdays[i].equals("")?"0":annualdays[i];
        // String tempapplydays=tempannualdays*8;
         sql=" select count(id) as num_annual,max(id) as dataid from uf_holiday_apply where applyholidays=19 and enddate='"+validDate+"' and applyuser="+tempresourceid+" ";
         RecordSet.executeSql(sql);
         if(RecordSet.next()){
                num_annual=RecordSet.getInt("num_annual");
                dataid=RecordSet.getInt("dataid");
         }
         if(num_annual>0){
                sql=" update uf_holiday_apply set applydays="+tempannualdays+",IsEffective=0,isSalary=0 where id="+dataid;  
         }else{
                sql = "insert into uf_holiday_apply (applyuser,applyholidays,applydays,IsEffective,enddate,orderby,isSalary) "
                +" values ('"+tempresourceid+"',19,'"+tempannualdays+"',0,'"+validDate+"','A',0)";  
         }
         //out.print("sql="+sql);
         RecordSet.executeSql(sql);
     }
   }
   response.sendRedirect("AnnualManagementView.jsp?cmd=true&subCompanyId="+subcompanyid+"&departmentid="+departmentid);
}

if(operation.equals("batchprocess")){
   if(!HrmUserVarify.checkUserRight("AnnualLeave:All", user)){
      response.sendRedirect("/notice/noright.jsp");
      return;
   }

   Calendar today = Calendar.getInstance();
   //String currentdate= Util.add0(today.get(Calendar.YEAR),4) +"-"+ Util.add0(today.get(Calendar.MONTH)+1,2) +"-"+ Util.add0(today.get(Calendar.DAY_OF_MONTH),2);   
   String currentdate = annualyear+"-"+ Util.add0(today.get(Calendar.MONTH)+1,2) +"-"+ Util.add0(today.get(Calendar.DAY_OF_MONTH),2);
   
   String result = HrmAnnualManagement.getBatchProcess(subcompanyid,departmentid);
   if(result.equals("-1")){
      response.sendRedirect("AnnualManagementEdit.jsp?message=12&subCompanyId="+subcompanyid+"&departmentid="+departmentid);
   }
   
   //人员卡片上面的工作信息，可以录入合同开始日期，合同开始日期则为到职日期,年假批量处理，根据工龄来初始化
   HashMap BatchProcess = new HashMap();//批量处理设置，工龄 + 年假天数
   RecordSet.executeSql("select * from HrmAnnualBatchProcess where subcompanyid = " + result + " order by workingage desc");
   int workingage[] = new int[RecordSet.getCounts()];//工龄
   int j = 0;
   while(RecordSet.next()){
      BatchProcess.put(RecordSet.getFloat("workingage")+"",RecordSet.getString("annualdays"));
      workingage[j++] = (int) RecordSet.getFloat("workingage");     
   }
   
   HashMap userStartDate = new HashMap();//所有用户的合同开始日期
   RecordSet.executeSql("select * from hrmresource");
   while(RecordSet.next()){
      userStartDate.put(RecordSet.getString("id"),Util.null2String(RecordSet.getString("startdate")));
   }
   
   String resourceid[] = request.getParameterValues("resourceid");
   if(resourceid!=null){
     for(int i=0;i<resourceid.length;i++){
       int num_annual=0;
       int dataid=0;
       String startdate = userStartDate.get(resourceid[i]).toString();
       if(startdate.equals("")) startdate = currentdate;
       int days = TimeUtil.dateInterval(startdate,currentdate);
       int _workingage = days/365;
       float annualdays = HrmAnnualManagement.getAnnualDays(BatchProcess,workingage,_workingage);

       String tempresourceid = resourceid[i];
       sql=" select count(id) as num_annual,max(id) as dataid from uf_holiday_apply where applyholidays=19 and enddate='"+validDate+"' and applyuser="+tempresourceid+" ";
         RecordSet.executeSql(sql);
         if(RecordSet.next()){
                num_annual=RecordSet.getInt("num_annual");
                dataid=RecordSet.getInt("dataid");
         }
         if(num_annual>0){
                sql=" update uf_holiday_apply set applydays="+annualdays+",IsEffective=0,isSalary=0 where id="+dataid;  
         }else{
                sql = "insert into uf_holiday_apply (applyuser,applyholidays,applydays,IsEffective,enddate,orderby,isSalary) "
                +" values ('"+tempresourceid+"',19,'"+annualdays+"',0,'"+validDate+"','A',0)";  
         }
       RecordSet.executeSql(sql);       
     }
   }
               
   response.sendRedirect("AnnualManagementView.jsp?subCompanyId="+subcompanyid+"&departmentid="+departmentid);
}

%>


