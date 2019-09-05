<%@page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="/page/maint/common/initNoCache.jsp"%>
<link href="/cpcompanyinfo/style/Operations.css" rel="stylesheet"
	type="text/css" />
<link href="/cpcompanyinfo/style/Public.css" rel="stylesheet"
	type="text/css" />
<link href="/cpcompanyinfo/style/Business.css" rel="stylesheet"
	type="text/css" />
<link href="/newportal/style/Contacts.css" rel="stylesheet"
	type="text/css" />
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>

<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%@page import="java.net.URLDecoder"%>

<div class="FL ML33" style="height:25px;width:475px;">
					
	<table width="458" border="0" cellpadding="0" cellspacing="1"
		class="stripe OTable">
		<tr id="OTable2" class="cBlack">
			<td width="20%" align="center">
				<strong><%=SystemEnv.getHtmlLabelName(30957,user.getLanguage())%></strong>
			</td>
			<td width="73%" align="center">
				<strong><%=SystemEnv.getHtmlLabelName(23752,user.getLanguage())%></strong>
			</td>
		</tr>
	</table>
	
	<div class="FR" style="height:24px;width:16px;background-color:#eeeeee; margin-top:-26px"></div>
	</div>
<div class="OContRightScroll FL OHeaderLayerW8 ML33" style="height:120px">
<table id="webTable2gd" width="458" border="0" cellpadding="0" cellspacing="1"   class="stripe OTable">
	<% 
		String companyid = Util.null2String(request.getParameter("companyid"));
		/* String sql = "select companyid ,shareaffix from ("+
			" select t1.companyid, t1.shareaffix from CPSHAREHOLDER t1"+
			" UNION "+
			" select t2.companyid,t2.drectorsaffix from CPBOARDDIRECTORS t2"+
			" UNION "+
			" select t3.companyid,t3.constituaffix from CPCONSTITUTION t3"+
			" union"+
			" select t4.companyid,t4.affixdoc from CPBUSINESSLICENSE t4 where t4.isdel='T'"+
			" )  sb where companyid = " + companyid; */
			
			//--得到该公司下的所有的附件
		String sql =" select companyid ,shareaffix,type from ( "+
			// --查询出所有的附件,并且指定附件的类型(模块类型)
		   "  select t1.companyid, t1.shareaffix,'lmshare'type from CPSHAREHOLDER t1 "+
		   "   UNION  select t2.companyid,t2.drectorsaffix,'lmdirectors' type from CPBOARDDIRECTORS t2 "+
		   "   UNION  select t3.companyid,t3.constituaffix,'lmconstitution' type from CPCONSTITUTION t3 "+
		   "   UNION  select t4.companyid,t4.affixdoc,'lmlicense' type from CPBUSINESSLICENSE t4 where t4.isdel='T' "+
		   "   )  sb where companyid = '"+companyid+"' and  ( shareaffix is not null or shareaffix !='' ) ";
  
  		System.out.println("得到该公司下的所有的附件"+sql);
		rs.execute(sql);
		//用于记录每个附件id，所属的附件类型(模块类型)
		HashMap m=new HashMap();
		String affixdoc = "";
		while(rs.next()){
			affixdoc+=Util.null2String(rs.getString("shareaffix"));
			String temp_[]=Util.null2String(rs.getString("shareaffix")).split(",");
			String kewvalue=Util.null2String(rs.getString("type"));
			for(int jk=0;jk<temp_.length;jk++){
					if(null!=temp_[jk]&&!"".equals(temp_[jk])){
							m.put(temp_[jk], kewvalue);//记录每一个附件id所对应的模块类型
					}
			}
		}
		if(!affixdoc.equals("")){
			if (',' == affixdoc.charAt(affixdoc.length() - 1)){
				affixdoc = affixdoc.substring(0,affixdoc.lastIndexOf(","));
			}
		}
		String field0 = Util.null2String(request.getParameter("field0"));
		String ship0 = Util.null2String(request.getParameter("ship0"));
		String field1 = Util.null2String(request.getParameter("field1"));
		String ship1 = Util.null2String(request.getParameter("ship1"));
		String field2 = Util.null2String(request.getParameter("field2"));
		String ship2 = Util.null2String(request.getParameter("ship2"));
		String field3 = Util.null2String(request.getParameter("field3"));
		String ship3 = Util.null2String(request.getParameter("ship3"));
		String field4 = Util.null2String(request.getParameter("field4"));
		String ship4 = Util.null2String(request.getParameter("ship4"));
		String field5 = Util.null2String(request.getParameter("field5"));
		String ship5 = Util.null2String(request.getParameter("ship5"));
		String field6 = Util.null2String(request.getParameter("field6"));
		String ship6 = Util.null2String(request.getParameter("ship6"));
		String field7 = Util.null2String(request.getParameter("field7"));
		String ship7 = Util.null2String(request.getParameter("ship7"));
		String field8 = Util.null2String(request.getParameter("field8"));
		String ship8 = Util.null2String(request.getParameter("ship8"));
		String field9 = Util.null2String(request.getParameter("field9"));
		
		String searchcondition="";
		if(!field0.equals("")){
			field0=field0.replace("_","\\_");
			searchcondition = " ta.imagefilename like '%"+field0+"%'  ESCAPE '\\'";
		}
		if(!field1.equals("")){
			field1=field1.replace("_","\\_");
			searchcondition += ship0+" ta.imagefilename like '%"+field1+"%'  ESCAPE '\\'";
			
		}
		if(!field2.equals("")){
			field2=field2.replace("_","\\_");
			searchcondition += ship1+" ta.imagefilename like '%"+field2+"%'  ESCAPE '\\'";
		}
		if(!field3.equals("")){
			field3=field3.replace("_","\\_");
			searchcondition += ship2+" ta.imagefilename like '%"+field3+"%'  ESCAPE '\\'";
		}
		if(!field4.equals("")){
			field4=field4.replace("_","\\_");
			searchcondition += ship3+" ta.imagefilename like '%"+field4+"%'  ESCAPE '\\'";
		}
		if(!field5.equals("")){
			field5=field5.replace("_","\\_");
			searchcondition += ship4+" ta.imagefilename like '%"+field5+"%' ESCAPE '\\'";
		}
		if(!field6.equals("")){
			field6=field6.replace("_","\\_");
			searchcondition += ship5+" ta.imagefilename like '%"+field6+"%' ESCAPE '\\'";
		}
		if(!field7.equals("")){
			field7=field7.replace("_","\\_");
			searchcondition += ship6+" ta.imagefilename like '%"+field7+"%' ESCAPE '\\'";
		}
		if(!field8.equals("")){
			field8=field8.replace("_","\\_");
			searchcondition += ship7+" ta.imagefilename like '%"+field8+"%' ESCAPE '\\'";
		}
		if(!field9.equals("")){
			field9=field9.replace("_","\\_");
			searchcondition += ship8+" ta.imagefilename like '%"+field9+"%'  ESCAPE '\\'";
		}
		if(field0.equals("")&&field0.equals("")&&field1.equals("")&&field2.equals("")&&field3.equals("")&&field4.equals("")&&field5.equals("")&&field6.equals("")&&field7.equals("")&&field8.equals("")&&field9.equals(""))
		searchcondition = "1=1";
		if("".equals(affixdoc)){
			affixdoc="''";
		}
	/* 	String sqldoc = " select tc.*,td.accessoriesname"+
		" from docdetail tb ,("+
		" select ta.docid,ta.imagefileid,ta.imagefilename "+
		" from docimagefile ta where ta.docid in("+affixdoc+") and ("+searchcondition+") ) tc,"+
		" mytrainaccessoriestype td"+
		" where tc.docid = tb.id and tb.maincategory = td.mainid and tb.subcategory = td.subid and tb.seccategory = td.secid"; */
		
	/* 	 String sqldoc ="select docid,imagefileid,imagefilename,maincategory,subcategory,seccategory "+
				             " from docimagefile a "+
						     "  left join  docdetail b on a.docid=b.id "+
						     "  where docid in("+affixdoc+") and ("+searchcondition+") "; */
		String sqldoc="  select imagefileid,imagefilename from imagefile ta where imagefileid in("+affixdoc+") and ("+searchcondition+") ";
		 
		// select imagefileid,imagefilename from imagefile ta where imagefileid 
		//in(1487,1488,1489) and ( ta.imagefilename like '%\_%' ESCAPE '\' ) 

		//new BaseBean().writeLog("嘻嘻"+sqldoc);
		System.out.println("嘻嘻"+sqldoc);
		

		rs.execute(sqldoc);
		while(rs.next()){
	 %>
 	<tr>
		
		<td width="20%" align="center">
				<%
					   String _type=m.get(rs.getString("imagefileid"))+"";
					   if(_type.equals("lmlicense")){
							out.print(""+SystemEnv.getHtmlLabelName(30958,user.getLanguage()));
						}else if(_type.equals("lmconstitution")){
							out.print(""+SystemEnv.getHtmlLabelName(30941,user.getLanguage()));
						}else if(_type.equals("lmshare")){
							out.print(""+SystemEnv.getHtmlLabelName(28421,user.getLanguage()));
						}else if(_type.equals("lmdirectors")){
							out.print(""+SystemEnv.getHtmlLabelName(30936,user.getLanguage()));
						}else{
							out.print("");
						} 
					%>
		</td>
		<td width="73%">
			<A href="/weaver/weaver.file.FileDownload?fileid=<%=rs.getString("imagefileid") %>&download=1" class='aContent0 FL'><%=rs.getString("imagefilename") %></A>
		</td>
	</tr>
	<%} %>
	
</table>
</div>