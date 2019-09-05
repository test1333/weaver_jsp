<%@page import="weaver.cpcompanyinfo.ProManageUtil"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="java.net.URLDecoder"%>
<%@ include file="/page/maint/common/initNoCache.jsp"%>
<jsp:useBean id="jspUtil" class="weaver.cpcompanyinfo.JspUtil" scope="page" />
<jsp:useBean id="pro" class="weaver.cpcompanyinfo.ProManageUtil" scope="page" />
<%@page import="weaver.general.TimeUtil"%>
<%@page import="weaver.cpcompanyinfo.CpBoardDirectors"%>
<%@page import="weaver.cpcompanyinfo.CpBoardOfficer"%>
<%@ page import="net.sf.json.*"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs02" class="weaver.conn.RecordSet" scope="page" />
<%
	String method = Util.null2String(request.getParameter("method"));
	
	String companyid = Util.null2String(request
			.getParameter("companyid"));
	StringBuffer strSql = new StringBuffer();

	String now = Util.date(2);

	String createdatetime = now;

	String appointbegindate = Util.null2String(request
			.getParameter("appointbegindate"));
	String appointenddate = Util.null2String(request
			.getParameter("appointenddate"));
	String appointduetime =Util.getIntValue(Util.null2String(request
			.getParameter("appointduetime")),0)+"";
	String supervisor = Util.null2String(request
			.getParameter("supervisor"));
	String generalmanager = Util.null2String(request
			.getParameter("generalmanager"));
	String ischairman = Util.null2String(request
			.getParameter("ischairman_dsh"));
	String chairman = Util
			.null2String(request.getParameter("chairman"));
	String faren = Util
			.null2String(request.getParameter("faren"));
	String affixdoc = Util.null2String(request
			.getParameter("affixdoc"));
	
	String versionnum = Util.null2String(request.getParameter("versionnum"));
	String versionname = Util.null2String(request.getParameter("versionname"));
	String versionmemo = Util.null2String(request.getParameter("versionmemo"));
	String versionaffix = Util.null2String(request.getParameter("versionaffix"));
	
	String isaddversion =  Util.null2String(request.getParameter("isaddversion"));
	String date2Version = Util.null2String(request.getParameter("date2Version")); 
	
	String managerbegindate = Util.null2String(request.getParameter("managerbegindate"));
	String managerenddate = Util.null2String(request.getParameter("managerenddate"));
	String managerduetime = Util.getIntValue(Util.null2String(request.getParameter("managerduetime")),0)+"";
	
	//-------------����ת��-----------------
	appointbegindate = URLDecoder.decode(appointbegindate, "utf-8");
	appointenddate = URLDecoder.decode(appointenddate, "utf-8");
	appointduetime = URLDecoder.decode(appointduetime, "utf-8");
	supervisor = URLDecoder.decode(supervisor, "utf-8");
	generalmanager = URLDecoder.decode(generalmanager, "utf-8");
	ischairman = URLDecoder.decode(ischairman, "utf-8");
	chairman = URLDecoder.decode(chairman, "utf-8");
	faren = URLDecoder.decode(faren, "utf-8");
	affixdoc = URLDecoder.decode(affixdoc, "utf-8");
	System.out.println("request chairman = "+chairman);
	versionnum =ProManageUtil.fetchString(URLDecoder.decode(versionnum,"utf-8"));
	versionname = URLDecoder.decode(versionname,"utf-8");
	versionmemo = URLDecoder.decode(versionmemo,"utf-8");
	versionaffix = URLDecoder.decode(versionaffix,"utf-8");
	isaddversion = URLDecoder.decode(isaddversion,"utf-8");
	date2Version = URLDecoder.decode(date2Version,"utf-8");
	
	

	String lastupdatetime = now;
	//System.out.println("���»�"+method);
	if ("add".equals(method)) {
		//------------�õ� request ֵ--------------

		strSql.setLength(0);
		strSql.append(" insert into CPBOARDDIRECTORS ");
		strSql
				.append(" (companyid,ischairman,chairman,appointbegindate,appointenddate,appointduetime,supervisor,generalmanager,createdatetime,lastupdatetime,isdel,drectorsaffix,managerbegindate,managerenddate,managerduetime,faren)");
		strSql.append(" values (" + companyid + ",'" + ischairman
				+ "','" + chairman + "','" + appointbegindate + "',");
		strSql.append(" '" + appointenddate + "','" + appointduetime
				+ "','" + supervisor + "','" + generalmanager + "',");
		strSql.append(" '" + createdatetime + "','" + lastupdatetime
				+ "','T','"+affixdoc+"','"+managerbegindate+"','"+managerenddate+"','"+managerduetime+"','"+faren+"')");
//		System.out.println("SQL:"+strSql.toString());
		rs.execute(strSql.toString());

		String listdshcy = Util.null2String(request
				.getParameter("data"));
		
		String listjshcy = Util.null2String(request
				.getParameter("data2js"));
		
		int directorsid = 0;
		
			strSql.setLength(0);
			strSql
					.append(" select directorsid from CPBOARDDIRECTORS where companyid="
							+ companyid);
			rs.execute(strSql.toString());
			if (rs.next()) {
				directorsid = rs.getInt("directorsid");
				if (!"".equals(listdshcy)) {
				listdshcy = URLDecoder.decode(listdshcy, "utf-8");
				org.json.JSONObject o4JsonArr2dsh = new org.json.JSONObject(
						listdshcy);
				for (int i = 0; i < o4JsonArr2dsh.length(); i++) {
					String sessions =o4JsonArr2dsh.getJSONObject(
							"tr" + i).getString("sessions");
					String officename = o4JsonArr2dsh.getJSONObject(
							"tr" + i).getString("officename");
					String officebegindate = o4JsonArr2dsh
							.getJSONObject("tr" + i).getString(
									"officebegindate");
					String officeenddate = o4JsonArr2dsh.getJSONObject(
							"tr" + i).getString("officeenddate");
					String isstop = o4JsonArr2dsh.getJSONObject(
							"tr" + i).getString("isstop");
					String remark = o4JsonArr2dsh.getJSONObject(
							"tr" + i).getString("remark");
					strSql.setLength(0);
					strSql
							.append(" insert into CPBOARDOFFICER (directorsid,sessions,officename,officebegindate,officeenddate,isstop,remark) values");
					strSql.append(" (" + directorsid + ",'" + sessions
							+ "','" + officename + "','"
							+ officebegindate + "','" + officeenddate
							+ "','" + isstop + "','" + remark + "')");
					//System.out.println("2222222222222222--------------"+strSql.toString());
					rs.execute(strSql.toString());
				}
			}
			
			if (!"".equals(listjshcy)) {
				listjshcy = URLDecoder.decode(listjshcy, "utf-8");
				org.json.JSONObject o4JsonArr2jsh = new org.json.JSONObject(
						listjshcy);
				for (int i = 0; i < o4JsonArr2jsh.length(); i++) {
					String sessions =  o4JsonArr2jsh.getJSONObject(
							"tr" + i).getString("sessions");
					String supername = o4JsonArr2jsh.getJSONObject(
							"tr" + i).getString("supername");
					String superbegindate = o4JsonArr2jsh
							.getJSONObject("tr" + i).getString(
									"superbegindate");
					String superenddate = o4JsonArr2jsh.getJSONObject(
							"tr" + i).getString("superenddate");
					String isstop = o4JsonArr2jsh.getJSONObject(
							"tr" + i).getString("isstop");
					String remark = o4JsonArr2jsh.getJSONObject(
							"tr" + i).getString("remark");
					strSql.setLength(0);
					strSql
							.append(" insert into CPBOARDSUPER (directorsid,sessions,supername,superbegindate,superenddate,isstop,remark) values");
					strSql.append(" (" + directorsid + ",'" + sessions
							+ "','" + supername + "','"
							+ superbegindate + "','" + superenddate
							+ "','" + isstop + "','" + remark + "')");
					//System.out.println("22222222222222--------------"+strSql.toString());
					rs.execute(strSql.toString());
				}
			}
		}
		
		if(isaddversion.equals("add")){
			strSql.setLength(0);
			strSql.append("insert into CPBOARDVERSION (directorsid,versionnum,versionname,versionmemo,versionaffix,Createdatetime,");
			strSql.append(" companyid,ischairman,chairman,appointbegindate,appointenddate,appointduetime,supervisor,generalmanager,drectorsaffix,managerbegindate,managerenddate,managerduetime)");
			strSql.append(" values ("+directorsid+",'"+versionnum+"','"+versionname+"','"+versionmemo+"','"+versionaffix+"','"+date2Version+"',");
			strSql.append(" " + companyid + ",'" + ischairman
					+ "','" + chairman + "','" + appointbegindate + "',");
			strSql.append(" '" + appointenddate + "','" + appointduetime
					+ "','" + supervisor + "','" + generalmanager + "','"+affixdoc+"','"+managerbegindate+"','"+managerenddate+"','"+managerduetime+"')");
			//System.out.println("333333333--------------"+strSql.toString());
			rs.execute(strSql.toString());	
			//����֪ͨ-���
			String upsql = "insert into CPCOMPANYUPGRADE (UPTYPE,UPVERSION,CREATEDATETIME,discription,companyid) values ('director','"+versionnum+"','"+now+"','"+SystemEnv.getHtmlLabelName(1421,user.getLanguage())+"��"+SystemEnv.getHtmlLabelName(30936,user.getLanguage())+"-["+versionnum+"]',"+companyid+")";
			rs.execute(upsql);
			
			if (!"".equals(listdshcy)) {
				listdshcy = URLDecoder.decode(listdshcy, "utf-8");
				org.json.JSONObject o4JsonArr2dsh = new org.json.JSONObject(
						listdshcy);
				for (int i = 0; i < o4JsonArr2dsh.length(); i++) {
					String sessions = o4JsonArr2dsh.getJSONObject(
							"tr" + i).getString("sessions");
					String officename = o4JsonArr2dsh.getJSONObject(
							"tr" + i).getString("officename");
					String officebegindate = o4JsonArr2dsh
							.getJSONObject("tr" + i).getString(
									"officebegindate");
					String officeenddate = o4JsonArr2dsh.getJSONObject(
							"tr" + i).getString("officeenddate");
					String isstop = o4JsonArr2dsh.getJSONObject(
							"tr" + i).getString("isstop");
					String remark = o4JsonArr2dsh.getJSONObject(
							"tr" + i).getString("remark");
					strSql.setLength(0);
					strSql
							.append(" insert into CPBOARDOFFICERVERSION (versionnum,directorsid,sessions,officename,officebegindate,officeenddate,isstop,remark) values");
					strSql.append(" ('"+versionnum+"'," + directorsid + ",'" + sessions
							+ "','" + officename + "','"
							+ officebegindate + "','" + officeenddate
							+ "','" + isstop + "','" + remark + "')");
					//System.out.println("444444444444444--------------"+strSql.toString());
					rs.execute(strSql.toString());
				}
			}
			
			if (!"".equals(listjshcy)) {
				listjshcy = URLDecoder.decode(listjshcy, "utf-8");
				org.json.JSONObject o4JsonArr2jsh = new org.json.JSONObject(
						listjshcy);
				for (int i = 0; i < o4JsonArr2jsh.length(); i++) {
					String sessions =  o4JsonArr2jsh.getJSONObject(
							"tr" + i).getString("sessions");
					String supername = o4JsonArr2jsh.getJSONObject(
							"tr" + i).getString("supername");
					String superbegindate = o4JsonArr2jsh
							.getJSONObject("tr" + i).getString(
									"superbegindate");
					String superenddate = o4JsonArr2jsh.getJSONObject(
							"tr" + i).getString("superenddate");
					String isstop = o4JsonArr2jsh.getJSONObject(
							"tr" + i).getString("isstop");
					String remark = o4JsonArr2jsh.getJSONObject(
							"tr" + i).getString("remark");
					strSql.setLength(0);
					strSql
							.append(" insert into CPBOARDSUPERVERSION (versionnum,directorsid,sessions,supername,superbegindate,superenddate,isstop,remark) values");
					strSql.append(" ('"+versionnum+"'," + directorsid + ",'" + sessions
							+ "','" + supername + "','"
							+ superbegindate + "','" + superenddate
							+ "','" + isstop + "','" + remark + "')");
						//System.out.println("5555555555555555--------------"+strSql.toString());
					rs.execute(strSql.toString());
				}
			}
		}
		
		pro.writeCompanylog("3",companyid,"1",user.getUID()+"",SystemEnv.getHtmlLabelName(30936,user.getLanguage()));
		out.clear();
		out.print("0");
	} else if ("edit".equals(method)) {
		if(!ProManageUtil.checkEdition("director", "", companyid, versionnum)){
			String directorsid = Util.null2String(request
					.getParameter("directorsid"));
					
					
			String _chairman="";
			String old_faren="";
			String new_faren="";
			String old_zjl="";
			String new_zjl="";
			String old_dsh="";
			String new_dsh="";
			String old_jsh="";
			String new_jsh="";
			rs02.execute("select chairman,faren,GENERALMANAGER from CPBOARDDIRECTORS where directorsid="+directorsid);
			if(rs02.next()){
				_chairman=rs02.getString("chairman");//�õ�ԭ���Ķ���
                old_faren=rs02.getString("faren");
                old_zjl=rs02.getString("GENERALMANAGER");
			}
			new_faren=faren;
	        new_zjl=generalmanager;
			System.out.println("_chairman = "+_chairman+" sql = select chairman,faren,GENERALMANAGER from CPBOARDDIRECTORS where directorsid="+directorsid);
			System.out.println("00000--------------"+isaddversion);
			if(isaddversion.equals("add")){
				String sqlmax = "select max(versionnum) as versionnum from CPBOARDVERSION where directorsid="+directorsid;
				rs.execute(sqlmax);
				String maxnum = "";
				if(rs.next())maxnum = Util.null2String(rs.getString("versionnum"));
				String listdshcy = Util.null2String(request
						.getParameter("data"));
				String listjshcy = Util.null2String(request
						.getParameter("data2js"));
				if(maxnum.equals("") || maxnum.compareTo(versionnum)<0){
					strSql.setLength(0);
					strSql.append(" update CPBOARDDIRECTORS set ischairman='"
							+ ischairman + "',chairman='" + chairman + "',");
					strSql.append(" appointbegindate='" + appointbegindate
							+ "',faren='"+faren+"',appointenddate='" + appointenddate + "',");
					strSql.append(" appointduetime='" + appointduetime
							+ "',supervisor='" + supervisor + "',");
					strSql.append(" generalmanager='" + generalmanager
							+ "',lastupdatetime='" + lastupdatetime + "',");
					strSql.append(" drectorsaffix='" + affixdoc + "',");
					strSql.append(" managerbegindate='" + managerbegindate + "',");
					strSql.append(" managerenddate='" + managerenddate + "',");
					strSql.append(" managerduetime='" + managerduetime + "'");
					strSql.append(" where directorsid=" + directorsid);
				   //System.out.println("11111--------------"+strSql.toString());
					rs.execute(strSql.toString());
	
					
					strSql.setLength(0);
					strSql.append(" delete from CPBOARDOFFICER where directorsid="
									+ directorsid);
					rs.execute(strSql.toString());
					if (!"".equals(listdshcy)) {
						listdshcy = URLDecoder.decode(listdshcy, "utf-8");
						org.json.JSONObject o4JsonArr2dsh = new org.json.JSONObject(
								listdshcy);
						for (int i = 0; i < o4JsonArr2dsh.length(); i++) {
							String sessions = o4JsonArr2dsh.getJSONObject("tr" + i)
									.getString("sessions");
							String officename = o4JsonArr2dsh.getJSONObject(
									"tr" + i).getString("officename");
							String officebegindate = o4JsonArr2dsh.getJSONObject(
									"tr" + i).getString("officebegindate");
							String officeenddate = o4JsonArr2dsh.getJSONObject(
									"tr" + i).getString("officeenddate");
							String isstop = o4JsonArr2dsh.getJSONObject("tr" + i)
									.getString("isstop");
							String remark = o4JsonArr2dsh.getJSONObject("tr" + i)
									.getString("remark");
							strSql.setLength(0);
							strSql
									.append(" insert into CPBOARDOFFICER (directorsid,sessions,officename,officebegindate,officeenddate,isstop,remark) values");
							strSql.append(" (" + directorsid + ",'" + sessions
									+ "','" + officename + "','" + officebegindate
									+ "','" + officeenddate + "','" + isstop
									+ "','" + remark + "')");
							// System.out.println("2222--------------"+strSql.toString());
							rs.execute(strSql.toString());
						}
					}
					
					strSql.setLength(0);
					strSql
							.append(" delete from CPBOARDSUPER where directorsid="
									+ directorsid);
					rs.execute(strSql.toString());
					if (!"".equals(listjshcy)) {
						listjshcy = URLDecoder.decode(listjshcy, "utf-8");
						org.json.JSONObject o4JsonArr2jsh = new org.json.JSONObject(
								listjshcy);
						for (int i = 0; i < o4JsonArr2jsh.length(); i++) {
							String sessions = o4JsonArr2jsh.getJSONObject("tr" + i)
									.getString("sessions");
							String supername = o4JsonArr2jsh.getJSONObject(
									"tr" + i).getString("supername");
							String superbegindate = o4JsonArr2jsh.getJSONObject(
									"tr" + i).getString("superbegindate");
							String superenddate = o4JsonArr2jsh.getJSONObject(
									"tr" + i).getString("superenddate");
							String isstop = o4JsonArr2jsh.getJSONObject("tr" + i)
									.getString("isstop");
							String remark = o4JsonArr2jsh.getJSONObject("tr" + i)
									.getString("remark");
							strSql.setLength(0);
							strSql
									.append(" insert into CPBOARDSUPER (directorsid,sessions,supername,superbegindate,superenddate,isstop,remark) values");
							strSql.append(" (" + directorsid + ",'" + sessions
									+ "','" + supername + "','" + superbegindate
									+ "','" + superenddate + "','" + isstop
									+ "','" + remark + "')");
							//System.out.println("33333--------------"+strSql.toString());
							rs.execute(strSql.toString());
						}
					}
				}
				strSql.setLength(0);
				//����汾
				strSql.append("insert into CPBOARDVERSION (directorsid,versionnum,versionname,versionmemo,versionaffix,Createdatetime,");
				strSql.append(" companyid,ischairman,faren,chairman,appointbegindate,appointenddate,appointduetime,supervisor,generalmanager,drectorsaffix,managerbegindate,managerenddate,managerduetime)");
				strSql.append(" values ("+directorsid+",'"+versionnum+"','"+versionname+"','"+versionmemo+"','"+versionaffix+"','"+date2Version+"',");
				strSql.append(" " + companyid + ",'" + ischairman+"','"+faren+"'"
						+ ",'" + chairman + "','" + appointbegindate + "',");
				strSql.append(" '" + appointenddate + "','" + appointduetime
						+ "','" + supervisor + "','" + generalmanager + "','"+affixdoc+"','"+managerbegindate+"','"+managerenddate+"','"+managerduetime+"')");
				// System.out.println("4444--------------"+strSql.toString());
				rs.execute(strSql.toString());	
				//����֪ͨ-���
				String upsql = "insert into CPCOMPANYUPGRADE (UPTYPE,UPVERSION,CREATEDATETIME,discription,companyid) values ('director','"+versionnum+"','"+now+"','"+SystemEnv.getHtmlLabelName(1421,user.getLanguage())+"��"+SystemEnv.getHtmlLabelName(30936,user.getLanguage())+"-["+versionnum+"]',"+companyid+")";
				rs.execute(upsql);
				//���±����¼cpcchangenotice
				System.out.println("_chairman = "+_chairman+" chairman="+chairman);
				if(!_chairman.equals(chairman)){//���ұ�������ҵ����Ӫҵִ��
								String year=TimeUtil.getCurrentDateString().substring(0,4);
								String month=TimeUtil.getCurrentDateString().substring(5,7);
								rs02.execute(" insert into cpcchangenotice (c_type,c_companyid,c_year,c_month,c_time,c_desc) values(2,'"+companyid+"','"+year+"','"+month+"','"+TimeUtil.getCurrentTimeString()+"','"+_chairman+"->"+chairman+"') ");	
				}
				if (!"".equals(listdshcy)) {
					listdshcy = URLDecoder.decode(listdshcy, "utf-8");
					org.json.JSONObject o4JsonArr2dsh = new org.json.JSONObject(
							listdshcy);
					for (int i = 0; i < o4JsonArr2dsh.length(); i++) {
						String sessions =  o4JsonArr2dsh.getJSONObject(
								"tr" + i).getString("sessions");
						String officename = o4JsonArr2dsh.getJSONObject(
								"tr" + i).getString("officename");
						String officebegindate = o4JsonArr2dsh
								.getJSONObject("tr" + i).getString(
										"officebegindate");
						String officeenddate = o4JsonArr2dsh.getJSONObject(
								"tr" + i).getString("officeenddate");
						String isstop = o4JsonArr2dsh.getJSONObject(
								"tr" + i).getString("isstop");
						String remark = o4JsonArr2dsh.getJSONObject(
								"tr" + i).getString("remark");
						strSql.setLength(0);
	
						//{'tr0':{'sessions':'������ζ','officename':'1','officebegindate':'2013-05-13','officeenddate':'2013-05-14','isstop':'2','remark':'qwe'}}
						//insert into CPBOARDOFFICERVERSION (versionnum,directorsid,sessions,
						//officename,officebegindate,officeenddate,isstop,remark)
						// values ('������ζ',21,'11','1','2013-05-13','2013-05-14','2','qwe')
						
						
						strSql
								.append(" insert into CPBOARDOFFICERVERSION (versionnum,directorsid,sessions,officename,officebegindate,officeenddate,isstop,remark) values");
						strSql.append(" ('"+versionnum+"'," + directorsid + ",'" + sessions
								+ "','" + officename + "','"
								+ officebegindate + "','" + officeenddate
								+ "','" + isstop + "','" + remark + "')");
					   // System.out.println("5555--------------"+strSql.toString());
						rs.execute(strSql.toString());
					}
				}
				if (!"".equals(listjshcy)) {
					listjshcy = URLDecoder.decode(listjshcy, "utf-8");
					org.json.JSONObject o4JsonArr2jsh = new org.json.JSONObject(
							listjshcy);
					for (int i = 0; i < o4JsonArr2jsh.length(); i++) {
						String sessions =  o4JsonArr2jsh.getJSONObject(
								"tr" + i).getString("sessions");
						String supername = o4JsonArr2jsh.getJSONObject(
								"tr" + i).getString("supername");
						String superbegindate = o4JsonArr2jsh
								.getJSONObject("tr" + i).getString(
										"superbegindate");
						String superenddate = o4JsonArr2jsh.getJSONObject(
								"tr" + i).getString("superenddate");
						String isstop = o4JsonArr2jsh.getJSONObject(
								"tr" + i).getString("isstop");
						String remark = o4JsonArr2jsh.getJSONObject(
								"tr" + i).getString("remark");
						strSql.setLength(0);
						strSql
								.append(" insert into CPBOARDSUPERVERSION (versionnum,directorsid,sessions,supername,superbegindate,superenddate,isstop,remark) values");
						strSql.append(" ('"+versionnum+"'," + directorsid + ",'" + sessions
								+ "','" + supername + "','"
								+ superbegindate + "','" + superenddate
								+ "','" + isstop + "','" + remark + "')");
						 //System.out.println("66666--------------"+strSql.toString());
						rs.execute(strSql.toString());
					}
				}
			}else{
				strSql.setLength(0);
				strSql.append(" update CPBOARDDIRECTORS set ischairman='"
						+ ischairman + "',chairman='" + chairman + "',");
				strSql.append(" faren='"+faren+"',appointbegindate='" + appointbegindate
						+ "',appointenddate='" + appointenddate + "',");
				strSql.append(" appointduetime='" + appointduetime
						+ "',supervisor='" + supervisor + "',");
				strSql.append(" generalmanager='" + generalmanager
						+ "',lastupdatetime='" + lastupdatetime + "',");
				strSql.append(" drectorsaffix='" + affixdoc + "',");
				strSql.append(" managerbegindate='" + managerbegindate + "',");
				strSql.append(" managerenddate='" + managerenddate + "',");
				strSql.append(" managerduetime='" + managerduetime + "'");
				strSql.append(" where directorsid=" + directorsid);
				//System.out.println(strSql.toString());
				rs.execute(strSql.toString());
				System.out.println("faren = "+faren+" generalmanager = "+generalmanager);
                //tagtag
	            new_faren=faren;
	            new_zjl=generalmanager;

				String listdshcy = Util.null2String(request
						.getParameter("data"));
				String listjshcy = Util.null2String(request
						.getParameter("data2js"));
				strSql.setLength(0);

                String mysql1="select * from CPBOARDOFFICER where directorsid="+directorsid+" order by isstop desc,officebegindate asc ";
                rs.executeSql(mysql1);
                while (rs.next()) {
                    old_dsh+="����:"+rs.getString("sessions");
                    old_dsh+=",��������:"+rs.getString("officename")+"<br/>";
                }


				strSql
						.append(" delete from CPBOARDOFFICER where directorsid="
								+ directorsid);
				rs.execute(strSql.toString());
				if (!"".equals(listdshcy)) {
					listdshcy = URLDecoder.decode(listdshcy, "utf-8");
					org.json.JSONObject o4JsonArr2dsh = new org.json.JSONObject(
							listdshcy);
					for (int i = 0; i < o4JsonArr2dsh.length(); i++) {
						String sessions =  o4JsonArr2dsh.getJSONObject("tr" + i)
								.getString("sessions");
						String officename = o4JsonArr2dsh.getJSONObject(
								"tr" + i).getString("officename");
						String officebegindate = o4JsonArr2dsh.getJSONObject(
								"tr" + i).getString("officebegindate");
						String officeenddate = o4JsonArr2dsh.getJSONObject(
								"tr" + i).getString("officeenddate");
						String isstop = o4JsonArr2dsh.getJSONObject("tr" + i)
								.getString("isstop");
						String remark = o4JsonArr2dsh.getJSONObject("tr" + i)
								.getString("remark");
						strSql.setLength(0);
						strSql
								.append(" insert into CPBOARDOFFICER (directorsid,sessions,officename,officebegindate,officeenddate,isstop,remark) values");
						strSql.append(" (" + directorsid + ",'" + sessions
								+ "','" + officename + "','" + officebegindate
								+ "','" + officeenddate + "','" + isstop
								+ "','" + remark + "')");
						//System.out.println(strSql);
						rs.execute(strSql.toString());

                        new_dsh+="����:"+sessions;
                        new_dsh+=",��������:"+officename+"<br/>";
					}
				}
				
				strSql.setLength(0);


                mysql1="select * from CPBOARDSUPER where directorsid="+directorsid+" order by isstop desc,SUPERBEGINDATE asc ";
                rs.executeSql(mysql1);
                while (rs.next()) {
                    old_jsh+="����:"+rs.getString("sessions");
                    old_jsh+=",��������:"+rs.getString("supername")+"<br/>";
                }

				strSql
						.append(" delete from CPBOARDSUPER where directorsid="
								+ directorsid);
				rs.execute(strSql.toString());
				if (!"".equals(listjshcy)) {
					listjshcy = URLDecoder.decode(listjshcy, "utf-8");
					org.json.JSONObject o4JsonArr2jsh = new org.json.JSONObject(
							listjshcy);
					for (int i = 0; i < o4JsonArr2jsh.length(); i++) {
						String sessions = o4JsonArr2jsh.getJSONObject("tr" + i)
								.getString("sessions");
						String supername = o4JsonArr2jsh.getJSONObject(
								"tr" + i).getString("supername");
						String superbegindate = o4JsonArr2jsh.getJSONObject(
								"tr" + i).getString("superbegindate");
						String superenddate = o4JsonArr2jsh.getJSONObject(
								"tr" + i).getString("superenddate");
						String isstop = o4JsonArr2jsh.getJSONObject("tr" + i)
								.getString("isstop");
						String remark = o4JsonArr2jsh.getJSONObject("tr" + i)
								.getString("remark");
						strSql.setLength(0);
						strSql
								.append(" insert into CPBOARDSUPER (directorsid,sessions,supername,superbegindate,superenddate,isstop,remark) values");
						strSql.append(" (" + directorsid + ",'" + sessions
								+ "','" + supername + "','" + superbegindate
								+ "','" + superenddate + "','" + isstop
								+ "','" + remark + "')");
						//System.out.println(strSql);

                        new_jsh+="����:"+sessions;
                        new_jsh+=",��������:"+supername+"<br/>";

						rs.execute(strSql.toString());
					}
				}
			}
			pro.writeCompanylog("3",companyid,"2",user.getUID()+"",SystemEnv.getHtmlLabelName(30936,user.getLanguage()));
            rs.executeSql("select max(plog_id) as maxid from pro_taskLog where plog_qf=3 and plog_protaskid="+companyid);
            if (rs.next()) {
                String maxid=rs.getString("maxid");
                String beforeStr="";
                String afterStr="";
                if (!old_faren.equals(new_faren)) {
                    beforeStr+="����:"+old_faren+"<br/>";
                    afterStr+="����:"+new_faren+"<br/>";
                }
                if (!old_zjl.equals(new_zjl)) {
                    beforeStr+="�ܾ���:"+old_zjl+"<br/>";
                    afterStr+="�ܾ���:"+new_zjl+"<br/>";
                }
                if (!old_dsh.equals(new_dsh)) {
                    beforeStr+=old_dsh;
                    afterStr+=new_dsh;
                }
                if (!old_jsh.equals(new_jsh)) {
                    beforeStr+=old_jsh;
                    afterStr+=new_jsh;
                }
				System.out.println("old_faren = "+old_faren+"  new_faren="+new_faren);
				System.out.println("old_zjl = "+old_zjl+"  new_zjl="+new_zjl);
				System.out.println("new_dsh = "+new_dsh+"  new_jsh="+new_dsh);
				System.out.println("new_jsh = "+new_jsh+"  new_jsh="+new_jsh);
                String mysql2="update pro_taskLog set plog_before='"+beforeStr+"',plog_after='"+afterStr+"' where plog_id="+maxid;
                rs.executeSql(mysql2);
            }
			out.clear();
			out.print("0");
		}else{
			//�汾���ظ�
			out.clear();
			out.print("�汾��"+versionnum+"�Ѿ�����,���ݱ���ʧ��!");
		}
	} else if ("get".equals(method)) {
		/*��� XX���»���Ϣ*/
		String dsh_isadd = "";
		JSONArray jsa = new JSONArray();
		CpBoardDirectors cpboarddirectors = new CpBoardDirectors();
		String strzc = " select * from CPBOARDDIRECTORS where isdel='T' and companyid= "
				+ companyid;
		//System.out.println(strzc);
		rs.execute(strzc);
		if (rs.next()) {
			cpboarddirectors.setDirectorsid(rs.getInt("directorsid"));
			cpboarddirectors.setChairman(rs.getString("chairman"));
			cpboarddirectors.setFaren (rs.getString("faren"));
			cpboarddirectors.setAppointbegindate(rs
					.getString("appointbegindate"));
			cpboarddirectors.setAppointenddate(rs
					.getString("appointenddate"));
			cpboarddirectors.setAppointduetime(rs
					.getString("appointduetime"));
			cpboarddirectors.setSupervisor(rs.getString("supervisor"));
			cpboarddirectors.setGeneralmanager(rs
					.getString("generalmanager"));
			cpboarddirectors.setIschairman(rs.getString("ischairman"));
			cpboarddirectors.setDrectorsaffix(rs.getString("drectorsaffix"));
			cpboarddirectors.setManagerbegindate(rs.getString("managerbegindate"));
			cpboarddirectors.setManagerenddate(rs.getString("managerenddate"));
			cpboarddirectors.setManagerduetime(rs.getString("managerduetime"));
			dsh_isadd = "edit";
			jsa.add(dsh_isadd);
			jsa.add(cpboarddirectors);
			pro.writeCompanylog("3",companyid,"4",user.getUID()+"",SystemEnv.getHtmlLabelName(30936,user.getLanguage()));
		} else {
			dsh_isadd = "add";
			jsa.add(dsh_isadd);
		}
		out.clear();
		out.print(jsa);
	}else if("delVersion".equals(method)){
		strSql.setLength(0);
		int directorsid=0;
		String _versionids =Util.TrimComma(Util.null2String(request.getParameter("versionids")));//Ҫ��ɾ���İ汾id
		String _versionnum=Util.TrimComma(Util.null2String(request.getParameter("_versionnum")));//Ҫ��ɾ���İ汾��
		rs02.execute("select companyid  from CPBOARDVERSION where  versionid in ("+_versionids+")");
		if(rs02.next()){
			String temp_companyid=rs02.getString("companyid");
			rs02.execute(" select directorsid from CPBOARDDIRECTORS  where companyid="+ companyid);
			if(rs02.next()){
				directorsid=rs02.getInt("directorsid");//�����CPBOARDOFFICERVERSION������ѽ
			}
			//����֪ͨ-ɾ��
			String upsql = "insert into CPCOMPANYUPGRADE (UPTYPE,UPVERSION,CREATEDATETIME,discription,companyid) values ('director','"+_versionnum+"','"+now+"','"+SystemEnv.getHtmlLabelName(23777,user.getLanguage())+"��"+SystemEnv.getHtmlLabelName(30936,user.getLanguage())+"-["+_versionnum+"]',"+temp_companyid+")";
			rs.execute(upsql);
			//ɾ���汾
			upsql=" delete from CPBOARDVERSION where versionid in ( "+_versionids+" )";
			rs.execute(upsql);
			//ɾ���汾֮�󣬻�Ҫɾ���汾�µ� ���»��Ա�汾�Ͷ��»��Ա�汾
			rs.execute(" delete  CPBOARDOFFICERVERSION where  versionnum in ( "+_versionnum+" )  and  directorsid='"+directorsid+"'");
			rs.execute(" delete  CPBOARDSUPERVERSION where  versionnum in ( "+_versionnum+" )  and  directorsid='"+directorsid+"'");
		}
		
	}else if("viewVersion".equals(method)){
		String versionids = Util.null2String(request.getParameter("versionids"));
		String _versionids = versionids.substring(0,versionids.lastIndexOf(","));
		JSONArray jsa = new JSONArray();
		CpBoardDirectors cpboarddirectors = new CpBoardDirectors();
		String sql = "select * from CPBOARDVERSION t1 where t1.versionid="+_versionids;
		//System.out.println(sql);
		rs.execute(sql);
		if(rs.next()){
			cpboarddirectors.setDirectorsid(rs.getInt("directorsid"));
			cpboarddirectors.setChairman(rs.getString("chairman"));
			cpboarddirectors.setAppointbegindate(rs
					.getString("appointbegindate"));
			cpboarddirectors.setAppointenddate(rs
					.getString("appointenddate"));
			cpboarddirectors.setAppointduetime(rs
					.getString("appointduetime"));
			cpboarddirectors.setSupervisor(rs.getString("supervisor"));
			cpboarddirectors.setGeneralmanager(rs
					.getString("generalmanager"));
			cpboarddirectors.setIschairman(rs.getString("ischairman"));
			cpboarddirectors.setManagerbegindate(rs.getString("managerbegindate"));
			cpboarddirectors.setManagerenddate(rs.getString("managerenddate"));
			cpboarddirectors.setManagerduetime(rs.getString("managerduetime"));
			
			//��������
			cpboarddirectors.setDrectorsaffix(rs.getString("drectorsaffix"));
			String[] affixdocs = cpboarddirectors.getDrectorsaffix().split(",");
			//System.out.println(cplicense.getAffixdoc());
			String imgid2db = "";
			String imgname2db = "";
			for(int i=0;i<affixdocs.length;i++){
			rs1.execute("select imagefileid,imagefilename from imagefile where imagefileid='"+affixdocs[i]+"'");
				if(rs1.next()){
					imgid2db += rs1.getString("imagefileid")+"|";
					imgname2db += rs1.getString("imagefilename")+"|";
				}
			}
			cpboarddirectors.setImgid(imgid2db);
			cpboarddirectors.setImgname(imgname2db);
		}
		jsa.add(cpboarddirectors);
		jsa.add(rs.getString("versionnum"));
		strSql.setLength(0);
		strSql.append("select companyid,versionnum from CPBOARDVERSION where versionid in ( "+_versionids+" )");
		rs.execute(strSql.toString());
		//System.out.println(strSql.toString());
		if(rs.next()){
			//System.out.println("1");
			pro.writeCompanylog("3",rs.getString("companyid"),"4",user.getUID()+"",SystemEnv.getHtmlLabelName(30936,user.getLanguage())+"["+SystemEnv.getHtmlLabelName(567,user.getLanguage())+":"+rs.getString("versionnum")+"]");
		}
		out.clear();
		out.print(jsa);
	}else if("viewOffersVersion".equals(method)){
		String directorsid = Util.null2String(request.getParameter("directorsid"));
		//String versionnum = Util.null2String(request.getParameter("versionnum"));
		String sql = " select * from CPBOARDOFFICERVERSION where directorsid ="+directorsid+" and versionnum = '"+versionnum+"' order by isstop desc,officebegindate asc";
		rs.execute(sql);
		//System.out.println("�鿴����"+sql);
		out.clear();
		while (rs.next()){
			String valuedate = "";
			if(!Util.null2String(rs.getString("officebegindate")).equals(""))
			valuedate = rs.getString("officebegindate").substring(0,4);
			out.print("<tr dbvalue='"+valuedate+"'>");
			out.print("<td width='4%' align='center'>");
			//out.print("<input type='checkbox' name='checkbox' inWhichPage='dsh'/>");
			out.print("</td>");
			out.print("<td width='16%' align='center'>");
			//out.print("<input type='text' value='"+rs.getString("sessions") +"' onfocus='this.blur();' readonly='true' style='margin:-5px; width:88px; height:20px; line-height:20px; border-color:#FFFFFF; background-image:none; text-align:center;'></input>");
			out.print(rs.getString("sessions"));
			out.print("</td>");
			out.print("<td width='18%' align='center'>");
			//out.print("<input type='text' value='"+rs.getString("officename")+"' onfocus='this.blur();' readonly='true' style='margin:-5px; width:104px; height:20px; line-height:20px;  border-color:#FFFFFF;  background-image:none; text-align:center;'></input>");
			out.print(rs.getString("officename"));
			out.print("</td>");
			out.print("<td width='17%' align='center'>");
			out.print("<span>"+rs.getString("officebegindate") +"</span>");
			out.print("</td>");
			out.print("<td width='17%' align='center'>");
			out.print("<span>"+rs.getString("officeenddate") +"</span>");
			out.print("</td>");
			out.print("<td width='8%' align='center'>");
			if("1".equals(rs.getString("isstop"))){
					out.println(SystemEnv.getHtmlLabelName(30586,user.getLanguage()));
			}else{
					out.println(SystemEnv.getHtmlLabelName(30587,user.getLanguage()));
			}
			out.print("</td>");
			out.print("<td width='20%' align='center'>");
			//out.print("<input type='text' value='"+rs.getString("remark") +"' onfocus='this.blur();' readonly='true' style='margin:-5px; width:110px; height:20px; line-height:20px; border-color:#FFFFFF; background-image:none; text-align:center;'></input>");
			out.print(rs.getString("remark"));
			out.print("</td>");
			out.print("</tr>");
		}
	}else if("viewSupersVersion".equals(method)){
		String directorsid = Util.null2String(request.getParameter("directorsid"));
		//String versionnum = Util.null2String(request.getParameter("versionnum"));
		String sql = " select * from CPBOARDSUPERVERSION where directorsid ="+directorsid+" and versionnum = '"+versionnum+"' order by isstop desc,superbegindate asc";
		//System.out.println("�鿴����"+sql);
		rs.execute(sql);
		out.clear();
		while (rs.next()){
			String valuedate = "";
			if(!Util.null2String(rs.getString("superbegindate")).equals(""))
			valuedate = rs.getString("superbegindate").substring(0,4);
			out.print("<tr dbvalue='"+valuedate+"'>");
			out.print("<td width='4%' align='center'>");
			//out.print("<input type='checkbox' name='checkbox' inWhichPage='jsh'/>");
			out.print("</td>");
			out.print("<td width='16%' align='center'>");
			//out.print("<input type='text' value='"+rs.getString("sessions") +"' onfocus='this.blur();' readonly='true' style='margin:-5px; width:88px; height:20px; line-height:20px; border-color:#FFFFFF; background-image:none; text-align:center;'></input>");
			out.print(rs.getString("sessions"));
			out.print("</td>");
			out.print("<td width='18%' align='center'>");
			//out.print("<input type='text' value='"+rs.getString("supername")+"' onfocus='this.blur();' readonly='true' style='margin:-5px; width:104px; height:20px; line-height:20px;  border-color:#FFFFFF;  background-image:none; text-align:center;'></input>");
			out.print(rs.getString("supername"));
			out.print("</td>");
			out.print("<td width='17%' align='center'>");
			out.print("<span>"+rs.getString("superbegindate") +"</span>");
			out.print("</td>");
			out.print("<td width='17%' align='center'>");
			out.print("<span>"+rs.getString("superenddate") +"</span>");
			out.print("</td>");
			out.print("<td width='8%' align='center'>");
				if("1".equals(rs.getString("isstop"))){
					out.println(SystemEnv.getHtmlLabelName(30586,user.getLanguage()));
			}else{
					out.println(SystemEnv.getHtmlLabelName(30587,user.getLanguage()));
			}
			out.print("</td>");
			out.print("<td width='20%' align='center'>");
			//out.print("<input type='text' value='"+rs.getString("remark") +"' onfocus='this.blur();' readonly='true' style='margin:-5px; width:110px; height:20px; line-height:20px; border-color:#FFFFFF; background-image:none; text-align:center;'></input>");
			out.print(rs.getString("remark"));
			out.print("</td>");
			out.print("</tr>");
		}
	}else if ("editversion".equals(method)){
		String versionid = Util.null2String(request.getParameter("versionid"));
		String upversionsql="";
		rs02.execute("select  versionnum,companyid  from CPBOARDVERSION where  versionid in ("+versionid+")");
		if(rs02.next()){
			String temp_versionnum=rs02.getString("versionnum");
			String temp_companyid=rs02.getString("companyid");
			//����֪ͨ-�޸�
			if(!versionnum.equals(temp_versionnum)){
				String upsql = "insert into CPCOMPANYUPGRADE (UPTYPE,UPVERSION,CREATEDATETIME,discription,companyid) values ('director','"+versionnum+"','"+now+"','"+SystemEnv.getHtmlLabelName(103,user.getLanguage())+"��"+SystemEnv.getHtmlLabelName(30936,user.getLanguage())+"-["+temp_versionnum+"->"+versionnum+"]',"+temp_companyid+")";
				rs.execute(upsql);
			}
			 upversionsql = "update CPBOARDVERSION set versionnum = '"+versionnum+"', versionname = '"+versionname+"' ,versionmemo='"+versionmemo+"',versionaffix='"+versionaffix+"',createdatetime='"+date2Version+"' where versionid="+versionid;
			System.out.println("jb-"+upversionsql);
			rs.execute(upversionsql);
		}
	}
%>