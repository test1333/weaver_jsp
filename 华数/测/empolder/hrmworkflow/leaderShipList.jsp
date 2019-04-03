<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="com.mk.webservice.service.*" %> 
<jsp:useBean id="resourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" /> 
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="hrservice" class="com.mk.webservice.service.HrServiceProxy" scope="page" />  
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET> 
<SCRIPT language="javascript" src="/js/weaver.js"></script>
<SCRIPT language="javascript" src="/js/jquery/jquery-1.4.2.min.js"></script>
<SCRIPT language="javascript" src="/js/jquery/jquery.corner.js"></script>
<SCRIPT language="javascript" src="/js/jquery/jquery.js"></script>
<style type="text/css">
 a {
	color:blue !important;
}
</style>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>领导力及专业素质汇总表</title>
</head>
<% 
String imagefilename = "/images/hdSystem.gif";
String titlename = "领导力及专业素质汇总表" ;
String needfav ="1";
String needhelp ="";  
/*
rs.executeSql(" select loginid from hrmresource where ( managerid ="+user.getUID()+" or managerid in ( select id from hrmresource where belongto="+user.getUID()+") )  and status<5 and loginid is not null ");
java.util.List loginidlist = new java.util.ArrayList();
java.util.List hrmlist = new java.util.ArrayList();
while(rs.next()){
	loginidlist.add(rs.getString("loginid")); 
}
for(int i=0;i<loginidlist.size();i++){
	String loginid=(String)loginidlist.get(i);
	WsEmployee[] emps = hrservice.getWSEmployeeList(loginid);
	if(emps!=null&&emps.length>0){ 
		hrmlist.add(emps[0]); 
	}
}*/
int userid = user.getUID();
String curyear = new java.text.SimpleDateFormat("yyyy").format(new java.util.Date()); 
java.util.Calendar c = java.util.Calendar.getInstance();
c.setTime(new java.util.Date()); 
int month = c.get(java.util.Calendar.MONTH);
int imptype = (month<=6)?1:0;
if(imptype == 1){
	curyear = String.valueOf((Integer.parseInt(curyear) - 1));
}
WsEmployee[] hrmlist = null;
String loginids = ""; 
rs.executeSql("select loginid from hrmresource where id in (select scorer from scorerecord where substr(scoredate,0,4) = '"+curyear+"' and yeartype = '"+imptype+"' and isleader = '1' and userid = '"+user.getUID()+"')");
while(rs.next()){
	loginids += rs.getString("loginid")+",";
}
if(!loginids.equals("")){
	String tem[] = loginids.split(",");
	hrmlist = new WsEmployee[tem.length];
	// out.println("============="+tem.length);
	for(int j = 0;j<tem.length;j++){
		if(tem[j].equals(String.valueOf(user.getLoginid()))){
			continue;
		}
// 		out.println("--------------"+tem[j]);
		WsEmployee[] wes = hrservice.getWSEmployeeList(tem[j]);
		if(wes!=null&&wes.length>0){ 
			hrmlist[j]=wes[0]; 
		}
	}
}
int year = c.get(java.util.Calendar.YEAR);
int year1=year-1;
int year2=year-2;
int year3=year-3;

String bgcolor="";
%> 
<body>
<%@ include file="/systeminfo/TopTitleprofession.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<% 	
//RCMenu += "{提交,javascript:onSubmit(this),_self} " ;
//RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>

<div align="center" style="margin:5 10 5 10" > 
  <table style="border-collapse:collapse;" border="1" bordercolor="#CCCCCC" width="135%">
    <colgroup>
      <col width="64" />
      <col width="66" />
      <col width="83" />
      <col width="79" />
      <col width="74" />
      <col width="38" />
      <col width="61" />
      <col width="38" />
      <col width="38" />
      <col width="38" />
      <col width="38" />
      <col width="82" />
      <col width="60" />
      <col width="74" />
      <col width="90" />
      <col width="61" />
      <col width="61" />
      <col width="61" />
      <col width="88" />
      <col width="67" />
      <col width="88" />
      <col width="81" />
      <col width="85" />
      <col width="88" />
      <col width="66" />
      <col width="96" />
      <col width="96" />
      <col width="130" />
    </colgroup>
    <tbody>
      <tr height=30>
        <td bgcolor="<%=bgcolor %>" valign="center" rowspan="2"><div align="center"><strong>职员代码</strong></div></td>
        <td bgcolor="<%=bgcolor %>" valign="center" rowspan="2"><div align="center"><strong>姓名</strong></div></td>
<%--         <td bgcolor="<%=bgcolor %>" valign="center" rowspan="2"><div align="center"><strong>一级部门</strong></div></td> --%>
        <td bgcolor="<%=bgcolor %>" valign="center" rowspan="2"><div align="center"><strong>二级部门</strong></div></td>
        <td bgcolor="<%=bgcolor %>" valign="center" rowspan="2"><div align="center"><strong>岗位</strong></div></td>
        <td bgcolor="<%=bgcolor %>" valign="center" rowspan="2"><div align="center"><strong>职级</strong></div></td>
<%--         <td bgcolor="<%=bgcolor %>" valign="center" rowspan="2"><div align="center"><strong>编制类别</strong></div></td> --%>
<%--         <td bgcolor="<%=bgcolor %>" valign="center" rowspan="2"><div align="center"><strong>年龄</strong></div></td> --%>
<%--         <td bgcolor="<%=bgcolor %>" valign="center" rowspan="2"><div align="center"><strong>性别</strong></div></td> --%>
        <td bgcolor="<%=bgcolor %>" valign="center" rowspan="2"><div align="center"><strong>司龄</strong></div></td>
        <td bgcolor="<%=bgcolor %>" valign="center" rowspan="2"><div align="center"><strong>工龄</strong></div></td>
<%--         <td bgcolor="<%=bgcolor %>" valign="center" rowspan="2"><div align="center"><strong>毕业学校</strong></div></td> --%>
<%--         <td bgcolor="<%=bgcolor %>" valign="center" rowspan="2"><div align="center"><strong>学历</strong></div></td> --%>
<%--         <td bgcolor="<%=bgcolor %>" valign="center" rowspan="2"><div align="center"><strong>专业</strong></div></td> --%>
<%--         <td bgcolor="<%=bgcolor %>" valign="center" rowspan="2"><div align="center"><strong>职称</strong></div></td> --%>
        <td bgcolor="<%=bgcolor %>" valign="center" rowspan="2"><div align="center" style="white-space: nowrap;"><strong><%=year3 %>年<br />
          绩效等级</strong></div></td>
        <td bgcolor="<%=bgcolor %>" valign="center" rowspan="2"><div align="center" style="white-space: nowrap;"><strong><%=year2 %>年<br />
          绩效等级</strong></div></td>
        <td bgcolor="<%=bgcolor %>" valign="center" rowspan="2"><div align="center" style="white-space: nowrap;"><strong><%=year1 %>年<br />
          绩效等级</strong></div></td>
        <td bgcolor="<%=bgcolor %>" valign="center" colspan="3"><div align="center"><strong>现岗位胜任情况</strong></div></td>
        <td bgcolor="<%=bgcolor %>" valign="center" rowspan="2"><div align="center"><strong>发展潜质</strong></div></td>
        <td bgcolor="<%=bgcolor %>" valign="center" rowspan="2"><div align="center"><strong>人才梯次</strong></div></td>
        <td bgcolor="<%=bgcolor %>" valign="center" rowspan="2"><div align="center" style="white-space: nowrap;"><strong>后续任用计划</strong></div></td>
        <td bgcolor="<%=bgcolor %>" valign="center" rowspan="2"><div align="center"><strong>延伸岗位</strong></div></td>
        <td bgcolor="<%=bgcolor %>" valign="center" rowspan="2"><div align="center"><strong>接任预估</strong></div></td>
        <td bgcolor="<%=bgcolor %>" valign="center" rowspan="2"><div align="center"><strong>个人优势</strong></div></td>
        <td bgcolor="<%=bgcolor %>" valign="center" rowspan="2"><div align="center" style="white-space: nowrap;"><strong>待改进与提升之处</strong></div></td>
      </tr>
      <tr height=30 style="white-space: nowrap;">
        <td bgcolor="<%=bgcolor %>" ><div align="center" style="white-space: nowrap;"><strong>专业素质评估</strong></div></td>
        <td bgcolor="<%=bgcolor %>" ><div align="center"><strong>领导力矩阵落点</strong></div></td>
        <td bgcolor="<%=bgcolor %>" ><div align="center" style="white-space: nowrap;"><strong>岗位胜任水平</strong></div></td>
      </tr>
      <%  
      if(hrmlist != null){
  
      for(int j=0;j<hrmlist.length;j++){ 
    	  WsEmployee Employee = hrmlist[j];
    	  if(Employee != null){
    	  String birth=Employee.getBirthday();
    	  int yeardiff = Integer.parseInt(curyear)-Util.getIntValue(birth.substring(0,birth.indexOf("-")))+1;
    	  int gongyear = Integer.parseInt(curyear)- Util.getIntValue(Employee.getJoinworkdate().substring(0,Employee.getJoinworkdate().indexOf("-")));
    	  int siyear = Integer.parseInt(curyear)- Util.getIntValue(Employee.getJoindate().substring(0,Employee.getJoindate().indexOf("-")));
    	   
    	  rs.executeSql(" select id from hrmresource where loginid='"+Employee.getJobnumber()+"'");
    	  rs.next();
    	  String tempuserid=rs.getString("id");
    	  
    	  rs.executeSql(" select scoreid from scorerecord where scorer="+tempuserid+" and scoretype=1 and yeartype="+imptype); 
    	  String tempscoreid="";
    	  String url="";
    	  if(rs.next()){
    		  tempscoreid = rs.getString("scoreid");
    		  url = "&scoreid="+tempscoreid;
    	  }
       %> 
      <tr>
        <td valign="center"><div align="center"><%=Employee.getJobnumber() %></div></td>
        <td valign="center"><div align="center"><%=Employee.getName()%></div></td>
<%--         <td valign="center"><div align="center">　<%=Employee.getPdeptidname()%></div></td> --%>
        <td valign="center"><div align="center"><%=Employee.getDeptname()%></div></td>
        <td valign="center"><div align="center"><%=Employee.getPostname()%></div></td>
        <td valign="center"><div align="center"><%=Employee.getRankidname()%></div></td>
        <!--  编制类别  -->
<%--         <td valign="center"><div align="center">   <%=Employee.getQuotaidname() %></div></td>  --%>
<%--         <td valign="center"><div align="center">　<%=yeardiff %></div></td>  --%>
<%--         <td valign="center"><div align="center">　<%=Employee.getSex().equals("1")?"男":"女"%></div></td> --%>
        <td valign="center"><div align="center"><%=siyear %></div></td>
        <td valign="center"><div align="center"><%=gongyear %></div></td>
<%--         <td valign="center"><div align="center">　<%=Employee.getEduorg()%></div></td> --%>
<%--         <td valign="center"><div align="center">　<%=Employee.getCulturename()%></div></td> --%>
<%--         <td valign="center"><div align="center">　<%=Employee.getProfessional()%> </div></td> --%>
<%--         <td valign="center"><div align="center">　<%=Employee.getAuth()%></div></td>  --%>
        <%
        String yearscore1="";
        String yearscore2="";
        String yearscore3=""; 
        rs.executeSql(" select * from yearscore where year="+year1+" and hrmid="+tempuserid+"  order by year asc");
        if(rs.next()){
        	yearscore1 = rs.getString("yearscore");
        }
        rs.executeSql(" select * from yearscore where year="+year2+" and hrmid="+tempuserid+"   order by year asc");
        if(rs.next()){
        	yearscore2 = rs.getString("yearscore");
        }
        rs.executeSql(" select * from yearscore where year="+year3+"  and hrmid="+tempuserid+"  order by year asc");
        if(rs.next()){
        	yearscore3 = rs.getString("yearscore");
        }
        %>
        
        <td valign="center"><div align="center"><%=yearscore3 %></div></td>
        <td valign="center"><div align="center"><%=yearscore2 %></div></td>
        <td valign="center"><div align="center"><%=yearscore1 %></div></td> 
        <!-- 以下开始数据是存放在OA的 --> 
        <%  
            String xrgwsrqk=""; 
            String fzqz="";
            String rctc="";
            String hxryjh="";
            String ysgw="";
            String jryg="";
            String grys="";
            String dgjzc="";
            String zyszpg="";
            String whrt="";
            String gwsrsp=""; 
            String ldlld = "";
        	rs.executeSql("select t1.*,t3.ldlld from scorerecord t1 left join HrmResource t2 on t1.scorer=t2.id left join(select resid,ldlld from ability where yeartype = '"+imptype+"' and years = '"+curyear+"') t3 on t1.scorer = t3.resid where t1.scoretype=1 and  substr(t1.scoredate,0,4)='"+curyear+"'  and t1.yeartype="+imptype+" and t2.loginid='"+Employee.getJobnumber()+"'");
//         	out.println("select t1.*,t3.ldlld from scorerecord t1 left join HrmResource t2 on t1.scorer=t2.id left join(select resid,ldlld from ability where yeartype = '"+imptype+"' and years = '"+curyear+"') t3 on t1.scorer = t3.resid where t1.scoretype=1 and  substr(t1.scoredate,0,4)='"+curyear+"'  and t1.yeartype="+imptype+" and t2.loginid='"+Employee.getJobnumber()+"'");
        	if(rs.next()){ 
        		xrgwsrqk = rs.getString("gwsrsp");
        		fzqz = rs.getString("fzqz"); 
        		rctc = rs.getString("rctc");
        		hxryjh = rs.getString("hxryjh");
        		ysgw = rs.getString("ysgw");
        		jryg = rs.getString("jryg");
        		grys = rs.getString("grys");
        		dgjzc = rs.getString("dgjyyszc");
        		zyszpg = rs.getString("whrt");
        		ldlld = rs.getString("ldlld");
        		gwsrsp = rs.getString("gwsrsp");
        	}else{
        		xrgwsrqk ="&nbsp;";
        		fzqz ="&nbsp;";
        		rctc = "&nbsp;";
        		hxryjh = "&nbsp;";
        		ysgw = "&nbsp;";
        		jryg = "&nbsp;";
        		grys ="&nbsp;";
        		dgjzc = "&nbsp;";
        		zyszpg = "&nbsp;";
        		whrt ="&nbsp;";
        		gwsrsp = "&nbsp;";
        		ldlld = "&nbsp;";
        	}
        	if("8".equals(ldlld)){
        		ldlld = "深入辅导";
        	}else if("7".equals(ldlld)){
        		ldlld = "深入辅导";
        	}else if("6".equals(ldlld)){
        		ldlld = "待观察";
        	}else if("5".equals(ldlld)){
        		ldlld = "具发展空间";
        	}else if("4".equals(ldlld)){
        		ldlld = "好苗子";
        	}else if("3".equals(ldlld)){
        		ldlld = "高潜力";
        	}else if("2".equals(ldlld)){
        		ldlld = "胜任者";
        	}else if("1".equals(ldlld)){
        		ldlld = "高潜力";
        	}else if("1".equals(ldlld)){
        		ldlld = "重点苗子";
        	}
         
        %>
        <td valign="center"><div align="center"><%=zyszpg %></div></td>
        <td valign="center"><div align="center"><%=ldlld %></div></td>
        <td valign="center"><div align="center"><%=gwsrsp %></div></td> 
        <!--   <td valign="center"><div align="center"><%=xrgwsrqk %>　 </div></td>  --> 
        <td valign="center"><div align="center"><%=fzqz %></div></td>
        <td valign="center"><div align="center"><%=rctc %></div></td>
        <td valign="center"><div align="center"><%=hxryjh %></div></td>
        <td valign="center"><div align="center"><%=ysgw %></div></td>
        <td valign="center"><div align="center"><%=jryg %></div></td>
        <td valign="center"><div align="center"><%=grys %></div></td>
        <td valign="center"><div align="center"><%=dgjzc %></div></td>
      </tr>
      <%}}} %>
    </tbody>
  </table>
</div>
</body>
</html>
<script language="javascript">
 
</script>
<SCRIPT language="javascript" defer="defer" src='/js/datetime.js?rnd="+Math.random()+"'></script>
<SCRIPT language="javascript" defer="defer" src='/js/JSDateTime/WdatePicker.js?rnd="+Math.random()+"'></script>
<SCRIPT language="javascript"  src='/js/selectDateTime.js?rnd="+Math.random()+"'></script>