package feilida;

import java.util.regex.Pattern;

import org.json.JSONException;

import feilida.InsertUtil;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.hrm.company.DepartmentComInfo;
import weaver.hrm.company.SubCompanyComInfo;
import weaver.hrm.job.JobTitlesComInfo;
import weaver.hrm.resource.ResourceComInfo;

public class HrmSynchronizationFunctions {
	public String getSub(String workflowId, String IV_DATUM){
	//	String workflowId = "1";
		java.util.Map<String, String> oaDatas = new java.util.HashMap<String, String>();
		oaDatas.put("IV_DATUM", IV_DATUM);

		tmc.BringMainAndDetailByMain bmb = new tmc.BringMainAndDetailByMain("1");
		String result = bmb.getReturn(oaDatas,workflowId);
		return result;    
	}	
	public String getHelp(String workflowId, String IV_DATUM){
		//	String workflowId = "1";
			java.util.Map<String, String> oaDatas = new java.util.HashMap<String, String>();
			oaDatas.put("IV_DATUM", IV_DATUM);
			oaDatas.put("IV_ZDMC", "");
			tmc.BringMainAndDetailByMain bmb = new tmc.BringMainAndDetailByMain("1");
			String result = bmb.getReturn(oaDatas,workflowId);
			return result;    
		}	
	//插入中间表
	public String doSub(String str){
		String sql = "";
		RecordSet rs_cc = new RecordSet();
		RecordSet rs_vv = new RecordSet();
		BaseBean log = new BaseBean();
		try {
			org.json.JSONObject json = new org.json.JSONObject(str);
			org.json.JSONArray jsonArr = json.getJSONObject("table").getJSONArray("main");	
			weaver.conn.RecordSet rs = new weaver.conn.RecordSet();
			
			for(int index=0;index<jsonArr.length();index++){
				org.json.JSONObject jsonx = (org.json.JSONObject)(jsonArr.get(index));
				
				// json的值是 tmc_sap_mapping 的OA字段
				String OBJID = jsonx.getString("OBJID").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");
				String SHORT = jsonx.getString("SHORT").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");
				String ZHZZLB = jsonx.getString("ZHZZLB");
				String ZHZZLBMS = jsonx.getString("ZHZZLBMS");
				
				String ZHBMM = jsonx.getString("ZHBMM").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");
				String ZHBMS  = jsonx.getString("ZHBMS").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");
				
				String STEXT  = jsonx.getString("STEXT").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");	
				String WERKS  = jsonx.getString("WERKS");
				String BUKRS  = jsonx.getString("BUKRS").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");	
				String BUTXT  = jsonx.getString("BUTXT").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");	
				String ZHBMS_L  = jsonx.getString("ZHBMS_L").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");					
				
				
				if(!"".equals(ZHBMM)&&!"".equals(ZHBMS)){
				String sql_isExist = " select * from hrmsubcompany where subcompanycode = "+ZHBMM+"";
				rs_cc.executeSql(sql_isExist);
				if(rs_cc.next()){
					
				String sql_up = " update hrmsubcompany set subcompanyname='"+ZHBMS+"',subcompanydesc='"+ZHBMS_L+"' where subcompanycode = "+ZHBMM+"";
				rs_cc.executeSql(sql_up);
				//log.writeLog("sql_update="+sql_up);
				
				rs_cc.executeSql(" update hrmsubcompanydefined set subcompany4code = "+WERKS+",BUKRS='"+BUKRS+"',BUTXT='"+BUTXT+"' where subcomid in (select id from hrmsubcompany where subcompanycode = "+ZHBMM+") ");
					
				}else{
					String sql_in = "insert into hrmsubcompany (subcompanyname,subcompanydesc,subcompanycode,supsubcomid,companyid)" +
							"  values ('"+ZHBMS+"','"+ZHBMS_L+"','"+ZHBMM+"',0,1)";
					rs_cc.executeSql(sql_in);
					//log.writeLog("sql_insert="+sql_in);
					
					rs_cc.executeSql("insert into hrmsubcompanydefined (subcomid,subcompany4code,BUKRS,BUTXT) values ((select id from hrmsubcompany where subcompanycode = "+ZHBMM+"),"+WERKS+",'"+BUKRS+"','"+BUTXT+"')");
					
					rs.executeSql("select id from HrmSubCompany where subcompanycode = '"+ZHBMM+"'");
					if(rs.next()) {	
					int idx = 0;
					idx = rs.getInt(1);	
					rs_cc.executeSql(" insert into leftmenuconfig (userid,infoid,visible,viewindex,resourceid,resourcetype,locked,lockedbyid,usecustomname,customname,customname_e)  select  " +
							  "	distinct  userid,infoid,visible,viewindex," + idx + ",2,locked,lockedbyid,usecustomname,customname,customname_e from leftmenuconfig where resourcetype=1  and resourceid=1");
					rs_cc.executeSql("insert into mainmenuconfig (userid,infoid,visible,viewindex,resourceid,resourcetype,locked,lockedbyid,usecustomname,customname,customname_e)  select  " +
							  "	distinct  userid,infoid,visible,viewindex," + idx + ",2,locked,lockedbyid,usecustomname,customname,customname_e from mainmenuconfig where resourcetype=1  and resourceid=1");
					}
				}
				
				
			}
				          
				if(!"".equals(OBJID)&&!"".equals(SHORT)){
					String sql_isExist2 = " select * from hrmdepartment where departmentcode = "+OBJID+"";
					rs_vv.executeSql(sql_isExist2);
					if(rs_vv.next()){
						String sql_up2 = "";
						if(!"".equals(ZHBMM)){
						  sql_up2 = " update hrmdepartment set departmentname ='"+STEXT+"',departmentmark ='"+SHORT+"',subcompanyid1=nvl((select id from hrmsubcompany where subcompanycode = '"+ZHBMM+"'),null) where departmentcode ='"+OBJID+"'";
						}else{
							 sql_up2 = " update hrmdepartment set departmentname ='"+STEXT+"',departmentmark ='"+SHORT+"' where departmentcode ='"+OBJID+"'";
						}
						rs_vv.executeSql(sql_up2);
						//log.writeLog("sql_update="+sql_up2);
					}else{
						
						String sql_in2 = "insert into hrmdepartment (departmentcode,departmentname,departmentmark,supdepid,subcompanyid1)" +
							"  values ('"+OBJID+"','"+STEXT+"','"+SHORT+"',0,nvl((select id from hrmsubcompany where subcompanycode = '"+ZHBMM+"'),null))";
						rs_vv.executeSql(sql_in2);
						//log.writeLog("sql_insert="+sql_in2);
				}
				}
				
			}
			
			
		} catch (JSONException e) {
			e.printStackTrace();
		}
		
		try {
			SubCompanyComInfo SubCompanyComInfo= new SubCompanyComInfo();
			SubCompanyComInfo.removeCompanyCache();
		} catch (Exception e) {
			e.printStackTrace();
			log.writeLog("Exception="+e.getMessage());
		}
		
		return sql;
		
	}
	
	public String doDep(String str){
		BaseBean log = new BaseBean();
		String sql = "";
		try {
			org.json.JSONObject json = new org.json.JSONObject(str);
			org.json.JSONArray jsonArr = json.getJSONObject("table").getJSONArray("main");	
			weaver.conn.RecordSet rs = new weaver.conn.RecordSet();
			
			for(int index=0;index<jsonArr.length();index++){
				org.json.JSONObject jsonx = (org.json.JSONObject)(jsonArr.get(index));
				
				// json的值是 tmc_sap_mapping 的OA字段
				String OBJID = jsonx.getString("OBJID").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");
				String SOBID = jsonx.getString("SOBID").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");
				
				
				String sql_upcom = " update hrmsubcompany set outkey=1,supsubcomid = nvl((select id from hrmsubcompany where subcompanycode = '"+SOBID+"'),null) "+
									" where subcompanycode ='"+OBJID+"' ";
				rs.execute(sql_upcom);
				
				
				String sql_upsup = " update hrmdepartment set outkey=1,supdepid = nvl((select id from hrmdepartment where departmentcode = '"+SOBID+"'),null) " +
									" where departmentcode ='"+OBJID+"' ";
				rs.execute(sql_upsup);
			}
		} catch (JSONException e) {
			e.printStackTrace();
		}
		try {
			SubCompanyComInfo SubCompanyComInfo= new SubCompanyComInfo();
			SubCompanyComInfo.removeCompanyCache();
		} catch (Exception e) {
			e.printStackTrace();
			log.writeLog("Exception="+e.getMessage());
		}
		
		try {
			DepartmentComInfo DepartmentComInfo= new DepartmentComInfo();
			DepartmentComInfo.removeCompanyCache();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			log.writeLog("Exception="+e.getMessage());
		}
		
		return sql;
	}
	
	
	public void excDep(){
		BaseBean log = new BaseBean();
		String sql = "";
		RecordSet rsx = new RecordSet();
		RecordSet rsx_d = new RecordSet();
		RecordSet rs = new RecordSet();
		String supdep="";
		String supdep1="";
		String supcmp="";
		String supcmp1="";
		String temp="";
		String vi_dep="";
		String id = "";
		
		String sql_searchdep = " select * from hrmdepartment order by id";
		rs.execute(sql_searchdep);
		//log.writeLog("sql_searchdep="+sql_searchdep);
		while(rs.next()){
			boolean result=true;
			id = Util.null2String(rs.getString("id"));
			supcmp = Util.null2String(rs.getString("subcompanyid1"));
			supdep = Util.null2String(rs.getString("supdepid"));
			temp=supdep;
			vi_dep=id;
			if(!"".equals(supdep)&&!"0".equals(supdep)){
			while(result){
				String sql_2 = "select subcompanyid1,supdepid from hrmdepartment where id = "+temp+"";
				rsx.execute(sql_2);
				//log.writeLog("sql_2="+sql_2);			
				if(rsx.next()){
				vi_dep=vi_dep+","+temp;
				supcmp1 = Util.null2String(rsx.getString("subcompanyid1"));
				//log.writeLog("supcmp1="+supcmp1);
				supdep1 = Util.null2String(rsx.getString("supdepid"));
				//log.writeLog("supdep1="+supdep1);
				if("".equals(supdep1)||"0".equals(supdep1)){
					if(!"".equals(supcmp1)){
						String sql_up="update hrmdepartment set subcompanyid1 ="+supcmp1+" where id  in ("+vi_dep+")";
						rsx_d.execute(sql_up);
						//log.writeLog("sql_up="+sql_up);
					}
					result=false;
				}else{
					temp=supdep1;
				}
								
			
				}else{
					result=false;
				}
			 }
			}else{
				continue;
			}
		}
			
		try {
			DepartmentComInfo DepartmentComInfo= new DepartmentComInfo();
			DepartmentComInfo.removeCompanyCache();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			log.writeLog("Exception="+e.getMessage());
		}
		
	}
	
	
	public String doJob(String str){
		BaseBean log = new BaseBean();
		String sql = "";
		RecordSet rs_cc = new RecordSet();
		try {
			org.json.JSONObject json = new org.json.JSONObject(str);
			org.json.JSONArray jsonArr = json.getJSONObject("table").getJSONArray("main");	
			
			for(int index=0;index<jsonArr.length();index++){
				org.json.JSONObject jsonx = (org.json.JSONObject)(jsonArr.get(index));
				
				// json的值是 tmc_sap_mapping 的OA字段
				String OBJID = jsonx.getString("OBJID").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");
				String SOBID = jsonx.getString("SHORT_S").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");
				String BEGDA = jsonx.getString("BEGDA");
				String ZHGJGW = jsonx.getString("ZHGJGW");
				String SOBID_O = jsonx.getString("SOBID_O");
				String SOBID_P = jsonx.getString("SOBID_P");
				String ZHSFJZ = jsonx.getString("ZHSFJZ");
				String SOBID_S = jsonx.getString("SOBID_S").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");
				
				String SOBID_C = jsonx.getString("SOBID_C").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");
				String SHORT_C = jsonx.getString("SHORT_C").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");
				
				if(!"".equals(SOBID_C)&&!"".equals(SHORT_C)){
					String sql_isExist = " select * from hrmjobactivities where jobactivitymark = '"+SOBID_C+"'";
					rs_cc.executeSql(sql_isExist);
					if(rs_cc.next()){
						String sql_update = " update HrmJobActivities set jobactivityname='"+SHORT_C+"' where jobactivitymark = '"+SOBID_C+"'";
						rs_cc.executeSql(sql_update);
						//log.writeLog("sql_update"+sql_update);
					}else{
						String sql_insert = " insert into HrmJobActivities (jobactivitymark,jobactivityname,jobgroupid) " +
											" values('"+SOBID_C+"','"+SHORT_C+"',11)";
						rs_cc.executeSql(sql_insert);
						//log.writeLog("sql_insert"+sql_insert);
					}
				}
				
				if(!"".equals(OBJID)&&!"".equals(SOBID)){
					
					String sql_isExist2 = " select * from hrmjobtitles where jobtitlecode = '"+OBJID+"'";
					rs_cc.executeSql(sql_isExist2);
					if(rs_cc.next()){
						String sql_update2 = " update hrmjobtitles set jobtitlemark='"+SOBID+"',jobtitlename='"+SOBID+"',jobtitleremark='"+ZHSFJZ+"',outkey='"+SOBID_S+"', " +
											" jobactivityid=nvl((select id from HrmJobActivities where jobactivitymark = '"+SOBID_C+"'),null), " +
											" jobdepartmentid=nvl((select id from hrmdepartment where departmentcode = '"+SOBID_O+"'),null) where jobtitlecode = '"+OBJID+"'";
						rs_cc.executeSql(sql_update2);
						//log.writeLog("sql_update"+sql_update2);
					}else{
						String sql_insert2 = " insert into hrmjobtitles (jobtitlecode,jobtitlemark,jobtitlename,jobactivityid,jobdepartmentid,jobtitleremark,outkey) " +
											" values('"+OBJID+"','"+SOBID+"','"+SOBID+"',nvl((select id from HrmJobActivities where jobactivitymark ='"+SOBID_C+"'),null)," +
											" nvl((select id from hrmdepartment where departmentcode = '"+SOBID_O+"'),null),'"+ZHSFJZ+"','"+SOBID_S+"')";
						rs_cc.executeSql(sql_insert2);
						//log.writeLog("sql_insert"+sql_insert2);
					}
					
					
				} 		
				
				
			}
		} catch (JSONException e) {
			e.printStackTrace();
		}
		
		try {
			JobTitlesComInfo JobTitlesComInfo = new JobTitlesComInfo();
			JobTitlesComInfo.removeJobTitlesCache();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			log.writeLog("Exception="+e.getMessage());
		}
		
		
		return sql;
	}
	
	public String doHrm(String str){
		BaseBean log = new BaseBean();
		String sql = "";
		try {
			org.json.JSONObject json = new org.json.JSONObject(str);
			org.json.JSONArray jsonArr = json.getJSONObject("table").getJSONArray("main");	
			weaver.conn.RecordSet rs = new weaver.conn.RecordSet();
			
			for(int index=0;index<jsonArr.length();index++){
				org.json.JSONObject jsonx = (org.json.JSONObject)(jsonArr.get(index));
				String BUKRS = jsonx.getString("BUKRS").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//公司编码
				String ORGEH_B = jsonx.getString("ORGEH_B").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//公司编码
				String ORGEH = jsonx.getString("ORGEH").replace("&","'||chr(38)||'").replace("'","'||chr(39)||'");//部门编码
				String PERNR = jsonx.getString("PERNR"); //员工号
				String ZHZW = jsonx.getString("ZHZW"); //职位
				String ENAME = jsonx.getString("ENAME").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'"); //员工姓名
				String ZHXB = jsonx.getString("ZHXB"); //性别
				String ZHHYZK = jsonx.getString("ZHHYZK"); //婚姻状况
				String ZHZZMM = jsonx.getString("ZHZZMM"); //政治面貌
				String ZHHKXZ = jsonx.getString("ZHHKXZ"); //户口性质
				String ZHCSNY = jsonx.getString("ZHCSNY"); //出生年月
				String ZHRJTRQ = jsonx.getString("ZHRJTRQ"); //入职日期
				String ZHZGXW = jsonx.getString("ZHZGXW"); //最高学位
				String ZHZJHM = jsonx.getString("ZHZJHM"); //证件号码
				//String ZHGJ = jsonx.getString("ZHGJ"); //国籍
				String ZHJTDZ = jsonx.getString("ZHJTDZ").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'"); //家庭住址
				String ZHXJZDZ = jsonx.getString("ZHXJZDZ").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'"); //现居住地址
				String ZHJG = jsonx.getString("ZHJG");//籍贯
				String ZHLDHTKS = jsonx.getString("ZHLDHTKS");//劳动合同开始日期
				String ZHLDHTJS = jsonx.getString("ZHLDHTJS");//劳动合同结束日期
				String ZHBGDH = jsonx.getString("ZHBGDH");//办公电话
				String ZHZZDH = jsonx.getString("ZHZZDH");//住宅电话
				String ZHSJ = jsonx.getString("ZHSJ");//手机
				String ZHBGYX = jsonx.getString("ZHBGYX");//办公邮箱
				String ZHCZ = jsonx.getString("ZHCZ");//传真
				String ZHGHHY = jsonx.getString("ZHGHHY");//工会会员
				String ZHYGZT = jsonx.getString("ZHYGZT");//员工状态
				String ZHYGZTBM = jsonx.getString("ZHYGZTBM");//员工状态编码
				String ZHGJGW = jsonx.getString("ZHGJGW");//是否关键岗位
				String ZHXZDJ = jsonx.getString("ZHXZDJ");//行政等级
				String ZSTATE = jsonx.getString("ZSTATE");//黑名单
				String ZHYGZ = jsonx.getString("ZHYGZ");//员工组
				String ZHYGZZ = jsonx.getString("ZHYGZZ");//员工子组
				
				if("男".equals(ZHXB)){
					ZHXB="0";
				}else if("女".equals(ZHXB)){
					ZHXB="1";
				}else{
					ZHXB="";
				}
				
				if("已婚".equals(ZHHYZK)){
					ZHHYZK="1";
				}else{
					ZHHYZK="0";
				}
				
				
				if("是".equals(ZHGHHY)){
					ZHGHHY="1";
				}else{
					ZHGHHY="0";
				}
				
				if("初中".equals(ZHZGXW)){
					ZHZGXW="2";
				}else if("高中".equals(ZHZGXW)){
					ZHZGXW="3";
				}else if("技校".equals(ZHZGXW)){
					ZHZGXW="4";
				}else if("中专".equals(ZHZGXW)){
					ZHZGXW="5";
				}else if("大专".equals(ZHZGXW)){
					ZHZGXW="6";
				}else if("学士".equals(ZHZGXW)){
					ZHZGXW="7";
				}else if("硕士".equals(ZHZGXW)){
					ZHZGXW="8";
				}else if("博士".equals(ZHZGXW)){
					ZHZGXW="9";
				}else if("博士后".equals(ZHZGXW)){
					ZHZGXW="12";
				}else{
					ZHZGXW="1";
				}
				
				if("1".equals(ZHYGZTBM)){
					ZHYGZTBM="1";//在职
				}else if("2".equals(ZHYGZTBM)){
					ZHYGZTBM="5";//离职
				}else if("3".equals(ZHYGZTBM)){
					ZHYGZTBM="6";//退休
				}else{
					ZHYGZTBM="2";//试用
				}
				//Pattern pattern = Pattern.compile("[0-9]*");
				
				//if(!pattern.matcher(ZHXZDJ).matches()){
				//	ZHXZDJ = "1";
				//}
				String sql_isExist = " select * from Hrmresource where workcode ='"+PERNR+"' and nvl(accounttype,0)=0  ";
				rs.executeSql(sql_isExist);
				if(rs.next()){
				}else{
					int idy = 0;
					String sql_idy = " select nvl(max(id),2) as idcc from hrmresource ";
					rs.executeSql(sql_idy);
					//log.writeLog("sql_idy="+sql_idy);
					if(rs.next()){
						idy = rs.getInt("idcc");
						idy=idy+1;
					}
					//log.writeLog("idy="+idy);
					
					String srt1 = "##nvl((select id from hrmjobtitles where jobtitlecode = '"+ZHZW+"'),null)";
					String str2 = "##nvl((select id from hrmdepartment where departmentcode = '"+ORGEH+"'),null)";
					String str3 = "##nvl((select id from hrmsubcompany where subcompanycode = '"+ORGEH_B+"'),null)";
					
					java.util.Map<String, String> charMosaic_in = new java.util.HashMap<String, String>();
					InsertUtil ui_in = new InsertUtil();
					charMosaic_in.put("id", String.valueOf(idy));
					charMosaic_in.put("systemlanguage ","7");
					charMosaic_in.put("lastname", ENAME);
					charMosaic_in.put("jobtitle", srt1);
					charMosaic_in.put("workcode", PERNR);
					charMosaic_in.put("seclevel", "");
					charMosaic_in.put("loginid", PERNR);
					charMosaic_in.put("password","C4CA4238A0B923820DCC509A6F75849B");
					charMosaic_in.put("departmentid", str2);
					charMosaic_in.put("subcompanyid1", str3);
					charMosaic_in.put("managerid","");
					charMosaic_in.put("status",ZHYGZTBM);
					charMosaic_in.put("sex", ZHXB);
					charMosaic_in.put("maritalstatus",ZHHYZK);
					charMosaic_in.put("policy", ZHZZMM);
					charMosaic_in.put("regresidentplace",ZHHKXZ);
					charMosaic_in.put("birthday", ZHCSNY);
					charMosaic_in.put("createdate", ZHRJTRQ);
					charMosaic_in.put("educationlevel", ZHZGXW);
					charMosaic_in.put("homeaddress", ZHJTDZ);
					charMosaic_in.put("residentplace", ZHXJZDZ);
					charMosaic_in.put("nativeplace", ZHJG);
					charMosaic_in.put("startdate", ZHLDHTKS);
					charMosaic_in.put("enddate", ZHLDHTJS);
					charMosaic_in.put("telephone", ZHBGDH);
					charMosaic_in.put("mobile", ZHSJ);
					charMosaic_in.put("email",ZHBGYX);
					charMosaic_in.put("fax",ZHCZ);
					charMosaic_in.put("islabouunion",ZHGHHY);
					//charMosaic_in.put("joblevel",ZHXZDJ);
					charMosaic_in.put("certificatenum",ZHZJHM);
					charMosaic_in.put("dsporder","0");
					ui_in.insert(charMosaic_in, "Hrmresource");
					
					sql= " select id from Hrmresource where  belongto is  null and workcode ='"+PERNR+"' and jobtitle " +
							"	in (select id from hrmjobtitles where jobtitlecode = '"+ZHZW+"') ";
					rs.executeSql(sql);
					String temp_id="";
					if(rs.next()){
						temp_id = Util.null2String(rs.getString("id"));
					}					
					
					java.util.Map<String, String> charMosaic_in_cus = new java.util.HashMap<String, String>();
					InsertUtil ui_in_cus = new InsertUtil();
					charMosaic_in_cus.put("scope", "HrmCustomFieldByInfoType");
					charMosaic_in_cus.put("scopeid", "-1");
					charMosaic_in_cus.put("id", temp_id);
					charMosaic_in_cus.put("field1", ZSTATE);
					charMosaic_in_cus.put("field2", ZHYGZ);
					charMosaic_in_cus.put("field3", ZHYGZZ);
					charMosaic_in_cus.put("field7", ZHXZDJ);
					if(temp_id.length() >0){
						ui_in_cus.insert(charMosaic_in_cus, "cus_fielddata");
					}
				}
				
				
			}
		} catch (JSONException e) {
			e.printStackTrace();
		}	
		return sql;
	}
	
	//次岗人员数据插入
		public void minorJob(String str){
			BaseBean log = new BaseBean();
			String sql = "";
			RecordSet rs_cc = new RecordSet();
			RecordSet rs = new RecordSet();
			try {
				org.json.JSONObject json = new org.json.JSONObject(str);
				org.json.JSONArray jsonArr = json.getJSONObject("table").getJSONArray("main");	
				
				for(int index=0;index<jsonArr.length();index++){
					org.json.JSONObject jsonx = (org.json.JSONObject)(jsonArr.get(index));
					
					// 是否兼职， 只获取未X的
					String ZHSFJZ = Util.null2String(jsonx.getString("ZHSFJZ"));
					if(!"X".equalsIgnoreCase(ZHSFJZ))
						continue;
					
					// 岗位的编码
					String OBJID = jsonx.getString("OBJID").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");
					
					String SOBID_O = jsonx.getString("SOBID_O").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");
					// 所属人的工号
					String SOBID_P = jsonx.getString("SOBID_P");
					// 上级岗位编号
					String SOBID_S = jsonx.getString("SOBID_S").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");		
					// 兼职的标示
					String ZHJZLX = jsonx.getString("ZHJZLX");
					// 兼职开始日期
					String BEGDA1 = jsonx.getString("BEGDA1"); 
					// 兼职结束日期
					String ENDDA1 = jsonx.getString("ENDDA1"); 
					
					/* 处理逻辑:
					 * 	1、遍历所有的次岗位  
					 * 	2、在人员表里查询到是否存在【通过人员和兼职标示来区分】,如果存在更新记录;如果不存在新增一条人员次岗位记录
					 * 	3、查看兼职的日期，如果未在期间内将让这条记录离职;期间内容让这条记录更新为正常
					 * 	4、处理人员上级
					 */
					// 主账号不存在，直接结束
					sql = "select count(id) as ct from Hrmresource where  workcode='"+SOBID_P+"' and nvl(accounttype,0)=0 ";
					rs_cc.executeSql(sql);
					log.writeLog("sql="+sql);
					int t_flag = 0;
					if(rs_cc.next()){
						t_flag = rs_cc.getInt("ct");
					}
					if(t_flag == 0) continue;
					
					// 该次账号是否存在，如果存在需要更新；如果不存在需要新增【注意更新上下级关系】
					sql = " select max(id) as ct from Hrmresource where workcode='"+SOBID_P
							+"' and accounttype=1 and id in (select id from cus_fielddata  "
							+" where scope='HrmCustomFieldByInfoType' and field4='"+ZHJZLX+"')";
					rs_cc.executeSql(sql);
					log.writeLog("sql2="+sql);
					t_flag = 0;
					String su_id = "";
					if(rs_cc.next()){
						su_id = Util.null2String(rs_cc.getString("ct"));
					}
					log.writeLog("su_id长度="+su_id.length());
					// 查询该账号的上级
					String superjobcode = "";
					String managerid="";
					rs.executeSql(" select outkey from hrmjobtitles where jobtitlecode ='"+OBJID+"' ");
					if(rs.next()){
						superjobcode = Util.null2String(rs.getString("outkey"));
					}
					//log.writeLog("superjobcode=" + superjobcode);
					while(!"".equals(superjobcode)){
						String sql_manager = " select id from hrmresource where jobtitle in (select id from hrmjobtitles where jobtitlecode = " +
								" '"+superjobcode+"') and status in (1,2)";
						rs.executeSql(sql_manager);
						//log.writeLog("sql_manager=" + sql_manager);
						if(rs.next()){
							managerid = Util.null2String(rs.getString("id"));
							break;
						}else{
							String sql_superjobcode =" select outkey from hrmjobtitles where jobtitlecode ='"+superjobcode+"' ";
							rs.executeSql(sql_superjobcode);
							if(rs.next()){
								superjobcode = Util.null2String(rs.getString("outkey"));
							}else{
								break;
							}
						}
					}
					
					// 不存在就新增
					if(su_id.length() == 0){
						String departmentid = "";
						String subcompanyid = "";
						String sql_dep = " select id,subcompanyid1 from hrmdepartment where departmentcode = '"+SOBID_O+"' ";
						rs.executeSql(sql_dep);
						if(rs.next()){
							departmentid = Util.null2String(rs.getString("id"));
							subcompanyid = Util.null2String(rs.getString("subcompanyid1"));	
						}else{
							continue;
						}
						
						String actcode ="";
						String seclevel ="";
						String sql_sec = " select * from hrmjobactivities where id in (select jobactivityid from hrmjobtitles where jobtitlecode = '"+OBJID+"')";
						rs.executeSql(sql_sec);
						log.writeLog("sql_sec" + sql_sec);
						if(rs.next()){
							actcode = Util.null2String(rs.getString("jobactivitymark"));
						}
						
						String sql_seclevel = " select seclevel from uf_seclevel where postcode = '"+actcode+"' ";
						rs.executeSql(sql_seclevel);
						if(rs.next()){
							seclevel = Util.null2String(rs.getString("seclevel"));
						}else{
							seclevel = "10";
						}
						
						
						// 复制主账号信息  managerid
						sql = "insert into Hrmresource (id,systemlanguage,lastname,jobtitle,workcode,departmentid,"
							 +" subcompanyid1,status,sex,maritalstatus,policy,regresidentplace,birthday,createdate," 
							 +" degree,homeaddress,residentplace,nativeplace,mobile,fax,islabouunion,joblevel,"
							 +" certificatenum,dsporder,accounttype,belongto,managerid,seclevel)"
							+" select (select nvl(max(id),2)+1 from Hrmresource),systemlanguage,lastname,"
							+"(select id from HrmJobTitles where jobtitlecode='"+OBJID
							+"'),'"+SOBID_P+"',"+departmentid+","+subcompanyid+",status,sex,maritalstatus,"
							+" policy,regresidentplace,birthday,createdate,degree,homeaddress,residentplace,"
							+" nativeplace,mobile,fax,islabouunion,joblevel,certificatenum,dsporder,1,id,"+managerid+","+seclevel 
							+" from Hrmresource where workcode='"+SOBID_P+"' and nvl(accounttype,0)=0 and status in (0,1,2,3,4) ";
						boolean isF = rs.executeSql(sql);
						log.writeLog("sql3=" + sql);
						
						if(!isF) continue;
						// 查询信插入的人员
						sql = "select max(id) as maxid from Hrmresource where  workcode='"+SOBID_P
								+"' and accounttype=1 ";
						rs.executeSql(sql);
						String id_x = "";
						if(rs.next()){
							id_x = Util.null2String(rs.getString("maxid"));
						}
						
						// 新增内容记录
						java.util.Map<String, String> charMosaic_in_cus = new java.util.HashMap<String, String>();
						charMosaic_in_cus.put("scope", "HrmCustomFieldByInfoType");
						charMosaic_in_cus.put("scopeid", "-1");
						charMosaic_in_cus.put("id", id_x);
						charMosaic_in_cus.put("field4", ZHJZLX);
						charMosaic_in_cus.put("field5", BEGDA1);
						charMosaic_in_cus.put("field6", ENDDA1);
						if(id_x.length() >0){
							InsertUtil ui_in_cus = new InsertUtil();
							ui_in_cus.insert(charMosaic_in_cus, "cus_fielddata");
						}else{
							continue;
						}
						
						if(ENDDA1 == null || ENDDA1.length() != 10) ENDDA1 = "9999-01-01";
						
						// 有效期记录更新
						sql = "select count(id) as ct from cus_fielddata where id="+id_x 
								+ " and scope='HrmCustomFieldByInfoType' and to_char(sysdate,'YYYY-MM-DD')<='"
								+ ENDDA1+"' ";
						rs.executeSql(sql);
						t_flag = 0;
						if(rs.next()){
							t_flag = rs.getInt("ct");
						}
						if(t_flag == 0) {
							sql = "update hrmresource set status=5 where id="+id_x;
						}else{
							sql = "update hrmresource set status=1 where id="+id_x;
						}
						rs.executeSql(sql);
						
						// 更新所有下级记录  如果上级是这个部门并且是有效的记录需要更新
						if(t_flag > 0 ){
							sql = "update hrmresource set managerid="+id_x  
								+" where id!="+id_x
								+" and jobtitle in(select id from hrmjobtitles where outkey='"+OBJID+"')";
							rs.executeSql(sql);
						}
						
					}else{   // 有的就更新	
						
						String departmentid = "";
						String subcompanyid = "";
						String sql_dep = " select id,subcompanyid1 from hrmdepartment where departmentcode = '"+SOBID_O+"' ";
						rs.executeSql(sql_dep);
						if(rs.next()){
							departmentid = Util.null2String(rs.getString("id"));
							subcompanyid = Util.null2String(rs.getString("subcompanyid1"));	
						}else{
							continue;
						}
						
						String actcode ="";
						String seclevel ="";
						String sql_sec = " select * from hrmjobactivities where id in (select jobactivityid from hrmjobtitles where jobtitlecode = '"+OBJID+"')";
						rs.executeSql(sql_sec);
						if(rs.next()){
							actcode = Util.null2String(rs.getString("jobactivitymark"));
						}
						
						String sql_seclevel = " select seclevel from uf_seclevel where postcode = '"+actcode+"' ";
						rs.executeSql(sql_seclevel);
						if(rs.next()){
							seclevel = Util.null2String(rs.getString("seclevel"));
						}else{
							seclevel = "10";
						}
						
						// 更新主表记录  上级记录
	 					sql = "update hrmresource set managerid='"+managerid + "',jobtitle=(select id from HrmJobTitles where jobtitlecode='"+OBJID+"'),departmentid="+departmentid+",subcompanyid1="+subcompanyid+",seclevel="+seclevel+" where id="+su_id  ;
	 					rs.executeSql(sql);
	 					// 更新附属信息记录
	 					sql = "update cus_fielddata set field5='"+BEGDA1 + "',field6='"+ENDDA1 
	 						+ "' where id="+su_id  +" and scope='HrmCustomFieldByInfoType'";
	 					rs.executeSql(sql);
	 					
	 					if(ENDDA1 == null || ENDDA1.length() != 10) ENDDA1 = "9999-01-01";
						
						// 有效期记录更新
						sql = "select count(id) as ct from cus_fielddata where id="+su_id 
								+ " and scope='HrmCustomFieldByInfoType' and to_char(sysdate,'YYYY-MM-DD')<='"+ENDDA1+"' ";
						rs.executeSql(sql);
						t_flag = 0;
						if(rs.next()){
							t_flag = rs.getInt("ct");
						}
						if(t_flag == 0) {
							sql = "update hrmresource set status=5 where id="+su_id;
						}else{
							sql = "update hrmresource set status=1 where id="+su_id;
						}
						rs.executeSql(sql);
						
						// 更新所有下级记录  如果上级是这个部门并且是有效的记录需要更新
						if(t_flag > 0 ){
							sql = "update hrmresource set managerid="+su_id  
								+" where id!="+su_id
								+" and jobtitle in(select id from hrmjobtitles where outkey='"+OBJID+"')";
							rs.executeSql(sql);
						}
					}
					
				}
			} catch (JSONException e) {
				e.printStackTrace();
			}
			
			try {
				JobTitlesComInfo JobTitlesComInfo = new JobTitlesComInfo();
				JobTitlesComInfo.removeJobTitlesCache();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				log.writeLog("Exception="+e.getMessage());
			}
			
		}
	
	public String upHrm(String str){
		InsertUtil ui = new InsertUtil();
		BaseBean log = new BaseBean();
		String sql = "";
		try {
			org.json.JSONObject json = new org.json.JSONObject(str);
			org.json.JSONArray jsonArr = json.getJSONObject("table").getJSONArray("main");	
			weaver.conn.RecordSet rs = new weaver.conn.RecordSet();
			weaver.conn.RecordSet rs1 = new weaver.conn.RecordSet();
			
			for(int index=0;index<jsonArr.length();index++){
				org.json.JSONObject jsonx = (org.json.JSONObject)(jsonArr.get(index));
				String BUKRS = jsonx.getString("BUKRS").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//公司编码
				String ORGEH_B = jsonx.getString("ORGEH_B").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//公司编码
				String ORGEH = jsonx.getString("ORGEH").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//部门编码
				String PERNR = jsonx.getString("PERNR"); //员工号
				String ZHZW = jsonx.getString("ZHZW"); //职位
				String ENAME = jsonx.getString("ENAME").replace("&","'||chr(38)||'"); //员工姓名
				String ZHXB = jsonx.getString("ZHXB"); //性别
				String ZHHYZK = jsonx.getString("ZHHYZK"); //婚姻状况
				String ZHZZMM = jsonx.getString("ZHZZMM"); //政治面貌
				String ZHHKXZ = jsonx.getString("ZHHKXZ"); //户口性质
				String ZHCSNY = jsonx.getString("ZHCSNY"); //出生年月
				String ZHRJTRQ = jsonx.getString("ZHRJTRQ"); //入职日期
				String ZHZGXW = jsonx.getString("ZHZGXW"); //最高学位
				String ZHZJHM = jsonx.getString("ZHZJHM"); //证件号码
				//String ZHGJ = jsonx.getString("ZHGJ"); //国籍
				String ZHJTDZ = jsonx.getString("ZHJTDZ").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'"); //家庭住址
				String ZHXJZDZ = jsonx.getString("ZHXJZDZ").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'"); //现居住地址
				String ZHJG = jsonx.getString("ZHJG");//籍贯
				String ZHLDHTKS = jsonx.getString("ZHLDHTKS");//劳动合同开始日期
				String ZHLDHTJS = jsonx.getString("ZHLDHTJS");//劳动合同结束日期
				String ZHBGDH = jsonx.getString("ZHBGDH");//办公电话
				String ZHZZDH = jsonx.getString("ZHZZDH");//住宅电话
				String ZHSJ = jsonx.getString("ZHSJ");//手机
				String ZHBGYX = jsonx.getString("ZHBGYX");//办公邮箱
				String ZHCZ = jsonx.getString("ZHCZ");//传真
				String ZHGHHY = jsonx.getString("ZHGHHY");//工会会员
				String ZHYGZT = jsonx.getString("ZHYGZT");//员工状态
				String ZHYGZTBM = jsonx.getString("ZHYGZTBM");//员工状态编码
				String ZHGJGW = jsonx.getString("ZHGJGW");//是否关键岗位
				String ZHXZDJ = jsonx.getString("ZHXZDJ");//行政等级
				String ZSTATE = jsonx.getString("ZSTATE");//黑名单
				String ZHYGZ = jsonx.getString("ZHYGZ");//员工组
				String ZHYGZZ = jsonx.getString("ZHYGZZ");//员工子组
				if("男".equals(ZHXB)){
					ZHXB="0";
				}else if("女".equals(ZHXB)){
					ZHXB="1";
				}else{
					ZHXB="";
				}
				
				if("已婚".equals(ZHHYZK)){
					ZHHYZK="1";
				}else{
					ZHHYZK="0";
				}
				
				if("是".equals(ZHGHHY)){
					ZHGHHY="1";
				}else{
					ZHGHHY="0";
				}
				
				if("初中".equals(ZHZGXW)){
					ZHZGXW="2";
				}else if("高中".equals(ZHZGXW)){
					ZHZGXW="3";
				}else if("技校".equals(ZHZGXW)){
					ZHZGXW="4";
				}else if("中专".equals(ZHZGXW)){
					ZHZGXW="5";
				}else if("大专".equals(ZHZGXW)){
					ZHZGXW="6";
				}else if("学士".equals(ZHZGXW)){
					ZHZGXW="7";
				}else if("硕士".equals(ZHZGXW)){
					ZHZGXW="8";
				}else if("博士".equals(ZHZGXW)){
					ZHZGXW="9";
				}else if("博士后".equals(ZHZGXW)){
					ZHZGXW="12";
				}else{
					ZHZGXW="1";
				}
				
				if("1".equals(ZHYGZTBM)){
					ZHYGZTBM="1";//在职
				}else if("2".equals(ZHYGZTBM)){
					ZHYGZTBM="5";//离职
				}else if("3".equals(ZHYGZTBM)){
					ZHYGZTBM="6";//退休
				}else{
					ZHYGZTBM="2";//试用
				}
				
				String superjobcode = "";
				String managerid="";
				rs.executeSql(" select outkey from hrmjobtitles where jobtitlecode ='"+ZHZW+"' ");
				if(rs.next()){
					superjobcode = Util.null2String(rs.getString("outkey"));
				}
				//log.writeLog("superjobcode=" + superjobcode);
				while(!"".equals(superjobcode)){
					String sql_manager = " select id from hrmresource where jobtitle in (select id from hrmjobtitles where jobtitlecode = " +
							" '"+superjobcode+"') and status in (1,2)";
					rs.executeSql(sql_manager);
					//log.writeLog("sql_manager=" + sql_manager);
					if(rs.next()){
						managerid = Util.null2String(rs.getString("id"));
						break;
					}else{
						String sql_superjobcode =" select outkey from hrmjobtitles where jobtitlecode ='"+superjobcode+"' ";
						rs.executeSql(sql_superjobcode);
						if(rs.next()){
							superjobcode = Util.null2String(rs.getString("outkey"));
						}else{
							break;
						}
					}
				}
				
				/*
				//判断是否为次岗
				int isbelongto=0;
				String belongto="";
				String sql_isbelongto = " select count(1) as num from hrmresource where workcode = '"+PERNR+"' and jobtitle in " +
										" (select id from hrmjobtitles where jobtitlecode ='"+ZHZW+"' and jobtitleremark ='X')";
				rs.executeSql(sql_isbelongto);
				if(rs.next()){
					isbelongto = rs.getInt("num");
				}
				String sql_belongto = " select id as idx from hrmresource where workcode = '"+PERNR+"' and jobtitle in " +
						" (select id from hrmjobtitles where  jobtitleremark is null)";
				rs.executeSql(sql_belongto);
				if(rs.next()){
					belongto = Util.null2String(rs.getString("idx"));
				}
				*/				

				
				String actcode ="";
				String seclevel ="";
				String sql_sec = " select * from hrmjobactivities where id in (select jobactivityid from hrmjobtitles where jobtitlecode = '"+ZHZW+"')";
				rs.executeSql(sql_sec);
				if(rs.next()){
					actcode = Util.null2String(rs.getString("jobactivitymark"));
				}
				
				String sql_seclevel = " select seclevel from uf_seclevel where postcode = '"+actcode+"' ";
				rs.executeSql(sql_seclevel);
				if(rs.next()){
					seclevel = Util.null2String(rs.getString("seclevel"));
				}else{
					seclevel = "10";
				}
				
				
				//Pattern pattern = Pattern.compile("[0-9]*");
				
				//if(!pattern.matcher(ZHXZDJ).matches()){
				//	ZHXZDJ = "1";
				//} 
				
				String sql_status=" select count(1) as count from hrmresource where loginid is null and belongto is null and status=5 and workcode ='"+PERNR+"'";
				rs.executeSql(sql_status);
				int count =0;
				boolean updatelogindi =false;
				if(rs.next()){
					count = rs.getInt("count");
				}
				if(count >0){
					updatelogindi = true;
				}
				
				String srt1 = "##nvl((select id from hrmjobtitles where jobtitlecode = '"+ZHZW+"'),null)";
				String str2 = "##nvl((select id from hrmdepartment where departmentcode = '"+ORGEH+"'),null)";
				String str3 = "##nvl((select id from hrmsubcompany where subcompanycode = '"+ORGEH_B+"'),null)";
				//String str4 =" and jobtitle=nvl((select id from hrmjobtitles where jobtitlecode = '"+ZHZW+"'),null)";
				String str4 =" and nvl(accounttype,0)=0 ";
				
					java.util.Map<String, String> charMosaic_up = new java.util.HashMap<String, String>();
					InsertUtil ui_up = new InsertUtil();
					charMosaic_up.put("lastname", ENAME);
					charMosaic_up.put("workcode", PERNR);
					charMosaic_up.put("jobtitle", srt1);
					charMosaic_up.put("departmentid", str2);
					charMosaic_up.put("subcompanyid1",str3);
					charMosaic_up.put("managerid",managerid);
					charMosaic_up.put("status",ZHYGZTBM);
					charMosaic_up.put("seclevel",seclevel);
					charMosaic_up.put("sex", ZHXB);
					charMosaic_up.put("maritalstatus",ZHHYZK);
					charMosaic_up.put("policy", ZHZZMM);
					charMosaic_up.put("regresidentplace",ZHHKXZ);
					charMosaic_up.put("birthday", ZHCSNY);
					charMosaic_up.put("createdate", ZHRJTRQ);
					charMosaic_up.put("educationlevel", ZHZGXW);
					charMosaic_up.put("homeaddress", ZHJTDZ);
					charMosaic_up.put("residentplace", ZHXJZDZ);
					charMosaic_up.put("nativeplace", ZHJG);
					charMosaic_up.put("startdate", ZHLDHTKS);
					charMosaic_up.put("enddate", ZHLDHTJS);
					charMosaic_up.put("telephone", ZHBGDH);
					charMosaic_up.put("mobile", ZHSJ);
					charMosaic_up.put("email",ZHBGYX);
					charMosaic_up.put("fax",ZHCZ);
					charMosaic_up.put("islabouunion",ZHGHHY);
					//charMosaic_up.put("joblevel",ZHXZDJ);
					charMosaic_up.put("certificatenum",ZHZJHM);
					if ("5".equals(ZHYGZTBM)){
						//charMosaic_up.put("belongto", belongto);
						//charMosaic_up.put("accounttype", "1");
						charMosaic_up.put("loginid", "");
						charMosaic_up.put("password","");
					}else if("1".equals(ZHYGZTBM) && updatelogindi){
						charMosaic_up.put("loginid", PERNR);
						charMosaic_up.put("password","C4CA4238A0B923820DCC509A6F75849B");
					}
					/*
					else {
						sql= " select * from Hrmresource where  belongto is not null and workcode ='"+PERNR+"' and jobtitle " +
								"	in (select id from hrmjobtitles where jobtitlecode = '"+ZHZW+"') ";
						rs.execute(sql);
						if(rs.next()){
							charMosaic_up.put("belongto", "");
							charMosaic_up.put("accounttype", "");
							charMosaic_up.put("loginid", PERNR);
							charMosaic_up.put("password","C4CA4238A0B923820DCC509A6F75849B");
							
						}else{
							charMosaic_up.put("belongto", "");
						}
					}
					*/				
					ui_up.updateGen(charMosaic_up, "Hrmresource", "workcode",PERNR,str4);	
					String idy = "";
					rs.execute("select id from Hrmresource where workcode='"+PERNR+"' and jobtitle in (select id from hrmjobtitles where jobtitlecode = '"+ZHZW+"') ");
					if(rs.next()){
						idy = Util.null2String(rs.getString("id"));	
					}
					
					java.util.Map<String, String> charMosaic_up_cus = new java.util.HashMap<String, String>();
					charMosaic_up_cus.put("scope", "HrmCustomFieldByInfoType");
					charMosaic_up_cus.put("scopeid", "-1");
					charMosaic_up_cus.put("id", idy);
					charMosaic_up_cus.put("field1", ZSTATE);
					charMosaic_up_cus.put("field2", ZHYGZ);
					charMosaic_up_cus.put("field3", ZHYGZZ);
					charMosaic_up_cus.put("field7", ZHXZDJ);
					if(idy.length()>0){
						InsertUtil ui_up_cus = new InsertUtil();
						ui_up_cus.updateGen(charMosaic_up_cus, "cus_fielddata", "id", idy," and scopeid = '-1' ");
					}		
				
			}
		} catch (JSONException e) {
			e.printStackTrace();
		}	
		return sql;
	}
	
	
	//人员缓存清除
	public void addCache(){
		RecordSet rs = new RecordSet();
		BaseBean log = new BaseBean();
		String sql = " select id from hrmresource ";
		rs.execute(sql);
		while(rs.next()){
			String idx = Util.null2String(rs.getString("id"));	
			try {
				ResourceComInfo ResourceComInfo = new ResourceComInfo();
				ResourceComInfo.addResourceInfoCache(idx);
			} catch (Exception e) {
				e.printStackTrace();
				log.writeLog("Exception=" + e.getMessage());
			}
		}	
	}
	
	
	//插入中间表
	public void doHelp(String str){
		String sql = "";
		RecordSet rs = new RecordSet();
		BaseBean log = new BaseBean();
		try {
			org.json.JSONObject json = new org.json.JSONObject(str);
			org.json.JSONArray jsonArr = json.getJSONObject("table").getJSONArray("main");
			sql="update uf_search_help set status='1' ";
			rs.execute(sql);
			for(int index=0;index<jsonArr.length();index++){
				org.json.JSONObject jsonx = (org.json.JSONObject)(jsonArr.get(index));
					
				// json的值是 tmc_sap_mapping 的OA字段
				String ZHZDMC = jsonx.getString("ZHZDMC").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//名称
				String ZHZDBM = jsonx.getString("ZHZDBM").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//编码
				String ZHZDMS = jsonx.getString("ZHZDMS").replace("'","'||chr(39)||'").replace("&","'||chr(38)||'");//描述
										
				if(!"".equals(ZHZDBM)){
					String sql_isExist = " select * from uf_search_help where ZHZDBM = '"+ZHZDBM+"'";
					rs.executeSql(sql_isExist);
					if(rs.next()){
							
						String sql_up = " update uf_search_help set ZHZDMC='"+ZHZDMC+"', ZHZDMS='"+ZHZDMS+"',status='0' where ZHZDBM = '"+ZHZDBM+"'";
						rs.executeSql(sql_up);
						//log.writeLog("sql_update="+sql_up);
						
					}else{
						String sql_in = "insert into uf_search_help (ZHZDMC,ZHZDBM,ZHZDMS,status)" +
								"  values ('"+ZHZDMC+"','"+ZHZDBM+"','"+ZHZDMS+"','0')";
						rs.executeSql(sql_in);
						//log.writeLog("sql_insert="+sql_in);												
					}					
				}										
			}								
		} catch (JSONException e) {
			e.printStackTrace();
		}
						
			
		}
	
	public void hrmSealed() {
		String ID = "";
		BaseBean log =new BaseBean();
		RecordSet rs = new RecordSet();
		RecordSet rs_dt = new RecordSet();
		
		//部门封存
		String sql_department = " select * from HrmDepartment where outkey is null and id not in " +
								" (select departmentid from Hrmresource where status=1 ) and id not in " +
								" (select supdepid from HrmDepartment where NVL(canceled,0) !=1 ) order by TLEVEL desc";
		rs_dt.execute(sql_department);
		while(rs_dt.next()){
			ID = Util.null2String(rs_dt.getString("ID"));
			String sql_Sealed_dep = " update HrmDepartment set canceled =1 where id = "+ID+"";
			rs.execute(sql_Sealed_dep);
			log.writeLog("sql_Sealed:" +sql_Sealed_dep);
		}
		
		try {
			DepartmentComInfo DepartmentComInfo= new DepartmentComInfo();
			DepartmentComInfo.removeCompanyCache();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			log.writeLog("Exception="+e.getMessage());
		}
		
		
		//分部封存
		String sql_subcompany = " select * from Hrmsubcompany where outkey is null and " +
								" id not in (select subcompanyid1 from Hrmresource where status=1) and id not in " +
								" (select subcompanyid1 from HrmDepartment where NVL(canceled,0) !=1) and id not in " +
								" (select supsubcomid from Hrmsubcompany where NVL(canceled,0) !=1) order by TLEVEL desc";
		rs_dt.execute(sql_subcompany);
		while(rs_dt.next()){
			ID = Util.null2String(rs_dt.getString("ID"));
			String sql_Sealed_com = " update Hrmsubcompany set canceled =1 where id = "+ID+"";
			rs.execute(sql_Sealed_com);
			log.writeLog("sql_Sealed_com:" +sql_Sealed_com);
			
		}
		
		try {
			SubCompanyComInfo SubCompanyComInfo= new SubCompanyComInfo();
			SubCompanyComInfo.removeCompanyCache();
		} catch (Exception e) {
			e.printStackTrace();
			log.writeLog("Exception="+e.getMessage());
		}

	}
	

}
