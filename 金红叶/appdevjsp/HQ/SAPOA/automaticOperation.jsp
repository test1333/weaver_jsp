
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.general.Util" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="java.util.*" %>
<%@page import="weaver.conn.ConnStatement"%>
<%@page import="weaver.general.BaseBean"%>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>

<%
BaseBean log=new BaseBean();
if(!HrmUserVarify.checkUserRight("OutDataInterface:Setting",user)) {
	response.sendRedirect("/notice/noright.jsp") ;
	return ;
}
String isDialog = Util.null2String(request.getParameter("isdialog"));
String operate = Util.null2String(request.getParameter("operate"));
String typename = Util.null2String(request.getParameter("typename"));
String parentWinHref ="".equals(typename)?"/appdevjsp/HQ/SAPOA/automaticsetting.jsp?biaoji=1":"/appdevjsp/HQ/SAPOA/automaticsetting.jsp?biaoji=1&typename="+typename;
List list =new ArrayList();List listname =new ArrayList();
String backto = Util.fromScreen(request.getParameter("backto"),user.getLanguage());
if(operate.equals("add") || operate.equals("addAndDetail")){
    String setname = Util.null2String(request.getParameter("setname"));//名称
    String workFlowId = Util.null2String(request.getParameter("workFlowId"));//流程id
	String paixu = Util.null2String(request.getParameter("paixu"));//
	String describe = Util.null2String(request.getParameter("describe"));//
	String shifou = Util.null2String(request.getParameter("shifou"));//
  
    String requestid = Util.null2String(request.getParameter("requestid"));//

    setname = Util.replace(setname,"'","''",0).replace(" ","");
    requestid = Util.replace(requestid,"'","''",0);
 
    String insertSql = "insert into  zoa_wfcode_mapping("+
                       "LC_TYPE,"+
                       "WfId,"+
                       "shower,"+"Remark,"+"IsActive,"+
                       "IsNext) values("+
                       "'"+setname+"','"+workFlowId+"',"+
                                           
                       "'"+paixu+"',"+
                       "'"+describe+"',1,"+shifou+")";
    //System.out.println("insertSql=="+insertSql);
    RecordSet.executeSql(insertSql);
    String viewid = "";
	String ztableName ="";
	String zhuid="";
	String mintablename=""; String mingid="";
    RecordSet.executeSql("select max(id) from  zoa_wfcode_mapping ");
    if(RecordSet.next()) {viewid = RecordSet.getString(1);}
	String zhubiao="select tablename from  workflow_bill where id in ("
				+ " Select formid From workflow_base Where id= " + workFlowId
				+ ")";
	RecordSet.executeSql(zhubiao);	
	if(RecordSet.next()) {
		
		ztableName=RecordSet.getString("tablename");
		String iner="insert into  zoa_wftable_map (Fid,Type,Flag,Tbname,Remark,IsActive,shower) values( '"+viewid+"','M','' ,'"+ztableName+"','' ,'1' ,'0 ')";
		rs.executeSql(iner);
		
		System.out.print("-----------------"+iner);
		rs.executeSql("select max(id) from  zoa_wftable_map");
		if(rs.next()) {zhuid = rs.getString(1);}
	}
	String ming="select tablename from Workflow_billdetailtable where billid in (Select formid From workflow_base Where id= " + workFlowId
				+ " )order by orderid";
	RecordSet.executeSql(ming);	
	int mnu=1;
	while(RecordSet.next()){
		mintablename=RecordSet.getString("tablename");
		listname.add(mintablename);
		String iner="insert into  zoa_wftable_map (Fid,Type,Flag,Tbname,Remark,IsActive,shower) values( '"+viewid+"','D','ITEM"+mnu+"' ,'"+mintablename+"','' ,'1' ,'"+mnu+"')";
		
		rs.executeSql(iner);
		
		rs.executeSql("select max(id) from  zoa_wftable_map");
		if(rs.next()) {list.add(rs.getString(1));}
		mnu++;	
	}
	String inse="select * from workflow_billfield where viewtype=0 and billid= (Select formid From workflow_base Where id= " + workFlowId+ ")";
	rs.executeSql(inse);
	String fieldnames="";String insq="";
	while(rs.next()){
		fieldnames=rs.getString("fieldname"); 
		insq="insert into zoa_wffield_map (Tid,FieldName,SAPFieldName,ChangeType,ChangeInfo,Remark,IsActive,ismust) values ('"+zhuid+"',UPPER('"+fieldnames+"'),UPPER('"+fieldnames+"'),'0','','','1','0')";
		RecordSet.executeSql(insq);	
	}
	for(int i=0;i<listname.size();i++){
		inse="select * from workflow_billfield where detailtable='"+listname.get(i)+"' and viewtype=1 and billid=(Select formid From workflow_base Where id= " + workFlowId+ ") order by dsporder";
		rs.executeSql(inse);
		while(rs.next()){
			fieldnames=rs.getString("fieldname"); 
			insq="insert into zoa_wffield_map (Tid,FieldName,SAPFieldName,ChangeType,ChangeInfo,Remark,IsActive,ismust) values ('"+list.get(i)+"',UPPER('"+fieldnames+"'),UPPER('"+fieldnames+"'),'0','','','1','0')";
			RecordSet.executeSql(insq);	
		}
			
		
	}	
	
	

	if("1".equals(isDialog)){
		if(operate.equals("add")){
%>
<script language=javascript >
    try{
		var parentWin = parent.parent.getParentWindow(parent);
		parentWin.location.href='<%=parentWinHref%>';
		parentWin.closeDialog();
	}catch(e){
		
	}
</script>
<%
		}else if(operate.equals("addAndDetail")){
%>
<script language=javascript >
    try{
		var parentWin = parent.parent.getParentWindow(parent);
		parentWin.location.href='<%=parentWinHref%>';
		parentWin.closeDialog();
		parentWin.doEditDetailById(<%=viewid%>,1);
		
	}catch(e){
		
	}
</script>
<%
		}
    }else{
 		response.sendRedirect("/appdevjsp/HQ/SAPOA/automaticsetting.jsp");
	}
	return;
}else if(operate.equals("edit")){
    String setname = Util.null2String(request.getParameter("setname"));//名称
    String workFlowId = Util.null2String(request.getParameter("workFlowId"));//流程id
	String paixu = Util.null2String(request.getParameter("paixu"));//
	String describe = Util.null2String(request.getParameter("describe"));//
	String viewid =Util.null2String(request.getParameter("viewid"));//
	String shifou=Util.null2String(request.getParameter("shifou"));//
    String requestid = Util.null2String(request.getParameter("requestid"));//
	System.out.println("shifou----"+shifou);
    setname = Util.replace(setname,"'","''",0);
    requestid = Util.replace(requestid,"'","''",0);
    
    String oldworkflowid = "";
    RecordSet.executeSql("select WfId from zoa_wfcode_mapping where id="+viewid);
    if(RecordSet.next()){
        oldworkflowid = RecordSet.getString("WfId");
        if(!oldworkflowid.equals(workFlowId)){
             //流程已变更，删除详细设置内容。
            // RecordSet.executeSql("delete from outerdatawfsetdetail where mainid="+viewid);
        }
    }
    
    setname = Util.replace(setname,"'","''",0).replace(" ","");
   
    String updateSql = "update zoa_wfcode_mapping set "+
                       "LC_TYPE='"+setname+"',WfId='"+workFlowId+"',"+ 
                       "shower='"+paixu+"',"+
                       "Remark='"+describe+"',"+ "IsNext='"+shifou+"' "+ 
                       "where id="+viewid;
					   
					   
    //System.out.println("updateSql=="+updateSql);
    RecordSet.executeSql(updateSql);
	if("1".equals(isDialog)){
%>
<script language=javascript >
    try{
		//alert(1);
		var parentWin = parent.parent.getParentWindow(parent);
		parentWin.location.href='<%=parentWinHref%>';
		parentWin.closeDialog();
	}catch(e){
		
	}
</script>
<%
    }else{
		
 		response.sendRedirect("/appdevjsp/HQ/SAPOA/automaticsetting.jsp");
	}
}else if(operate.equals("adddetail")){
    String viewid = Util.null2String(request.getParameter("viewid"));//keyid 
	String zhutableName= Util.null2String(request.getParameter("zhutableName"));//
	//String zhubiaoshi= Util.null2String(request.getParameter("zhubiaoshi"));//
	int zhus = Util.getIntValue(Util.null2String(request.getParameter("zhus_1")),0);//主字段数
	int num = Util.getIntValue(Util.null2String(request.getParameter("num")),0);//明细个数
	String mingxiid="";//明细id
	String showerNo="";//shower顺序
	String Remark="";
	String zhuflag=Util.null2String(request.getParameter("zhubiaoshi")); //
	String zhuid="";
	String mingid_="";
	String mingflag="";
	String 	ss="update zoa_wftable_map   set  Flag ='"+zhuflag+"' where fid = '"+viewid+"' and TYPE='M' ";
	RecordSet.executeSql(ss);
//
	List<String> listMing=new ArrayList<String>();//id
	List<String> listMing1=new ArrayList<String>();//页面上的明细id
	List<String> listshowerNo=new ArrayList<String>();//页面上的明细id
	List<String> listNum=new ArrayList<String>();//
	List<String> listNam=new ArrayList<String>();//明细表的名称
	List<String> listNumnew=new ArrayList<String>();//
	ss="select id  from  zoa_wftable_map where fid='"+viewid+"' and  TYPE='M' ";
	RecordSet.executeSql(ss);
	if(RecordSet.next()){
		zhuid=Util.null2String(RecordSet.getString("id"));
	}
	
	ss="select id from  zoa_wftable_map where fid='"+viewid+"' and  TYPE='D' and  isactive=1  order by shower asc ";
	RecordSet.executeSql(ss);
	while(RecordSet.next()){
		listMing.add(Util.null2String(RecordSet.getString("id")));
	}
	////
	for(int i=0;i<num;i++){
		showerNo=Util.null2String(request.getParameter("shower_"+i));
		mingxiid=Util.null2String(request.getParameter("mingxiid_"+i));
		if(mingxiid!=""){
			listMing1.add(mingxiid);
			listshowerNo.add(showerNo);
		}
		
	}
	
	
	//
	ss="select tablename from workflow_billdetailtable where billid =(select formid  from workflow_base where id= (select WfId from zoa_wfcode_mapping  where id='"+viewid+"'))  order by orderid  asc";
	RecordSet.executeSql(ss);
	while(RecordSet.next()){
		listNam.add(Util.null2String(RecordSet.getString("tablename")));
		ss="select count(id) as cc from zoa_wftable_map where Fid='"+viewid+"' and  TYPE='D'  and Tbname ='"+Util.null2String(RecordSet.getString("tablename"))+"' and  IsActive=1";
		rs.executeSql(ss);
		int cc=0;
		if(rs.next()){
			cc=rs.getInt("cc");
		}
		if(cc<1){
			ss="select max(shower) as mas from zoa_wftable_map where Fid='"+viewid+"' ";
			rs.executeSql(ss);
			if(rs.next()){
				int asd=rs.getInt("mas");
				ss="insert into zoa_wftable_map (Fid,Type,Flag,Tbname,Remark,IsActive,shower) values( '"+viewid+"','D','ITEM"+(asd+1)+"','"+RecordSet.getString("tablename")+"','','1','"+(asd+1)+"')";
				rs.executeSql(ss);
				rs.executeSql("select max(id) as maxid from  zoa_wftable_map where fid ='"+viewid+"'");
				if(rs.next()){ 
					listMing.add(rs.getString("maxid"));
					listMing1.add(rs.getString("maxid"));
					int sno=asd+1;
					listshowerNo.add(String.valueOf(sno));
				}
			}
			
			
		}	
		
	}///---
	for(int i=0;i<num;i++){
		mingflag=Util.null2String(request.getParameter("mingxibiaoshi_"+i)); //
		
		ss="update zoa_wftable_map   set  Flag ='"+mingflag+"' where fid = '"+viewid+"' and TYPE='D' and shower=' "+listshowerNo.get(i)+"'";
		RecordSet.executeSql(ss);	
	}

	for(int i=0;i<listNam.size();i++){
		ss="select COUNT(id) as con from workflow_billfield  where billid=(select formid  from workflow_base where id= (select WfId from zoa_wfcode_mapping  where id='"+viewid+"'))  and viewtype='1' and detailtable='"+listNam.get(i)+"'";
		rs.executeSql(ss);
		if(rs.next()){
			listNum.add(String.valueOf(rs.getInt("con")));
		}	
	}
	
    int fieldscount = Util.getIntValue(Util.null2String(request.getParameter("fieldscount")),0);//字段总数
    

	for(int i=0;i<listNum.size();i++){
		int nw= 0;
		int l=0;
		for(int j=0;j<=i;j++){
			l=Integer.parseInt(listNum.get(j));
			nw+=l;
		}
		listNumnew.add(String.valueOf(nw));
		
	}
	int Tid=0;String sqt="";	
    for(int i=1;i<=fieldscount;i++){
		
		String FieldName =Util.null2String(request.getParameter("field_index_"+i));
		String SAPFieldName =Util.null2String(request.getParameter("waiyuanziduan_"+i));
		int ChangeType =Util.getIntValue(Util.null2String(request.getParameter("zhaunhuan_"+i)),0);
		String ChangeInf = Util.null2String(request.getParameter("zhuanhuanneirong_"+i));
		String ChangeInfo = ChangeInf.replaceAll("duaal","dual");
		Remark =Util.null2String(request.getParameter("neirongmiaoshu_"+i));
		int IsActive =Util.getIntValue(Util.null2String(request.getParameter("shifou_"+i)),0);
		String ismust =Util.null2String(request.getParameter("ismust_"+i));
		///listMing
		String cssql = "insert into zoa_wffield_map(Tid,FieldName,SAPFieldName,ChangeType,ChangeInfo,Remark,IsActive,ismust) values(?,?,?,?,?,?,?,?)"; 
		ConnStatement cs = new ConnStatement();
		if(i<=zhus) {
			String str="select *  from zoa_wffield_map where tid= '"+zhuid+"' and FieldName= UPPER('"+FieldName+"')";
			rs.executeSql(str);
			if(rs.next()){
				
				String ChangeInfo1 =ChangeInfo.replace("'", "'||chr(39)||'").replace("&", "'||chr(38)||'");
				
				String upsql ="update zoa_wffield_map set  SAPFieldName=UPPER('"+SAPFieldName+"'),ChangeType='"+ChangeType+"',ChangeInfo='"+ChangeInfo1+"',Remark='"+Remark+"',IsActive='"+IsActive+
				"',ismust='"+ismust+"'  where  tid= '"+zhuid+"' and FieldName=UPPER('"+FieldName+"')";
				RecordSet.executeSql(upsql);
				//log.writeLog("upsql---" + upsql);
			}else{
				Tid=Integer.parseInt(zhuid);
				cs.setStatementSql(cssql);
				cs.setInt(1,Tid);
				cs.setString(2,FieldName.toUpperCase());
				cs.setString(3,SAPFieldName.toUpperCase());
				cs.setInt(4,ChangeType);
				cs.setString(5,ChangeInfo);
				cs.setString(6,Remark);
				cs.setInt(7,IsActive);
				cs.setString(8,ismust);
				cs.executeUpdate();				
				cs.close();
			}
			
		//主表字段
			String st3=" update zoa_wffield_map  set ISACTIVE=0 where  id  in ("+"select wm.id from zoa_wffield_map wm where wm.tid in "+
			" (select  zb.id from  zoa_wftable_map zb where zb.TYPE='M' and  zb.fid = '"+viewid+"') and FieldName not in ( select  UPPER(wd.fieldname) from workflow_billfield wd where   wd.viewtype=0 "+
				"  and  wd.billid in ( select wb.id from  workflow_bill wb where wb.tablename= '"+zhutableName+"') )  "+") ";	
			RecordSet.executeSql(st3);	
			
		}else{
			int m=0;//listNam  listMing1
			for(int j=0;j<listNam.size();j++){
				int n=Integer.parseInt(listNumnew.get(j));
			//System.out.println("-------------"+n+"-------------");
				if(m==0&&i<=(n+zhus)){
					//System.out.println("--i------"+i+"-----------");
					
					String str1="select * from zoa_wffield_map where tid= '"+listMing1.get(j)+"' and FieldName= UPPER('"+FieldName+"')";
					rs.executeSql(str1);
					if(rs.next()){
						String ChangeInfo1 =ChangeInfo.replace("'", "'||chr(39)||'").replace("&", "'||chr(38)||'");
						String upsql1 ="update zoa_wffield_map set  SAPFieldName=UPPER('"+SAPFieldName+"'),ChangeType='"+ChangeType+"',ChangeInfo='"+ChangeInfo1+"',Remark='"+Remark+"',IsActive='"+IsActive+
						"',ismust='"+ismust+"' where  tid= '"+listMing1.get(j)+"' and FieldName=UPPER('"+FieldName+"')";
						RecordSet.executeSql(upsql1);
						m++;
						//log.writeLog("upsql1---" + upsql1);
					}else{
						Tid=Integer.parseInt((String)listMing1.get(j));
						cs.setStatementSql(cssql);
						cs.setInt(1,Tid);
						cs.setString(2,FieldName.toUpperCase());
						cs.setString(3,SAPFieldName.toUpperCase());
						cs.setInt(4,ChangeType);
						cs.setString(5,ChangeInfo);
						cs.setString(6,Remark);
						cs.setInt(7,IsActive);
						cs.setString(8,ismust);
						cs.executeUpdate();				
						cs.close();
						m++;
					}
					
					
				}
				
			}
			//删除明细
			String am="";
			String am1="";
			String am2="";

			for(int j=0;j<listMing1.size();j++ ){
				if(j==0){
					am1=listMing1.get(j);
				}else{
					am1=am1+","+listMing1.get(j);
				}
			}
			int jsu=0;
			for(int j=0;j<listMing.size();j++ ){
				if(j==0){
					am=listMing.get(j);
					if(am1.indexOf(listMing.get(j)) == -1 && jsu==0){
						am2=listMing.get(j);
						jsu++;
					}
				}else{
					am=am+","+listMing.get(j);
					if(am1.indexOf(listMing.get(j)) == -1 && jsu==0){
						
						am2=listMing.get(j);
						jsu++;
					}
					if(am1.indexOf(listMing.get(j)) == -1 && jsu!=0){
						am2=am2+","+listMing.get(j);
					}
				}
			}
			///1.更新明细表字段   //zhutableName
			String st1=" update zoa_wffield_map  set ISACTIVE=0 where  id  in ("+"select wm.id from zoa_wffield_map wm where wm.tid in ("+am+") and FieldName not in ( select UPPER(wd.fieldname) from workflow_billfield wd where   wd.viewtype=1 "+
				"  and  wd.billid in ( select wb.id from  workflow_bill wb where wb.tablename= '"+zhutableName+"') and wd.detailtable=(select tbname from zoa_wftable_map where id=wm.tid) )  "+") ";
			RecordSet.executeSql(st1);	
			//关闭明细表
			if(!am2.equals("")){
				String st2="update zoa_wftable_map set  ISACTIVE=0 where id in ( select aa.id from zoa_wftable_map aa where  aa.id in ("+am2+")) and type='D' and fid= '"+viewid+"' ";
				RecordSet.executeSql(st2);
			}

		
			
		} 
        
        
      
    }
    
    %>
    <script language=javascript >
    try{
		var parentWin = parent.parent.getParentWindow(parent);
		parentWin.location.href='<%=parentWinHref%>';
		//parentWin.closeDialog();
		dialog = parent.parent.getDialog(parent);
		dialog.close();
	}catch(e){
		
	}
	</script>
    <%
}
%>