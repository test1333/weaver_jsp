<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="java.net.URLDecoder"%>
<%@ include file="/page/maint/common/initNoCache.jsp"%>
<%@page import="weaver.general.TimeUtil"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs02" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="pro" class="weaver.cpcompanyinfo.ProManageUtil" scope="page" />
<%
	String method = Util.null2String(request.getParameter("method"));
	StringBuffer strSql = new StringBuffer();
	
	String now = Util.date(2);
	
	String createdatetime = now;
	
	String archivenum = Util.null2String(request.getParameter("archivenum")).trim();
	String companyregion = Util.null2String(request.getParameter("companyregion")).trim();
	//System.out.println("后台区域的值"+companyregion);
	//公司归属
	String companyvestin = Util.null2String(request.getParameter("companyvestin")).trim();
	String companyname = Util.null2String(request.getParameter("companyname")).trim();
	String companyename = Util.null2String(request.getParameter("companyename")).trim();
	String companyaddress = Util.null2String(request.getParameter("companyaddress")).trim();
	String bgdz_ = Util.null2String(request.getParameter("bgdz_")).trim();
	String zt_ = Util.null2String(request.getParameter("zt_")).trim();
	String aggregateinvest_zc = Util.null2String(request.getParameter("aggregateinvest_zc")).trim();
	String currencyid_zc = Util.null2String(request.getParameter("currencyid_zc")).trim();
	String methodval=Util.null2String(request.getParameter("methodval")).trim();
	String foundingTime=Util.null2String(request.getParameter("foundingTime")).trim();
	//业务类型
	String businesstype = Util.null2String(request.getParameter("businesstype")).trim();
	String loancard = Util.null2String(request.getParameter("loancard")).trim();
	archivenum = URLDecoder.decode(archivenum,"utf-8").trim();
	companyregion = URLDecoder.decode(companyregion,"utf-8").trim();
	companyname = URLDecoder.decode(companyname,"utf-8").trim();
	companyaddress = URLDecoder.decode(companyaddress,"utf-8").trim();
	bgdz_ = URLDecoder.decode(bgdz_,"utf-8").trim();
	aggregateinvest_zc = URLDecoder.decode(aggregateinvest_zc,"utf-8").trim();
	currencyid_zc = URLDecoder.decode(currencyid_zc,"utf-8").trim();
	loancard = URLDecoder.decode(loancard,"utf-8").trim();
	companyename = URLDecoder.decode(companyename,"utf-8").trim();
	foundingTime=URLDecoder.decode(foundingTime,"utf-8").trim();
	String lastupdatetime = now;
	if("add".equals(method)){
		strSql.setLength(0);
		//判断业务类型和公司归属是否存在，如果不存在，则创建失败
		//companyvestin
		//businesstype
		rs.execute("select count(*) s from Companyattributable where id='"+companyvestin+"'");
		if(rs.next()&&rs.getInt("s")>0){
			rs.execute("select count(*) s from CompanyBusinessService where id='"+businesstype+"'");
			if(rs.next()&&rs.getInt("s")>0){
					strSql.append(" insert into CPCOMPANYINFO (archivenum,companyregion,companyvestin,");
					strSql.append(" companyname,companyaddress,businesstype,loancard,createdatetime,lastupdatetime,isdel,companyename,subcompanyid,foundingTime,bgdz_,zt_,AGGREGATEINVEST,CURRENCYID) ");
					strSql.append(" values('" + archivenum + "'," + companyregion + ",");
					strSql.append(" '" + companyvestin + "','"+ companyname +"','" + companyaddress + "',");
					strSql.append(" '"+businesstype+"','" + loancard + "','" + createdatetime + "','" + lastupdatetime + "','T','"+companyename+"',"+user.getUserSubCompany1()+",'"+foundingTime+"','"+bgdz_+"','"+zt_+"','"+aggregateinvest_zc+"','"+currencyid_zc+"')");
					rs.execute(strSql.toString());
					strSql.setLength(0);
					strSql.append(" select max(companyid) as companyid from CPCOMPANYINFO");
					rs.execute(strSql.toString());
					if(rs.next()){
						pro.writeCompanylog("3",rs.getString("companyid"),"1",user.getUID()+"",SystemEnv.getHtmlLabelName(1361,user.getLanguage()));
					}
			}
		}
	}
	else if("edit".equals(method))
	{
		String companyid = Util.null2String(request.getParameter("companyid"));
		rs.execute("select count(*) s from Companyattributable where id='"+companyvestin+"'");
		if(rs.next()&&rs.getInt("s")>0){
			rs.execute("select count(*) s from CompanyBusinessService where id='"+businesstype+"'");
			if(rs.next()&&rs.getInt("s")>0){
				strSql.setLength(0);
				strSql.append(" update CPCOMPANYINFO set archivenum = '"+archivenum+"',companyregion="+companyregion+",");
				strSql.append(" companyvestin='"+companyvestin+"',companyname='"+companyname+"',");
				strSql.append(" companyaddress='"+companyaddress+"',businesstype='"+businesstype+"',");
				strSql.append(" loancard='"+loancard+"',lastupdatetime='"+lastupdatetime+"',companyename='"+companyename+"',foundingTime='"+foundingTime+"',bgdz_='"+bgdz_+"',zt_='"+zt_+"',AGGREGATEINVEST='"+aggregateinvest_zc+"',CURRENCYID='"+currencyid_zc+"' ");
				strSql.append(" where companyid="+companyid);
				//System.out.println(strSql.toString());
				rs.execute(strSql.toString());
				pro.writeCompanylog("3",companyid,"2",user.getUID()+"",SystemEnv.getHtmlLabelName(1361,user.getLanguage()));
			}
		}
	}
	else if("del".equals(method)){
		String companyids = Util.null2String(request.getParameter("companyids"));
		strSql.setLength(0);
		strSql.append(" update CPCOMPANYINFO set isdel='F' where companyid in("+companyids+")");
		//System.out.println(strSql.toString());
		rs.execute(strSql.toString());
		pro.writeCompanylog("3",companyids,"3",user.getUID()+"",SystemEnv.getHtmlLabelName(1361,user.getLanguage()));
	}else if("haved".equals(method)){
		String companyid = Util.null2String(request.getParameter("companyid"));
		String havesql = "select count(tcp.companyid) as count from cpcompanyinfo tcp where tcp.companyname = '"+companyname+"' and tcp.archivenum='"+archivenum+"' and tcp.isdel='T'";
		if("edit".equals(methodval)){
			//如果是编辑，需要排除本身
			havesql+=" and companyid !="+companyid+"";
		}
	
		rs.execute(havesql);
		if(rs.next()){
			String havecount = rs.getString("count");
			if(havecount.equals("1"))
			{
				out.print("lmboth");
			}else{
				String havenumsql = "select count(tcp.companyid) as count from cpcompanyinfo tcp where tcp.archivenum='"+archivenum+"' and tcp.isdel='T'";
				if("edit".equals(methodval)){
					//如果是编辑，需要排除本身
					havenumsql+=" and companyid !="+companyid+"";
				}
				rs.execute(havenumsql);
				if(rs.next()){
					havecount = rs.getString("count");
					if(havecount.equals("1")){
						out.print("lmnum");
					}else{
						String havenamesql = "select count(tcp.companyid) as count from cpcompanyinfo tcp where tcp.companyname = '"+companyname+"' and tcp.isdel='T'";
						if("edit".equals(methodval)){
							//如果是编辑，需要排除本身
							havenamesql+=" and companyid !="+companyid+"";
						}
						rs.execute(havenamesql);
						if(rs.next()){
							havecount = rs.getString("count");
							if(havecount.equals("1")){
								out.print("lmname");
							}else{
								out.print("lmnohave");
							}
						}
					}
				}
			}
		}
	}
	//out.println("{method:'"+method+"',flag:'"+flag+"'}");
%>
