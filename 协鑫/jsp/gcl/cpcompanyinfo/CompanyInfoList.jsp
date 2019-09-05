<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="weaver.company.CompanyUtil"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%> 
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<link href="/cpcompanyinfo/style/Business.css" rel="stylesheet"  type="text/css" />
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="CompanyPermissionService" class="weaver.cpcompanyinfo.CompanyPermissionService" scope="page" />
<jsp:useBean id="CityComInfo" class="weaver.hrm.city.CityComInfo" scope="page" />
<jsp:useBean id="XssUtil" class="weaver.filter.XssUtil" scope="page" />
<%
    String ishide=Util.null2String(request.getParameter("ishide"));
	String refFarenParam = "";//法人
	String refDshParam = "";//董事会
	String refZhzhParam = "";//证照
	String refGdParam = "";//股东
	String refZhchParam = "";//章程
	String chzhzh = "";
	String chdsh = "";
	String chgd = "";
	String chzhch = "";
	String chxgs = "";
	
	rs.execute("SELECT * FROM CPCOMPANYTIMEOVER");
	if(rs.next()){
		refFarenParam = rs.getString("tofaren");
		refDshParam = rs.getString("todsh");
		refZhzhParam = rs.getString("tozhzh");
		refGdParam = rs.getString("togd");
		refZhchParam = rs.getString("tozhch");
		
		chzhzh = rs.getString("chzhzh");
		chdsh = rs.getString("chdsh");
		chgd = rs.getString("chgd");
		chzhch = rs.getString("chzhch");
		chxgs = rs.getString("chxgs");
	}
	
	String userManager="";
	CompanyUtil cu=new CompanyUtil();
	 if(!cu.canOperate(user,"2")){
		//得到当前用户管辖那几个公司
		userManager=cu.canOperateCOM(user,"2");
//         System.out.println("usermanager:"+userManager);
	}else{
		userManager="ALL";
	}
	if("".equals(userManager)){
		//防止报错，如果传个空字符串进去会报错
		userManager="NONE";
	}
	//要查找的列
	String businesstype = Util.null2String(request.getParameter("businesstype"));
	String ischzhzh =  Util.null2String(request.getParameter("o4chzhzh"));
	String ischzhch =  Util.null2String(request.getParameter("o4chzhch"));
	String ischgd =  Util.null2String(request.getParameter("o4chgd"));
	String ischdsh =  Util.null2String(request.getParameter("o4chdsh"));
	String ischxgs =  Util.null2String(request.getParameter("o4chxgs"));
	
	String issearchTX = Util.null2String(request.getParameter("o4searchTx"));
	String issearchSL = Util.null2String(request.getParameter("o4searchSL"));
	int language=user.getLanguage();
	String checkWhichs = "";
	
	
	String zrrid="";//得到自然人的id
	String  isShowZrr="NONE";
	if(rs.execute("select id,name from CompanyBusinessService where affixindex=-1")&&rs.next()){
		zrrid=rs.getString("id");
	}
	 if(zrrid.equals(businesstype)){
	 		isShowZrr="HAVE";
	 }
	if("sqlserver".equals(rs.getDBType())){
		if(ischzhzh.equals("on")){
			
			checkWhichs+=" and exists ( select tlv.companyid from CPBUSINESSLICENSEVERSION tlv where t1.companyid = tlv.companyid  and  datediff(day,CONVERT(varchar(100), tlv.createdatetime, 23),CONVERT(varchar(100), getdate(), 23))  "+Util.toHtmlForSplitPage("<") +chzhzh+") ";
		}
		if(ischzhch.equals("on")){
			checkWhichs+=" and exists (  select tcv.companyid from CPCONSTITUTIONVERSION tcv where t1.companyid = tcv.companyid and  datediff(day,CONVERT(varchar(100), tcv.createdatetime, 23),CONVERT(varchar(100), getdate(), 23))  "+Util.toHtmlForSplitPage("<") +chzhch+") ";
		}
		if(ischgd.equals("on")){
			checkWhichs+=" and exists ( select tsv.companyid from CPSHAREHOLDERVERSION tsv where t1.companyid = tsv.companyid and  datediff(day,CONVERT(varchar(100), tsv.createdatetime, 23),CONVERT(varchar(100), getdate(), 23))  "+Util.toHtmlForSplitPage("<") +chgd+") ";
		}
		if(ischdsh.equals("on")){
			checkWhichs+=" and exists ( select tbv.companyid from CPBOARDVERSION tbv where t1.companyid = tbv.companyid and datediff(day,CONVERT(varchar(100), tbv.createdatetime, 23),CONVERT(varchar(100), getdate(), 23)) "+Util.toHtmlForSplitPage("<") +chdsh+") ";
		}
		if(ischxgs.equals("on")){
				//--------------------------datediff 这个函数在oracle中是没有的呀---------------------------------------------------------------------------------------------------
			//checkWhichs+=" and datediff(day,CONVERT(varchar(100), t2.usefulbegindate, 23),CONVERT(varchar(100), getdate(), 23))  " +Util.toHtmlForSplitPage("<") +chxgs;
			
			checkWhichs+=" and  t1.companyid  in(   ";   
			checkWhichs+=" select companyid  from (   ";                                
				checkWhichs+="select  companyid,foundingtime begdata, ";        
				checkWhichs+="CONVERT(varchar(100),DATEADD(day,("+chxgs+"-1),foundingtime),23 )enddata, ";        
				checkWhichs+="CONVERT(varchar(100),getdate(),23)curdata  ";        
				checkWhichs+="from CPCOMPANYINFO  ";        
			checkWhichs+=" ) s where curdata"+Util.toHtmlForSplitPage(">")+"=begdata and curdata "+Util.toHtmlForSplitPage("<")+"=enddata )";        

		}
	
	}else{
		if(ischzhzh.equals("on")){
			checkWhichs+=" and exists (select tlv.companyid from CPBUSINESSLICENSEVERSION tlv where t1.companyid = tlv.companyid and  TO_NUMBER(to_date((select to_char(sysdate,'YYYY-MM-DD') datetime from dual),'YYYY-MM-DD')-to_date(substr(tlv.createdatetime,0,10),'YYYY-MM-DD')) "+Util.toHtmlForSplitPage("<") +chzhzh+") ";
		}
		if(ischzhch.equals("on")){
			checkWhichs+=" and exists (select tcv.companyid from CPCONSTITUTIONVERSION tcv where t1.companyid = tcv.companyid and  TO_NUMBER(to_date((select to_char(sysdate,'YYYY-MM-DD') datetime from dual),'YYYY-MM-DD')-to_date(substr(tcv.createdatetime,0,10),'YYYY-MM-DD')) "+Util.toHtmlForSplitPage("<") +chzhch+") ";
		}
		if(ischgd.equals("on")){
			checkWhichs+=" and exists (select tsv.companyid from CPSHAREHOLDERVERSION tsv where t1.companyid = tsv.companyid and  TO_NUMBER(to_date((select to_char(sysdate,'YYYY-MM-DD') datetime from dual),'YYYY-MM-DD')-to_date(substr(tsv.createdatetime,0,10),'YYYY-MM-DD')) "+Util.toHtmlForSplitPage("<") +chgd+") ";
		}
		if(ischdsh.equals("on")){
			checkWhichs+=" and exists (select tbv.companyid from CPBOARDVERSION tbv where t1.companyid = tbv.companyid and  TO_NUMBER(to_date((select to_char(sysdate,'YYYY-MM-DD') datetime from dual),'YYYY-MM-DD')-to_date(substr(tbv.createdatetime,0,10),'YYYY-MM-DD')) "+Util.toHtmlForSplitPage("<") +chdsh+") ";
		}
		if(ischxgs.equals("on")){
		
			//checkWhichs+=" and TO_NUMBER(to_date((select to_char(sysdate,'YYYY-MM-DD') datetime from dual),'YYYY-MM-DD')-to_date(t2.usefulbegindate,'YYYY-MM-DD'))" +Util.toHtmlForSplitPage("<") +chxgs;
			
			checkWhichs+="and  t1.companyid  in( ";
				checkWhichs+=" select companyid from ( ";
			checkWhichs+=" select companyid,companyname,foundingtime begin ,to_char(trunc(to_date(foundingtime,'yyyy-mm-dd')+("+chxgs+"-1)),'yyyy-mm-dd') enddata, ";
			checkWhichs+="  (  ";
		   	checkWhichs+="  select to_char(sysdate,'YYYY-MM-DD') datetime from dual) cur  ";
		     	checkWhichs+="       from CPCOMPANYINFO    ";
		 	checkWhichs+="  ) where cur "+Util.toHtmlForSplitPage(">")+"=begin and cur "+Util.toHtmlForSplitPage("<")+"=enddata  ";
				checkWhichs+=" ) ";
				} 
	}
	
	if(!issearchTX.equals("")){
		if(!issearchSL.equals("t1.COMPANYREGION")){
			checkWhichs +=" and "+issearchSL+" like '%"+issearchTX+"%'";
		}else{
			checkWhichs += "and exists (select hc.id from hrmcity hc where t1.companyregion = hc.id and hc.cityname like '%"+issearchTX+"%')";
		}
	}
	String backfields="";
	if("sqlserver".equals(rs.getDBType())){
			backfields = " t1.businesstype,t4.appointenddate, t1.companyid, ISNULL(t1.foundingTime,'') foundingTime,t1.archivenum,t1.companyregion,t1.companyname,t2.usefulbegindate,t2.registercapital,t2.companytype,t2.usefulenddate,t3.stituenddate,t3.effectenddate,(case substring(t1.archivenum,0,1) when 'L' then 1 when 'H' then 2 when 'R' then 3 when 'W' then 4 end ) as abilty , '"+userManager+"' as  userManager,'"+isShowZrr+"' as  isShowZrr,"+language+" as language";
	}else{
		 backfields = " t1.businesstype,t4.appointenddate,  t1.companyid,t1.foundingTime,t1.archivenum,t1.companyregion,t1.companyname,t2.usefulbegindate,t2.registercapital,t2.companytype,t2.usefulenddate,t3.stituenddate,t3.effectenddate,(case substr(t1.archivenum,0,1) when 'L' then 1 when 'H' then 2 when 'R' then 3 when 'W' then 4 end ) as abilty , '"+userManager+"' as  userManager,'"+isShowZrr+"' as  isShowZrr ,"+language+" as language";
	}
	String fromSql = " CPCOMPANYINFO t1 left join (select tb.* from CPBUSINESSLICENSE tb,CPLMLICENSEAFFIX tl where tb.licenseaffixid=tl.licenseaffixid and tl.licensetype=1 and tb.isdel='T') t2 on t1.companyid = t2.companyid left join CPCONSTITUTION t3 on  t1.companyid=t3.companyid  left join CPBOARDDIRECTORS t4 on t1.companyid=t4.companyid";
	String sqlwhere = " where t1.isdel='T' "+checkWhichs;
	if(!businesstype.equals("")) {
        sqlwhere += " and t1.businesstype = " + businesstype;
	}else{

    }
    if(!"1".equals(""+user.getUID())){
        if(!"1".equals(businesstype)){

            sqlwhere += " and t1.businesstype  not in( select id from CompanyBusinessService where affixindex=-1) and ( t1.businesstype in("+CompanyPermissionService.getCanviewGlgsIds(user)+") or ( t1.companyid in ("+("NONE".equals(userManager)?"-1":userManager)+") and t1.BUSINESSTYPE not in ("+CompanyPermissionService.getCanviewGlgsIds(user)+") ) ) ";	//过滤掉自然人
        }
    }else{
        if(!"1".equals(businesstype)){

            sqlwhere += " and t1.businesstype  not in( select id from CompanyBusinessService where affixindex=-1) ";
        }
    }



    String gsmc_=Util.null2String(request.getParameter("gsmc_"));//公司名称
    String szqy_=Util.null2String(request.getParameter("szqy_"));//所在区域
    String faren_=Util.null2String(request.getParameter("faren_"));//法人
    String zjl_=Util.null2String(request.getParameter("zjl_"));//总经理
    String dsh_=Util.null2String(request.getParameter("dsh_"));//董事会
    String jsh_=Util.null2String(request.getParameter("jsh_"));//监事会
    String gqgs_=Util.null2String(request.getParameter("gqgs_"));//股权归属
    String clsj1_=Util.null2String(request.getParameter("clsj1_"));//成立时间1
    String clsj2_=Util.null2String(request.getParameter("clsj2_"));//成立时间2
    String zczb_=Util.null2String(request.getParameter("zczb_"));//注册资本
    String dsz_=Util.null2String(request.getParameter("dsz_"));//董事长
    String gdmc_=Util.null2String(request.getParameter("gdmc_"));//股东名称
    String glgs_=Util.null2String(request.getParameter("glgs_"));//管理归属
    String zcdz_=Util.null2String(request.getParameter("zcdz_"));
    if(!"".equals(gsmc_)){
        sqlwhere+=" and t1.companyname like '%"+gsmc_+"%' ";
    }
    if(!"".equals(zcdz_)){
        sqlwhere+=" and t1.companyaddress like '%"+zcdz_+"%' ";
    }
    if(!"".equals(szqy_)){
        sqlwhere+=" and t1.companyregion ='"+szqy_+"' ";
    }
    if(!"".equals(faren_)){
        sqlwhere+=" and exists(select 1 from CPBOARDDIRECTORS tt1 where tt1.companyid=t1.companyid and tt1.faren like '%"+faren_+"%' ) ";
    }
    if(!"".equals(zjl_)){
        sqlwhere+=" and exists(select 1 from CPBOARDDIRECTORS tt1 where tt1.companyid=t1.companyid and tt1.GENERALMANAGER like '%"+zjl_+"%' ) ";
    }
    if(!"".equals(dsz_)){
        sqlwhere+=" and exists(select 1 from CPBOARDDIRECTORS tt1 where tt1.companyid=t1.companyid and tt1.CHAIRMAN like '%"+dsz_+"%' ) ";
    }
    if(!"".equals(dsh_)){
        sqlwhere+=" and exists(select 1 from CPCONSTITUTION tt1 where tt1.companyid=t1.companyid and tt1.THEBOARD like '%"+dsh_+"%' ) ";
    }
    if(!"".equals(jsh_)){
        sqlwhere+=" and exists(select 1 from CPCONSTITUTION tt1 where tt1.companyid=t1.companyid and tt1.BOARDVISITORS like '%"+jsh_+"%' ) ";
    }
    if(!"".equals(gqgs_)){
        sqlwhere+=" and exists(select 1 from Companyattributable tt1 where tt1.id=t1.companyvestin and tt1.name like '%"+gqgs_+"%' ) ";
    }
    if(!"".equals(glgs_)){
        sqlwhere+=" and exists(select 1 from CompanyBusinessService tt1 where tt1.id=t1.businesstype and tt1.name like '%"+glgs_+"%' ) ";
    }
    if(!"".equals(clsj1_)){
        sqlwhere+=" and t1.foundingtime >='"+clsj1_+"' ";
    }
    if(!"".equals(clsj2_)){
        sqlwhere+=" and t1.foundingtime <='"+clsj2_+"' ";
    }
    if(!"".equals(zczb_)){
        sqlwhere+=" and exists(select 1 from CPCONSTITUTION tt1 where tt1.companyid=t1.companyid and tt1.REGISTERCAPITAL like '%"+zczb_+"%' ) ";
    }
    if(!"".equals(gdmc_)){
        sqlwhere+=" and exists(select TT1.COMPANYID  from CPSHAREHOLDER tt1,CPSHAREOFFICERS tt2 where TT1.SHAREID=TT2.SHAREID and tt1.companyid=t1.companyid and tt2.OFFICERNAME like '%"+gdmc_+"%' ) ";
    }






//    out.print(sqlwhere);
//    System.out.println("sqlwhere:"+sqlwhere);
	
	// href=javascript:window.parent.location.href='/cpcompanyinfo/CompanyManageMain.jsp?companyid="+refCompanyNameParam+"';
	String sqlorderby = " t1.companyid ";
	
	String refCompanyNameParam = "column:companyid+column:userManager+column:isShowZrr";
	String refComlog="column:userManager+column:isShowZrr+column:language+column:BUSINESSTYPE+"+user.getUID();
	StringBuffer tableString = new StringBuffer();
	tableString .append(" <table instanceid=\"workflowRequestListTable\" tabletype=\"checkbox\" pagesize=\"10\" width=\"100%\" isfixed=\"true\" isnew= \"true\" _style= \"true\"> ");
	tableString .append(" <checkboxpopedom    popedompara=\"column:BUSINESSTYPE+"+user.getUID()+"\"  showmethod='weaver.cpcompanyinfo.CompanyPermissionService.getCanShouquan' />");
	tableString .append(" <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+sqlwhere+"\"  sqlorderby=\""+sqlorderby+"\"  sqlprimarykey=\"t1.companyid\" sqlsortway=\"desc\"  />");
	tableString .append(" <head>");         
	 if(zrrid.equals(businesstype)){
	 		tableString.append("	<col   text=\""+SystemEnv.getHtmlLabelName(714,user.getLanguage()) +"\"  column=\"archivenum\"   orderkey=\"archivenum\"  align=\"center\"   		width=\"8%\"  />");
		    tableString.append("	<col   text=\""+SystemEnv.getHtmlLabelName(28100,user.getLanguage()) +"\" column=\"companyregion\"    align=\"center\" transmethod=\"weaver.cpcompanyinfo.CompanyInfoTransMethod.getCompanyRegion\" width=\"10%\"	 />");
		    tableString.append("	<col   text=\""+SystemEnv.getHtmlLabelName(31445,user.getLanguage()) +"\" column=\"companyname\"   align=\"center\"  width=\"10%\"	otherpara=\""+refCompanyNameParam+"\"  transmethod=\"weaver.cpcompanyinfo.CompanyInfoTransMethod.setCompanyNameRef\" />");
		    tableString.append("	<col  text=\""+SystemEnv.getHtmlLabelName(30585,user.getLanguage()) +"\" column=\"companyid\"        otherpara=\""+refComlog+"\"   align=\"center\"   width=\"16%\"   transmethod=\"weaver.cpcompanyinfo.CompanyInfoTransMethod.getOperating\" />");        
	 }else{
	 	    tableString.append("	<col   text=\""+SystemEnv.getHtmlLabelName(714,user.getLanguage()) +"\"  column=\"archivenum\"   orderkey=\"archivenum\"  align=\"center\"   		width=\"8%\"  />");
		    tableString.append("	<col   text=\""+SystemEnv.getHtmlLabelName(28100,user.getLanguage()) +"\" column=\"companyregion\"    align=\"center\" transmethod=\"weaver.cpcompanyinfo.CompanyInfoTransMethod.getCompanyRegion\" width=\"10%\"	 />");
		    tableString.append("	<col   text=\""+SystemEnv.getHtmlLabelName(1976,user.getLanguage()) +"\" column=\"companyname\"   align=\"center\"  width=\"10%\"	otherpara=\""+refCompanyNameParam+"\"  transmethod=\"weaver.cpcompanyinfo.CompanyInfoTransMethod.setCompanyNameRef\" />");        
		    tableString.append("	<col   text=\""+SystemEnv.getHtmlLabelName(30975,user.getLanguage()) +"\"   column=\"foundingTime\" orderkey=\"foundingTime\" align=\"center\"  width=\"10%\"  />");
		    tableString.append("	<col   text=\""+SystemEnv.getHtmlLabelName(30976,user.getLanguage()) +"\" column=\"companytype\"   orderkey=\"companytype\" width=\"10%\"  align=\"center\"  />");     
		    tableString.append("	<col   text=\""+SystemEnv.getHtmlLabelName(20668,user.getLanguage()) +"\" column=\"companyid\"    align=\"center\"  width=\"8%\" transmethod=\"weaver.cpcompanyinfo.CompanyInfoTransMethod.getZczj\" />");
		    tableString.append("	<col   text=\""+SystemEnv.getHtmlLabelName(23797,user.getLanguage()) +"\" column=\"usefulenddate\"   width=\"5%\"	 align=\"center\" otherpara=\""+refFarenParam+"_"+language+"\"  transmethod=\"weaver.cpcompanyinfo.CompanyInfoTransMethod.getToCompairDate\"  />");    
		    tableString.append("	<col   text=\""+SystemEnv.getHtmlLabelName(30936,user.getLanguage()) +"\" column=\"appointenddate\"    align=\"center\"   width=\"5%\" otherpara=\""+refDshParam+"_"+language+"\"  transmethod=\"weaver.cpcompanyinfo.CompanyInfoTransMethod.getToCompairDate\" />"); 
		    tableString.append("	<col   text=\""+SystemEnv.getHtmlLabelName(30958,user.getLanguage()) +"\" column=\"companyid\"    align=\"center\"   width=\"8%\" otherpara=\""+refZhzhParam+"_"+language+"\"  transmethod=\"weaver.cpcompanyinfo.CompanyInfoTransMethod.getToCompairLicenseDate\" />");
		    tableString.append("	<col   text=\""+SystemEnv.getHtmlLabelName(28421,user.getLanguage()) +"\" column=\"companyid\"    align=\"center\"   width=\"5%\" otherpara=\""+language+"\"   transmethod=\"weaver.cpcompanyinfo.CompanyInfoTransMethod.getToGd\"  />");
		    tableString.append("	<col   text=\""+SystemEnv.getHtmlLabelName(30941,user.getLanguage()) +"\" column=\"effectenddate\"    align=\"center\"   width=\"5%\" otherpara=\""+refZhchParam+"_"+language+"\"  transmethod=\"weaver.cpcompanyinfo.CompanyInfoTransMethod.getToCompairDate\" />");
		     tableString.append("	<col  text=\""+SystemEnv.getHtmlLabelName(30585,user.getLanguage()) +"\" column=\"companyid\"        otherpara=\""+refComlog+"\"   align=\"center\"   width=\"16%\"   transmethod=\"weaver.cpcompanyinfo.CompanyInfoTransMethod.getOperating\"  />");
	 }
  
     
    tableString.append(" </head> </table>");
%>


<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%

    if(!"1".equals(businesstype)){
        RCMenu += "{"+"查询"+",javascript:onSearch(),_self} " ;
        RCMenuHeight += RCMenuHeightStep ;

        RCMenu += "{"+"导出Excel"+",javascript:_xtable_getAllExcel(),_self} " ;
        RCMenuHeight += RCMenuHeightStep ;

        RCMenu += "{"+"导出附件"+",javascript:outacc(),_self} " ;
        RCMenuHeight += RCMenuHeightStep ;

        RCMenu += "{"+"显示报表"+",javascript:viewreport(),_self} " ;
        RCMenuHeight += RCMenuHeightStep ;

        RCMenu += "{"+"查看授权"+",javascript:viewshare(),_self} " ;
        RCMenuHeight += RCMenuHeightStep ;

        RCMenu += "{"+"印章管理授权"+",javascript:yinzhangshare(),_self} " ;
        RCMenuHeight += RCMenuHeightStep ;

        RCMenu += "{"+"日志"+",javascript:showlog(),_self} " ;
        RCMenuHeight += RCMenuHeightStep ;
    }



%>

<%@ include file="/systeminfo/RightClickMenu.jsp" %>

<body>
<FORM id=searchForm name=searchForm action="CompanyInfoList.jsp" method=post <%="1".equals(businesstype)?"style='display:none'":"" %> >
    <input type="hidden" name="ishide" id="ishide" value="<%=ishide %>" />
    <input type="hidden" name="businesstype" id="businesstype" value="<%=businesstype %>" />
    <table class=Viewform id="searchTable" style="display:<%="1".equals(ishide)?"none":"" %>">
        <tbody>
        <COLGROUP>
            <COL width="15%">
            <COL width="35%">
            <COL width="15%">
            <COL width="35%">

            <TR class=Title>
                <TH colSpan=4><%=SystemEnv.getHtmlLabelName(15774,user.getLanguage())%></TH>
            </TR>
            <TR class=Spacing style="height:1px;"> <TD class=Line1 colSpan=4 ></TD> </TR>
            <tr>
                <td>公司名称</td>
                <td class=Field>
                    <input class=InputStyle maxlength=60 size=30 name="gsmc_" value="<%=gsmc_ %>">
                </td>
                <td>所在区域</td>
                <td class=Field>
                    <%--<input class=InputStyle maxlength=60 name="szqy_" size=30 value="<%=szqy_ %>">--%>
                        <BUTTON type="button" class=Browser id=SelectCityID onclick="onShowCityID()"></BUTTON>
                        <input type="hidden"  name="szqy_" size=30 value="<%=szqy_ %>" />
                        <span id="szqy_span"><%=CityComInfo.getCityname(szqy_) %></span>
                </td>
            </tr>
            <TR style="height:1px;"> <TD class=Line colSpan=4></TD> </TR>

            <tr>
                <td>法人</td>
                <td class=Field>
                    <input class=InputStyle maxlength=60 size=30 name="faren_" value="<%=faren_ %>">
                </td>
                <td>总经理</td>
                <td class=Field>
                    <input class=InputStyle maxlength=60 name="zjl_" size=30 value="<%=zjl_ %>">
                </td>
            </tr>
            <TR style="height:1px;"> <TD class=Line colSpan=4></TD> </TR>

            <tr>
                <td>董事会</td>
                <td class=Field>
                    <input class=InputStyle maxlength=60 size=30 name="dsh_" value="<%=dsh_ %>">
                </td>
                <td>监事会</td>
                <td class=Field>
                    <input class=InputStyle maxlength=60 name="jsh_" size=30 value="<%=jsh_ %>">
                </td>
            </tr>
            <TR style="height:1px;"> <TD class=Line colSpan=4></TD> </TR>

            <tr>
                <td>股权归属</td>
                <td class=Field>
                    <input class=InputStyle maxlength=60 size=30 name="gqgs_" value="<%=gqgs_ %>">
                </td>
                <td>成立时间</td>
                <td class=Field>
                    <button type=button  class=Calendar id=selectstartdate onClick="onShowDate_2('clsj1_span','clsj1_')"></button>
                    <input type="hidden"  name="clsj1_" size=30 value="<%=clsj1_ %>" />
                    <span id="clsj1_span"><%=clsj1_ %></span>&nbsp;-&nbsp;
                    <button type=button  class=Calendar id=selectenddate onClick="onShowDate_2('clsj2_span','clsj2_')"></button>
                    <input type="hidden"  name="clsj2_" size=30 value="<%=clsj2_ %>" />
                    <span id="clsj2_span"><%=clsj2_ %></span>
                </td>
            </tr>
            <TR style="height:1px;"> <TD class=Line colSpan=4></TD> </TR>

            <tr>
                <td>注册资本</td>
                <td class=Field>
                    <input class=InputStyle maxlength=60 size=30 name="zczb_" value="<%=zczb_ %>">
                </td>
                <td>董事长</td>
                <td class=Field>
                    <input class=InputStyle maxlength=60 name="dsz_" size=30 value="<%=dsz_ %>">
                </td>
            </tr>
            <TR style="height:1px;"> <TD class=Line colSpan=4></TD> </TR>

            <tr>
                <td>股东名称</td>
                <td class=Field>
                    <input class=InputStyle maxlength=60 size=30 name="gdmc_" value="<%=gdmc_ %>">
                </td>
                <td>管理归属</td>
                <td class=Field>
                    <input class=InputStyle maxlength=60 name="glgs_" size=30 value="<%=glgs_ %>">
                </td>
            </tr>
            <TR style="height:1px;"> <TD class=Line colSpan=4></TD> </TR>

            <tr>
                <td>注册地址</td>
                <td class=Field>
                    <input class=InputStyle maxlength=60 size=30 name="zcdz_" value="<%=zcdz_ %>">
                </td>
                <td></td>
                <td class=Field>
                    
                </td>
            </tr>
            <TR style="height:1px;"> <TD class=Line colSpan=4></TD> </TR>
    </table>
</FORM>
<div <%="1".equals(businesstype)?"style='display:none'":"" %>>
    <button onclick="toggle(this)" id="ishideBtn"><%="1".equals(ishide)?"显示条件":"隐藏条件" %></button>
</div>

                                        <div style="">
                                            <wea:SplitPageTag   tableString="<%=tableString.toString()%>"  mode="run"  isShowTopInfo="false" isShowBottomInfo="true"/>
	</div>

</body>
<script type="text/javascript">
	function getOperating(id,companyid){
			if(id==1){
				window.parent.beforeEditorView('viewBtn',companyid);
			}else if(id==2){
				window.parent.beforeEditorView('editBtn',companyid);
			}else if(id==3){
//                var confirminfo=confirm("确定删除么?");
//                if(confirminfo==true){
                    window.parent.delMutiList2Info(companyid);
//                }

			}else if(id==4){
				window.parent.openLogView(companyid);
			}else if(id==5){
//                alert("授权");
//                window.parent.openLogView(companyid);
                var url="/cpcompanyinfo/Comcheckright.jsp?comid="+companyid;
                window.open(url);
//                window.showModalDialog(""+url,window, "dialogWidth:450px; dialogHeight:250px; status:no;scroll:no;resizable=no;");
            }
	}
	/*刷新自身页面*/
	function reloadListContent(){
		window.location.reload();
	}
	/*获得公司资料 ID*/
	function getrequestids(){
		var requestids = _xtable_CheckedCheckboxId();
		return requestids;
	}
	function openConter(companyid,showOrUpdate){
			<%
				 if(!zrrid.equals(businesstype)){
			%>
//				window.parent.location.href="/cpcompanyinfo/CompanyManageMain.jsp?companyid="+companyid+"&showOrUpdate="+showOrUpdate;
                var url="/cpcompanyinfo/newpage/companysummary.jsp?from=newpage&companyid="+companyid+"&showOrUpdate="+showOrUpdate;
				window.open(url);
			<%
				 }
			%>
			
	}

    function viewshare(){
        var ids=_xtable_CheckedCheckboxId();
        if(_xtable_CheckedCheckboxId()==""){
            alert("<%=SystemEnv.getHtmlLabelName(19689,user.getLanguage())%>");
            return false;
        }

        var msg = window.showModalDialog("/cpcompanyinfo/ComcheckAccessRightAdd.jsp?from=batchshare&ids="+ids+"&opertype=2&comid=",window, "dialogWidth:450px; dialogHeight:250px;  status:no;scroll:no;resizable=no;");
        if(msg=='1'){
            alert("授权完成!");
        }


    }
    function yinzhangshare(){
        var ids=_xtable_CheckedCheckboxId();
        if(_xtable_CheckedCheckboxId()==""){
            alert("<%=SystemEnv.getHtmlLabelName(19689,user.getLanguage())%>");
            return false;
        }

        var msg = window.showModalDialog("/cpcompanyinfo/ComcheckAccessRightAdd.jsp?from=batchshare&ids="+ids+"&opertype=22&comid=",window, "dialogWidth:450px; dialogHeight:250px;  status:no;scroll:no;resizable=no;");
        if(msg=='1'){
            alert("授权完成!");
        }
    }
function onSearch(){
    document.getElementById("searchForm").submit();
}
function toggle(obj){
    if(jQuery("#ishide").val()=="1"){
        jQuery("#ishide").val("");
        jQuery("#ishideBtn").html("隐藏条件");
        jQuery("#searchTable").show();

    }else{
        jQuery("#ishide").val("1");
        jQuery("#ishideBtn").html("显示条件");
        jQuery("#searchTable").hide();
    }
}
    function onShowCityID(){
        datas = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/city/CityBrowser.jsp");
        if(datas){
            if(datas.id!=""){
                $GetEle("szqy_span").innerHTML = datas.name;
                $GetEle("szqy_").value=datas.id;
            }else{
                $GetEle("szqy_span").innerHTML = "";
                $GetEle("szqy_").value="";
            }
        }
    }

    function viewreport(){
        var url="/cpcompanyinfo/newpage/companyrp.jsp?businesstype=<%=businesstype %>&fromsqlwhere=<%=XssUtil.put(sqlwhere) %>";
        window.open(url);
    }

function outacc(){
    window.open("<%="/weaver/weaver.file.FileDownload?labelid=30905&fieldids=&download=1&downloadfrom=companyinfolist&downloadbatch=1&sqlwhere="+sqlwhere+""%>");
}
function showlog(){
    var url="/cpcompanyinfo/CPLog.jsp?from=companyinfolist";
    window.open(url);
}

</script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>