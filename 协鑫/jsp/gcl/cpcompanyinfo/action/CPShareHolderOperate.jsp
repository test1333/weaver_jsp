<%@page import="weaver.cpcompanyinfo.ProManageUtil"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="java.net.URLDecoder"%>
<%@ include file="/page/maint/common/initNoCache.jsp"%>

<jsp:useBean id="jspUtil" class="weaver.cpcompanyinfo.JspUtil" scope="page" />
<jsp:useBean id="pro" class="weaver.cpcompanyinfo.ProManageUtil" scope="page" />
<%@page import="weaver.general.TimeUtil"%>
<%@page import="weaver.cpcompanyinfo.CpShareHolder"%>
<%@page import="weaver.cpcompanyinfo.CpShareOfficers"%>
<%@page import="weaver.conn.RecordSet"%>

<%@page import="org.dom4j.Element" %>
<%@page import="org.dom4j.Document" %>
<%@page import="org.dom4j.DocumentHelper" %>
<%@page import="org.dom4j.DocumentException" %>
<%@page import="java.io.IOException" %>
<%@page import="java.io.StringWriter" %>
<%@page import="org.dom4j.io.XMLWriter" %>
<%@page import="org.dom4j.io.OutputFormat" %>


<%@ page import="net.sf.json.*"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs02" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="companyMagager" class="weaver.company.CompanyManager" scope="page" />
<%
	String method = Util.null2String(request.getParameter("method"));
	//System.out.println("�ɶ���"+method);
	String companyid = Util.null2String(request
			.getParameter("companyid"));
	StringBuffer strSql = new StringBuffer();

	String now = Util.date(2);

	String createdatetime = now;

	String boardshareholder = Util.null2String(request
			.getParameter("boardshareholder"));
	String established = Util.null2String(request
			.getParameter("established"));
	String affixdoc = Util.null2String(request
			.getParameter("affixdoc"));
	
	String versionnum =Util.null2String(request.getParameter("versionnum"));

	String versionname = Util.null2String(request.getParameter("versionname"));
	String versionmemo = Util.null2String(request.getParameter("versionmemo"));
	String versionaffix = Util.null2String(request.getParameter("versionaffix"));
	
	String isaddversion =  Util.null2String(request.getParameter("isaddversion"));
	String date2Version = Util.null2String(request.getParameter("date2Version")); 
	
	//-------------����ת��-----------------
	boardshareholder = URLDecoder.decode(boardshareholder, "utf-8");
	established = URLDecoder.decode(established, "utf-8");
	affixdoc = URLDecoder.decode(affixdoc, "utf-8");
	
	versionnum = ProManageUtil.fetchString(URLDecoder.decode(versionnum,"utf-8"));
	versionname = URLDecoder.decode(versionname,"utf-8");
	versionmemo = URLDecoder.decode(versionmemo,"utf-8");
	versionaffix = URLDecoder.decode(versionaffix,"utf-8");
	isaddversion = URLDecoder.decode(isaddversion,"utf-8");
	date2Version = URLDecoder.decode(date2Version,"utf-8");
	
	String lastupdatetime = now;
	//List tempids = new ArrayList();
	//companyMagager.tempids
	if ("add".equals(method)) {
		//------------�õ� request ֵ--------------
		//����ɶ��Ļ�����Ϣ-----------------------------------start
		strSql.setLength(0);
		strSql.append(" insert into CPSHAREHOLDER ");
		strSql.append(" (companyid,boardshareholder,established,createdatetime,lastupdatetime,isdel,shareaffix)");
		strSql.append(" values ('" + companyid + "','" + boardshareholder
				+ "','" + established + "',");
		strSql.append(" '" + createdatetime + "','" + lastupdatetime
				+ "','T','"+affixdoc+"')");
		
		rs.execute(strSql.toString());
		//����ɶ��Ļ�����Ϣ-----------------------------------end
//		System.out.println("sql:"+strSql.toString());
		String listgdcy = Util.null2String(request.getParameter("data"));
		int shareid =0;
		//String cpparentid = "";
		//�õ��ղ���Ĺɶ���id
		strSql.setLength(0);
		strSql.append(" select shareid from CPSHAREHOLDER where companyid="+ companyid);

			rs.execute(strSql.toString());
			if (rs.next()) {
				
				shareid = rs.getInt("shareid");
					org.json.JSONObject o4JsonArr2gd=null;
					
					//�жϹɶ���ϵA-B��˾��ϵ�Ƿ����仯--start
					String oldcompanyid="";
					String newcompanyid="";
					if (!"".equals(listgdcy)) {
							listgdcy = URLDecoder.decode(listgdcy, "utf-8");
							o4JsonArr2gd = new org.json.JSONObject(listgdcy);
							for (int i = 0; i < o4JsonArr2gd.length(); i++) {
										String companyid2share = o4JsonArr2gd.getJSONObject("tr" + i).getString("companyid2share");
										if(!"".equals(companyid2share)){
											newcompanyid+=companyid2share+",";
										}
							}
					}
					rs.execute("select companyid from CPSHAREOFFICERS where shareid in("+shareid+")");
					while(rs.next()){
							if(!"".equals(rs.getString("companyid"))){
								oldcompanyid+=rs.getString("companyid")+",";
							}
					}
					if(!jspUtil.CheckStr(oldcompanyid, newcompanyid)){
						//˵���ɶ���ϵ�����˱仯����Ҫ����A-B��˾�Ĺ�ϵ
						rs.execute("update CPCOMPANYINFOAB set status='u' ");
						//���ı�־λ�������߳�ɨ���������
					}
					//�жϹɶ���ϵA-B��˾��ϵ�Ƿ����仯--end
				
				if (!"".equals(listgdcy)) {
				String cpparentid = "";
				//�󶨹ɶ���˾����ǰ��˾
				for (int i = 0; i < o4JsonArr2gd.length(); i++) {
					String officername = o4JsonArr2gd.getJSONObject(
							"tr" + i).getString("officername");
					//System.out.println(officername);
					String isstop = o4JsonArr2gd
							.getJSONObject("tr" + i)
							.getString("isstop");
					String aggregateinvest = o4JsonArr2gd
							.getJSONObject("tr" + i).getString(
									"aggregateinvest");
					String aggregateinvest_sj = o4JsonArr2gd
							.getJSONObject("tr" + i).getString(
									"aggregateinvest_sj");
					String yongt = o4JsonArr2gd
							.getJSONObject("tr" + i).getString(
									"yongt");
					String aggregatedate = o4JsonArr2gd.getJSONObject(
							"tr" + i).getString("aggregatedate");
					String investment =Util.getFloatValue(o4JsonArr2gd.getJSONObject(
							"tr" + i).getString("investment"),0)+"";
					String companyid2share = o4JsonArr2gd.getJSONObject(
							"tr" + i).getString("companyid2share");
					String currencyid = o4JsonArr2gd.getJSONObject(
							"tr" + i).getString("currencyid");
					String ishow = o4JsonArr2gd.getJSONObject(
							"tr" + i).getString("ishow");
					strSql.setLength(0);
					strSql
							.append(" insert into CPSHAREOFFICERS (shareid,officername,isstop,aggregateinvest,aggregateinvest_sj,aggregatedate,investment,companyid,currencyid,ishow,yongt) values");
					strSql.append(" ('" + shareid + "','" + officername
							+ "','" + isstop + "','" + aggregateinvest
							+ "','"+aggregateinvest_sj+"','" + aggregatedate + "','"
							+ investment + "','"+companyid2share+"','"+currencyid+"','"+ishow+"','"+yongt+"')");
					rs.execute(strSql.toString());
					
					String spsql = "select cpparentid from cpcompanyinfo where companyid='"+companyid2share+"'";
					rs.execute(spsql);
					if(rs.next()){
						cpparentid=cpparentid+companyid2share+",";
						
					}
				}
				strSql.setLength(0);
				strSql.append("update cpcompanyinfo set cpparentid='"+cpparentid+"' where companyid='"+companyid+"'");
				//System.out.println(strSql.toString());
				rs.execute(strSql.toString());
			}
		}
		//����Ǳ���汾
		if(isaddversion.equals("add")){
			strSql.setLength(0);
			strSql.append("insert into CPSHAREHOLDERVERSION (shareid,versionnum,versionname,versionmemo,versionaffix,Createdatetime,");
			strSql.append("companyid,boardshareholder,established,shareaffix)");
			strSql.append(" values ('"+shareid+"','"+versionnum+"','"+versionname+"','"+versionmemo+"','"+versionaffix+"','"+date2Version+"',");
			strSql.append(" '" + companyid + "','" + boardshareholder
					+ "','" + established + "','"+affixdoc+"')");
			//System.out.println(strSql);
			rs.execute(strSql.toString());	
			//����֪ͨ-���
			String upsql = "insert into CPCOMPANYUPGRADE (UPTYPE,UPVERSION,CREATEDATETIME,discription,companyid) values ('director','"+versionnum+"','"+now+"','"+SystemEnv.getHtmlLabelName(1421,user.getLanguage())+"��"+SystemEnv.getHtmlLabelName(30944,user.getLanguage())+"-["+versionnum+"]',"+companyid+")";
			rs.execute(upsql);
			if (!"".equals(listgdcy)) {
				listgdcy = URLDecoder.decode(listgdcy, "utf-8");
				org.json.JSONObject o4JsonArr2gd = new org.json.JSONObject(
						listgdcy);
				for (int i = 0; i < o4JsonArr2gd.length(); i++) {
					String officername = o4JsonArr2gd.getJSONObject(
							"tr" + i).getString("officername");
					//System.out.println(officername);
					String isstop = o4JsonArr2gd
							.getJSONObject("tr" + i)
							.getString("isstop");
					String aggregateinvest = o4JsonArr2gd
							.getJSONObject("tr" + i).getString(
									"aggregateinvest");
					String aggregateinvest_sj = o4JsonArr2gd
							.getJSONObject("tr" + i).getString(
									"aggregateinvest_sj");
                    String yongt = o4JsonArr2gd
                            .getJSONObject("tr" + i).getString(
                                    "yongt");
					String aggregatedate = o4JsonArr2gd.getJSONObject(
							"tr" + i).getString("aggregatedate");
					String investment = Util.getFloatValue(o4JsonArr2gd.getJSONObject(
							"tr" + i).getString("investment"),0)+"";
					String companyid2share = o4JsonArr2gd.getJSONObject(
							"tr" + i).getString("companyid2share");
					String currencyid = o4JsonArr2gd.getJSONObject(
							"tr" + i).getString("currencyid");
					String ishow = o4JsonArr2gd.getJSONObject(
							"tr" + i).getString("ishow");
					strSql.setLength(0);
					strSql
							.append(" insert into CPSHAREOFFICERSVERSION (shareid,officername,isstop,aggregateinvest,aggregateinvest_sj,aggregatedate,investment,companyid,currencyid,versionnum,VERSIONTYPE,ishow,yongt) values");
					strSql.append(" ('" + shareid + "','" + officername
							+ "','" + isstop + "','" + aggregateinvest
							+ "','"+aggregateinvest_sj+"','" + aggregatedate + "','"
							+ investment + "','"+companyid2share+"','"+currencyid+"','"+versionnum+"','gd','"+ishow+"','"+yongt+"')");
					//System.out.println(strSql);
					rs.execute(strSql.toString());
				}
			}
		}
		//companyMagager.froWheelTree(companyid);
		//out.print(this.getSumInvestment(companyid));
		pro.writeCompanylog("3",companyid,"1",user.getUID()+"","�ɶ���");
		out.clear();
		out.print("0");
} else if ("edit".equals(method)) {
		if(!ProManageUtil.checkEdition("share", "", companyid, versionnum)){
				String shareid = Util.null2String(request.getParameter("shareid"));
				String listgdcy = Util.null2String(request.getParameter("data"));		
			
				
				org.json.JSONObject o4JsonArr2gd=null;
				//�жϹɶ���ϵA-B��˾��ϵ�Ƿ����仯--start
				String oldcompanyid="";
				String newcompanyid="";
				if (!"".equals(listgdcy)) {
						listgdcy = URLDecoder.decode(listgdcy, "utf-8");
						o4JsonArr2gd = new org.json.JSONObject(listgdcy);
						for (int i = 0; i < o4JsonArr2gd.length(); i++) {
									String companyid2share = o4JsonArr2gd.getJSONObject("tr" + i).getString("companyid2share");
									if(!"".equals(companyid2share)){
										newcompanyid+=companyid2share+",";
									}
						}
				}
				rs.execute("select companyid from CPSHAREOFFICERS where shareid in("+shareid+")");
				while(rs.next()){
						if(!"".equals(rs.getString("companyid"))){
							oldcompanyid+=rs.getString("companyid")+",";
						}
				}
				boolean ched=false;
				System.out.println("oldcompanyid = "+oldcompanyid+" newcompanyid="+newcompanyid);
				if(!jspUtil.CheckStr(oldcompanyid, newcompanyid)){
					//˵���ɶ���ϵ�����˱仯����Ҫ����A-B��˾�Ĺ�ϵ
					rs.execute("update CPCOMPANYINFOAB set status='u' ");
					//���ı�־λ�������߳�ɨ���������
					ched=true;
				}
				System.out.println("ched = "+ched+"");
				//�жϹɶ���ϵA-B��˾��ϵ�Ƿ����仯--end
		        String old_gdgx="";
		        String new_gdgx="";
				if(isaddversion.equals("add")){
					String sqlmax = "select max(versionnum) as versionnum from CPSHAREHOLDERVERSION where SHAREID="+shareid;
					rs.execute(sqlmax);
					//System.out.println("��һ��"+sqlmax);
					String maxnum = "";
					if(rs.next())maxnum = Util.null2String(rs.getString("versionnum"));
				
					//System.out.println("maxnum="+maxnum);
					//System.out.println("versionnum="+versionnum);
					//System.out.println("maxnum="+maxnum.compareTo(versionnum));
					if(maxnum.equals("") || maxnum.compareTo(versionnum)<0){
						strSql.setLength(0);
						strSql.append(" update CPSHAREHOLDER set boardshareholder='"
								+ boardshareholder + "',established='" + established
								+ "',shareaffix='"+affixdoc+"',");
						strSql.append(" lastupdatetime='" + lastupdatetime
								+ "' where shareid=" + shareid);
						//System.out.println(strSql.toString());
						rs.execute(strSql.toString());
                        String mysql1="select * from CPSHAREOFFICERS where shareid="+shareid+" order by investment desc ";
                        rs.executeSql(mysql1);
                        while (rs.next()) {
                            old_gdgx+="�ɶ�����:"+rs.getString("officername");
                            old_gdgx+=",����Ͷ�ʱ���:"+rs.getString("INVESTMENT")+"%"+"<br/>";
                        }
						//System.out.println("�ڶ���"+strSql);
						strSql.setLength(0);
						strSql.append(" delete from CPSHAREOFFICERS where shareid="
								+ shareid);
						//System.out.println("������"+strSql);
						rs.execute(strSql.toString());
						if (!"".equals(listgdcy)) {
							String cpparentid = "";
							//listgdcy = URLDecoder.decode(listgdcy, "utf-8");
							//org.json.JSONObject o4JsonArr2gd = new org.json.JSONObject(listgdcy);
							for (int i = 0; i < o4JsonArr2gd.length(); i++) {
								String officername = o4JsonArr2gd.getJSONObject(
										"tr" + i).getString("officername");
								//System.out.println(officername);
								String isstop = o4JsonArr2gd.getJSONObject("tr" + i)
										.getString("isstop");
								String aggregateinvest = o4JsonArr2gd.getJSONObject(
										"tr" + i).getString("aggregateinvest");
								String aggregateinvest_sj = o4JsonArr2gd.getJSONObject(
										"tr" + i).getString("aggregateinvest_sj");
                                String yongt = o4JsonArr2gd.getJSONObject(
                                        "tr" + i).getString("yongt");
								String aggregatedate = o4JsonArr2gd.getJSONObject(
										"tr" + i).getString("aggregatedate");
								String investment =Util.getFloatValue( o4JsonArr2gd
										.getJSONObject("tr" + i)
										.getString("investment"),0)+"";
								String companyid2share = o4JsonArr2gd.getJSONObject(
										"tr" + i).getString("companyid2share");
								String currencyid = o4JsonArr2gd.getJSONObject(
										"tr" + i).getString("currencyid");
								String ishow = o4JsonArr2gd.getJSONObject(
										"tr" + i).getString("ishow");
								strSql.setLength(0);
								strSql
										.append(" insert into CPSHAREOFFICERS (shareid,officername,isstop,aggregateinvest,aggregateinvest_sj,aggregatedate,investment,companyid,currencyid,ishow,yongt) values");
								strSql.append(" (" + shareid + ",'" + officername
										+ "','" + isstop + "','" + aggregateinvest
										+ "','"+aggregateinvest_sj+"','" + aggregatedate + "','" + investment +"','"+companyid2share+"','"+currencyid
										+ "','"+ishow+"','"+yongt+"')");
								//System.out.println("���Ĵ�"+strSql);

                                new_gdgx+="�ɶ�����:"+officername;
                                new_gdgx+=",����Ͷ�ʱ���:"+investment+"%"+"<br/>";

								rs.execute(strSql.toString());
								String spsql = "select cpparentid from cpcompanyinfo where companyid="+companyid2share;
								//System.out.println(spsql);
								rs.execute(spsql);
								if(rs.next()){
									cpparentid=cpparentid+companyid2share+",";
								}
							}
							strSql.setLength(0);
							strSql.append("update cpcompanyinfo set cpparentid='"+cpparentid+"' where companyid="+companyid);
							//System.out.println(strSql.toString());
							rs.execute(strSql.toString());
							
						}else{
								//��ʾ�Ѿ�û�йɶ���ϵ�ˣ���Ҫ�����Ĺ�˾Ϊ�����ܲ�
								rs.execute("update cpcompanyinfo set cpparentid='' where companyid="+companyid);
						}
					}
					strSql.setLength(0);
					strSql.append("insert into CPSHAREHOLDERVERSION (shareid,versionnum,versionname,versionmemo,versionaffix,Createdatetime,");
					strSql.append("companyid,boardshareholder,established,shareaffix)");
					strSql.append(" values ("+shareid+",'"+versionnum+"','"+versionname+"','"+versionmemo+"','"+versionaffix+"','"+date2Version+"',");
					strSql.append(" " + companyid + ",'" + boardshareholder
							+ "','" + established + "','"+affixdoc+"')");
					//System.out.println("�����"+strSql);
					rs.execute(strSql.toString());	
					//����֪ͨ-���
					String upsql = "insert into CPCOMPANYUPGRADE (UPTYPE,UPVERSION,CREATEDATETIME,discription,companyid) values ('director','"+versionnum+"','"+now+"','"+SystemEnv.getHtmlLabelName(1421,user.getLanguage())+"��"+SystemEnv.getHtmlLabelName(30944,user.getLanguage())+"-["+versionnum+"]',"+companyid+")";
					//System.out.println(strSql);
					rs.execute(upsql);
					if(ched){//˵���ɶ���ϵ�����仯�����Ҳ������µİ汾
						//���±����¼cpcchangenotice
						String year=TimeUtil.getCurrentDateString().substring(0,4);
						String month=TimeUtil.getCurrentDateString().substring(5,7);
						rs02.execute(" insert into cpcchangenotice (c_type,c_companyid,c_year,c_month,c_time,c_desc) values(3,'"+companyid+"','"+year+"','"+month+"','"+TimeUtil.getCurrentTimeString()+"','�ɶ��汾["+versionnum+"]') ");	
					}
					if (!"".equals(listgdcy)) {
					/* 	listgdcy = URLDecoder.decode(listgdcy, "utf-8");
						org.json.JSONObject o4JsonArr2gd = new org.json.JSONObject(
								listgdcy); */
						for (int i = 0; i < o4JsonArr2gd.length(); i++) {
							String officername = o4JsonArr2gd.getJSONObject(
									"tr" + i).getString("officername");
							//System.out.println(officername);
							String isstop = o4JsonArr2gd
									.getJSONObject("tr" + i)
									.getString("isstop");
							String aggregateinvest =o4JsonArr2gd
									.getJSONObject("tr" + i).getString(
											"aggregateinvest");
							String aggregateinvest_sj =o4JsonArr2gd
									.getJSONObject("tr" + i).getString(
											"aggregateinvest_sj");
                            String yongt =o4JsonArr2gd
                                    .getJSONObject("tr" + i).getString(
                                            "yongt");
							String aggregatedate = o4JsonArr2gd.getJSONObject(
									"tr" + i).getString("aggregatedate");
							String investment = Util.getFloatValue(o4JsonArr2gd.getJSONObject(
									"tr" + i).getString("investment"),0)+"";
							String companyid2share = o4JsonArr2gd.getJSONObject(
									"tr" + i).getString("companyid2share");
							String currencyid = o4JsonArr2gd.getJSONObject(
									"tr" + i).getString("currencyid");
							String ishow = o4JsonArr2gd.getJSONObject(
									"tr" + i).getString("ishow");
							strSql.setLength(0);
							strSql
									.append(" insert into CPSHAREOFFICERSVERSION (shareid,officername,isstop,aggregateinvest,aggregateinvest_sj,aggregatedate,investment,companyid,currencyid,versionnum,VERSIONTYPE,ishow,yongt) values");
							strSql.append(" (" + shareid + ",'" + officername
									+ "','" + isstop + "','" + aggregateinvest
									+ "','"+aggregateinvest_sj+"','" + aggregatedate + "','"
									+ investment + "','"+companyid2share+"','"+currencyid+"','"+versionnum+"','gd','"+ishow+"','"+yongt+"')");
							//System.out.println("������"+strSql);
							rs.execute(strSql.toString());
							String spsql = "select cpparentid from cpcompanyinfo where companyid="+companyid2share;
							rs.execute(spsql);
						}
					}
				}else{
					
					strSql.setLength(0);
					strSql.append(" update CPSHAREHOLDER set boardshareholder='"
							+ boardshareholder + "',established='" + established
							+ "',shareaffix='"+affixdoc+"',");
					strSql.append(" lastupdatetime='" + lastupdatetime
							+ "' where shareid=" + shareid);
					//System.out.println(strSql.toString());
					rs.execute(strSql.toString());
					//String listgdcy = Util.null2String(request.getParameter("data"));
					strSql.setLength(0);

                    String mysql1="select * from CPSHAREOFFICERS where shareid="+shareid+" order by investment desc ";
                    rs.executeSql(mysql1);
                    while (rs.next()) {
                        old_gdgx+="�ɶ�����:"+rs.getString("officername");
                        old_gdgx+=",����Ͷ�ʱ���:"+rs.getString("INVESTMENT")+"%"+"<br/>";
                    }
					strSql.append(" delete from CPSHAREOFFICERS where shareid="
							+ shareid);
					//System.out.println(strSql);
					rs.execute(strSql.toString());
					if (!"".equals(listgdcy)) {
						/* listgdcy = URLDecoder.decode(listgdcy, "utf-8");
						org.json.JSONObject o4JsonArr2gd = new org.json.JSONObject(
								listgdcy); */
						String cpparentid = "";
						for (int i = 0; i < o4JsonArr2gd.length(); i++) {
							String officername = o4JsonArr2gd.getJSONObject(
									"tr" + i).getString("officername");
							//System.out.println(officername);
							String isstop = o4JsonArr2gd.getJSONObject("tr" + i)
									.getString("isstop");
							String aggregateinvest =o4JsonArr2gd.getJSONObject(
									"tr" + i).getString("aggregateinvest");
							String aggregateinvest_sj =o4JsonArr2gd.getJSONObject(
                                    "tr" + i).getString("aggregateinvest_sj");
                            String yongt =o4JsonArr2gd.getJSONObject(
                                    "tr" + i).getString("yongt");
							String aggregatedate = o4JsonArr2gd.getJSONObject(
									"tr" + i).getString("aggregatedate");
							String investment = Util.getFloatValue(o4JsonArr2gd
									.getJSONObject("tr" + i)
									.getString("investment"),0)+"";
							String companyid2share = o4JsonArr2gd.getJSONObject(
									"tr" + i).getString("companyid2share");
							String currencyid = o4JsonArr2gd.getJSONObject(
									"tr" + i).getString("currencyid");
							String ishow = o4JsonArr2gd.getJSONObject(
									"tr" + i).getString("ishow");
							strSql.setLength(0);
							strSql
									.append(" insert into CPSHAREOFFICERS (shareid,officername,isstop,aggregateinvest,aggregateinvest_sj,aggregatedate,investment,companyid,currencyid,ishow,yongt) values");
							strSql.append(" (" + shareid + ",'" + officername
									+ "','" + isstop + "','" + aggregateinvest
									+ "','"+aggregateinvest_sj+"','" + aggregatedate + "','" + investment +"','"+companyid2share+"','"+currencyid
									+ "','"+ishow+"','"+yongt+"')");
							//System.out.println(strSql);
                            new_gdgx+="�ɶ�����:"+officername;
                            new_gdgx+=",����Ͷ�ʱ���:"+investment+"%"+"<br/>";
							rs.execute(strSql.toString());
							String spsql = "select cpparentid from cpcompanyinfo where companyid="+companyid2share;
							rs.execute(spsql);
							if(rs.next()){
								cpparentid=cpparentid+companyid2share+",";
								//System.out.println(cpparentid);
								
							}
						}
						strSql.setLength(0);
						strSql.append("update cpcompanyinfo set cpparentid='"+cpparentid+"' where companyid="+companyid);
						//System.out.println(strSql.toString());
						rs.execute(strSql.toString());
					}else{
								//��ʾ�Ѿ�û�йɶ���ϵ�ˣ���Ҫ�����Ĺ�˾Ϊ�����ܲ�
								rs.execute("update cpcompanyinfo set cpparentid='' where companyid="+companyid);
					}
				}
				
				
				//System.out.println(companyid);
				//companyMagager.froWheelTree(companyid);
				//out.print(this.getSumInvestment(companyid));
				pro.writeCompanylog("3",companyid,"2",user.getUID()+"",SystemEnv.getHtmlLabelName(30944,user.getLanguage()));

                rs.executeSql("select max(plog_id) as maxid from pro_taskLog where plog_qf=3 and plog_protaskid="+companyid);
                if (rs.next()) {
                    String maxid=rs.getString("maxid");
                    if (!old_gdgx.equals(new_gdgx)) {
                        String mysql2="update pro_taskLog set plog_before='"+old_gdgx+"',plog_after='"+new_gdgx+"' where plog_id="+maxid;
                        rs.executeSql(mysql2);
                    }
                }

				out.clear();
				out.print("0");
		}else{
			//�汾���ظ�
			out.clear();
			out.print("�汾��"+versionnum+"�Ѿ�����,���ݱ���ʧ��!");
		}
		
	} else if ("get".equals(method)) {
		//��� XX�ɶ������Ϣ
		String gdh_isadd = "";
		JSONArray jsa = new JSONArray();
		CpShareHolder cpshareholder = new CpShareHolder();
		String strgdh = " select * from CPSHAREHOLDER where isdel='T' and companyid= "
				+ companyid;
		//System.out.println(strgdh);
		rs.execute(strgdh);
		if (rs.next()) {
			cpshareholder.setShareid(rs.getInt("shareid"));
			cpshareholder.setEstablished(rs.getString("established"));
			cpshareholder.setBoardshareholder(rs
					.getString("boardshareholder"));
			cpshareholder.setShareaffix(rs.getString("shareaffix"));

			gdh_isadd = "edit";
			jsa.add(gdh_isadd);
			jsa.add(cpshareholder);
			pro.writeCompanylog("3",companyid,"4",user.getUID()+"",SystemEnv.getHtmlLabelName(30944,user.getLanguage()));
		} else {
			gdh_isadd = "add";
			jsa.add(gdh_isadd);
		}
		out.clear();
		out.print(jsa);
	}else if("delVersion".equals(method)){
		strSql.setLength(0);
		int shareid=0;
		String _versionids =Util.TrimComma(Util.null2String(request.getParameter("versionids")));//Ҫ��ɾ���İ汾id
		String _versionnum=Util.TrimComma(Util.null2String(request.getParameter("_versionnum")));//Ҫ��ɾ���İ汾��
		rs02.execute("select companyid  from CPSHAREHOLDERVERSION where  versionid in ("+_versionids+")");
		if(rs02.next()){
			String temp_companyid=rs02.getString("companyid");
			rs02.execute(" select shareid from CPSHAREHOLDER where companyid="+ companyid);
			if(rs02.next()){
				shareid=rs02.getInt("shareid");//�����CPSHAREOFFICERSVERSION������ѽ
			}
			//����֪ͨ-ɾ��
			String upsql = "insert into CPCOMPANYUPGRADE (UPTYPE,UPVERSION,CREATEDATETIME,discription,companyid) values ('director','"+_versionnum+"','"+now+"','"+SystemEnv.getHtmlLabelName(23777,user.getLanguage())+"��"+SystemEnv.getHtmlLabelName(30944,user.getLanguage())+"-["+_versionnum+"]',"+temp_companyid+")";
			rs.execute(upsql);
			//ɾ���汾
			upsql=" delete from CPSHAREHOLDERVERSION where versionid in ( "+_versionids+" )";
			rs.execute(upsql);
			//ɾ���汾֮�󣬻�Ҫɾ���汾�µ� ���»��Ա�汾�Ͷ��»��Ա�汾
			rs.execute(" delete  CPSHAREOFFICERSVERSION where  versionnum in ( "+_versionnum+" )  and  shareid='"+shareid+"'");
		}
	}else if("viewVersion".equals(method)){
		String versionids = Util.null2String(request.getParameter("versionids"));
		String _versionids = versionids.substring(0,versionids.lastIndexOf(","));
		JSONArray jsa = new JSONArray();
		CpShareHolder cpshareholder = new CpShareHolder();
		String sql = "select * from CPSHAREHOLDERVERSION t1 where t1.versionid="+_versionids;
		//System.out.println("�鿴�ɶ��汾"+sql);
		rs.execute(sql);
		if(rs.next()){
			cpshareholder.setShareid(rs.getInt("shareid"));
			cpshareholder.setEstablished(rs.getString("established"));
			cpshareholder.setBoardshareholder(rs
					.getString("boardshareholder"));
			//��������
			cpshareholder.setShareaffix(rs.getString("shareaffix"));
			String[] affixdocs = cpshareholder.getShareaffix().split(",");
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
			cpshareholder.setImgid(imgid2db);
			cpshareholder.setImgname(imgname2db);
		}
		jsa.add(cpshareholder);
		jsa.add(rs.getString("versionnum"));
		strSql.setLength(0);
		strSql.append("select companyid,versionnum from CPSHAREHOLDERVERSION where versionid in ( "+_versionids+" )");
		rs.execute(strSql.toString());
		//System.out.println(strSql.toString());
		if(rs.next()){
			//System.out.println("1");
			pro.writeCompanylog("3",rs.getString("companyid"),"4",user.getUID()+"",""+SystemEnv.getHtmlLabelName(30944,user.getLanguage())+"["+SystemEnv.getHtmlLabelName(567,user.getLanguage())+":"+rs.getString("versionnum")+"]");
		}
		out.clear();
		out.print(jsa);
	}else if("viewOffersVersion".equals(method)){
		String shareid = Util.null2String(request.getParameter("shareid"));
		String sql = " select * from CPSHAREOFFICERSVERSION where shareid ="+shareid+" and versionnum = '"+versionnum+"' and versiontype='gd' order by investment desc";
		//System.out.println("��ѯ�ɶ�������"+sql);
		rs.execute(sql);
		out.clear();
		while (rs.next()){
			String valuedate = "";
			if(!Util.null2String(rs.getString("aggregatedate")).equals(""))
			valuedate = rs.getString("aggregatedate").substring(0,4);
			out.print("<tr dbvalue='"+valuedate +"'>");
			out.print("<td width='27' align='center'>");
			//out.print("<input type='checkbox' name='checkbox' inWhichPage='gd'/>");
			out.print("</td>");
			out.print("<td width='100' style=\"word-wrap:break-word;\" >");
			out.print("<span>&nbsp;&nbsp;"+rs.getString("officername")+"<span>");
			out.print("</td>");
			out.print("<td width='52' >");
			if("1".equals(rs.getString("isstop"))){
				out.println("&nbsp;&nbsp;��");
			}else{
				out.println("&nbsp;&nbsp;��");
			}
			out.print("</td>");
			
			
			out.print("<td width='99' >");
			out.print("&nbsp;&nbsp"+rs.getString("aggregateinvest")+"");
			out.print("</td>");
			out.print("<td width='99' >");
			out.print("&nbsp;&nbsp"+rs.getString("aggregateinvest_sj")+"");
			out.print("</td>");
			out.print("<td width='70' >&nbsp;&nbsp;");
			rs02.execute("select id,currencyname,currencydesc from FnaCurrency  where id = '"+rs.getString("currencyid")+"'");
			if(rs02.next()){
				out.print(rs02.getString("currencyname"));
			}
			out.print("</td>");
			out.print("<td width='120' >");
			out.print("<span>&nbsp;&nbsp;"+rs.getString("aggregatedate") +"</span>");
			out.print("</td>");
			out.print("<td width='120'>");
			out.print("&nbsp;&nbsp;"+rs.getString("investment") +"");
			out.print("</td>");
			out.print("<td width='120'>");
			out.print("&nbsp;&nbsp;"+rs.getString("yongt") +"");
			out.print("</td>");
			out.print("<td width='0' >&nbsp;&nbsp;");
			out.print("<select style=' width:0px; height:26px;border:0px;'>");
			out.print(jspUtil.getOption("1,0",""+SystemEnv.getHtmlLabelName(26523,user.getLanguage())+","+SystemEnv.getHtmlLabelName(23857,user.getLanguage())+"",rs.getString("ishow")));
			out.print("</select>");
			out.print("</td>");
			out.print("</tr>");
		}
	}else if ("editversion".equals(method)){
		String versionid = Util.null2String(request.getParameter("versionid"));
		String upversionsql="";
		rs02.execute("select  versionnum,companyid  from CPSHAREHOLDERVERSION where  versionid in ("+versionid+")");
		if(rs02.next()){
			String temp_versionnum=rs02.getString("versionnum");
			String temp_companyid=rs02.getString("companyid");
			//����֪ͨ-�޸�
			if(!versionnum.equals(temp_versionnum)){
				String upsql = "insert into CPCOMPANYUPGRADE (UPTYPE,UPVERSION,CREATEDATETIME,discription,companyid) values ('director','"+versionnum+"','"+now+"','"+SystemEnv.getHtmlLabelName(103,user.getLanguage())+"��"+SystemEnv.getHtmlLabelName(30944,user.getLanguage())+"-["+temp_versionnum+"->"+versionnum+"]',"+temp_companyid+")";
				rs.execute(upsql);
			}
			 upversionsql = "update CPSHAREHOLDERVERSION set versionnum = '"+versionnum+"', versionname = '"+versionname+"' ,versionmemo='"+versionmemo+"',versionaffix='"+versionaffix+"',createdatetime='"+date2Version+"' where versionid="+versionid;
			//System.out.println(upversionsql);
			rs.execute(upversionsql);
		}
	}
	else if ("shareholding".equals(method)){
		String cpid= "166";
		//companyMagager.getGroupInfo(cpid,"businesstype","1");
		//getGroupVersionList(cpid);
		companyMagager.getGroupInfo(cpid,"");
		//String xml = companyMagager.getABCompanyIDs(cpid);
		//System.out.println(xml);
		/*StringWriter sw = new StringWriter();
		XMLWriter writer = null;
		OutputFormat format = OutputFormat.createPrettyPrint();
		format.setEncoding("GBK");
		try {
			writer = new XMLWriter(format);
		   	writer.setWriter(sw);
		   	writer.write(getXMLData(cpid));
		   	writer.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		//System.out.println(sw.toString());*/
	}
	
%>

