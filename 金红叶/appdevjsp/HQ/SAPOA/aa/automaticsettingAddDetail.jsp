
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<%@ page import="java.util.*"%>
<%@ page import="weaver.general.Util"%>
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rss" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="FieldComInfo" class="weaver.workflow.field.FieldComInfo" scope="page" />
<jsp:useBean id="GetColumns" class="APPDEV.HQ.SAPOAInterface.GetColumns" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<% 
if(!HrmUserVarify.checkUserRight("OutDataInterface:Setting",user)) {
    response.sendRedirect("/notice/noright.jsp") ;
    return ;
}
%>
<%
String biaoji=Util.null2String(request.getParameter("biaoji"));
String dbtype = RecordSet.getDBType();
String requestnamedbtype = "varchar(400)";
String createrdbtype = "int";
if(dbtype.equals("oracle")){
    requestnamedbtype = "varchar2(400)";
    createrdbtype = "integer";
}

String isdialog = Util.null2String(request.getParameter("isdialog"));
String shifou="0";
String typename = Util.null2String(request.getParameter("typename"));
String viewid=Util.null2String(request.getParameter("viewid"));//数据id
String setname = "";
String workFlowId = "";
String paixu = "";
String describe = "";


String workFlowName = "";


String isbill = "";
String formID = "";
String outermaintable = "";


String isview = "";
RecordSet.executeSql("select * from zoa_wfcode_mapping where id="+viewid);
if(RecordSet.next()){
    setname = Util.null2String(RecordSet.getString("LC_TYPE"));
    workFlowId = Util.null2String(RecordSet.getString("WfId"));
    paixu = Util.null2String(RecordSet.getString("shower"));
    workFlowName=Util.null2String(WorkflowComInfo.getWorkflowname(workFlowId));
    isbill=Util.null2String(WorkflowComInfo.getIsBill(workFlowId));
    formID=Util.null2String(WorkflowComInfo.getFormId(workFlowId));
    describe = Util.null2String(RecordSet.getString("remark"));


    isview= Util.null2String(RecordSet.getString("isview"));

}



ArrayList maintablecolsList = GetColumns.getAllColumns(workFlowId);//遍历字段
ArrayList outerdetailtablesArr =new ArrayList();

String tableName="";
String aa="select tablename from workflow_billdetailtable  where billid in (Select formid From workflow_base Where id= " + workFlowId+ ") order by orderid " ;
		RecordSet.execute(aa);
		while(RecordSet.next()) {
			tableName = Util.null2String(RecordSet.getString("tablename"));
			outerdetailtablesArr.add(tableName); 
		} 
aa= " Select tablename From Workflow_bill Where id in ("
				+ " Select formid From workflow_base Where id= " + workFlowId
				+ ")";
				
RecordSet.execute(aa);
String zhutableName="";
while(RecordSet.next()) {
			zhutableName = Util.null2String(RecordSet.getString("tablename"));
		} 				
				
		
String maintableoptions = "";
String temptableoptions = "";
String temprulesoptvalue = "0";
String tempiswriteback = "0";
String tempcustomsql = "";
for(int i=0;i<maintablecolsList.size();i++){
    String columnname = outermaintable+"."+(String)maintablecolsList.get(i);
    maintableoptions += "<option value='"+columnname+"'>"+columnname+"</option>";
}

int fieldscount = 0;

Hashtable outerfieldname_ht = new Hashtable();
Hashtable changetype_ht = new Hashtable();
Hashtable customsql_ht = new Hashtable();
Hashtable iswriteback_ht = new Hashtable();
RecordSet.executeSql("select * from outerdatawfsetdetail where mainid="+viewid+" order by id");
while(RecordSet.next()){
    String wffieldid = Util.null2String(RecordSet.getString("wffieldid"));
    String outerfieldname = Util.null2String(RecordSet.getString("outerfieldname"));
    String customsql = Util.null2String(RecordSet.getString("customsql"));
    String changetype = Util.null2String(RecordSet.getString("changetype"));
    String iswriteback = Util.null2String(RecordSet.getString("iswriteback"));
    outerfieldname_ht.put(wffieldid,outerfieldname);
    customsql_ht.put(wffieldid,customsql);
    changetype_ht.put(wffieldid,changetype);
    iswriteback_ht.put(wffieldid,iswriteback);
}
String tiptitle1 = SystemEnv.getHtmlLabelName(125539,user.getLanguage());//如果转换规则为自定义sql，此设置查询的是当前系统，格式为：select 最终字段 from tablename where 条件字段={?currentvalue}，{?currentvalue}为固定格式。
%>
<html>
<head>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<script type="text/javascript" src="/js/weaver_wev8.js"></script>
<link rel="stylesheet" href="/css/ecology8/request/requestTopMenu_wev8.css" type="text/css" />
<link rel="stylesheet" href="/wui/theme/ecology8/jquery/js/zDialog_e8_wev8.css" type="text/css" />
<script type="text/javascript" src="/js/dragBox/parentShowcol_wev8.js"></script>
<link rel="stylesheet" href="/css/ecology8/request/requestView_wev8.css" type="text/css" />
<script language=javascript src="/js/ecology8/request/e8.browser_wev8.js"></script>
<link href="/js/checkbox/jquery.tzCheckbox_wev8.css" type=text/css rel=STYLESHEET>
<script type="text/javascript" src="/js/ecology8/jNice/jNice/jquery.jNice_wev8.js"></script>
</head>
<%
String imagefilename = "/images/hdDOC_wev8.gif";
String titlename = SystemEnv.getHtmlLabelName(23076,user.getLanguage())+" - "+SystemEnv.getHtmlLabelName(19342,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<body id="setbody">
<%if("1".equals(isdialog)){ %>
<div class="zDialog_div_content">
<script language=javascript >
var parentWin = parent.parent.getParentWindow(parent);
</script>
<%} %>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:doSubmit(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<table id="topTitle" cellpadding="0" cellspacing="0">
	<tr>
		<td></td>
		<td class="rightSearchSpan" style="text-align:right; width:500px!important">
		

			<input type="button" id="doSubmit" value="<%=SystemEnv.getHtmlLabelName(86 ,user.getLanguage()) %>" class="e8_btn_top" onclick="doSubmit()"/>
			<span title="<%=SystemEnv.getHtmlLabelName(23036 ,user.getLanguage()) %>" class="cornerMenu"></span>
		</td>
	</tr>
</table>
<form id="frmmain" name="frmmain" method="post" action="automaticOperation.jsp">
<input type="hidden" id="operate" name="operate" value="adddetail">
<input type="hidden" id="viewid" name="viewid" value="<%=viewid%>">
<input type="hidden" id="typename" name="typename" value="<%=typename%>">

<input type="hidden" id="fieldscount" name="fieldscount" value="<%=fieldscount%>">
<%if("1".equals(isdialog)){ %>
<input type="hidden" name="isdialog" value="<%=isdialog%>">
<%} %>
<input  type="hidden" name="zhutableName" id="zhutableName" value='<%=zhutableName%>'>
<input  type="hidden" name="num" id="num" value='<%=outerdetailtablesArr.size()%>'>
<%
	String  zhubiaoshi="";
	List list1=new ArrayList();//明细标识
	List list2=new ArrayList();//明细id
	List list3=new ArrayList();//页面明细 shower
    String bbb="select Flag  from zoa_wftable_map  where  Fid='"+viewid+"' and shower='0'" ;
    rs.executeSql(bbb);
    if(rs.next()){zhubiaoshi=rs.getString("Flag");}
    String cc="select tablename from workflow_billdetailtable where billid =(select formid  from workflow_base where id= (select WfId from zoa_wfcode_mapping  where id='"+viewid+"'))  order by orderid  asc";
    rs.executeSql(cc);
    while(rs.next()){
		String mname=Util.null2String(rs.getString("tablename"));
		bbb="select id, TBNAME, Flag ,shower  from zoa_wftable_map  where  Fid='"+viewid+"' and shower not in ( '0')  and   isactive=1  order by shower " ;
		RecordSet.executeSql(bbb);
		while(RecordSet.next()){
			String TBNAME=Util.null2String(RecordSet.getString("TBNAME"));
			String Flag=Util.null2String(RecordSet.getString("Flag"));
			String mingid=Util.null2String(RecordSet.getString("id"));
			String shower=Util.null2String(RecordSet.getString("shower"));
			if(mname.equals(TBNAME)){
				list1.add(Flag);
				list2.add(mingid);
				list3.add(shower);
			}
		}
	         
   }
   
%>
主表标识：<input  type="text" name="zhubiaoshi" id="zhubiaoshi" value='<%=zhubiaoshi%>'>
<%for(int i=0;i<outerdetailtablesArr.size();i++){ 
	if(i<list1.size()){
%>
明细标识<%=i+1%>:<input  type="text" name="mingxibiaoshi_<%=i%>" id="mingxibiaoshi_<%=i%>" value='<%=list1.get(i)%>'>
		<input  type="hidden" name="mingxiid_<%=i%>" id="mingxiid_<%=i%>" value='<%=list2.get(i)%>'>
		<input  type="hidden" name="shower_<%=i%>" id="shower_<%=i%>" value='<%=list3.get(i)%>'>
<%}else {%>
明细标识<%=i+1%>:<input  type="text" name="mingxibiaoshi_<%=i%>" id="mingxibiaoshi_<%=i%>" value=''>

<%}
}%>
<wea:layout>

		<%
		String tempfieldname = "";
		if(!workFlowId.equals("")){ %>
		<wea:group context="<%=SystemEnv.getHtmlLabelNames("6074,24087",user.getLanguage())%>" attributes="{'samePair':'SetInfo','groupOperDisplay':'none','itemAreaDisplay':'block'}">
			
			<wea:item attributes="{'colspan':'2','isTableList':'true'}">
				<table class=ListStyle cellspacing=1>
					<colgroup>
					<col width="15%">
					<col width="15%">
					<col width="15%">
					<col width="20%">
					<col width="20%">
					<col width="15%">
					
					<tr class=header>
						<td>OA系统字段</td>
						<td>SAP字段名</td>
						<td>转换类型</td>
						<td>转换内容</td>
						<td>内容描述</td>
						<td>启用标识</td>
					</tr>
					<%
					ArrayList fieldids = new ArrayList();             //字段队列
					ArrayList fieldlabels = new ArrayList();          //字段的label队列
					ArrayList fieldhtmltypes = new ArrayList();       //字段的html type队列
					ArrayList fieldtypes = new ArrayList();           //字段的type队列
					ArrayList fieldnames = new ArrayList();           //字段名队列
					ArrayList fielddbtypes = new ArrayList();         //字段数据类型
					if(!formID.equals("")){
					    if(isbill.equals("0")){//表单
					        RecordSet.executeSql("select t2.fieldid,t2.fieldorder,t1.fieldlable,t1.langurageid from workflow_fieldlable t1,workflow_formfield t2 where t1.formid=t2.formid and t1.fieldid=t2.fieldid and (t2.isdetail<>'1' or t2.isdetail is null)  and t2.formid="+formID+"  and t1.langurageid="+user.getLanguage()+" order by t2.fieldid ");
					        while(RecordSet.next()){
					            fieldids.add(Util.null2String(RecordSet.getString("fieldid")));
					            fieldlabels.add(Util.null2String(RecordSet.getString("fieldlable")));
					        }
					    }else if(isbill.equals("1")){//单据
					        RecordSet.executeSql("select * from workflow_billfield where viewtype=0 and billid="+formID);
					        while(RecordSet.next()){
					            fieldids.add(Util.null2String(RecordSet.getString("id")));
					            fieldlabels.add(Util.null2String(RecordSet.getString("fieldlabel")));
					            fieldhtmltypes.add(Util.null2String(RecordSet.getString("fieldhtmltype")));
					            fieldtypes.add(Util.null2String(RecordSet.getString("type")));
					            fieldnames.add(Util.null2String(RecordSet.getString("fieldname")));
					            fielddbtypes.add(Util.null2String(RecordSet.getString("fielddbtype")));
					        }
					    }
					}
					for(int i=0;i<fieldids.size();i++){// 主字段循环开始
					    fieldscount++;
					    String fieldid = (String)fieldids.get(i);
					    String fieldlable = (String)fieldlabels.get(i);
						String SapFieldlable="";
					    String fieldhtmltype = "";
					    String fieldtype = "";
					    String fieldname = "";
					    String fielddbtype = "";
					    if(isbill.equals("0")){
					        fieldhtmltype = FieldComInfo.getFieldhtmltype(fieldid);
					        fieldtype = FieldComInfo.getFieldType(fieldid);
					        fieldname = FieldComInfo.getFieldname(fieldid);
							SapFieldlable=fieldname;
					        fielddbtype = FieldComInfo.getFielddbtype(fieldid);
					    }else if(isbill.equals("1")){
					        fieldhtmltype = (String)fieldhtmltypes.get(i);
					        fieldtype = (String)fieldtypes.get(i);
					        fieldname = (String)fieldnames.get(i);
							SapFieldlable=fieldname;
					        fieldlable = SystemEnv.getHtmlLabelName( Util.getIntValue(fieldlable,0),user.getLanguage() );
					        fielddbtype = (String)fielddbtypes.get(i);
					    }
					%>  
					<%if(i%2==1){%><tr class=DataDark><%}%>
					<%if(i%2==0){%><tr class=DataLight><%}%>
						<td>
							<%=fieldlable%>(<%=SapFieldlable%>)
							<input type="hidden" id="field_index_<%=fieldscount%>" name="field_index_<%=fieldscount%>" value="<%=SapFieldlable%>">
							<input type="hidden" id="fieldid_index_<%=fieldscount%>" name="fieldid_index_<%=fieldscount%>" value="<%=fieldid%>">
							<input type="hidden" id="fieldname_index_<%=fieldscount%>" name="fieldname_index_<%=fieldscount%>" value="<%=fieldname%>">
							<input type="hidden" id="fieldhtmltype_index_<%=fieldscount%>" name="fieldhtmltype_index_<%=fieldscount%>" value="<%=fieldhtmltype%>">
							<input type="hidden" id="fieldtype_index_<%=fieldscount%>" name="fieldtype_index_<%=fieldscount%>" value="<%=fieldtype%>">
							<input type="hidden" id="fielddbtype_index_<%=fieldscount%>" name="fielddbtype_index_<%=fieldscount%>" value="<%=fielddbtype%>">
							<input type="hidden" id="zhus_<%=fieldscount%>" name="zhus_<%=fieldscount%>" value="<%=fieldids.size()%>">
						</td>
						<%
						
						temptableoptions = maintableoptions;
						tempfieldname = Util.null2String((String)outerfieldname_ht.get(fieldid));
						if(!tempfieldname.equals("")){
						    String replaceedStr = "<option value='"+tempfieldname+"'>"+tempfieldname+"</option>";
						    String replaceStr = "<option value='"+tempfieldname+"' selected>"+tempfieldname+"</option>";
						    temptableoptions = Util.replace(temptableoptions,replaceedStr,replaceStr,0);
						}
						%>
						
						
						
						<%
						  String yanzh="select SAPFIELDNAME,CHANGETYPE,CHANGEINFO,REMARK ,ISACTIVE  from  zoa_wffield_map where TID= (select ID from zoa_wftable_map where fid ="+viewid+"   and TYPE='M'  ) and FIELDNAME = UPPER('"+SapFieldlable+"')";
						  rss.executeSql(yanzh);
						  if(rss.next()){
							  String  SAPFIELDNAME = Util.null2String(rss.getString("SAPFIELDNAME"));
							  String  CHANGETYPE = Util.null2String(rss.getString("CHANGETYPE"));
							  
							  String  CHANGEIN = Util.null2String(rss.getString("CHANGEINFO"));
							  String  CHANGEINFO =CHANGEIN.replaceAll("dual","duaal");
							  String  REMARK =Util.null2String(rss.getString("REMARK"));
							  String  ISACTIVE =Util.null2String(rss.getString("ISACTIVE"));
							  if(!SAPFIELDNAME.equals("")){%>
								  <td>
								<input type="text" id="waiyuanziduan_<%=fieldscount%>" name="waiyuanziduan_<%=fieldscount%>"   value="<%=SAPFIELDNAME%>">
								</td>  
							 <% }else{
									if(CHANGETYPE.equals("5") || CHANGETYPE.equals("7")){%>
										<td>
										<input type="text"  id="waiyuanziduan_<%=fieldscount%>" name="waiyuanziduan_<%=fieldscount%>"   value=""  readOnly> 
										</td>  
									<%}else{%>
										<td>
										<input type="text"  id="waiyuanziduan_<%=fieldscount%>" name="waiyuanziduan_<%=fieldscount%>"   value="" > 
										</td> 
									<%}
								 %>
							<% }
							if(!CHANGETYPE.equals("")){%>
								<td>
							<select id="zhaunhuan_<%=fieldscount%>" name="zhaunhuan_<%=fieldscount%>" onchange="onSelect(<%=fieldscount%>)" >
								<option value="0" <% if(CHANGETYPE.equals("0")) out.print("selected");%> >不转换</option>
								<option value="1" <% if(CHANGETYPE.equals("1")) out.print("selected");%>  >固定值</option>
								<option value="2" <% if(CHANGETYPE.equals("2")) out.print("selected");%> >SQL转换</option>
								<option value="3" <% if(CHANGETYPE.equals("3")) out.print("selected");%> >长文本</option>
								<option value="5" <% if(CHANGETYPE.equals("5")) out.print("selected");%> >INDEX_NO</option>
								<option value="7" <% if(CHANGETYPE.equals("7")) out.print("selected");%>  >MANDT</option>
							</select>    						
						</td>	
							<%}else{%>
								<td>
							<select id="zhaunhuan_<%=fieldscount%>" name="zhaunhuan_<%=fieldscount%>" onchange="onSelect(<%=fieldscount%>)" >
								<option value="0"  >不转换</option>
								<option value="1"  >固定值</option>
								<option value="2"  >SQL转换</option>
								<option value="3"  >长文本</option>
								<option value="5"  >INDEX_NO</option>
								<option value="7"  >MANDT</option>
							</select>    						
						</td>
							<%}
							if(!CHANGEINFO.equals("")){%>
								<td>
							<textarea  id="zhuanhuanneirong_<%=fieldscount%>" name="zhuanhuanneirong_<%=fieldscount%>" rows=1  ><%=CHANGEINFO%></textarea>
							
								</td>
							
							<%	
							}else{%>
								<td>
							<textarea  id="zhuanhuanneirong_<%=fieldscount%>" name="zhuanhuanneirong_<%=fieldscount%>" rows=1  ></textarea>
							
								</td>
							<%}   
							 if(!REMARK.equals("")){%>
							 <td>
							<textarea   id="neirongmiaoshu_<%=fieldscount%>" name="neirongmiaoshu_<%=fieldscount%>" rows=1 ><%=REMARK%></textarea>
								</td> 
							 <% }else{%>
							  <td>
							<textarea   id="neirongmiaoshu_<%=fieldscount%>" name="neirongmiaoshu_<%=fieldscount%>" rows=1 ></textarea>
								</td> 
							 <%}  
							 if(!ISACTIVE.equals("")){%>
							 <td>
							<input type="checkbox" tzCheckbox="true" class=InputStyle id="shifou1_<%=fieldscount%>" name="shifou1_<%=fieldscount%>" value="<%=ISACTIVE%>" onclick="aa(<%=fieldscount%>)"   <%if("1".equals(ISACTIVE)) {%> checked <%}%>>
				
							<input type="hidden"  id="shifou_<%=fieldscount%>" name="shifou_<%=fieldscount%>"  value="<%=ISACTIVE%>" > 
						</td>
							 <%
								
							}else{%>
							<td>
							<input type="checkbox" tzCheckbox="true" class=InputStyle id="shifou1_<%=fieldscount%>" name="shifou1_<%=fieldscount%>" value="0" onclick="aa(<%=fieldscount%>)" >
				
							<input type="hidden"  id="shifou_<%=fieldscount%>" name="shifou_<%=fieldscount%>"   value="<%=shifou%>" > 
						</td>
							
							<%}  	  
							  
						  }else{%>
							  <td>
								<input type="text" id="waiyuanziduan_<%=fieldscount%>" name="waiyuanziduan_<%=fieldscount%>"   value=""> 
							 </td>  
							  <td>
							<select id="zhaunhuan_<%=fieldscount%>" name="zhaunhuan_<%=fieldscount%>" onchange="onSelect(<%=fieldscount%>)">
								<option value="0"  >不转换</option>
								<option value="1"  >固定值</option>
								<option value="2"  >SQL转换</option>
								<option value="3"  >长文本</option>
								<option value="5"  >INDEX_NO</option>
								<option value="7"  >MANDT</option>
							</select>    
							 <td>
							<textarea  id="zhuanhuanneirong_<%=fieldscount%>" name="zhuanhuanneirong_<%=fieldscount%>" rows=1  ></textarea>
							
								</td> 
							  <td>
							<textarea   id="neirongmiaoshu_<%=fieldscount%>" name="neirongmiaoshu_<%=fieldscount%>" rows=1 ></textarea>
								</td>  
								<td>
							<input type="checkbox" tzCheckbox="true" class=InputStyle id="shifou1_<%=fieldscount%>" name="shifou1_<%=fieldscount%>" value="0" onclick="aa(<%=fieldscount%>)">
				
							<input type="hidden"  id="shifou_<%=fieldscount%>" name="shifou_<%=fieldscount%>"  value="<%=shifou%>" > 
						</td>
							  
						 <% }
						
						%>
						
					</tr>  
					<%}%>
				</table>
			</wea:item>
		</wea:group>
		
		
		
		

		
		
		<%
		    int detailindex = 0;
			int bb=0;
		     String detailsSQL = "select tablename from Workflow_billdetailtable where billid="+formID+" order by orderid";
		    boolean isonlyone = false;
		    RecordSet.executeSql(detailsSQL);
		    if(RecordSet.getCounts()==0){
		        //没有记录不代表没有明细,单据对应的明细表可能没有写进Workflow_billdetailtable中
		        //但此时可以确定该单据即使有明细，也只有一个明细。
		        isonlyone = true;
		        detailsSQL = "select distinct viewtype from workflow_billfield where viewtype=1 and billid="+formID;
		    }
		    RecordSet.executeSql(detailsSQL);
		    while(RecordSet.next()){//单据明细字段
		        String outdetailtable = "";//流程明细对应外部数据表
		        if(outerdetailtablesArr.size()>detailindex) outdetailtable = (String)outerdetailtablesArr.get(detailindex);
		        detailindex++;
		        String outerdetailoptions = "";
	         /* ArrayList outdetailtablecolsList = GetColumns.getMingxColumns(outdetailtable);
	          for(int j=0;j<outdetailtablecolsList.size();j++){
	              String detailcolname = outdetailtable+"."+(String)outdetailtablecolsList.get(j);
	              outerdetailoptions += "<option value='"+detailcolname+"'>"+detailcolname+"</option>";
	          }*/
		        String fieldsSearchSql = "select * from workflow_billfield where viewtype=1 and billid="+formID+" order by dsporder";
		        if(isonlyone)
		            fieldsSearchSql = "select * from workflow_billfield where viewtype=1 and billid="+formID+" order by dsporder";
		        else
		            fieldsSearchSql = "select * from workflow_billfield where detailtable='"+RecordSet.getString("tablename")+"' and viewtype=1 and billid="+formID+" order by dsporder";
		%>
		
		
		<input type="text" id="" name="" value="">
		<wea:group context='<%=SystemEnv.getHtmlLabelName(17463,user.getLanguage())+SystemEnv.getHtmlLabelName(24087,user.getLanguage())%>' attributes="{'samePair':'DetailInfo','groupOperDisplay':'none','itemAreaDisplay':'block'}">
		<wea:item attributes="{'colspan':'2','isTableList':'true'}">
				<table class=ListStyle cellspacing=1>
					<colgroup>
					<col width="15%">
					<col width="15%">
					<col width="15%">
					<col width="20%">
					<col width="20%">
					<col width="15%">
					<tr class=header>
						<td>明细字段<%=detailindex%></td>
						<td>SAP字段名</td>
						<td>转换类型</td>
						<td>转换内容</td>
						<td>内容描述</td>
						<td>启用标识</td>
					</tr>
					<%
					int colorindex = 0;
					rs1.executeSql(fieldsSearchSql);
					String SapDetailfield="";
				  while(rs1.next()){
				      fieldscount++;
				      String detailfieldid = Util.null2String(rs1.getString("id"));
				      String detailfieldname = Util.null2String(rs1.getString("fieldname"));
					  SapDetailfield=detailfieldname;
				      String detailfieldhtmltype = Util.null2String(rs1.getString("fieldhtmltype"));
				      String detailfieldtype = Util.null2String(rs1.getString("type"));
				      String detailfielddbtype = Util.null2String(rs1.getString("fielddbtype"));
				      String detailfieldlable = Util.null2String(rs1.getString("fieldlabel"));
				      detailfieldlable = SystemEnv.getHtmlLabelName(Util.getIntValue(detailfieldlable),user.getLanguage());
					%>
					<%if(colorindex==0){
					    colorindex = 1;
					%>
					<tr class=DataDark>
					<%}else{
					    colorindex = 0;
					 %>
					<tr class=DataLight>
					<%}%>
						<td>
							<%=detailfieldlable%>(<%=SapDetailfield%>)
							<input type="hidden" id="field_index_<%=fieldscount%>" name="field_index_<%=fieldscount%>" value="<%=SapDetailfield%>">
							<input type="hidden" id="fieldid_index_<%=fieldscount%>" name="fieldid_index_<%=fieldscount%>" value="<%=detailfieldid%>">
							<input type="hidden" id="fieldname_index_<%=fieldscount%>" name="fieldname_index_<%=fieldscount%>" value="<%=detailfieldname%>">
							<input type="hidden" id="fieldhtmltype_index_<%=fieldscount%>" name="fieldhtmltype_index_<%=fieldscount%>" value="<%=detailfieldhtmltype%>">
							<input type="hidden" id="fieldtype_index_<%=fieldscount%>" name="fieldtype_index_<%=fieldscount%>" value="<%=detailfieldtype%>">
							<input type="hidden" id="fielddbtype_index_<%=fieldscount%>" name="fielddbtype_index_<%=fieldscount%>" value="<%=detailfielddbtype%>">
						</td>
						<%
						temptableoptions = outerdetailoptions;
						tempfieldname = Util.null2String((String)outerfieldname_ht.get(detailfieldid));
						if(!tempfieldname.equals("")){
						    String replaceedStr = "<option value='"+tempfieldname+"'>"+tempfieldname+"</option>";
						    String replaceStr = "<option value='"+tempfieldname+"' selected>"+tempfieldname+"</option>";
						    temptableoptions = Util.replace(temptableoptions,replaceedStr,replaceStr,0);
						}///////////////////////////////////////////////////////////////////
						%>
						
						
						<%
						  String yanzh="select SAPFIELDNAME,CHANGETYPE,CHANGEINFO,REMARK ,ISACTIVE  from  zoa_wffield_map where TID= (select ID from zoa_wftable_map where fid ="+viewid+"   and TYPE not in ('M') and  tbname= '"+RecordSet.getString("tablename")+"' and  ISACTIVE=1 ) and FIELDNAME = UPPER('"+SapDetailfield+"')";
						  rss.executeSql(yanzh);
						  if(rss.next()){
							  String  SAPFIELDNAME =Util.null2String(rss.getString("SAPFIELDNAME"));
							  String  CHANGETYPE =Util.null2String(rss.getString("CHANGETYPE"));
							  String  CHANGEIN = Util.null2String(rss.getString("CHANGEINFO"));
							  String  CHANGEINFO =CHANGEIN.replaceAll("dual","duaal");
							  String  REMARK =Util.null2String(rss.getString("REMARK"));
							  String  ISACTIVE =Util.null2String(rss.getString("ISACTIVE"));
							  if(!SAPFIELDNAME.equals("")){%>
								  <td>
								<input type="text" id="waiyuanziduan_<%=fieldscount%>" name="waiyuanziduan_<%=fieldscount%>"   value="<%=SAPFIELDNAME%>">
								</td>  
							 <% }else{
									if(CHANGETYPE.equals("5") || CHANGETYPE.equals("7")){%>
										<td>
										<input type="text"  id="waiyuanziduan_<%=fieldscount%>" name="waiyuanziduan_<%=fieldscount%>"   value=""  readOnly> 
										</td>  
									<%}else{%>
										<td>
										<input type="text"  id="waiyuanziduan_<%=fieldscount%>" name="waiyuanziduan_<%=fieldscount%>"   value="" > 
										</td> 
									<%}
								 %>
							<% }
							if(!CHANGETYPE.equals("")){%>
								<td>
							<select id="zhaunhuan_<%=fieldscount%>" name="zhaunhuan_<%=fieldscount%>" onchange="onSelect(<%=fieldscount%>)" >
								<option value="0" <% if(CHANGETYPE.equals("0")) out.print("selected");%> >不转换</option>
								<option value="1" <% if(CHANGETYPE.equals("1")) out.print("selected");%>  >固定值</option>
								<option value="2" <% if(CHANGETYPE.equals("2")) out.print("selected");%> >SQL转换</option>
								<option value="3" <% if(CHANGETYPE.equals("3")) out.print("selected");%> >长文本</option>
								<option value="4" <% if(CHANGETYPE.equals("4")) out.print("selected");%> >附件</option>
								<option value="5" <% if(CHANGETYPE.equals("5")) out.print("selected");%> >INDEX_NO</option>
								<option value="6" <% if(CHANGETYPE.equals("6")) out.print("selected");%>  >超链接</option>
								<option value="7" <% if(CHANGETYPE.equals("7")) out.print("selected");%>  >MANDT</option>
							</select>    						
						</td>	
							<%}else{%>
								<td>
							<select id="zhaunhuan_<%=fieldscount%>" name="zhaunhuan_<%=fieldscount%>" onchange="onSelect(<%=fieldscount%>)" >
								<option value="0"  >不转换</option>
								<option value="1"  >固定值</option>
								<option value="2"  >SQL转换</option>
								<option value="3"  >长文本</option>
								<option value="4"  >附件</option>
								<option value="5"  >INDEX_NO</option>
								<option value="6"  >超链接</option>
								<option value="7"  >MANDT</option>
							</select>    						
						</td>
							<%}
							if(!CHANGEINFO.equals("")){%>
								<td>
							<textarea  id="zhuanhuanneirong_<%=fieldscount%>" name="zhuanhuanneirong_<%=fieldscount%>" rows=1  ><%=CHANGEINFO%></textarea>
							
								</td>
							
							<%	
							}else{%>
								<td>
							<textarea  id="zhuanhuanneirong_<%=fieldscount%>" name="zhuanhuanneirong_<%=fieldscount%>" rows=1  ></textarea>
							
								</td>
							<%}   
							 if(!REMARK.equals("")){%>
							 <td>
							<textarea   id="neirongmiaoshu_<%=fieldscount%>" name="neirongmiaoshu_<%=fieldscount%>" rows=1 ><%=REMARK%></textarea>
								</td> 
							 <% }else{%>
							  <td>
							<textarea   id="neirongmiaoshu_<%=fieldscount%>" name="neirongmiaoshu_<%=fieldscount%>" rows=1 ></textarea>
								</td> 
							 <%}  
							 if(!ISACTIVE.equals("")){%>
							 <td>
							<input type="checkbox" tzCheckbox="true" class=InputStyle id="shifou1_<%=fieldscount%>" name="shifou1_<%=fieldscount%>" value="<%=ISACTIVE%>" onclick="aa(<%=fieldscount%>)"   <%if("1".equals(ISACTIVE)) {%> checked <%}%>>
				
							<input type="hidden"  id="shifou_<%=fieldscount%>" name="shifou_<%=fieldscount%>"    value="<%=ISACTIVE%>"  > 
						</td>
							 <%
								
							}else{%>
							<td>
							<input type="checkbox" tzCheckbox="true" class=InputStyle id="shifou1_<%=fieldscount%>" name="shifou1_<%=fieldscount%>" value="0" onclick="aa(<%=fieldscount%>)" >
				
							<input type="hidden"  id="shifou_<%=fieldscount%>" name="shifou_<%=fieldscount%>"    value="<%=shifou%>"  > 
						</td>
							
							<%}  	  
							  
						  }else{%>
							  <td>
								<input type="text" id="waiyuanziduan_<%=fieldscount%>" name="waiyuanziduan_<%=fieldscount%>"   value=""> 
							 </td>  
							  <td>
							<select id="zhaunhuan_<%=fieldscount%>" name="zhaunhuan_<%=fieldscount%>" onchange="onSelect(<%=fieldscount%>)">
								<option value="0"  >不转换</option>
								<option value="1"  >固定值</option>
								<option value="2"  >SQL转换</option>
								<option value="3"  >长文本</option>
								<option value="4"  >附件</option>
								<option value="5"  >INDEX_NO</option>
								<option value="6"  >超链接</option>
								<option value="7"  >MANDT</option>
							</select>    
							 <td>
							<textarea  id="zhuanhuanneirong_<%=fieldscount%>" name="zhuanhuanneirong_<%=fieldscount%>" rows=1  ></textarea>
							
								</td> 
							  <td>
							<textarea   id="neirongmiaoshu_<%=fieldscount%>" name="neirongmiaoshu_<%=fieldscount%>" rows=1 ></textarea>
								</td>  
								<td>
							<input type="checkbox" tzCheckbox="true" class=InputStyle id="shifou1_<%=fieldscount%>" name="shifou1_<%=fieldscount%>" value="0" onclick="aa(<%=fieldscount%>)"  >
				
							<input type="hidden"  id="shifou_<%=fieldscount%>" name="shifou_<%=fieldscount%>"     value="<%=shifou%>" > 
						</td>
							  
						 <% }
						
						%>
					</tr>
					<%}%>
				</table>
			</wea:item>
			</wea:group>
		<%}
		}%>
  </wea:layout>
</form>
<%if("1".equals(isdialog)){ %>
	<div id="zDialog_div_bottom" class="zDialog_div_bottom">
		<input type="button" style="display:none;" class=zd_btn_submit accessKey=S  id=btnsearch value="S-<%=SystemEnv.getHtmlLabelName(197,user.getLanguage())%>"></input>
		<wea:layout needImportDefaultJsAndCss="false">
			<wea:group context=""  attributes="{'groupDisplay':'none'}">
				<wea:item type="toolbar">
					<input type="button" class=zd_btn_cancle accessKey=T  id=btncancel value="T-<%=SystemEnv.getHtmlLabelName(309,user.getLanguage())%>" onclick='onClose();'></input>
				</wea:item>
			</wea:group>
		</wea:layout>
		<script type="text/javascript">
			jQuery(document).ready(function(){
				resizeDialog(document);
			});
		</script>
	</div>
</div>
<%} %>
</body>
</html>
<script language="javascript">
function aa(index){
	
	var shifou_val=jQuery("#shifou1_"+index).val();
	if(shifou_val==0){
		jQuery("#shifou_"+index).val("1");
		jQuery("#shifou1_"+index).val("1");
	}else{
		jQuery("#shifou_"+index).val("0");
		jQuery("#shifou1_"+index).val("0");
	}
	
}

function onSelect(index){
	var zhaunhuan_val=jQuery("#zhaunhuan_"+index).val();
	if(zhaunhuan_val=='5'||zhaunhuan_val=='7'){
		jQuery("#waiyuanziduan_"+index).val("");
		jQuery("#waiyuanziduan_"+index).attr("readOnly","true");
	}else{
		jQuery("#waiyuanziduan_"+index).removeAttr("readOnly");
	}
	
	
}


jQuery(document).ready(function(){
	jQuery("#shifou").val("0");
 jQuery("input[type=checkbox]").each(function(){
  if(jQuery(this).attr("tzCheckbox")=="true"){
   jQuery(this).tzCheckbox({labels:['','']});
  }
 });
});

/* window.onbeforeunload = function protectManageBillFlow(event){
	alert(6);
  	if(!checkDataChange())//added by cyril on 2008-06-10 for TD:8828
        return "<%=SystemEnv.getHtmlLabelName(18407,user.getLanguage())%>";
} */
function doSubmit(){
    document.getElementById("fieldscount").value = "<%=fieldscount%>";
    //jQuery("#setbody").attr("onbeforeunload", "");//事件的绑定，当页面关闭或者加载即将离开本页面时触发
	var len= parseInt("<%=fieldscount%>");
	for(var i=1;i<=len;i++){
		var waiyuanziduan_val=jQuery("#waiyuanziduan_"+i).val();
		var zhaunhuan_val=jQuery("#zhaunhuan_"+i).val();
		var shifou_val=jQuery("#shifou_"+i).val();
		var zhuanhuanneirong_val=jQuery("#zhuanhuanneirong_"+i).val();
		
		if(waiyuanziduan_val==''&&shifou_val=='1' && zhaunhuan_val!='5'&& zhaunhuan_val!='7'){
			Dialog.alert("转换类型非INDEX_NO和MANDT的时候，SAP字段为空，不能被启用！请重新检查！");
			return;
		}
		if(zhaunhuan_val=='2'&&zhuanhuanneirong_val==''){
			Dialog.alert("转换类型为SQL的时候，转换内容必须填写！请写入相应转换内容！");
			return;
			
		}
		
	}
	
	var  aa=parseInt("<%=outerdetailtablesArr.size()%>");
	for(var i=0;i<aa;i++){
		var biaoshi=jQuery("#mingxibiaoshi_"+i).val();
		if(biaoshi==''){
			Dialog.alert("明细标识不能为空，请填入相应的明细标识！");
			return;
		}
		
	}
	$('#frmmain').submit(); 
	//$GetEle("frmmain").submit();//document.frmmain.submit();
	
	
    
}
function changeRules(rulevalue,order){
    if(rulevalue==5){
    	if(order==2)
    	{
	        document.getElementById("outerfieldnamediv").style.display = "none";
	        document.getElementById("fixhrmresource").style.display = "";
        }
        document.getElementById("customsql_"+order).style.display = "none";
    }
    else if(rulevalue==6){
    	if(order==2)
    	{
	        document.getElementById("outerfieldnamediv").style.display = "";
	        document.getElementById("fixhrmresource").style.display = "none";
        }
        document.getElementById("customsql_"+order).style.display = "";
    }
    else{
    	if(order==2)
    	{
	        document.getElementById("outerfieldnamediv").style.display = "";
	        document.getElementById("fixhrmresource").style.display = "none";
        }
        document.getElementById("customsql_"+order).style.display = "none";
    }
}
function onShowHrmResource(inputename,tdname){
	var ids = jQuery("#"+inputename).val();            
	var datas=null;
	var iTop = (window.screen.availHeight-30-550)/2+"px"; //获得窗口的垂直位置;
	var iLeft = (window.screen.availWidth-10-550)/2+"px"; //获得窗口的水平位置; 
	datas = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?resourceids="+ids);
    
    if (datas){
	    if (datas.id!= "" ){
	    	var strs="<a href=javaScript:openhrm("+datas.id+"); onclick='pointerXY(event);'>"+datas.name+"</a>&nbsp";
            
			jQuery("#"+tdname).html(strs);
			jQuery("#"+inputename).val(datas.id);
		}
		else{
			jQuery("#"+tdname).html("");
			jQuery("#"+inputename).val("");
		}
	}
}
/* function onBackUrl(url)
{
	jQuery($GetEle("setbody")).attr("onbeforeunload", "");
	document.location.href=url;
} */
/* jQuery(document).ready(function(){
	jQuery(".e8tips").wTooltip({html:true});
}); */
function onClose()
{
	parentWin.closeDialog();
}
</script>
<script language="vbs">
 Sub onShowWorkFlowSerach(inputname, spanname)
    retValue = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/workflow/workflow/WorkflowBrowser.jsp")
    temp=document.all(inputname).value
    If (Not IsEmpty(retValue)) Then
        If retValue(0) <> "0" Then
            document.all(spanname).innerHtml = retValue(1)
            document.all(inputname).value = retValue(0)
        end if
    Else 
        document.all(inputname).value = ""
        document.all(spanname).innerHtml = ""			
    End If
    document.frmmain.action="automaticsettingAdd.jsp"
    document.frmmain.submit()
End Sub 
</script>
<script language=javascript src="/js/checkData_wev8.js"></script>
