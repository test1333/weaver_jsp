<%@page import="weaver.proj.Maint.ProjectTypeComInfo"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.general.Util" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="java.util.*,java.util.regex.*" %>
<jsp:useBean id="rs2" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="PrjFieldManager" class="weaver.proj.util.PrjFieldManager" scope="page"/>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="LabelComInfo" class="weaver.systeminfo.label.LabelComInfo" scope="page" />	
<jsp:useBean id="RecordSetTrans" class="weaver.conn.RecordSetTrans" scope="page" />
<jsp:useBean id="BrowserComInfo" class="weaver.workflow.field.BrowserComInfo" scope="page" />
<jsp:useBean id="PrjFieldComInfo" class="weaver.proj.util.PrjFieldComInfo" scope="page" />
<%
/**	
if(!HrmUserVarify.checkUserRight("DeptDefineInfo1:DeptMaintain1", user)){
		response.sendRedirect("/notice/noright.jsp");	
		return;
}**/

  boolean isoracle = (RecordSet.getDBType()).equals("oracle") ;
  boolean isdb2 = (RecordSet.getDBType()).equals("db2") ;
  boolean issqlserver = (RecordSet.getDBType()).equals("sqlserver") ;

  String ajax=Util.null2String(request.getParameter("ajax"));
  String src = Util.null2String(request.getParameter("src"));
  String from = Util.null2String(request.getParameter("from"));
  int prjtype = Util.getIntValue(request.getParameter("prjtype"),-1);
  boolean fromType="prjtypefield_def".equals(from)&&prjtype>0;
  
  //System.out.println("prjtype:"+prjtype);
  //System.out.println("fromType:"+fromType);
  //System.out.println("====================:");
 
String maintablename = "prj_projectinfo";//主表名
String maintablename2 = "Prj_Template";//项目模板主表名
String defineTable="prjDefineField";//字段定义表
if(fromType){
	maintablename="cus_fielddata";
	defineTable="cus_formfield t1 left outer join cus_formdict t2 on t1.fieldid=t2.id ";
	maintablename2="";
}
  
  
  if(src.equals("addfieldbatch")){//批量添加字段
	  
synchronized(this){
	


	  	char flag=2;
	  	RecordSetTrans.setAutoCommit(false);
	  	
	  	try{
	  	int formid = Util.getIntValue((request.getParameter("formid")),0);//表单id
	  	
	  	int recordNum = Util.getIntValue(Util.null2String(request.getParameter("recordNum")),0);//字段行数
	  	String delids = Util.null2String(request.getParameter("delids"));//删除行id集
	  	String changeRowIndexs = Util.null2String(request.getParameter("changeRowIndexs"));//有改变的行id集
	  	String labelidsCache = ",";//更新缓存用
	  	
	  	//主字段 开始
	  	ArrayList delidsArray = Util.TokenizerString(delids,",");
	  	for(int i=0;i<delidsArray.size();i++){//删除指定的字段
	  		String fieldnameForDel = "";
	  		String delFieldId = (String)delidsArray.get(i);

			if(fromType){
				RecordSetTrans.executeSql("select fieldname from cus_formdict where id="+delFieldId);
			}else{
				RecordSetTrans.executeSql("select fieldname from "+defineTable+" where id="+delFieldId);
			}
	  		
			
			
	  		if(RecordSetTrans.next()) fieldnameForDel = RecordSetTrans.getString("fieldname");//取得字段名
	  		
	  		
	  		RecordSetTrans.executeSql("alter table "+maintablename+" drop column "+fieldnameForDel);//修改表结构
	  		if(fromType){
	  			RecordSetTrans.executeSql("delete from cus_formfield where scope='ProjCustomField' and scopeid='"+prjtype+"' and fieldid='"+delFieldId+"'  ");//删除字段引用
	  			RecordSetTrans.executeSql("delete from cus_formdict where id='"+delFieldId+"'  ");//删除字段
	  			RecordSetTrans.executeSql("delete from cus_SelectItem where fieldid="+delFieldId+" ");
	  		}else{
			  	RecordSetTrans.executeSql("alter table "+maintablename2+" drop column "+fieldnameForDel);//修改表结构
			  	RecordSetTrans.executeSql("delete from "+defineTable+" where fieldname='"+fieldnameForDel+"' ");//删除字段
		  		//RecordSetTrans.executeSql("delete from prj_SelectItem where fieldid in(select id from "+defineTable+" where fieldname='"+fieldnameForDel+"')");//删除表workflow_SelectItem中该字段对应数据
		  		//RecordSetTrans.executeSql("delete from prj_specialfield where fieldid in(select id from "+defineTable+" where fieldname='"+fieldnameForDel+"')");//删除表workflow_specialfield中该字段对应数据
	  		}
	  		
				  		
	  	}
	  	ArrayList changeRowIndexsArray = Util.TokenizerString(changeRowIndexs,",");
	  //for(int i=0;i<changeRowIndexsArray.size();i++){//修改有改变的行(包括新增行和编辑行)
  		//String index = (String)changeRowIndexsArray.get(i);
  	for(int i=0;i<recordNum;i++){//修改有改变的行(包括新增行和编辑行)
  		String index = ""+i;
		  		String new_OR_modify = Util.null2String(request.getParameter("modifyflag_"+index));
		  		
	  			String fieldname = "";//数据库字段名称
	  			int fieldlabel = 0;//字段显示名标签id
	  			String fielddbtype = "";//字段数据库类型
				String _fielddbtype = "";//字段数据库类型
	  			String fieldhtmltype = "";//字段页面类型
	  			String type = "";//字段详细类型
	  			String dsporder = "";//显示顺序
	  			String viewtype = "0";//viewtype="0"表示主表字段,viewtype="1"表示明细表字段
	  			String detailtable = "";//明细表名
	  			int textheight = 0;//多行文本框的高度
	  			
	  			String isopen = "";//启用
	  	  		String ismand = "";//必填
	  	  		String groupid = "";//组
	  	  		String fieldtype = "";//类型:1,主表字段;2,项目类型自定义字段;
	  	  		isopen = ""+Util.getIntValue(request.getParameter("isopen_"+index),0);
	  	  		ismand = ""+Util.getIntValue(request.getParameter("ismand_"+index),0);
	  	  		groupid = ""+Util.getIntValue(request.getParameter("group_"+index),0);
	  	  		fieldtype = ""+Util.getIntValue(request.getParameter("fieldtype_"+index),0);
	  	  		boolean isprjtypefield="2".equals(fieldtype);
	  	  		//System.out.println("fieldtype:"+fieldtype);
	  			fieldname = Util.null2String(request.getParameter("itemDspName_"+index));
	  			if(!new_OR_modify.equals("")){//不为空表示是编辑字段，为空表示新添加字段。
		  			//对编辑字段先删除，再添加
		  			if(fromType){
		  				if(isprjtypefield){
		  					RecordSetTrans.executeSql("delete from cus_SelectItem where fieldid='"+new_OR_modify+"'  ");
		  				}
		  			}else{
		  				String tmpfieldname="";
		  				RecordSetTrans.executeSql("select fieldname from prjDefineField where id="+new_OR_modify);
		  		  		if(RecordSetTrans.next()) tmpfieldname = RecordSetTrans.getString("fieldname");//取得字段名
		  				RecordSetTrans.executeSql("delete from prj_SelectItem where  fieldid in(select id from "+defineTable+" where fieldname='"+tmpfieldname+"')");//删除表workflow_SelectItem中该字段对应数据
				  		RecordSetTrans.executeSql("delete from prj_specialfield where  fieldid in(select id from "+defineTable+" where fieldname='"+tmpfieldname+"')");//删除表workflow_specialfield中该字段对应数据	
		  			}
		  		}
	  			
	  			if(fieldname.equals("")) continue;//先添加后删除的
	  			int imgwidth = Util.getIntValue(request.getParameter("imgwidth_"+index),0);
	            int imgheight = Util.getIntValue(request.getParameter("imgheight_"+index),0);
	  			String fieldlabelname = Util.null2String(request.getParameter("itemFieldName_"+index));
	  			fieldlabelname = Util.StringReplace(fieldlabelname, "\"", "");//TD10108 表单字段显示名不可以含有半角双引号“"”
	  			if(issqlserver) RecordSetTrans.executeSql("select indexid from HtmlLabelInfo where labelname='"+fieldlabelname+"' collate Chinese_PRC_CS_AI and languageid="+Util.getIntValue(""+user.getLanguage(),7));
			  	else RecordSetTrans.executeSql("select indexid from HtmlLabelInfo where labelname='"+fieldlabelname+"' and languageid="+Util.getIntValue(""+user.getLanguage(),7));
			  	if(RecordSetTrans.next()) fieldlabel = RecordSetTrans.getInt("indexid");//如果字段名称在标签库中存在，取得标签id
			  	else{
			  		fieldlabel = PrjFieldManager.getNewIndexId(RecordSetTrans);//生成新的标签id
				  	if(fieldlabel!=-1){//更新标签库
				  		labelidsCache+=fieldlabel+",";
				  		RecordSetTrans.executeSql("delete from HtmlLabelIndex where id="+fieldlabel);
				  		RecordSetTrans.executeSql("delete from HtmlLabelInfo where indexid="+fieldlabel);
				  		RecordSetTrans.executeSql("INSERT INTO HtmlLabelIndex values("+fieldlabel+",'"+fieldlabelname+"')");
				  		RecordSetTrans.executeSql("INSERT INTO HtmlLabelInfo values("+fieldlabel+",'"+fieldlabelname+"',7)");
				  		RecordSetTrans.executeSql("INSERT INTO HtmlLabelInfo values("+fieldlabel+",'"+fieldlabelname+"',8)");
				  		RecordSetTrans.executeSql("INSERT INTO HtmlLabelInfo values("+fieldlabel+",'"+fieldlabelname+"',9)");
				  	}
				  }
				  
				  fieldhtmltype = Util.null2String(request.getParameter("itemFieldType_"+index));
				  if(fieldhtmltype.equals("1")){
					  int decimaldigits = Util.getIntValue(request.getParameter("decimaldigits_"+index),2);
				  	type = Util.null2String(request.getParameter("documentType_"+index));	
					  if(type.equals("1")){
					  	String strlength = Util.null2String(request.getParameter("itemFieldScale1_"+index));
					  	if(Util.getIntValue(strlength,1)<=1) strlength = "1";
				    	if(isoracle) fielddbtype="varchar2("+strlength+")";
				    	else fielddbtype="varchar("+strlength+")";
				    	
				    	if(!new_OR_modify.equals("")){
				    	    String oldfielddbtype = "";
				    	    if(isprjtypefield){
				    	    	RecordSetTrans.executeSql("select fielddbtype from cus_formdict where id="+new_OR_modify);
				    	    }else{
				    	    	RecordSetTrans.executeSql("select fielddbtype from prjDefineField where id="+new_OR_modify);
				    	    }
				    	    
				    	    if(RecordSetTrans.next()) oldfielddbtype = RecordSetTrans.getString("fielddbtype");
				    	    //修改字段暂时屏蔽掉修改字段属性
				    	    /**
				    	    if(!fielddbtype.equals(oldfielddbtype)){
				    	        if(isoracle) {
				    	        	RecordSetTrans.executeSql("ALTER TABLE "+maintablename+" MODIFY "+fieldname+" "+fielddbtype);
				    	        	if(fromType){
				    	        		
				    	        	}else{
				    	        		RecordSetTrans.executeSql("ALTER TABLE "+maintablename2+" MODIFY "+fieldname+" "+fielddbtype);
				    	        	}
				    	        	
				    	        }else{
				    	        	RecordSetTrans.executeSql("ALTER TABLE "+maintablename+" ALTER COLUMN "+fieldname+" "+fielddbtype);
				    	        	if(fromType){
				    	        		
				    	        	}else{
				    	        		RecordSetTrans.executeSql("ALTER TABLE "+maintablename2+" ALTER COLUMN "+fieldname+" "+fielddbtype);
				    	        	}
				    	        	
				    	        }
				    	    }
				    	    **/
				    	}
				   	}
					 	if(type.equals("2")){
				   		if(isoracle) fielddbtype="integer";
				   		else fielddbtype="int";
				   	}
					 	if(type.equals("3")){
				   		if(isoracle) fielddbtype="number(15,"+decimaldigits+")";
				   		else fielddbtype="decimal(15,"+decimaldigits+")";
				 	 	}
				   	if(type.equals("4")){
				   		if(isoracle) fielddbtype="number(15,2)";
				   		else fielddbtype="decimal(15,2)";
						}
				   	if(type.equals("5")){
				   		if(isoracle) fielddbtype="varchar2(30)";
				   		else fielddbtype="varchar(30)";
						}
				  }
				  if(fieldhtmltype.equals("2")){
				  	String htmledit = Util.null2String(request.getParameter("htmledit_"+index));
				  	if(htmledit.equals("")) type="1";
				  	else type=htmledit;
						if(isoracle) fielddbtype="varchar2(4000)";
						else if(isdb2) fielddbtype="varchar(2000)";
						else fielddbtype="text";
						textheight = Util.getIntValue(Util.null2String(request.getParameter("textheight_"+index)),4);
				  }
				  if(fieldhtmltype.equals("3")){
				  	int temptype = Util.getIntValue(Util.null2String(request.getParameter("broswerType_"+index)),0);
				  	type = ""+temptype;
				  	if(temptype>0)
				  		fielddbtype=BrowserComInfo.getBrowserdbtype(type+"");
					  	if(temptype==118){
					  		if(isoracle) fielddbtype="varchar2(200)";
				              else fielddbtype="varchar(200)";
					  	}
						if(temptype==161||temptype==162){
							fielddbtype=Util.null2String(request.getParameter("definebroswerType_"+index));
							if(temptype==161){
								if(isoracle) _fielddbtype="varchar2(1000)";
								else if(isdb2) _fielddbtype="varchar(1000)";
								else _fielddbtype="varchar(1000)";
							}else{
								if(isoracle) _fielddbtype="varchar2(4000)";
								else if(isdb2) _fielddbtype="varchar(2000)";
								else _fielddbtype="text";
							}
						}
						if(temptype==224||temptype==225){
							fielddbtype=Util.null2String(request.getParameter("sapbrowser_"+index));
							if(temptype==224){
								if(isoracle) _fielddbtype="varchar2(1000)";
								else if(isdb2) _fielddbtype="varchar(1000)";
								else _fielddbtype="varchar(1000)";
							}else{
								if(isoracle) _fielddbtype="varchar2(4000)";
								else if(isdb2) _fielddbtype="varchar(2000)";
								else _fielddbtype="text";
							}
						}
					  if(temptype==165||temptype==166||temptype==167||temptype==168) 
					  	textheight=Util.getIntValue(Util.null2String(request.getParameter("decentralizationbroswerType_"+index)),0); 
				  }
				  if(fieldhtmltype.equals("4")){
				  	type = "1";
				  	fielddbtype="char(1)";
				  }
				  if(fieldhtmltype.equals("5"))	{
				  	type = "1";
				  	if(isoracle) fielddbtype="integer";
				  	else fielddbtype="int";
				  }
				  if(fieldhtmltype.equals("6"))	{
				  	type = "" + Util.getIntValue(Util.null2String(request.getParameter("uploadtype_"+index)), 1);
				    if(isoracle) fielddbtype="varchar2(4000)";
					  else if(isdb2) fielddbtype="varchar(2000)";
				    else fielddbtype="text";
	                textheight = Util.getIntValue(Util.null2String(request.getParameter("strlength_"+index)), 0);  
				  }
				  if(fieldhtmltype.equals("7"))	{
				  	type = Util.null2String(request.getParameter("specialfield_"+index));
				    if(isoracle) fielddbtype="varchar2(4000)";
					  else if(isdb2) fielddbtype="varchar(2000)";
				    else fielddbtype="text";
				  }			  
				  dsporder = Util.null2String(request.getParameter("itemDspOrder_"+index));
				  //if(dsporder.equals("")) dsporder="0";
				  dsporder = ""+Util.getDoubleValue(dsporder,0.0);
				  int childfieldid_tmp = Util.getIntValue(request.getParameter("childfieldid_"+index), 0);
				  if(!new_OR_modify.equals("")){//不为空表示是编辑字段，为空表示新添加字段。
				  	String oldfieldname = "";
				  	String oldfielddbtype = "";
				  	if(isprjtypefield){
				  		RecordSetTrans.executeSql("select fieldname,fielddbtype from cus_formdict where id="+new_OR_modify);
				  	}else{
				  		RecordSetTrans.executeSql("select fieldname,fielddbtype from prjDefineField where id="+new_OR_modify);
				  	}
				  	
				  	if(RecordSetTrans.next()){
				  	    oldfieldname = RecordSetTrans.getString("fieldname");
				  	    oldfielddbtype = RecordSetTrans.getString("fielddbtype");
				  	}
				  	if(isprjtypefield){
				  		RecordSetTrans.executeSql("update cus_formfield set groupid='"+groupid+"',isuse='"+isopen+"',ismand='"+ismand+"',prj_fieldlabel="+fieldlabel+",fieldorder="+dsporder+" where scope='ProjCustomField' and scopeid="+prjtype+" and fieldid="+new_OR_modify);
				  	}else{
					  	RecordSetTrans.executeSql("update prjDefineField set groupid='"+groupid+"',isopen='"+isopen+"',ismand='"+ismand+"',billid="+formid+",fieldname='"+fieldname+"',fieldlabel="+fieldlabel+",fielddbtype='"+fielddbtype+"',fieldhtmltype="+fieldhtmltype+",type="+type+",dsporder="+dsporder+",viewtype="+viewtype+",detailtable='"+detailtable+"',textheight="+textheight+",childfieldid="+childfieldid_tmp+",imgwidth="+imgwidth+",imgheight="+imgheight+" where id="+new_OR_modify);
				  	}
				  	/**if(!fieldname.equals(oldfieldname)||(!fielddbtype.equals(oldfielddbtype) && !"1".equals(fieldhtmltype) && !"".equals(type))||(fieldhtmltype.equals("3")&&(type.equals("161")||type.equals("162")))){//修改了数据库字段名称或类型
				  	    RecordSetTrans.executeSql("alter table "+maintablename+" drop column "+oldfieldname);
				  		if(fromType){
				  			
				  		}else{
				  			RecordSetTrans.executeSql("alter table "+maintablename2+" drop column "+oldfieldname);
				  		}
				  	    
				  	    if(fieldhtmltype.equals("3")&&(type.equals("161")||type.equals("162"))){
				  	        RecordSetTrans.executeSql("alter table "+maintablename+" add "+fieldname+" "+_fielddbtype);
				  	      	if(fromType){
					  			
					  		}else{
					  			RecordSetTrans.executeSql("alter table "+maintablename2+" add "+fieldname+" "+_fielddbtype);
					  		}
				  	        
				  	    }else if(fieldhtmltype.equals("3")&&(type.equals("224")||type.equals("225"))){
				  	        RecordSetTrans.executeSql("alter table "+maintablename+" add "+fieldname+" "+_fielddbtype);
				  	        if(fromType){
				  	        	
				  	        }else{
				  	        	RecordSetTrans.executeSql("alter table "+maintablename2+" add "+fieldname+" "+_fielddbtype);
				  	        }
				  	        
				  	    }else{
				  	        RecordSetTrans.executeSql("alter table "+maintablename+" add "+fieldname+" "+fielddbtype);
				  	        if(fromType){
				  	        	
				  	        }else{
				  	        	RecordSetTrans.executeSql("alter table "+maintablename2+" add "+fieldname+" "+fielddbtype);
				  	        }
				  	        
				  	    }
				  	}**/
					}else{
					  //插入字段信息
					  if(fromType){
						  //tagtagtodo
						  
						  String sql="select max(id) as maxid from cus_formdict";
						  RecordSetTrans.executeSql(sql);
						  RecordSetTrans.next();
						  int fieldid=1+Util.getIntValue(RecordSetTrans.getString("maxid"),0);
							  sql="insert into cus_formdict(id,fielddbtype,fieldhtmltype,type,fieldname,fieldlabel,scope) values('"+fieldid+"','"+fielddbtype+"','"+fieldhtmltype+"','"+type+"','"+fieldname+"','"+fieldlabel+"','ProjCustomField')";
							  RecordSetTrans.executeSql(sql);
								sql=""+
										" insert into cus_formfield "+
										" (scope, scopeid, fieldlable, fieldid, fieldorder,isuse, ismand,  prj_fieldlabel,groupid) "+
										" values "+
										" ('ProjCustomField','"+prjtype+"','"+fieldlabel+"','"+fieldid+"','"+(int)Util.getDoubleValue(dsporder,0.0)+"','"+isopen+"','"+ismand+"','"+fieldlabel+"','"+groupid+"') ";
								RecordSetTrans.executeSql(sql);
						  
					  }else{
						  RecordSetTrans.executeSql("INSERT INTO prjDefineField(prjtype,groupid,isopen,ismand,billid,fieldname,fieldlabel,fielddbtype,fieldhtmltype,type,dsporder,viewtype,detailtable,textheight,childfieldid,imgwidth,imgheight) "+
								  " VALUES ('"+prjtype+"','"+groupid+"','"+isopen+"','"+ismand+"',"+formid+",'"+fieldname+"',"+fieldlabel+",'"+fielddbtype+"',"+fieldhtmltype+","+type+","+dsporder+","+viewtype+",'"+detailtable+"',"+textheight+","+childfieldid_tmp+","+imgwidth+","+imgheight+")");
					  }
					  
				  }
				  if(new_OR_modify.equals("")){//新添加字段
				  //更新主表结构
				  if(fieldhtmltype.equals("3")&&(type.equals("161")||type.equals("162"))){
				  	  RecordSetTrans.executeSql("alter table "+maintablename+" add "+fieldname+" "+_fielddbtype);
				  	  if(fromType){
				  		  
				  	  }else{
				  		RecordSetTrans.executeSql("alter table "+maintablename2+" add "+fieldname+" "+_fielddbtype);
				  	  }
				  	  
				  }else if(fieldhtmltype.equals("3")&&(type.equals("224")||type.equals("225"))){
				  	  RecordSetTrans.executeSql("alter table "+maintablename+" add "+fieldname+" "+_fielddbtype);
				  	  if(fromType){
				  		  
				  	  }else{
				  		RecordSetTrans.executeSql("alter table "+maintablename2+" add "+fieldname+" "+_fielddbtype);
				  	  }
				  	  
				  }else{
				  	  RecordSetTrans.executeSql("alter table "+maintablename+" add "+fieldname+" "+fielddbtype);
				  	  if(fromType){
				  		  
				  	  }else{
				  		RecordSetTrans.executeSql("alter table "+maintablename2+" add "+fieldname+" "+fielddbtype);
				  	  }
				  	  
				  }
				  }
				  
				  //如果是选择框，更新表workflow_SelectItem
				  String curfieldid = "";
				  if(new_OR_modify.equals("")){
				      RecordSetTrans.executeSql("select max(id) as id from "+(fromType?"cus_formdict":"prjDefineField"));
				      if(RecordSetTrans.next()) curfieldid = RecordSetTrans.getString("id");
				  }else{
				      curfieldid = new_OR_modify;
				  }
				  if(fieldhtmltype.equals("5")){
					//System.out.println("==========fieldhtmltype.equals(5)==========");
				  	int rowsum = Util.getIntValue(Util.null2String(request.getParameter("choiceRows_"+index)));
				  	//System.out.println("rowsum:"+rowsum);
	                int curvalue=0;
				  	for(int temprow=1;temprow<=rowsum;temprow++){
				  		String curname = Util.null2String(request.getParameter("field_"+index+"_"+temprow+"_name"));
				  		if(curname.equals("")) continue;
				  		String curorder = Util.null2String(request.getParameter("field_count_"+index+"_"+temprow+"_name"));
				  		String isdefault = "n";
				  		String checkValue = Util.null2String(request.getParameter("field_checked_"+index+"_"+temprow+"_name"));
				  		String cancel = Util.null2String(request.getParameter("cancel_"+index+"_"+temprow+"_name")); 
				  		if(cancel!=null && !cancel.equals("") && cancel.equals("1")){
							cancel = "1";
						}else{
							cancel = "0";
						}
						if(checkValue.equals("1")) isdefault="y";
				  			int isAccordToSubCom_tmp = Util.getIntValue(request.getParameter("isAccordToSubCom"+index+"_"+temprow), 0);
				  			//System.out.println("isAccordToSubCom_tmp:"+isAccordToSubCom_tmp);
							String doccatalog = Util.null2String(request.getParameter("maincategory_"+index+"_"+temprow));
							String docPath = Util.null2String(request.getParameter("pathcategory_"+index+"_"+temprow));
							String childItem_tmp = Util.null2String(request.getParameter("childItem_"+index+"_"+temprow));
							String para=curfieldid+flag+"1"+flag+""+curvalue+flag+curname+flag+curorder+flag+isdefault+flag+cancel; 
							if(fromType){
								String selsql="insert into cus_SelectItem(fieldid,selectname,selectvalue,prj_isdefault,fieldorder,cancel) "+
								"values('"+curfieldid+"','"+curname+"','"+curvalue+"','"+isdefault+"','"+Util.getIntValue( curorder,0)+"','"+cancel+"')";
								RecordSetTrans.executeSql(selsql);
							}else{
								RecordSetTrans.executeProc("prj_selectitem_insert_new",para);//更新表workflow_SelectItem
								RecordSetTrans.executeSql("update prj_selectitem set docpath='"+docPath+"', docCategory='"+doccatalog+"',childitemid='"+childItem_tmp+"',isAccordToSubCom='"+isAccordToSubCom_tmp+"' where fieldid="+curfieldid+" and selectvalue="+curvalue);
							}
	                        curvalue++;
				  	}
				  }
				  if(fieldhtmltype.equals("7")){
		               String displayname = Util.null2String(request.getParameter("displayname_"+index));//显示名
		               String linkaddress = Util.null2String(request.getParameter("linkaddress_"+index));//链接地址
		               String descriptivetext = Util.null2String(request.getParameter("descriptivetext_"+index));//描述性文字
		               descriptivetext = Util.spacetoHtml(descriptivetext);	
			  	       String specialfield = Util.null2String(request.getParameter("specialfield_"+index));//类型
			           String sql = "";
			           if(specialfield.equals("1")){
			              sql = "insert into prj_specialfield(fieldid,displayname,linkaddress,isform,isbill) values("+curfieldid+",'"+displayname+"','"+linkaddress+"',0,1)";    
			           }else{
			              sql = "insert into prj_specialfield(fieldid,descriptivetext,isform,isbill) values("+curfieldid+",'"+descriptivetext+"',0,1)";    
			           }
				       RecordSetTrans.executeSql(sql);
				  }
				  
	  	}
	  	//主字段 结束
	  	
	  	
	  	
			RecordSetTrans.commit();
	  	
			ArrayList labelidsArray = Util.TokenizerString(labelidsCache,",");
			for(int i=0;i<labelidsArray.size();i++){//添加标签id到缓存
				LabelComInfo.addLabeInfoCache((String)labelidsArray.get(i));
			}
			
			
	  }catch(Exception e){
			RecordSetTrans.rollback();
	  
	}
	
	  //同步项目类型的字段
	  ProjectTypeComInfo projectTypeComInfo=new ProjectTypeComInfo();
	  projectTypeComInfo.setTofirstRow();
	  while(projectTypeComInfo.next()){
		  PrjFieldManager.syncDefinedFields(Util.getIntValue( projectTypeComInfo.getProjectTypeid(),0));
	  }
	  
}
	  response.sendRedirect("/proj/ffield/editPrjFieldBatch.jsp?ajax=1&paraid="+prjtype+"&from="+from);
}else if(src.equals("editfieldlabel")){
	String formid = Util.null2String(request.getParameter("formid"));
	String changefieldids = Util.null2String(request.getParameter("changefieldids"));
	ArrayList<String> labelids=new ArrayList<String>();
	RecordSetTrans.setAutoCommit(false);
	try{
		ArrayList changefieldidsArray = Util.TokenizerString(changefieldids,",");
		for(int i=0;i<changefieldidsArray.size();i++){
			String fieldid = (String)changefieldidsArray.get(i);
			String fieldnameCN = Util.null2String(request.getParameter("field_"+fieldid+"_CN"));
			String fieldnameEn = Util.null2String(request.getParameter("field_"+fieldid+"_En"));
			String fieldnameTW = Util.null2String(request.getParameter("field_"+fieldid+"_TW"));
			fieldnameCN = Util.StringReplace(fieldnameCN, "\"", "");//TD10108 表单字段显示名不可以含有半角双引号“"”
			fieldnameEn = Util.StringReplace(fieldnameEn, "\"", "");//TD10108 表单字段显示名不可以含有半角双引号“"”
			fieldnameTW = Util.StringReplace(fieldnameTW, "\"", "");//TD10108 表单字段显示名不可以含有半角双引号“"”
			int lableid = 0;
			String mysql=""+
					" select distinct t2.indexid from HtmlLabelInfo t2 where "+
					" exists (select 1 from HtmlLabelInfo t1 where t1.indexid=t2.indexid and t1.labelname='"+fieldnameCN+"' and t1.languageid=7) "+
					" and exists (select 1 from HtmlLabelInfo t1 where t1.indexid=t2.indexid and t1.labelname='"+fieldnameEn+"' and t1.languageid=8) "+ 
					" and exists (select 1 from HtmlLabelInfo t1 where t1.indexid=t2.indexid and t1.labelname='"+fieldnameTW+"' and t1.languageid=9) " ;
			RecordSetTrans.executeSql(mysql);
			  if(!RecordSetTrans.next()){
				  lableid = PrjFieldManager.getNewIndexId(RecordSetTrans);
				  labelids.add(""+lableid);
				  RecordSetTrans.executeSql("delete from HtmlLabelIndex where id="+lableid);
				  RecordSetTrans.executeSql("delete from HtmlLabelInfo where indexid="+lableid);
				  RecordSetTrans.executeSql("INSERT INTO HtmlLabelIndex values("+lableid+",'"+fieldnameCN+"')");
				  RecordSetTrans.executeSql("INSERT INTO HtmlLabelInfo values("+lableid+",'"+fieldnameCN+"',7)");//中文
				  RecordSetTrans.executeSql("INSERT INTO HtmlLabelInfo values("+lableid+",'"+fieldnameEn+"',8)");//英文
				  RecordSetTrans.executeSql("INSERT INTO HtmlLabelInfo values("+lableid+",'"+fieldnameTW+"',9)");//繁体
				  
					
			  }else{
				  lableid=RecordSetTrans.getInt("indexid");
			  }
			
			if(fieldid.indexOf("prjtype_")!=-1){
				RecordSetTrans.executeSql("update cus_formfield set prj_fieldlabel="+lableid+" where scope='ProjCustomField' and scopeid='"+prjtype+"' and fieldid="+(fieldid.replace("prjtype_","")));
			}else{
				RecordSetTrans.executeSql("update prjDefineField set fieldlabel="+lableid+" where id="+fieldid);
			}
			
		}
		RecordSetTrans.commit();
		int newlabelsize=labelids.size();
		for(int j=0;j<newlabelsize;j++){
			LabelComInfo.addLabeInfoCache(labelids.get(j));//更新缓存
		}
	}catch(Exception exception){
		RecordSetTrans.rollback();
	}
	PrjFieldComInfo.removeFieldCache();
	
	
	response.sendRedirect("/proj/ffield/addPrjFieldlabel.jsp?ajax=1&paraid="+prjtype+"&from="+from);
}
%>