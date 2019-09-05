<%@page import="weaver.cpcompanyinfo.CompanyInfoTransMethod"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="/page/maint/common/initNoCache.jsp"%>
<%
    boolean fromNEWPAGE="newpage".equals(request.getParameter("from"));
    if (fromNEWPAGE) {
%>
<jsp:include page="/cpcompanyinfo/newpage/CompanyInfoContainer2.jsp" />
<%
    }
%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%@page import="weaver.docs.docs.DocComInfo"%>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.fna.maintenance.CurrencyComInfo" %>
<jsp:useBean id="jspUtil" class="weaver.cpcompanyinfo.JspUtil" scope="page" />
<link rel="stylesheet" type="text/css" href="/cpcompanyinfo/style/wbox.css" />
<jsp:useBean id="cu" class="weaver.company.CompanyUtil" scope="page" />
<jsp:useBean id="CompanyInfoTransMethod" class="weaver.cpcompanyinfo.CompanyInfoTransMethod" scope="page" />
<jsp:useBean id="CurrencyComInfo" class="weaver.fna.maintenance.CurrencyComInfo" scope="page" />
<jsp:useBean id="CompanyPermissionService" class="weaver.cpcompanyinfo.CompanyPermissionService" scope="page" />
<%

	String companyid = Util.null2String(request.getParameter("companyid"));
    if(! CompanyPermissionService.canViewCompany (user,""+Util.getIntValue( companyid,0))){
        response.sendRedirect("/notice/noright.jsp");
        return;
    }
	boolean maintFlag = false;
	if(cu.canOperate(user,"2")||cu.canOperate(companyid,user,"2"))//后台维护权限
	{
		maintFlag = true;
	}	
	String companyname = Util.null2String(request.getParameter("companyname"));
	/*证照<一定是营业执照>*/
	String zz_isadd = "add";
	
	int licenseid = 0;
	String registeraddress = "";
	String registercapital = "";
	String paiclupcapital = "";
	int currencyid_zz = 0;
	String licensename = "";
	
	String corporation = "";
	String usefulbegindate = "";
	String usefulenddate = "";
	String usefulyear = "";
	
	String strzz = " select t1.licenseid, t1.registeraddress,t1.registercapital,t1.paiclupcapital,t1.currencyid,t2.licensename," +
	" t1.corporation,t1.usefulbegindate,t1.usefulenddate,t1.usefulyear " +
	" from CPBUSINESSLICENSE t1,CPLMLICENSEAFFIX t2 where t1.licenseaffixid = t2.licenseaffixid and t1.isdel='T'" +
	" and t2.licensetype='1' and companyid= " + companyid;
	//System.out.println(strzz);
	rs.execute(strzz);
	if(rs.next()){
		licenseid = rs.getInt("licenseid");
		registeraddress = rs.getString("registeraddress");
		registercapital = rs.getString("registercapital");
		paiclupcapital = rs.getString("paiclupcapital");
		currencyid_zz = rs.getInt("currencyid");
		licensename = rs.getString("licensename");
		corporation = rs.getString("corporation");
		usefulbegindate = rs.getString("usefulbegindate");
		usefulenddate = rs.getString("usefulenddate");
		usefulyear = rs.getString("usefulyear");
	}
	
	String o4sql = " select * from mytrainaccessoriestype where accessoriesname='lmdirectors'";
	rs.execute(o4sql);
	String mainId="0";
	String subId="0";
	String secId="0";
	if(rs.next()){
		mainId=rs.getString("mainId");//覆盖默认的0
	 	subId=rs.getString("subId");//覆盖默认的0
	 	secId=rs.getString("secId");//覆盖默认的0c
	}
		//很关键的一个变量，用于判断后续页面是否开发编辑权限
	//0--只有这个公司的查看权限，没有维护权限
	//1--拥有这个公司查看和维护全县
	String showOrUpdate = Util.null2String(request.getParameter("showOrUpdate"));
%>

<!--表头浮动层 start-->
<input type="hidden" id="constitutionid_dsh"/>
<input type="hidden" id="method_dsh"/>
<input type="hidden" id="directorsid"/>
<input type="hidden" id="isaddversion"/>
<div 
	class="<%=fromNEWPAGE?"":"Absolute OHeaderLayer5 Bgfff BorderLMDIVHide" %>" >
	<div class="OHeaderLayerTit FL OHeaderLayerW5 " style="<%=fromNEWPAGE?"display: none":""%>">
		<span id="spanTitle_dsh" class="cBlue FontYahei FS16 PL15 FL"></span>
		<img src="images/O_40.jpg" class="FR MT10 MR10" 
			style="cursor: hand;" onclick="javascript:closeMaint4Win();" />
	</div>







	<div  style="padding: 10px;<%=fromNEWPAGE?"":"height:340px;" %>overflow-x:hidden;overflow-y:auto  ">
<a id="testaaa" style="display:none;"></a>
        <%--基本信息--%>
        <%
            /*公司信息*/
            String companyename = ""; //公司英文名称
            String companyaddress = ""; //公司地址
            String archivenum = ""; //全宗号
            String companyregion = ""; //区域
            String foundingTime = ""; //公司成立时间
            int businesstype = 0; //业务类型
            String loancard = ""; //贷款卡号
            String companyvestin = ""; //公司归属
	/*营业执照信息*/
            String scopebusiness = "";
            String corporatdelegate = "";
            String licenseregistnum = "";
            String companytype = "";
	/*章程*/
	/*董事会*/

//	新增字段：“办公地址”、“状态”字段（正常、注销，默认为“正常”）
            String bgdz_ = "";
            String zt_ = "";
//	其他：“投资总额”、“币种”字段放在“新建公司”界面维护；
            String AGGREGATEINVEST = "";
            String CURRENCYID = "";
            if (!companyid.equals("")) {
                String sql = "select t1.*,t3.*,t5.generalmanager,hrmcity. cityname from cpcompanyinfo t1 left join ("
                        + " select t2.companyid,t2.scopebusiness,t2.registercapital,t2.corporatdelegate, "
                        + " t2.usefulbegindate,t2.usefulenddate,t2.usefulyear,t2.licenseregistnum,t2.companytype "
                        + " from CPBUSINESSLICENSE t2 , CPLMLICENSEAFFIX taf where t2.licenseaffixid = taf.licenseaffixid and t2.isdel='T' and taf.licensetype = '1' ) t3 on t1.companyid = t3.companyid"
                        + " left join CPCONSTITUTION t4 on t1.companyid = t4.companyid"
                        + " left join CPBOARDDIRECTORS t5 on t1.companyid = t5.companyid "
                        +" left join  hrmcity  on t1.companyregion=hrmcity.id"
                        + " where t1.companyid = " + companyid;


                rs.execute(sql);
                while (rs.next()) {
			/*公司信息*/
                    companyname = Util.null2String(rs.getString("companyname")); //公司名称
                    companyename = Util.null2String(rs
                            .getString("companyename")); //公司英文名称
                    companyaddress = Util.null2String(rs
                            .getString("companyaddress")); //公司地址
                    archivenum = Util.null2String(rs.getString("archivenum")); //全宗号
                    companyregion =Util.null2String(rs.getString("companyregion")); //区域
                    foundingTime=Util.null2String(rs.getString("foundingTime")); //公司成立时间
                    if("NULL".equals(foundingTime)){
                        foundingTime="";
                    }
                    businesstype = rs.getInt("businesstype"); //业务类型
                    loancard = Util.null2String(rs.getString("loancard")); //贷款卡号
                    companyvestin = Util.null2String(rs
                            .getString("companyvestin")); //公司归属
			/*营业执照信息*/
                    scopebusiness = Util.null2String(rs.getString("scopebusiness")).replace("\n", "");
                    registercapital = Util.null2String(rs
                            .getString("registercapital"));
                    corporatdelegate = Util.null2String(rs
                            .getString("corporatdelegate"));
                    usefulbegindate = Util.null2String(rs
                            .getString("usefulbegindate"));
                    usefulenddate = Util.null2String(rs
                            .getString("usefulenddate"));
                    usefulyear = Util.null2String(rs.getString("usefulyear"));
                    companytype = Util.null2String(rs.getString("companytype"));
			/*章程*/
			/*董事会*/
                    bgdz_=Util.null2String(rs.getString("bgdz_"));
                    zt_=""+Util.getIntValue( Util.null2String(rs.getString("zt_")),1);
                    AGGREGATEINVEST=Util.null2String(rs.getString("AGGREGATEINVEST"));
                    CURRENCYID=Util.null2String(rs.getString("CURRENCYID"));
                }
            }

        %>

        <div class="border17 FL PTop10 OHeaderLayerW6 ML33"> <ul class="ONav FL cBlue"> <li><a class="hover" href="#"> <div><div style="font-size: 14px;"> 基本信息 </div> </div> </a> </li> </ul> <div class="clear"></div></div>
            <table width="620" border="0" <%=fromNEWPAGE?"":"align='center'"%> cellpadding="0" cellspacing="0" class="MT5">
                <tr >
                    <td height="25">
                        <strong>编号：</strong>
                    </td>
                    <td >
                        <span><%=archivenum %></span>
                    </td>
                    <td height="25">
                        <strong>区域：</strong>
                    </td>
                    <td >
                        <span><%=CompanyInfoTransMethod.getCompanyRegion( companyregion) %></span>
                    </td>
                </tr>
                <tr >
                    <td height="25">
                        <strong>管理归属：</strong>
                    </td>
                    <td >
                        <span><%=CompanyInfoTransMethod.getGuanliguishu( ""+businesstype) %></span>
                    </td>
                    <td height="25">
                        <strong>股权归属：</strong>
                    </td>
                    <td >
                        <span><%=CompanyInfoTransMethod.getGuquanguishu( companyvestin) %></span>
                    </td>
                </tr>
                <tr >
                    <td height="25">
                        <strong>公司名称：</strong>
                    </td>
                    <td >
                        <span><%=companyname %></span>
                    </td>
                    <td height="25">
                        <strong>成立时间：</strong>
                    </td>
                    <td >
                        <span><%=foundingTime %></span>
                    </td>
                </tr>
                <tr >
                    <td height="25">
                        <strong>投资总额：</strong>
                    </td>
                    <td >
                        <span><%=AGGREGATEINVEST %></span>
                    </td>
                    <td height="25">
                        <strong>币种：</strong>
                    </td>
                    <td >
                        <span><%=CurrencyComInfo.getCurrencyname( CURRENCYID ) %></span>
                    </td>
                </tr>
                <tr >
                    <td height="25">
                        <strong>注册地址：</strong>
                    </td>
                    <td colspan="3">
                        <span><%=companyaddress %></span>
                    </td>
                </tr>
                <tr >
                    <td height="25">
                        <strong>办公地址：</strong>
                    </td>
                    <td colspan="3">
                        <span><%=bgdz_ %></span>
                    </td>
                </tr>
            </table>





        <%--证照信息--%>
        <div class="border17 FL PTop10 OHeaderLayerW6 ML33"> <ul class="ONav FL cBlue"> <li><a class="hover" href="#"> <div><div style="font-size: 14px;"> 证照信息 </div> </div> </a> </li> </ul> <div class="clear"></div></div>
            <div class="FL ML33" style="<%=fromNEWPAGE?"":"height:25px;width:630px;" %>">
                <table width="614" border="0" cellpadding="0" cellspacing="1"
                       class="stripe OTable">
                    <tr id="OTable2" class="cBlack">
                        <td width="16%" align="center">
                            <strong>证照名称</strong>
                        </td>
                        <td width="18%" align="center">
                            <strong>注册号</strong>
                        </td>
                        <td width="10%" align="center">
                            <strong>成立日期</strong>
                        </td>
                        <td width="10%" align="center">
                            <strong>年检日期</strong>
                        </td>
                        <td width="8%" align="center">
                            <strong>登记机关</strong>
                        </td>
                        <td width="10%" align="center">
                            <strong>创建日期</strong>
                        </td>
                        <td width="20%" align="center">
                            <strong>附件</strong>
                        </td>
                        <td width="20%" align="center">
                            <strong>备注</strong>
                        </td>
                    </tr>
                </table>
                <div class="FR" style="height:24px;width:16px;background-color:#eeeeee; margin-top:-26px"></div>
            </div>
            <div class="OContRightScroll FL OHeaderLayerW6 ML33" style="<%=fromNEWPAGE?"":"height:56px;" %>">
                <table id="webTable2zz" width="614" border="0" cellpadding="0" cellspacing="1"
                       class="stripe OTable">
                    <%
                        String jssql="select t1.*,(select tla.affixindex from CPLMLICENSEAFFIX tla where tla.licenseaffixid = t1.licenseaffixid) affixindex,(select tla.licensename from CPLMLICENSEAFFIX tla where tla.licenseaffixid = t1.licenseaffixid) licensename,t1.dateinssue,t1.departinssue,t1.memo,t1.affixdoc,t1.createdatetime from CPBUSINESSLICENSE t1 where t1.isdel='T' and t1.companyid ="+companyid+" order by affixindex ";
                        rs.execute(jssql);
                        int jsix=1;
                        while (rs.next()){
                    %>
                    <tr >
                        <td width="16%" >
                            &nbsp;
                            <%--<%=CompanyInfoTransMethod.getLicensename(Util.null2String( rs.getString("licenseid")),Util.null2String( rs.getString("licensename")))  %>--%>
                            <%=Util.null2String( rs.getString("licensename"))  %>
                        </td>
                        <td width="18%" >
                            &nbsp;
                            <%=Util.null2String(rs.getString("recordnum")) %>
                        </td>
                        <td width="10%" >
                            &nbsp;
                            <%=Util.null2String(rs.getString("dateinssue")) %>
                        </td>
                        <td width="10%" >
                            &nbsp;
                            <%=Util.null2String(rs.getString("annualinspection")) %>
                        </td>
                        <td width="8%" >
                            <%=Util.null2String( rs.getString("departinssue"))  %>
                        </td>
                        <td width="10%" >
                            <%=Util.null2String(rs.getString("createdatetime")) %>
                        </td>
                        <td width="20%" >
                            <%=CompanyInfoTransMethod.getFujian( Util.null2String(rs.getString("affixdoc")),user) %>
                        </td>
                        <td width="20%" >
                            <%=Util.null2String(rs.getString("memo")) %>
                        </td>
                    </tr>
                    <%
                            jsix++;}
                    %>
                </table>
            </div>




        <%--章程--%>
            <%
                String strzc = " select * from CPCONSTITUTION where isdel='T' and companyid= " + companyid;
                rs.execute(strzc);
                String constitutionid="";
                String aggregateinvest="";
                String currencyid_zc="";
                String isvisitors="";
                String boardvisitors="";
                String visitbegindate="";
                String visitenddate="";
                String theboard="";
                String stitubegindate="";
                String stituenddate="";
                String appointduetime="";
                String isreappoint="";
                String generalmanager="";
                String effectbegindate="";
                String effectenddate="";
                String constituaffix="";
                String REGISTERCAPITAL="";
                String PAICLUPCAPITAL="";
                if(rs.next()){
                    constitutionid=""+rs.getInt("constitutionid");
                    aggregateinvest=""+rs.getString("aggregateinvest");
                    currencyid_zc=""+rs.getString("currencyid");
                    isvisitors=""+rs.getString("isvisitors");
                    boardvisitors=""+rs.getString("boardvisitors");
                    visitbegindate=""+rs.getString("visitbegindate");
                    visitenddate=""+rs.getString("visitenddate");
                    theboard=""+rs.getString("theboard");
                    stitubegindate=""+rs.getString("stitubegindate");
                    stituenddate=""+rs.getString("stituenddate");
                    appointduetime=""+rs.getString("appointduetime");
                    isreappoint=""+rs.getString("isreappoint");
                    generalmanager=""+rs.getString("generalmanager");
                    effectbegindate=""+rs.getString("effectbegindate");
                    effectenddate=""+rs.getString("effectenddate");
                    constituaffix=""+rs.getString("constituaffix");
                    REGISTERCAPITAL=""+Util.null2String( rs.getString("REGISTERCAPITAL"));
                    PAICLUPCAPITAL=""+Util.null2String(rs.getString("PAICLUPCAPITAL"));
                }

            %>
        <div class="border17 FL PTop10 OHeaderLayerW6 ML33"> <ul class="ONav FL cBlue"> <li><a class="hover" href="#"> <div><div style="font-size: 14px;"> 章程 </div> </div> </a> </li> </ul> <div class="clear"></div></div>
            <table width="620" border="0" <%=fromNEWPAGE?"":"align='center'"%> cellpadding="0" cellspacing="0" class="MT5">
                <tr >
                    <td height="25">
                        <strong>注册资本：</strong>
                    </td>
                    <td >
                        <span><%=REGISTERCAPITAL %></span>
                    </td>
                    <td height="25">
                        <strong>实收资本：</strong>
                    </td>
                    <td >
                        <span><%=PAICLUPCAPITAL %></span>
                    </td>
                </tr>
                <tr >
                    <td height="25">
                        <strong><%="2".equals(isvisitors)?"执行董事":"董事会" %>：</strong>
                    </td>
                    <td >
                        <span><%=theboard %></span>
                    </td>
                    <td height="25">
                        <strong>起止时间：</strong>
                    </td>
                    <td >
                        <span><%=stitubegindate %> - <%=stituenddate %></span>
                    </td>
                </tr>
                <tr >
                    <td height="25">
                        <strong>监事会：</strong>
                    </td>
                    <td >
                        <span><%=boardvisitors %></span>
                    </td>
                    <td height="25">
                        <strong>起止时间：</strong>
                    </td>
                    <td >
                        <span><%=visitbegindate %> - <%=visitenddate %></span>
                    </td>
                </tr>
                <tr >
                    <td height="25">
                        <strong>董事任职期限(年)：</strong>
                    </td>
                    <td >
                        <span><%=appointduetime %></span>
                    </td>
                    <td height="25">
                        <strong>连选连任：</strong>
                    </td>
                    <td >
                        <span><%="T".equals(isreappoint)?"是":"否" %></span>
                    </td>
                </tr>


                <tr>
                    <td height="25" align="left"  vAlign="top"><strong>附件：</strong></td>
                    <td colspan="3">
                        <%if(!CompanyInfoTransMethod.CheckPack("2")){out.println("<span style='color:red'>"+SystemEnv.getHtmlLabelName(31004,user.getLanguage())+"！</span>");}%>
                        <div id="licenseAffixUpload" style="display: none;" >
                            <input type="hidden" name="affixdoc" id="affixdoc">
						<span>
							<span id='spanButtonPlaceHolder'></span><!--选取多个文件-->
						</span>
                            &nbsp;&nbsp;
						<span style="color: #262626; cursor: hand; TEXT-DECORATION: none;<%if(!CompanyInfoTransMethod.CheckPack("2")){out.println("display: none;");}%>"
                              disabled id="btnCancel_upload">
							<span><img src="/js/swfupload/delete.gif" border="0" onClick="oUploader.cancelQueue()"> </span> <span
                                style="height: 19px"> <font style="margin: 0 0 0 -1"><%=SystemEnv.getHtmlLabelName(21407,user.getLanguage()) %>
                            (<%=SystemEnv.getHtmlLabelName(18976,user.getLanguage()) %>100<%=SystemEnv.getHtmlLabelName(18977,user.getLanguage()) %>)
                        </font> <!--清除所有--> </span> </span>
                            <div id="divImgsAddContent" style="overflow: auto;">
                                <div></div>
                                <div class="fieldset flash" id="fsUploadProgress"></div>
                                <div id="divStatus"></div>
                            </div>

						<span  id="_fximg">
								<img src='/images/BacoError.gif' align=absMiddle  >
						 </span>

                        </div>
                        <div id="affixcpdosDIV">
                            <%
                                int userid = user.getUID();
                                String affixdoc = "";
                                String affixsql = " select constituaffix from CPCONSTITUTION where companyid = " + companyid;
                                rs.execute(affixsql);
                                if(rs.next()){
                                    affixdoc = Util.null2String(rs.getString("constituaffix"));
                                }
                                String isdoc="";
                                if(!"".equals(affixdoc))
                                {

                                    DocComInfo dc=new DocComInfo();
                                    String []slaves=affixdoc.split(",");
                                    for(int i=0;i<slaves.length;i++)
                                    {
                                        String tempid="asid"+slaves[i];

                                        out.println("<div id='imgfileDiv"+i+"' style='background-color: #F7F7F7;height:20px;padding-left:4px;border: solid 1px #E8E8E8;padding: 4px;margin-bottom: 5px;'  class='progressWrapper'>");

                                        String filename="";
                                        String fileid="";
                                        rs.execute("select imagefileid,imagefilename from imagefile where imagefileid = "+slaves[i]);
                                        if(rs.next()){
                                            filename = rs.getString("imagefilename");
                                            fileid= rs.getString("imagefileid");
                                        }
                                        out.println("<div style='width:80%;float:left;' >");
                                        String str="<A id='pdflinkid"+i+"' href='/weaver/weaver.file.FileDownload?fileid="+fileid+"&download=1' class='aContent0 FL'>"+filename+"</A>";
                                        //输出文档主题，提供下载
                                        out.println(str);
                                        out.println("</div>");



                                        out.println("<div style='padding-right:0px;float:right;padding-top:0px'>");

                                        //输出下载文档超链接
                                        out.println("<a href='/weaver/weaver.file.FileDownload?fileid="+fileid+"&download=1'><img src='../images/downLoadPic.gif'  title='"+SystemEnv.getHtmlLabelName(22629,user.getLanguage())+"'  ></a>");

                                        out.println("</div>");
                                        out.println("</div>");
                                    }
                                }


                            %>
                        </div>
                    </td>
                </tr>

            </table>


        <%--股东会--%>

            <%
                String strgdh = " select * from CPSHAREHOLDER where isdel='T' and companyid= "
                        + companyid;
                String BOARDSHAREHOLDER="";
                String established="";
                rs.execute(strgdh);
                if (rs.next()) {
                    BOARDSHAREHOLDER=rs.getString("BOARDSHAREHOLDER");
                    established=rs.getString("established");
                }

            %>
        <div class="border17 FL PTop10 OHeaderLayerW6 ML33"> <ul class="ONav FL cBlue"> <li><a class="hover" href="#"> <div><div style="font-size: 14px;"> 股东会 </div> </div> </a> </li> </ul> <div class="clear"></div></div>
            <table width="620" border="0" <%=fromNEWPAGE?"":"align='center'"%> cellpadding="0" cellspacing="0" class="MT5">
                <tr >
                    <td height="25">
                        <strong>股东会：</strong>
                    </td>
                    <td >
                        <span id="BOARDSHAREHOLDER"><%=BOARDSHAREHOLDER %></span>
                    </td>
                    <td height="25">
                        <strong>成立时间：</strong>
                    </td>
                    <td >
                        <span id="established"><%=established %></span>
                    </td>
                </tr>
            </table>


            <div class="border17 FL PTop10 OHeaderLayerW61 ML33" >

                <ul class="ONav FL cBlue">
                    <li>
                        <a href="#" class="hover">
                            <div>
                                <div>
                                    <%=SystemEnv.getHtmlLabelName(31107,user.getLanguage()) %>
                                </div>
                            </div> </a>
                    </li>
                    <select id="gdh_selectdate01" onchange="javascript:searchzhzhdate_gdh(this);" class="OSelect MT3 MLeft8">
                    </select>
                </ul>
                <div class="clear"></div>

            </div>
            <div class="FL ML33" style="<%=fromNEWPAGE?"":"height:25px;width:700px;" %>">
                <table width="684" border="0" cellpadding="0" cellspacing="1"
                       class="stripe OTable" >
                    <tr id="gdh_OTable2" class="cBlack">
                        <td width="27" align="center">
                        </td>
                        <td width="100" align="center">
                            <strong><%=SystemEnv.getHtmlLabelName(27336,user.getLanguage()) %></strong>
                        </td>
                        <td width="52" align="center">
                            <strong><%=SystemEnv.getHtmlLabelName(31001,user.getLanguage()) %></strong>
                        </td>
                        <td width="99" align="center">
                            <strong>法定<%=SystemEnv.getHtmlLabelName(31040,user.getLanguage()) %></strong>
                        </td>
                        <td width="99" align="center">
                            <strong>实际<%=SystemEnv.getHtmlLabelName(31040,user.getLanguage()) %></strong>
                        </td>
                        <td width="70" align="center">
                            <strong><%=SystemEnv.getHtmlLabelName(406,user.getLanguage()) %></strong>
                        </td>
                        <td width="120" align="center">
                            <strong><%=SystemEnv.getHtmlLabelName(31108,user.getLanguage()) %></strong>
                        </td>
                        <td width="120" align="center">
                            <strong>法定<%=SystemEnv.getHtmlLabelName(31109,user.getLanguage()) %>(%)</strong>
                        </td>
                        <td width="120" align="center">
                            <strong>用途</strong>
                        </td>
                        <td width="0" align="center">
                            <!--  <strong><%=SystemEnv.getHtmlLabelName(31110,user.getLanguage()) %></strong>-->
                        </td>
                    </tr>
                </table>
                <div class="FR" style="height:24px;width:16px;background-color:#eeeeee; margin-top:-26px"></div>
            </div>
            <div class="OContRightScroll FL OHeaderLayerW61 ML33" style="<%=fromNEWPAGE?"":"height:137px;" %>">
                <table id="webTable2gd" width="684" border="0" cellpadding="0" cellspacing="1"
                       class="stripe OTable" style="table-layout: fixed;">
                    <%
                        String sql = "select t2.* from CPSHAREHOLDER t1,CPSHAREOFFICERS t2 where t1.shareid = t2.shareid and t1.companyid = '" + companyid +"'  order by investment desc";
                        rs.execute(sql);
                        int ix=1;
                        while (rs.next()){
                            String valuedate = "";
                            if(!Util.null2String(rs.getString("aggregatedate")).equals(""))
                                valuedate = rs.getString("aggregatedate").substring(0,4);
                    %>





                    <tr dbvalue="<%=valuedate%>">
                        <td width="27" align="center">
                        </td>
                        <td width="100" style="word-wrap:break-word;" >
                            &nbsp;
                            &nbsp;&nbsp;
						<span  ><%=rs.getString("officername")%>
						</span>
                            <input type="hidden"   value="<%=rs.getString("companyid") %>">
                        </td>
                        <td width="52" >
                            &nbsp;
                            <%="1".equals(rs.getString("isstop"))?"是":"否" %>
                        </td>
                        <td width="99" >
                            <%
                                    out.println("&nbsp;&nbsp;&nbsp;&nbsp;"+rs.getString("aggregateinvest"));
                            %>

                        </td>
                        <td width="99" >
                            <%
                                    out.println("&nbsp;&nbsp;&nbsp;&nbsp;"+rs.getString("aggregateinvest_sj"));
                            %>

                        </td>
                        <td width="70" >
                            &nbsp;
							<span>
							<%
                                RecordSet rs02=new RecordSet();
                                rs02.execute("select id,currencyname,currencydesc from FnaCurrency  where id = '"+rs.getString("currencyid")+"'");
                                if(rs02.next()){
                                    out.println(rs02.getString("currencyname"));
                                }
                            %>
							</span>
                            <input type="hidden"  value="<%=rs.getString("currencyid")%>">
                        </td>
                        <td width="120" >
                            &nbsp;
                            <INPUT  type=hidden  value="<%=rs.getString("aggregatedate") %>"   id=get_input<%=ix%>>
						<SPAN  id=get_sapn<%=ix%>>
									<%=rs.getString("aggregatedate") %>
						</SPAN>

                        </td>
                        <td width="120">
                            &nbsp;&nbsp;
                            <%
                                    out.println("&nbsp;&nbsp;&nbsp;&nbsp;"+rs.getString("investment"));
                            %>

                        </td>
                        <td width="120">
                            &nbsp;&nbsp;
                            <%
                                out.println("&nbsp;&nbsp;&nbsp;&nbsp;"+rs.getString("yongt"));
                            %>

                        </td>
                        <td width="0" >
                            <select style=" width:0px; height:0px;border:0px;">
                                <%=jspUtil.getOption("1,0",""+SystemEnv.getHtmlLabelName(26523,user.getLanguage())+","+SystemEnv.getHtmlLabelName(23857,user.getLanguage())+"",rs.getString("ishow")) %>
                            </select>
                        </td>
                    </tr>
                    <%
                            ix++;}
                    %>
                </table>
            </div>


            <table width="620" border="0" <%=fromNEWPAGE?"":"align='center'"%> cellpadding="0" cellspacing="0" class="MT5" style="padding-top:5px;">
                <tr>
                    <td height="25" vAlign="top">
                        <strong>附件：</strong>
                    </td>
                    <td colspan="3">
                        <%if(!CompanyInfoTransMethod.CheckPack("3")){out.println("<span style='color:red'>"+SystemEnv.getHtmlLabelName(31004,user.getLanguage()) +"！</span>");}%>
                        <div id="licenseAffixUpload" style="display: none;" >
                            <input type="hidden" name="affixdoc" id="affixdoc">
						<span>
							<span id='spanButtonPlaceHolder'></span><!--选取多个文件-->
						</span>
                            &nbsp;&nbsp;
						<span style="color: #262626; cursor: hand; TEXT-DECORATION: none;<%if(!CompanyInfoTransMethod.CheckPack("3")){out.println("display: none;");}%>"
                              disabled id="btnCancel_upload">
							<span><img src="/js/swfupload/delete.gif" border="0" onClick="oUploader.cancelQueue()"> </span> <span
                                style="height: 19px"> <font style="margin: 0 0 0 -1"><%=SystemEnv.getHtmlLabelName(21407,user.getLanguage()) %>
                            (<%=SystemEnv.getHtmlLabelName(18976,user.getLanguage()) %>100<%=SystemEnv.getHtmlLabelName(18977,user.getLanguage()) %>)
                        </font> <!--清除所有--> </span> </span>
                            <div id="divImgsAddContent" style="overflow: auto;">
                                <div></div>
                                <div class="fieldset flash" id="fsUploadProgress"></div>
                                <div id="divStatus"></div>
                            </div>
                        </div>

                        <div id="affixcpdosDIV">
                            <%
                                userid = user.getUID();
                                affixdoc = "";
                                affixsql = " select shareaffix from CPSHAREHOLDER where companyid = " + companyid;
                                rs.execute(affixsql);
                                if(rs.next()){
                                    affixdoc = Util.null2String(rs.getString("shareaffix"));
                                }
                                isdoc="";
                                if(!"".equals(affixdoc))
                                {

                                    DocComInfo dc=new DocComInfo();
                                    String []slaves=affixdoc.split(",");
                                    for(int i=0;i<slaves.length;i++)
                                    {
                                        String tempid="asid"+slaves[i];

                                        out.println("<div id='imgfileDiv"+i+"' style='background-color: #F7F7F7;height:20px;padding-left:4px;border: solid 1px #E8E8E8;padding: 4px;margin-bottom: 5px;'>");

                                        String filename="";
                                        String fileid="";
                                        rs.execute("select imagefileid,imagefilename from imagefile where imagefileid = "+slaves[i]);
                                        if(rs.next()){
                                            filename = rs.getString("imagefilename");
                                            fileid= rs.getString("imagefileid");
                                        }
                                        out.println("<div style='width:80%;float:left;' >");
                                        String str="<A id='pdflinkid"+i+"' href='/weaver/weaver.file.FileDownload?fileid="+fileid+"&download=1' class='aContent0 FL'>"+filename+"</A>";
                                        //输出文档主题，提供下载
                                        out.println(str);
                                        out.println("</div>");



                                        out.println("<div style='padding-right:0px;float:right;padding-top:0px'>");


                                        out.println("<a href='/weaver/weaver.file.FileDownload?fileid="+fileid+"&download=1'><img src='../images/downLoadPic.gif'  title='"+SystemEnv.getHtmlLabelName(22629,user.getLanguage())+"'  ></a>");
                                        //}

                                        out.println("</div>");
                                        out.println("</div>");
                                    }
                                }


                            %>
                        </div>


                    </td>
                </tr>
            </table>




        <%--董事会--%>
        <div class="border17 FL PTop10 OHeaderLayerW6 ML33"> <ul class="ONav FL cBlue"> <li><a class="hover" href="#"> <div><div style="font-size: 14px;"> 董事会 </div> </div> </a> </li> </ul> <div class="clear"></div></div>




        <table width="620" border="0" <%=fromNEWPAGE?"":"align='center'"%> cellpadding="0"
			cellspacing="0" class="MT5">
			<tr >
				<td height="25">
					<strong><%=SystemEnv.getHtmlLabelName(23797,user.getLanguage()) %>：</strong>
				</td>
				<td colspan="3">
                    <span id="faren"></span>
				</td>
			</tr>
			<tr>
				<td height="25">
                    <strong><span id="ischairman_dsh"></span>：</strong>
				</td>
				<td  height="25">
                    <span id="chairman_dsh"></span>
                </td>
                <td>
					<strong><%=SystemEnv.getHtmlLabelName(17697,user.getLanguage()) %>：</strong>
                </td>
                <td>
					<input type="hidden" id="appbegintime" name="appbegintime"  />
					<span id="appointbegindate_dsh">

					</span>
					-
					<input type="hidden" id="appendtime" name="appendtime"  />
					<span id="appointenddate_dsh">

					</span>


			  	</td>
			</tr>
			<tr>
				<td height="25">
					<strong><%=SystemEnv.getHtmlLabelName(20696,user.getLanguage())  %>：</strong>
				</td>
				<td  >
					<span id="generalmanager_dsh"></span>
					&nbsp;
                    <td>
					<strong><%=SystemEnv.getHtmlLabelName(17697,user.getLanguage())  %>：</strong>
                </td>
                <td>
					<SPAN id=managerbegindate_dsh ></SPAN>
					<input type="hidden" name="manbegintime"   id="manbegintime" >
					-
					<SPAN id=managerenddate_dsh ></SPAN>
					<input type="hidden" name="manendtime"  id="manendtime" >
                </td>
			</tr>
	  </table>
		<div class="border17 FL PTop10 OHeaderLayerW6 ML33">

			<ul class="ONav FL cBlue">
				<li>
					<a href="#" class="hover">
						<div>
							<div>
								<%=SystemEnv.getHtmlLabelName(30998,user.getLanguage()) %>
							</div>
						</div> </a>
				</li>
				<select id="selectdate01" onchange="javascript:searchzhzhdate(this);" class="OSelect MT3 MLeft8">
				</select>
			</ul>
			<div class="clear"></div>

		</div>
		<div class="FL ML33" style="<%=fromNEWPAGE?"":"height:25px;width:630px;" %>">
		<table width="614" border="0" cellpadding="0" cellspacing="1"
			class="stripe OTable">
			<tr id="OTable2" class="cBlack">
				<td width="4%" align="center">
					<%
							if(!"0".equals(showOrUpdate)){
					%>
					<%
						}
					 %>
				</td>
				<td width="16%" align="center">
					<strong><%=SystemEnv.getHtmlLabelName(30999,user.getLanguage()) %></strong>
				</td>
				<td width="18%" align="center">
					<strong><%=SystemEnv.getHtmlLabelName(31000,user.getLanguage()) %></strong>
				</td>
				<td width="17%" align="center">
					<strong><%=SystemEnv.getHtmlLabelName(24978,user.getLanguage()) %></strong>
				</td>
				<td width="17%" align="center">
					<strong><%=SystemEnv.getHtmlLabelName(22326,user.getLanguage()) %></strong>
				</td>
				<td width="8%" align="center">
					<strong><%=SystemEnv.getHtmlLabelName(31001,user.getLanguage()) %></strong>
				</td>
				<td width="20%" align="center">
					<strong><%=SystemEnv.getHtmlLabelName(20820,user.getLanguage()) %></strong>
				</td>
			</tr>
		</table>
		<div class="FR" style="height:24px;width:16px;background-color:#eeeeee; margin-top:-26px"></div>
		</div>
		
		

	
		
		
		<div class="OContRightScroll FL OHeaderLayerW6 ML33" style="<%=fromNEWPAGE?"":"height:56px;" %>">
			<table id="webTable2dsh" width="614" border="0" cellpadding="0" cellspacing="1"
				class="stripe OTable">
				<%
					sql="select t2.* from CPBOARDDIRECTORS t1,CPBOARDOFFICER t2 where t1.directorsid = t2.directorsid and t1.companyid = " + companyid +" order by t2.isstop desc,t2.officebegindate asc";
					rs.execute(sql);
					ix=1;
					while (rs.next()){
					
					String valuedate = "";
					if(!Util.null2String(rs.getString("officebegindate")).equals(""))
					valuedate = rs.getString("officebegindate").substring(0,4);
				 %>
				<tr dbvalue="<%=valuedate %>">
					<td width="4%"  align="center">
						<%
							if(!"0".equals(showOrUpdate)){
						%>
						<%
							}
						%>
							
						
						
					</td>
					<td width="16%" >
						&nbsp;
						<%
							if(!"0".equals(showOrUpdate)){
						%>
						<!-- 董事会届数 -->
						<span>
								<%=rs.getString("sessions") %>
						</span>
						<%
							}else{
						%>
								<%=rs.getString("sessions") %>
						<% 
							}
						%>
			
					</td>
					<td width="18%" >
						&nbsp;
						<%
							if(!"0".equals(showOrUpdate)){
						%>
						<!-- 董事姓名 -->
						<span>
								<%=rs.getString("officename") %>
						</span>
						<%
							}else{
						%>
								<%=rs.getString("officename") %>
						<% 
							}
						%>
					</td>
					<td width="17%" >
						<!-- 开始时间 -->
							&nbsp;
							<INPUT  type=hidden value="<%=rs.getString("officebegindate") %>" id="officebegindate_input<%=ix%>">
							<span id="officebegindate_span<%=ix%>">
									<%=rs.getString("officebegindate") %>
							</span>
							
					</td>
					<td width="17%" >
						<!-- 结束时间 -->
						&nbsp;
						<INPUT  type=hidden  value="<%=rs.getString("officeenddate") %>" id="officeenddate_input<%=ix%>">
						<span id="officeenddate_span<%=ix%>">
									<%=rs.getString("officeenddate") %>
						</span>
					</td>
					<td width="8%" >
                        <%="1".equals( rs.getString("isstop"))?"是":"否" %>
					</td>
					<td width="20%" >
						<%=rs.getString("remark") %>
					</td>
				</tr>
				<%
					ix++;}
				 %>
			</table>
		</div>
		
		<!-- 监事会成员 -->
		<div class="border17 FL PTop10 OHeaderLayerW6 ML33">

			<ul class="ONav FL cBlue">
				<li>
					<a href="#" class="hover">
						<div>
							<div>
								<%=SystemEnv.getHtmlLabelName(31002,user.getLanguage()) %>
							</div>
						</div> </a>
				</li>
				<select id="selectdate03" onchange="javascript:searchzhzhdate2js(this);" class="OSelect MT3 MLeft8">
				</select>
			</ul>
			<div class="clear"></div>

		</div>
		<div class="FL ML33" style="<%=fromNEWPAGE?"":"height:25px;width:630px;" %>">
		<table width="614" border="0" cellpadding="0" cellspacing="1"
			class="stripe OTable">
			<tr id="OTable2" class="cBlack">
				<td width="4%" align="center">
					<%
							if(!"0".equals(showOrUpdate)){
					%>
					<%
						}
					 %>
				</td>
				<td width="16%" align="center">
					<strong><%=SystemEnv.getHtmlLabelName(30999,user.getLanguage()) %></strong>
				</td>
				<td width="18%" align="center">
					<strong><%=SystemEnv.getHtmlLabelName(31003,user.getLanguage()) %></strong>
				</td>
				<td width="17%" align="center">
					<strong><%=SystemEnv.getHtmlLabelName(24978,user.getLanguage()) %></strong>
				</td>
				<td width="17%" align="center">
					<strong><%=SystemEnv.getHtmlLabelName(22326,user.getLanguage()) %></strong>
				</td>
				<td width="8%" align="center">
					<strong><%=SystemEnv.getHtmlLabelName(31001,user.getLanguage()) %></strong>
				</td>
				<td width="20%" align="center">
					<strong><%=SystemEnv.getHtmlLabelName(26408,user.getLanguage()) %></strong>
				</td>
			</tr>
		</table>
		<div class="FR" style="height:24px;width:16px;background-color:#eeeeee; margin-top:-26px"></div>
		</div>
		<div class="OContRightScroll FL OHeaderLayerW6 ML33" style="<%=fromNEWPAGE?"":"height:56px;" %>">
			<table id="webTable2jsh" width="614" border="0" cellpadding="0" cellspacing="1"
				class="stripe OTable">
				<%
					jssql="select t2.* from CPBOARDDIRECTORS t1,CPBOARDSUPER t2 where t1.directorsid = t2.directorsid and t1.companyid = " + companyid +" order by t2.isstop desc,t2.SUPERBEGINDATE asc";
					rs.execute(jssql);
					jsix=1;
					while (rs.next()){
					//System.out.println(Util.null2String(rs.getString("officebegindate")).substring(0,4));
					String valuedate = "";
					if(!Util.null2String(rs.getString("SUPERBEGINDATE")).equals(""))
					valuedate = rs.getString("SUPERBEGINDATE").substring(0,4);
				 %>
				<tr dbvalue="<%=valuedate %>">
					<td width="4%"  align="center">
						<%
							if(!"0".equals(showOrUpdate)){
						%>
						<%
							}
						 %>
					</td>
					<td width="16%" >
						&nbsp;
						<%
							if(!"0".equals(showOrUpdate)){
						%>
						<span>
								<%=rs.getString("sessions") %>
						</span>
						<%
							}else{
						%>
							<%=rs.getString("sessions") %>
						<%
							}
						 %>
					</td>
					<td width="18%" >
							&nbsp;
							<%
							if(!"0".equals(showOrUpdate)){
						%>
						<span>
								<%=rs.getString("SUPERNAME") %>
						</span>
						<%
							}else{
						%>
							<%=rs.getString("SUPERNAME") %>
						<%
							}
						 %>
						
					</td>
					<td width="17%" >
							<!-- 开始时间 -->
							&nbsp;
							<INPUT  type=hidden value="<%=rs.getString("SUPERBEGINDATE") %>"  id="superbegindate_input<%=jsix%>">
							<span  id="superbegindate_span<%=jsix%>">
									<%=rs.getString("SUPERBEGINDATE") %>
							</span>
					</td>
					<td width="17%" >
							<!-- 结束时间 -->
							&nbsp;
							<INPUT  type=hidden  value="<%=rs.getString("SUPERENDDATE") %>"  id=superenddate_input<%=jsix%>>
							<span  id=superenddate_span<%=jsix%>>
									<%=rs.getString("SUPERENDDATE") %>
							</span>
					</td>
					<td width="8%" >
                        <%="1".equals(rs.getString("isstop"))?"是":"否"  %>
					</td>
					<td width="20%" >
						<%=rs.getString("remark") %>
					</td>
				</tr>
				<%
					jsix++;}
				 %>
			</table>
		</div>
		
		<table width="620" border="0" <%=fromNEWPAGE?"":"align='center'"%> cellpadding="0"  cellspacing="0" class="PTop5">

			<tr>
				<td height="25" align="left" vAlign="top"><strong>附件：</strong></td>
		    	<td align="left"  colspan="3">
		    		<%if(!CompanyInfoTransMethod.CheckPack("4")){out.println("<span style='color:red'>"+SystemEnv.getHtmlLabelName(31004,user.getLanguage()) +"！</span>");}%>
					<div id="licenseAffixUpload" style="display: none;" >
					<input type="hidden" name="affixdoc" id="affixdoc">
						<span> 
							<span id='spanButtonPlaceHolder'></span><!--选取多个文件-->
						</span>
						&nbsp;&nbsp;
						<span style="color: #262626; cursor: hand; TEXT-DECORATION: none;<%if(!CompanyInfoTransMethod.CheckPack("4")){out.println("display: none;");}%>"
							disabled id="btnCancel_upload">
							<span><img src="/js/swfupload/delete.gif" border="0" onClick="oUploader.cancelQueue()"> </span> <span
							style="height: 19px"> <font style="margin: 0 0 0 -1"><%=SystemEnv.getHtmlLabelName(21407,user.getLanguage()) %>
							(<%=SystemEnv.getHtmlLabelName(18976,user.getLanguage()) %>100<%=SystemEnv.getHtmlLabelName(18977,user.getLanguage()) %>)
							</font> <!--清除所有--> </span> </span>
						<div id="divImgsAddContent" style="overflow: auto;">
							<div></div>
							<div class="fieldset flash" id="fsUploadProgress"></div>
							<div id="divStatus"></div>
						</div>
					</div>
						<div id="affixcpdosDIV">
						<%
							userid = user.getUID();
							affixdoc = "";
							affixsql = " select drectorsaffix from CPBOARDDIRECTORS where companyid = " + companyid;
							rs.execute(affixsql);
							if(rs.next()){
								affixdoc = Util.null2String(rs.getString("drectorsaffix"));
							}
							isdoc="";
							if(!"".equals(affixdoc))
							{
								
								DocComInfo dc=new DocComInfo();						
								String []slaves=affixdoc.split(",");
								for(int i=0;i<slaves.length;i++)
								{
									String tempid="asid"+slaves[i];
								
									out.println("<div id='imgfileDiv"+i+"' style='background-color: #F7F7F7;height:20px;padding-left:4px;border: solid 1px #E8E8E8;padding: 4px;margin-bottom: 5px;'>");
								
									String filename="";
									String fileid="";
									rs.execute("select imagefileid,imagefilename from imagefile where imagefileid = "+slaves[i]);
									if(rs.next()){
										filename = rs.getString("imagefilename");
										fileid= rs.getString("imagefileid");
									}
									out.println("<div style='width:80%;float:left;' >");
									String str="<A id='pdflinkid"+i+"' href='/weaver/weaver.file.FileDownload?fileid="+fileid+"&download=1' class='aContent0 FL'>"+filename+"</A>";
									//输出文档主题，提供下载
									out.println(str);
									out.println("</div>");
									
									//out.println("<div style='width:40%;float:left;'>");
									//输出文档创建时间
									//out.println(dc.getDocCreateTime(slaves));
									//out.println("</div>");
									
									
									out.println("<div style='padding-right:0px;float:right;padding-top:0px'>");
									
									//out.println("文档创建着id"+dc.getDocCreaterid(slaves[i]));
									//getDocOwnerid
									
									//if(dc.getDocCreaterid(slaves[i]).equals(userid+""))//当前用户是文档的创建者
								//	{		
										//输出删除文档超链接												
										//isdoc = "affixdoc";
										//out.println("<img src='images/delwk.gif' onclick=delImg(imgfileDiv"+i+","+slaves[i]+") title='删除'></a>");
									//}else
									//{
										//输出下载文档超链接									
									
										out.println("<a href='/weaver/weaver.file.FileDownload?fileid="+fileid+"&download=1'><img src='../images/downLoadPic.gif'  title='下载'  ></a>");
										if(!"0".equals(showOrUpdate)){
//											out.println("<img src='images/delwk.gif' onclick=delImg(imgfileDiv"+i+","+slaves[i]+") title='删除'></a>");
										}
									//}
									
									out.println("</div>");					
									out.println("</div>");
								}
							}
									
				
						%>
						</div>
		    	</td>
		  	</tr>
		</table>
		
	</div>
</div>
<!--表头浮动层 end-->

<div id="hiddenTrInDIV" style="display:none">


		<span _calss="show">
			<input type="checkbox" name="checkbox" inWhichPage="dsh" onclick="selectone_chk()"/>
		</span>
		<span _calss="show">
			&nbsp;
			<input type="text"  style=" width:60px; height:20px; line-height:20px;  background-image:none; text-align:center;" onblur="displayimg(this)" />
			<span>
					<IMG align=absMiddle src='/images/BacoError.gif'>
			</span>
		</span>
		<span _calss="show">
			&nbsp;
			<input type="text" style=" width:80px; height:20px; line-height:20px;    background-image:none; text-align:center;" onblur="displayimg(this)" />
			<span>
					<IMG align=absMiddle src='/images/BacoError.gif'>
			</span>
		</span>
		<span _calss="show">
			<!-- 开始时间 -->
			&nbsp;&nbsp;
			<BUTTON class=Clock   name="hidebegindate01"   type="button"></BUTTON>
			<INPUT  type=hidden>
			<span>
					<IMG align=absMiddle src='/images/BacoError.gif'>
			</span>
		</span>
		<span _calss="show">
			<!-- 结束时间 -->
			&nbsp;&nbsp;
			<BUTTON class=Clock   name="hideenddate01"   type="button"></BUTTON>
			<INPUT  type=hidden>
			<span>
					<IMG align=absMiddle src='/images/BacoError.gif'>
			</span>
		</span>
		<span _calss="show">
			<select style=" width:48px; height:26px;border:0px; ">
				<option value="2"><%=SystemEnv.getHtmlLabelName(30587,user.getLanguage())  %></option>
				<option value="1"><%=SystemEnv.getHtmlLabelName(30586,user.getLanguage())  %></option>
			</select>
		</span>
		<span _calss="show">
			<input type="text"  style=" width:110px; height:20px; line-height:20px;  background-image:none; text-align:center;" />
		</span>
	
	
</div>
<div id="hiddenTrInDIV2js" style="display:none">


 
 
		<span _calss="show">
				&nbsp;
 				<input type="checkbox" name="checkbox" inWhichPage="jsh" onclick="selectone_chk2js()"/>
 		</span>
		<span _calss="show">
				&nbsp;
			<input type="text"  style=" width:60px; height:20px; line-height:20px;  background-image:none; text-align:center;" onblur="displayimg(this)" />
			<span>
					<IMG align=absMiddle src='/images/BacoError.gif'>
			</span>
		 </span>
		 <span _calss="show">
		 		&nbsp;
			<input type="text" style=" width:80px; height:20px; line-height:20px;    background-image:none; text-align:center;" onblur="displayimg(this)" />
			<span>
					<IMG align=absMiddle src='/images/BacoError.gif'>
			</span>
		 </span>
		<span _calss="show">
				<!-- 开始时间 -->
				&nbsp;&nbsp;
				<BUTTON class=Clock   name="hidebegindate02"   type="button"></BUTTON>
				<INPUT  type=hidden>
				<span>
					<IMG align=absMiddle src='/images/BacoError.gif'>
				</span>
		 </span>
		<span _calss="show">
				<!-- 结束时间 -->
				&nbsp;&nbsp;
				<BUTTON class=Clock   name="hideenddate02"   type="button"></BUTTON>
				<INPUT  type=hidden>
				<span>
					<IMG align=absMiddle src='/images/BacoError.gif'>
				</span>
		 </span>
		 <span _calss="show">
			<select style=" width:48px; height:26px;border:0px; ">
				<option value="2"><%=SystemEnv.getHtmlLabelName(30587,user.getLanguage())  %></option>
				<option value="1"><%=SystemEnv.getHtmlLabelName(30586,user.getLanguage())  %></option>
			</select>
		 </span>
		<span _calss="show">
			<input type="text"  style=" width:110px; height:20px; line-height:20px;  background-image:none; text-align:center;" />
		 </span>
		
</div>

<!-- 证照弹出层 -->

<div style="clear:both;display:none" id="licenseDiv">
	<div id="wBox" style="top:80px;left:400px;"><!-- 定义层在什么位置上 -->
		<div class="wBox_popup">
    		<table>
    			<tbody>
    				<tr><td class="wBox_tl"/><td class="wBox_b"/><td class="wBox_tr"/></tr>
    				<tr><td class="wBox_b"></td>
    					<td>
		   					<div class="wBox_body">
		       					<table class="wBox_title">
		       						<tr>
		          						<td class="wBox_dragTitle"><div class="wBox_itemTitle"><%=SystemEnv.getHtmlLabelName(31006,user.getLanguage())  %></div></td>
		          						<td width="20px" title="关闭" onclick="javascript:onLicenseDivClose();"><div class="wBox_close"></div></td>
		       						</tr>
		     					</table>
		     					<div class="wBox_content" id="wBoxContent" style="width:335px;height:325px;overflow-y:auto;">
		      					<!-- 定义层里面的内容 -->
		     					</div>
		   					</div>
        				</td>
        				<td class="wBox_b"></td></tr>
        			<tr><td class="wBox_bl"></td><td class="wBox_b"></td><td class="wBox_br"></td></tr>
        		</tbody>
        	</table>
   		</div>
	</div>
</div> 
 <!-- 遮罩层 start -->
<div id='wBox_overlay' class='wBox_hide' style="clear:both;"></div>
<!-- 遮罩层 end --> 

<script type="text/javascript">
	jQuery(document).ready(function(){
		var o4params = {
			method:"get",
			companyid:"<%=companyid%>"
		}
		
		jQuery.post("/cpcompanyinfo/action/CPBoardDirectorsOperate.jsp",o4params,function(data){
			var dsh_add = data[0];
			jQuery("#method_dsh").val(dsh_add);
			if(dsh_add=="add"){
				jQuery("#spanTitle_dsh").html("<%=SystemEnv.getHtmlLabelName(31007,user.getLanguage())  %>");
				<%if("0".equals(showOrUpdate)){%>jQuery("#spanTitle_dsh").html("<%=SystemEnv.getHtmlLabelName(31148,user.getLanguage()) %>");<%}%>
				jQuery(":text[id$='_dsh']").val("");		//清空文本框文
				jQuery(".OSelect").val("1");	//选择框复原
			}else{
				jQuery("#spanTitle_dsh").html("<%=SystemEnv.getHtmlLabelName(31008,user.getLanguage())  %>");
				<%if("0".equals(showOrUpdate)){%>jQuery("#spanTitle_dsh").html("<%=SystemEnv.getHtmlLabelName(31148,user.getLanguage()) %>");<%}%>
				jQuery("#directorsid").val(data[1]["directorsid"]);
				jQuery("#chairman_dsh").html(data[1]["chairman"]);
				
				jQuery("#appointbegindate_dsh").html(data[1]["appointbegindate"]);
				jQuery("#appbegintime").val(data[1]["appointbegindate"]);
				jQuery("#appointenddate_dsh").html(data[1]["appointenddate"]);
				jQuery("#appendtime").val(data[1]["appointenddate"]);
				
				jQuery("#appointduetime_dsh").val(data[1]["appointduetime"]);
				jQuery("#supervisor_dsh").val(data[1]["supervisor"]);
				jQuery("#generalmanager_dsh").html(data[1]["generalmanager"]);
				jQuery("#ischairman_dsh").val(data[1]["ischairman"]);
                if(data[1]["ischairman"]=="2"){
                    jQuery("#ischairman_dsh").html("<%=SystemEnv.getHtmlLabelName(30997,user.getLanguage()) %>");
                }else{
                    jQuery("#ischairman_dsh").html("<%=SystemEnv.getHtmlLabelName(30996,user.getLanguage()) %>");
                }
				jQuery("#faren").html(data[1]["faren"]);
				jQuery("#affixdoc").val(data[1]["drectorsaffix"]);
				
				jQuery("#managerbegindate_dsh").html(data[1]["managerbegindate"]);
				jQuery("#manbegintime").val(data[1]["managerbegindate"]);
				
				jQuery("#managerenddate_dsh").html(data[1]["managerenddate"]);
				jQuery("#manendtime").val(data[1]["managerenddate"]);
				
				
				
				jQuery("#managerduetime_dsh").val(data[1]["managerduetime"]);
			}
		},"json");
		
		/*灰色、默认初始化值*/
		jQuery("#companyname_indsh").val("<%=companyname%>");
		jQuery("#corporation_indsh").val("<%=corporation%>");
		jQuery("#usefulbegindate_indsh").val("<%=usefulbegindate%>");
		jQuery("#usefulenddate_indsh").val("<%=usefulenddate%>");
		jQuery("#usefulyear_indsh").val("<%=usefulyear%>");
		
		//保存按钮指向保存方法
		jQuery("#saveBoardDirectorsBtn").attr("href","javascript:saveDate();");
		
		var now = new Date();
		var currentYear = now.getFullYear();
		var selectdateoptions = '';
		var selectdateoptions2 = '';
        selectdateoptions2+= "<option value=''>"+"全部"+"</option>";
		for(xx=0;xx<=currentYear-1990;xx++){
			selectdateoptions+= "<option value='"+(currentYear-xx)+"'>"+(currentYear-xx)+"</option>";
			selectdateoptions2+= "<option value='"+(currentYear-xx)+"'>"+(currentYear-xx)+"</option>";
		}
		jQuery("#selectdate01").html(selectdateoptions);
		jQuery("#selectdate03").html(selectdateoptions);
		jQuery("#gdh_selectdate01").html(selectdateoptions2);
		<%
		
			if("0".equals(showOrUpdate)){
		%>
				jQuery(".Clock").hide();
				jQuery(".OInput2").removeClass("OInput2").addClass("OInput3").focus(function(){this.blur();});
				jQuery("select").attr("disabled","disabled");  
				jQuery("#save_H").hide();
				jQuery("#webTable2dsh").attr("disabled","disabled");  
				jQuery("#webTable2jsh").attr("disabled","disabled");  
				jQuery("#licenseAffixUpload").hide();
		<%
			}
		%>

        searchzhzhdate_gdh(document.getElementById("gdh_selectdate01") );
		
	});
	
	function searchzhzhdate(o4this){
		var obj = jQuery("#webTable2dsh").find("tr");
		for(i=0;i<obj.size();i++){
			
			if(jQuery(o4this).val()==jQuery(obj[i]).attr("dbvalue"))
				jQuery(obj[i]).show();
			else
				jQuery(obj[i]).hide();
		}
	}
    function searchzhzhdate_gdh(o4this){
        var obj = jQuery("#webTable2gd").find("tr");
        var dateval=jQuery(o4this).val();
        for(i=0;i<obj.size();i++){

            if(dateval==jQuery(obj[i]).attr("dbvalue")||dateval=="")
                jQuery(obj[i]).show();
            else
                jQuery(obj[i]).hide();
        }
    }
	
	function searchzhzhdate2js(o4this){
		var obj = jQuery("#webTable2jsh").find("tr");
		for(i=0;i<obj.size();i++){
			
			if(jQuery(o4this).val()==jQuery(obj[i]).attr("dbvalue"))
				jQuery(obj[i]).show();
			else
				jQuery(obj[i]).hide();
		}
	}
	
	/*保存 董事会*/
	function saveBoardDirectors() 
	{
		
		jQuery("#saveBoardDirectorsBtn").attr("href","javascript:void(0);");	//不让保存重复点击
		var trsize2dsh = jQuery("#webTable2dsh tr").length;
		var Alist2dsh = new Array();
		var strjsonArr="";
		
		
		jQuery('#webTable2dsh tr').each(function (i) { 
				var Blist2dsh = new Array();
				var sessions="";
				var officename="";
				var officebegindate="";
				var officeenddate="";
				var isstop="";
				var remark="";
				jQuery(this).children('td').each(function (j){
						if(j==1){
							sessions=jQuery(this).find("input").val();
						}else if(j==2){
							officename=jQuery(this).find("input").val();
						}else if(j==3){
							officebegindate=jQuery(this).find("input").val();
						}else if(j==4){
							officeenddate=jQuery(this).find("input").val();
						}else if(j==5){
							isstop=jQuery(this).find("select").val();
						}else if(j==6){
							remark=jQuery(this).find("input").val();
						}
				});
				Blist2dsh[0] = "";
				Blist2dsh[1] = sessions;
				Blist2dsh[2] = officename;
				Blist2dsh[3] = officebegindate;
				Blist2dsh[4] = officeenddate;
				Blist2dsh[5] = isstop;
				Blist2dsh[6] = remark;
				Alist2dsh[i] = Blist2dsh;
           	});
           	//组装json数组字符串
           	
			if(Alist2dsh.length>0){
			
			strjsonArr="{";
			for(var x=0;x<trsize2dsh;x++){
				strjsonArr+="'tr"+x+"':{";
				strjsonArr+="'sessions':'"+Alist2dsh[x][1]+"',";
				strjsonArr+="'officename':'"+Alist2dsh[x][2]+"',";
				strjsonArr+="'officebegindate':'"+Alist2dsh[x][3]+"',";
				strjsonArr+="'officeenddate':'"+Alist2dsh[x][4]+"',";
				strjsonArr+="'isstop':'"+Alist2dsh[x][5]+"',";
				strjsonArr+="'remark':'"+Alist2dsh[x][6]+"'";
				if(x==trsize2dsh-1)strjsonArr+="}";
				else strjsonArr+="},";
			}
			strjsonArr+="}";
		}
		
		
		
		var trsize2jsh = jQuery("#webTable2jsh tr").length;
		var Alist2jsh = new Array();
		var strjsonArr2js="";
		jQuery('#webTable2jsh tr').each(function (i) { 
			var Blist2jsh = new Array();
			var sessions="";
			var supername="";
			var superbegindate="";
			var superenddate="";
			var isstop="";
			var remark="";
				
			jQuery(this).children('td').each(function (j){
					if(j==1){
								sessions=jQuery(this).find("input").val();
					}else if(j==2){
						supername=jQuery(this).find("input").val();
					}else if(j==3){
						superbegindate=jQuery(this).find("input").val();
					}else if(j==4){
						superenddate=jQuery(this).find("input").val();
					}else if(j==5){
						isstop=jQuery(this).find("select").val();
					}else if(j==6){
						remark=jQuery(this).find("input").val();
					}
				
			});
				Blist2jsh[0] = "";
				Blist2jsh[1] = sessions;
				Blist2jsh[2] = supername;
				Blist2jsh[3] = superbegindate;
				Blist2jsh[4] = superenddate;
				Blist2jsh[5] = isstop;
				Blist2jsh[6] = remark;
				
               	Alist2jsh[i] = Blist2jsh;
           	});
           	//组装json数组字符串
			
			if(Alist2jsh.length>0){
			strjsonArr2js="{";
			for(var x=0;x<trsize2jsh;x++){
				strjsonArr2js+="'tr"+x+"':{";
				strjsonArr2js+="'sessions':'"+Alist2jsh[x][1]+"',";
				strjsonArr2js+="'supername':'"+Alist2jsh[x][2]+"',";
				strjsonArr2js+="'superbegindate':'"+Alist2jsh[x][3]+"',";
				strjsonArr2js+="'superenddate':'"+Alist2jsh[x][4]+"',";
				strjsonArr2js+="'isstop':'"+Alist2jsh[x][5]+"',";
				strjsonArr2js+="'remark':'"+Alist2jsh[x][6]+"'";
				if(x==trsize2jsh-1)strjsonArr2js+="}";
				else strjsonArr2js+="},";
			}
			strjsonArr2js+="}";
		}
		
		var o4params = {
			method:jQuery("#method_dsh").val(),
			isaddversion:jQuery("#isaddversion").val(),
			companyid:"<%=companyid%>",
			directorsid:jQuery("#directorsid").val(),
			chairman:encodeURI(jQuery("#chairman_dsh").val()),
			faren:encodeURI(jQuery("#faren").val()),
			appointbegindate:encodeURI(jQuery("#appbegintime").val()),
			appointenddate:encodeURI(jQuery("#appendtime").val()),
			appointduetime:encodeURI(jQuery("#appointduetime_dsh").val()),
			supervisor:encodeURI(jQuery("#supervisor_dsh").val()),
			generalmanager:encodeURI(jQuery("#generalmanager_dsh").val()),
			ischairman:encodeURI(jQuery("#ischairman_dsh").val()),
			data:encodeURI(strjsonArr),
			data2js:encodeURI(strjsonArr2js),
			affixdoc:encodeURI(jQuery("#affixdoc").val()),
			
			versionnum:encodeURI(jQuery("#versionnum").val()),
			versionname:encodeURI(jQuery("#versionname").val()),
			versionmemo:encodeURI(jQuery("#versionmemo").val()),
			versionaffix:"",
			date2Version:encodeURI(jQuery("#versionTime").val()),
			managerbegindate:encodeURI(jQuery("#manbegintime").val()),
			managerenddate:encodeURI(jQuery("#manendtime").val()),
			managerduetime:encodeURI(jQuery("#managerduetime_dsh").val())
		}
	 	jQuery.post("/cpcompanyinfo/action/CPBoardDirectorsOperate.jsp",o4params,function(data){
					if(jQuery.trim(data)!="0"){
							alert(data);
					}

            if("<%=fromNEWPAGE %>"=="true"){
                alert("保存完成!");
                window.location.href=window.location.href;
            }else{
                closeMaint4Win();
            }
		}); 
	}
	function displayimg(obj){
		if(jQuery.trim(jQuery(obj).val())!=""){
			jQuery(obj).parent().find("img").css("display","none");
		}else{
			jQuery(obj).parent().find("img").css("display","");
		}
	}
	/*验证是否通过、通过后方保存*/
	function checkForm(typepage)
	{
		var ischecked = false;
		if(!jQuery.trim(jQuery("#chairman_dsh").val())==""
			&&!jQuery.trim(jQuery("#faren").val())==""
			&&!jQuery.trim(jQuery("#generalmanager_dsh").val())==""
		){
			ischecked = true;
		}
		jQuery("#webTable2dsh").find("img[align='absMiddle'][display!='none']").each(function (){
			if(!$(this).is(":hidden")){
				ischecked=false;
			}
		})
		jQuery("#webTable2jsh").find("img[align='absMiddle'][display!='none']").each(function (){
			if(!$(this).is(":hidden")){
				ischecked=false;
			}
		})
		return ischecked;
	}
	
	/* 关闭 已打开的面板 */
	function closeMaint4Win()
	{
		jQuery("a[typepage='dsh']").qtip('hide');
		jQuery("a[typepage='dsh']").qtip('destroy');
		//回调刷新界面数据
		refsh();
	}
	
	//全部选择操作，复选框
	function selectall_chk(Tcheck){
	   if(Tcheck.checked==true){
	      $("input[type=checkbox][inWhichPage='dsh']").each(function(){
				 $(this).attr("checked",true);
		  });
	   }else{
		  $("input[type=checkbox][inWhichPage='dsh']").each(function(){
				 $(this).attr("checked",false);
		  });
	   }
	}
	//全部选择操作，复选框
	function selectall_chk2js(Tcheck){
	   if(Tcheck.checked==true){
	      $("input[type=checkbox][inWhichPage='jsh']").each(function(){
				 $(this).attr("checked",true);
		  });
	   }else{
		  $("input[type=checkbox][inWhichPage='jsh']").each(function(){
				 $(this).attr("checked",false);
		  });
	   }
	}
	 
	 
	//选中其中的一个
	function selectone_chk(){
	    jQuery("#fileid").attr("checked",false); 
	}
	//选中其中的一个
	function selectone_chk2js(){
	    jQuery("#fileid2js").attr("checked",false); 
	}
	/*增加一行tr*/
	function doadd_dsh(){
	
		var trhrml="<tr height=30px >";
		jQuery("#hiddenTrInDIV").find("span[_calss='show']").each(function(i){
						var temp=jQuery(this).html();
						if(i==0){
							trhrml+="<td width=\"4%\" align='center' >";
						}else if(i==1){
							trhrml+="<td width=\"16%\">";
						}else if(i==2){
							trhrml+="<td width=\"18%\">";
						}else if(i==3){
							trhrml+="<td width=\"17%\" >";
						}else if(i==4){
							trhrml+="<td width=\"17%\">";
						}else if(i==5){
							trhrml+="<td  width=\"8%\" >";
						}else if(i==6){
							trhrml+="<td  width=\"20%\" >";
						}
						trhrml+=temp;
						trhrml+="</td>";
		})
		trhrml+="</tr>";
		
		jQuery("#webTable2dsh").append(trhrml);
		jQuery("#webTable2dsh").find("tr").find("td").find("button[name='hidebegindate01']").each(function(){
				$(this).attr("name","");//给name赋值，防止下次循环又找到他
				$(this).click(function (){
						//gettheDate这个方法只接受普通对象，不能把jquery对象传进去
						onShowDate($(this).next().next()[0],$(this).next()[0]);
				})
		});
		jQuery("#webTable2dsh").find("tr").find("td").find("button[name='hideenddate01']").each(function(){
				$(this).attr("name","");//给name赋值，防止下次循环又找到他
				$(this).click(function (){
						//gettheDate这个方法只接受普通对象，不能把jquery对象传进去
						onShowDate($(this).next().next()[0],$(this).next()[0]);
				})
		});
		
		
	}
	/*增加一行tr*/
	function doadd_jsh(){
	
		var trhrml="<tr height=30px >";
		jQuery("#hiddenTrInDIV2js").find("span[_calss='show']").each(function(i){
						var temp=jQuery(this).html();
						if(i==0){
							trhrml+="<td width=\"4%\" align='center' >";
						}else if(i==1){
							trhrml+="<td width=\"16%\">";
						}else if(i==2){
							trhrml+="<td width=\"18%\">";
						}else if(i==3){
							trhrml+="<td width=\"17%\">";
						}else if(i==4){
							trhrml+="<td width=\"17%\">";
						}else if(i==5){
							trhrml+="<td  width=\"8%\">";
						}else if(i==6){
							trhrml+="<td  width=\"20%\">";
						}
						trhrml+=temp;
						trhrml+="</td>";
		})
		trhrml+="</tr>";
		
		jQuery("#webTable2jsh").append(trhrml);
		jQuery("#webTable2jsh").find("tr").find("td").find("button[name='hidebegindate02']").each(function(){
				$(this).attr("name","");//给name赋值，防止下次循环又找到他
				$(this).click(function (){
						//gettheDate这个方法只接受普通对象，不能把jquery对象传进去
						onShowDate($(this).next().next()[0],$(this).next()[0]);
				})
		});
		jQuery("#webTable2jsh").find("tr").find("td").find("button[name='hideenddate02']").each(function(){
				$(this).attr("name","");//给name赋值，防止下次循环又找到他
				$(this).click(function (){
						//gettheDate这个方法只接受普通对象，不能把jquery对象传进去
						onShowDate($(this).next().next()[0],$(this).next()[0]);
				})
		});
	}
	/*删除一行或多行*/
	function dodel_dsh(){
		var _temp=0;
			jQuery('#webTable2dsh tr').each(function(){
			if(jQuery(this).children('td').find("input[type=checkbox]").attr("checked")==true){
				_temp++;
			}
		});
		if(_temp<=0){
				alert("<%=SystemEnv.getHtmlLabelName(22686,user.getLanguage()) %>!");
		}else {
					var truth4Told = window.confirm("<%=SystemEnv.getHtmlLabelName(30695,user.getLanguage()) %>?"); 
					if(truth4Told){
								jQuery('#webTable2dsh tr').each(function(){
							if(jQuery(this).children('td').find("input[type=checkbox]").attr("checked")==true){
								jQuery(this).remove();
							}
						});
					}else{
					
					}
		}
	}
	
	/*删除一行或多行*/
	function dodel_jsh(){
		var _temp=0;
			jQuery('#webTable2jsh tr').each(function(){
			if(jQuery(this).children('td').find("input[type=checkbox]").attr("checked")==true){
				_temp++;
			}
		});
		if(_temp<=0){
				alert("<%=SystemEnv.getHtmlLabelName(22686,user.getLanguage()) %>!");
		}else {
					var truth4Told = window.confirm("<%=SystemEnv.getHtmlLabelName(30695,user.getLanguage()) %>?"); 
					if(truth4Told){
							jQuery('#webTable2jsh tr').each(function(){
							if(jQuery(this).children('td').find("input[type=checkbox]").attr("checked")==true){
								jQuery(this).remove();
							}
						});
					}else{
					
					}
		}
		
	}
	function opinionStartTimeEndTime( stratTime , endTime ){
	      var strat = stratTime.split( "-" );
	      var end = endTime.split( "-" );
	      var sdate=new Date(strat[0],strat[1],strat[2]);
	      var edate=new Date(end[0],end[1],end[2]);
	      if(sdate.getTime()>edate.getTime()){
	        return false;
	      }
	      return true;
    }
    
	function saveDate(){
	
		var begintime=jQuery.trim(jQuery("#appbegintime").val());
		var endtime=jQuery.trim(jQuery("#appendtime").val());
		if(""!=begintime&&""!=endtime){
			if(opinionStartTimeEndTime(begintime,endtime)==false){
					alert("<%=SystemEnv.getHtmlLabelName(31191,user.getLanguage())  %>!");
					return;
			}
		}
		
		var begintime02=jQuery.trim(jQuery("#manbegintime").val());
		var endtime02=jQuery.trim(jQuery("#manendtime").val());
		if(""!=begintime02&&""!=endtime02){
			if(opinionStartTimeEndTime(begintime02,endtime02)==false){
					alert("<%=SystemEnv.getHtmlLabelName(31191,user.getLanguage())  %>!");
					return;
			}
		}
		
		var check=0;
		jQuery('#webTable2dsh tr').each(function (i) { 
			 var $td = jQuery(this).children('td');
			 var atime=$td.eq(3).find("input[type=hidden]").val(); //第一个td的内容
			 var btime=$td.eq(4).find("input[type=hidden]").val();  //第一个td的内容
			 if(""!=atime&&""!=btime){
				 if(opinionStartTimeEndTime(atime,btime)==false){
					check++;
				 }
			}
		});
		if(check>0){
					alert("<%=SystemEnv.getHtmlLabelName(31189,user.getLanguage())%>!");
					return;
		}
		var check02=0;
		jQuery('#webTable2jsh tr').each(function (i) { 
			 var $td = jQuery(this).children('td');
			 var atime=$td.eq(3).find("input[type=hidden]").val(); //第一个td的内容
			 var btime=$td.eq(4).find("input[type=hidden]").val();  //第一个td的内容
			 if(""!=atime&&""!=btime){
					 if(opinionStartTimeEndTime(atime,btime)==false){
						check02++;
					  }
			  }
		});
		if(check02>0){
					alert("<%=SystemEnv.getHtmlLabelName(31190,user.getLanguage())%>!");
					return;
		}
				
				
				
		jQuery("#saveBoardDirectorsBtn").attr("href","javascript:void(0);");	//不让保存重复点击
		if(checkForm()){
			var truthBeTold = window.confirm("<%=SystemEnv.getHtmlLabelName(31009,user.getLanguage()) %>！"); 
			if (truthBeTold) { 
				onversionAddDivOpen();
			} else {
				var truth4Told = window.confirm("<%=SystemEnv.getHtmlLabelName(31010,user.getLanguage()) %>？"); 
				if(truth4Told){
					StartUploadAll();
					checkuploadcomplet();
				}else{
					jQuery("#saveBoardDirectorsBtn").attr("href","javascript:saveDate();");	//恢复保存按钮
				}
			}
		}
		else
		{
			alert("<%=SystemEnv.getHtmlLabelName(15859,user.getLanguage()) %>！");
			jQuery("#saveBoardDirectorsBtn").attr("href","javascript:saveDate();");	//恢复保存按钮
		}
	} 
	
	
	/*打开版本管理页面*/
	function openVersionManage(){
		jQuery("#wBoxContent").html("");
		jQuery("#wBox").css("top","130px").css("left","190px");
		jQuery("#wBoxContent").css("width","476px").css("height","225px");
		jQuery(".wBox_itemTitle").html("<%=SystemEnv.getHtmlLabelName(19450,user.getLanguage()) %>");
		jQuery("#wBoxContent").load("/cpcompanyinfo/CompanyVersionManage.jsp?directorsid="+jQuery("#directorsid").val()+"&oneMoudel=director&showOrUpdate=<%=showOrUpdate%>");
		jQuery("#wBox_overlay").removeClass("wBox_hide").addClass("wBox_overlayBG");
		jQuery("#licenseDiv").css("display","");
	}
	
	/*打开版本新增DIV*/
	function onversionAddDivOpen(){
		jQuery("#wBoxContent").html("");
		jQuery("#wBox").css("top","130px").css("left","330px");
		jQuery("#wBoxContent").css("width","335px").css("height","225px");
		jQuery(".wBox_itemTitle").html("<%=SystemEnv.getHtmlLabelName(31011,user.getLanguage()) %>");
		jQuery("#wBoxContent").load("CompanyVersionMaint.jsp?directorsid="+jQuery("#directorsid").val()+"&oneMoudel=director&companyid=<%=companyid%>");
		jQuery("#wBox_overlay").removeClass("wBox_hide").addClass("wBox_overlayBG");
		jQuery("#licenseDiv").css("display","");
	}
	
	/*关闭选择证照DIV*/
	function onLicenseDivClose() {
		jQuery("#wBox_overlay").removeClass("wBox_overlayBG").addClass("wBox_hide");
		jQuery("#licenseDiv").css("display","none");
		jQuery("#saveBoardDirectorsBtn").attr("href","javascript:saveDate();");	//恢复保存按钮
	} 
	
	function onLicenseDivCloseNoSave(){
		jQuery("#wBox_overlay").removeClass("wBox_overlayBG").addClass("wBox_hide");
		jQuery("#licenseDiv").css("display","none");
	}
	
	/*版本方法 开始*/
	
	
	
	//董事会保存“董事会的所有信息”
	function saveversionDate(){
		jQuery("#isaddversion").val("add");
		StartUploadAll();
		checkuploadcomplet();
	}
	
	function editversionDate(versionid){
		o4params ={
		method:"editversion",
		versionid:versionid,
		versionnum:encodeURI(jQuery("#versionnum").val()),
		versionname:encodeURI(jQuery("#versionname").val()),
		versionmemo:encodeURI(jQuery("#versionmemo").val()),
		versionaffix:"",
		date2Version:encodeURI(jQuery("#versionTime").val())
		};
		jQuery.post("/cpcompanyinfo/action/CPBoardDirectorsOperate.jsp",o4params,function(){
			alert("<%=SystemEnv.getHtmlLabelName(31012,user.getLanguage()) %>!");
			//closeMaint4Win();		
		});
	}
	
	
	/*删除一行或多行*/
	function dodel_gd(){
		var versionids="";
		var _versionnum="";
		jQuery('#webTable2version tr').each(function(){
			if(jQuery(this).children('td').find("input[type=checkbox][inWhichPage='zhzhVersion']").attr("checked")==true)
			{
				versionids += jQuery(this).attr("versionid")+",";
				_versionnum+= jQuery(this).attr("_versionnum")+",";
			}
		});
		if(versionids.length == 0){
			alert("<%=SystemEnv.getHtmlLabelName(22686,user.getLanguage()) %>！");
			return;
		}
		var truthBeTold = window.confirm("<%=SystemEnv.getHtmlLabelName(31013,user.getLanguage()) %>？"); 
		if (truthBeTold) { 
			jQuery('#webTable2version tr').each(function(){
				if(jQuery(this).children('td').find("input[type=checkbox][inWhichPage='zhzhVersion']").attr("checked")==true)
				{
					jQuery(this).remove();
				}
			});


			var o4params={method:"delVersion",versionids:versionids,_versionnum:_versionnum}
			jQuery.post("/cpcompanyinfo/action/CPBoardDirectorsOperate.jsp",o4params,function(){
				
			});
		}
	}
	
	function delImg(imgfileDiv,docid){
		var affix123doc = jQuery("#affixdoc").val().split(",");
		var tempdocid = "";
		for(i=0;i<affix123doc.length-1;i++){
			if(affix123doc[i]!=docid){
				tempdocid+=affix123doc[i]+",";
			}
		}
		jQuery("#affixdoc").val(tempdocid);
		jQuery(imgfileDiv).css("display","none");
		jQuery("#source").find("img").attr("src","images/nopic.jpg");
		jQuery("#_s2uiContent").css("display","none");
	}
	
	function viewVersion(){
		var versionids="";
		jQuery('#webTable2version tr').each(function(){
			if(jQuery(this).children('td').find("input[type=checkbox][inWhichPage='zhzhVersion']").attr("checked")==true)
			{
				versionids += jQuery(this).attr("versionid")+",";
			}
		});
		if(versionids.length == 0){
				alert("<%=SystemEnv.getHtmlLabelName(31017,user.getLanguage()) %>！");
		}else  if(versionids.split(",").length>2){
			alert("<%=SystemEnv.getHtmlLabelName(31014,user.getLanguage()) %>！");
		}else{
			var o4params = {method:"viewVersion",versionids:versionids}
			jQuery.post("/cpcompanyinfo/action/CPBoardDirectorsOperate.jsp",o4params,function(data){
				jQuery("#directorsid").val(data[0]["directorsid"]);
				jQuery("#chairman_dsh").val(data[0]["chairman"]);
				jQuery("#appointbegindate_dsh").html(data[0]["appointbegindate"]);
				jQuery("#appbegintime").val(data[0]["appointbegindate"]);
				jQuery("#appointenddate_dsh").html(data[0]["appointenddate"]);
				jQuery("#appendtime").val(data[0]["appointbegindate"]);
				
				jQuery("#appointduetime_dsh").val(data[0]["appointduetime"]);
				jQuery("#supervisor_dsh").val(data[0]["supervisor"]);
				jQuery("#generalmanager_dsh").val(data[0]["generalmanager"]);
				jQuery("#ischairman_dsh").val(data[0]["ischairman"]);
				
				jQuery("#managerbegindate_dsh").html(data[0]["managerbegindate"]);
				jQuery("#manbegintime").val(data[0]["managerbegindate"]);
				jQuery("#managerenddate_dsh").html(data[0]["managerenddate"]);
				jQuery("#manendtime").val(data[0]["managerbegindate"]);
				
				
				jQuery("#newDscyBtn").css("display","none");
				jQuery("#delDscyBtn").css("display","none");
				jQuery("#newDscy2jsBtn").css("display","none");
				jQuery("#delDscy2jsBtn").css("display","none");
				jQuery("#webTable2dsh").html("");
				jQuery("#saveBoardDirectorsBtn").attr("href","javascript:nosaveAgain();");	//恢复保存按钮
				jQuery("#spanTitle_dsh").html("<%=SystemEnv.getHtmlLabelName(31015,user.getLanguage()) %>["+data[1]+"]");
				jQuery.post("/cpcompanyinfo/action/CPBoardDirectorsOperate.jsp",{method:"viewOffersVersion",versionnum:data[1],directorsid:data[0]["directorsid"]},function(data1){
					jQuery("#webTable2dsh").html(jQuery.trim(data1));
				});
				jQuery.post("/cpcompanyinfo/action/CPBoardDirectorsOperate.jsp",{method:"viewSupersVersion",versionnum:data[1],directorsid:data[0]["directorsid"]},function(data2){
					jQuery("#webTable2jsh").html(jQuery.trim(data2));
				});
				
				var imgid4db = data[0]["imgid"].split("|");
				var imgname4db = data[0]["imgname"].split("|");
				if(jQuery("#affixcpdosDIV").find("div").length/3>0){
					jQuery("#affixcpdosDIV").html("");
				}
				var html4doc="";
				for(i=0;i<imgid4db.length - 1;i++){
					html4doc += "<div id='imgfileDiv"+i+"' style='background-color: #F7F7F7;width:291px;height:20px;padding-left:4px;border: solid 1px #E8E8E8;padding: 4px;margin-bottom: 5px;'>";
					html4doc+="<div style='width:80%;float:left;' >";
					html4doc+="<A id='pdflinkid"+i+"' href='/weaver/weaver.file.FileDownload?fileid="+imgid4db[i]+"&download=1' class='aContent0 FL'>"+imgname4db[i]+"</A>";
					html4doc+="</div>";
					html4doc+="<div style='padding-right:0px;float:right;padding-top:0px'>";
					html4doc+="<a href='/weaver/weaver.file.FileDownload?fileid="+imgid4db[i]+"&download=1'><img src='images/downLoadPic.gif'  title='<%=SystemEnv.getHtmlLabelName(22629,user.getLanguage()) %>'  ></a>";
					html4doc+="</div>";
					html4doc+="</div>";
				}
				jQuery("#affixcpdosDIV").html(html4doc);
				
				jQuery(".Clock").hide();
				jQuery(".OInput2").removeClass("OInput2").addClass("OInput3").focus(function(){this.blur();});
				jQuery("select").attr("disabled","disabled");  
				jQuery("#save_H").hide();
				jQuery("#webTable2dsh").attr("disabled","disabled");  
				jQuery("#webTable2jsh").attr("disabled","disabled");  
				jQuery("#licenseAffixUpload").hide();
				
				onLicenseDivCloseNoSave();
			},"json");
		}
	}
	
	function nosaveAgain(){
		alert("<%=SystemEnv.getHtmlLabelName(31016,user.getLanguage()) %>！")
	}
	
	function getVersion(){
		var versionids="";
		jQuery('#webTable2version tr').each(function(){
			if(jQuery(this).children('td').find("input[type=checkbox][inWhichPage='zhzhVersion']").attr("checked")==true)
			{
				versionids += jQuery(this).attr("versionid")+",";
			}
		});
		if(versionids.split(",").length>2 || versionids.length == 0){
			alert("<%=SystemEnv.getHtmlLabelName(31017,user.getLanguage()) %>！");
		}else{
			//licenseid='' and companyid=''
			jQuery("#wBoxContent").html("");
			jQuery("#wBox").css("top","130px").css("left","330px");
			jQuery("#wBoxContent").css("width","335px").css("height","225px");
			jQuery(".wBox_itemTitle").html("<%=SystemEnv.getHtmlLabelName(31018,user.getLanguage()) %>");
			jQuery("#wBoxContent").load("CompanyVersionMaint.jsp?versionids="+versionids+"&oneMoudel=director&companyid=<%=companyid%>");
			jQuery("#wBox_overlay").removeClass("wBox_hide").addClass("wBox_overlayBG");
			jQuery("#licenseDiv").css("display","");
			
		}
	}
	
	/*版本方法 结束*/
	
	/*flash上传需要的方法*/
	function StartUploadAll() {  
        eval("SWFUpload.instances.SWFUpload_0.startUpload()");
        // files_queued当前上传队列中存在的文件数量        
        eval("upfilesnum+=SWFUpload.instances.SWFUpload_0.getStats().files_queued"); 
	}
	function checkuploadcomplet(){	
	    if(upfilesnum>0){    	
	        setTimeout("checkuploadcomplet()",1000);       	
	    }else{
	       saveBoardDirectors();
	    }
	}
	function flashChecker() {
		var hasFlash = 0; //是否安装了flash
		var flashVersion = 0; //flash版本
		var isIE = /*@cc_on!@*/0; //是否IE浏览器
		if (isIE) {
			var swf = new ActiveXObject('ShockwaveFlash.ShockwaveFlash');
			if (swf) {
				hasFlash = 1;
				VSwf = swf.GetVariable("$version");
				flashVersion = parseInt(VSwf.split(" ")[1].split(",")[0]);
			}
		} else {
			if (navigator.plugins && navigator.plugins.length > 0) {
				var swf = navigator.plugins["Shockwave Flash"];
				if (swf) {
					hasFlash = 1;
					var words = swf.description.split(" ");
					for ( var i = 0; i < words.length; ++i) {
						if (isNaN(parseInt(words[i])))
							continue;
						flashVersion = parseInt(words[i]);
					}
				}
			}
		}
		return {
			f :hasFlash,
			v :flashVersion
		};
	}
	/*上传空间判断是否安装了flash控件*/
	var fls = flashChecker();
	var flashversion = 0;
	if (fls.f)
		flashversion = fls.v;
	if (flashversion < 9)
		document.getElementById("fsUploadProgress").innerHTML = "<br>&nbsp;&nbsp;附件上传的功能需要你的机器支持Flash9及其以上的版本，请从下面选择安装方式:<br><br><a target='_blank' href='http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=shockwaveFlash'>&nbsp;&nbsp;在线安装<a>	<br><br><a href='/resource/install_flash9_player.exe' target='_blank'>&nbsp;&nbsp;下载安装包</a>";	
	
</script>

<script language="javascript">

var upfilesnum=0;//计数器
var oUploader;//一个SWFUpload 实例
var mode="add";//当期模式

var settings = {   
	
	flash_url : "/js/swfupload/swfupload.swf",     
	upload_url: "/cpcompanyinfo/action/uploaderOperate.jsp",
	post_params: {
                "mainId": <%=mainId%>,
                "subId":<%=subId%>,
                "secId":<%=secId%>
            },
	file_size_limit :"100MB",							//单个文件大小
	file_types : "*.*;", 	//过滤文件类型
	file_types_description : "All Files",					//描述，会添加在类型前面
	file_upload_limit : "50",							//一次性上传几个文件
	file_queue_limit : "0",								
	//customSettings属性是一个空的JavaScript对象，它被用来存储跟SWFUpload实例相关联的数据。
	//它的内容可以使用设置对象中的custom_settings属性来初始化
	custom_settings : {
		progressTarget : "fsUploadProgress",
		cancelButtonId : "btnCancel_upload"
	},
	debug: false,
	
	button_image_url : "/js/swfupload/add.png",	// Relative to the SWF file
	button_placeholder_id : "spanButtonPlaceHolder",
	
	button_width: 100,//“上传"按钮的宽度
	button_height: <%if(!CompanyInfoTransMethod.CheckPack("4")){out.println("0");}else{out.println("18");}%>,//“上传”按钮的高度
	button_text : '<span class="button">'+"上传"+'</span>',//“上传”按钮的文字
	button_text_style : '.button { font-family: Helvetica, Arial, sans-serif; font-size: 12pt; } .buttonSmall { font-size: 10pt; }',
	button_text_top_padding: 0,//“上传"按钮的top_padding
	button_text_left_padding: 18,//“上传"按钮的left_padding
		
	button_window_mode: SWFUpload.WINDOW_MODE.TRANSPARENT,
	button_cursor: SWFUpload.CURSOR.HAND,//“上传"按钮的鼠标悬浮样式
	
	file_queued_handler : fileQueued,
	file_queue_error_handler : fileQueueError,
	
	file_dialog_complete_handler : function(){	//设置事件回调函数,file_dialog_complete_handler为类对象的属性		
		//让按钮失效
		//document.getElementById("btnCancel_upload").disabled = true;
		//alert("按钮细小");
		//fileDialogComplete				
	},
	//设置事件回调函数,upload_start_handler为类对象的属性,在文件往服务端上传之前触发此事件，可以在这里完成上传前的最后验证以及其他你需要的操作，例如添加、修改、删除post数据等。
	//在完成最后的操作以后，如果函数返回false，那么这个上传不会被启动，并且触发uploadError事件（code为ERROR_CODE_FILE_VALIDATION_FAILED），
	//如果返回true或者无返回，那么将正式启动上传
	upload_start_handler : uploadStart,	
	upload_progress_handler : uploadProgress,//设置事件回调函数,upload_progress_handler为类对象的属性
	upload_error_handler : uploadError,//设置事件回调函数,upload_error_handler为类对象的属性
	queue_complete_handler : queueComplete,//设置事件回调函数,queue_complete_handler为类对象的属性

	//文件上传成功，调用下面的方法
	upload_success_handler : function (file, server_data) {	//设置事件回调函数,upload_success_handler为类对象的属性
		if(mode=="add"){
			var imageid=server_data.replace(/(^\s*)|(\s*$)/g, "");			
			//得到文档id,得到文件的名字	
			document.getElementById("affixdoc").value+=imageid+",";
		}

	},	
	//文件上传成功，调用下面的方法			
	upload_complete_handler : function(){	
		upfilesnum=upfilesnum-1;//计数器减减
	}
	
};	
function queueComplete(numFilesUploaded) {
	var status = document.getElementById("divStatus");
	status.innerHTML = numFilesUploaded + " file" + (numFilesUploaded === 1 ? "" : "s") + " uploaded.";
}
try{
	oUploader = new SWFUpload(settings);//返回:一个SWFUpload 实例
} catch(e){alert(e)}
function openConter(licenseid){
    var url="/cpcompanyinfo/CompanyBusinessLicenseMaint.jsp?btnid=viewBtn&showOrUpdate=0&companyid=<%=companyid %>&licenseid="+licenseid;
    jQuery("#testaaa").qtip(
            {
                content: {
                    url: url
                },
                position: {
                    target: jQuery(document.body), // Position it via the document body...
                    corner: 'center' // ...at the center of the viewport
                },
                show: {
                    when: 'click', // Show it on click
                    solo: true, // And hide all other tooltips
                    ready:true
                },
                hide: false,
                style: {
                    width: { max: 990 },
                    width:943,
                    height:402,
                    padding: '0px 0px',
                    border: {
                        width: 0,
                        radius: 0,
                        color: '#666666'
                    },
                    name: 'light'
                },
                api: {
                    beforeShow: function()
                    {
                        // Fade in the modal "blanket" using the defined show speed
                        SWFUpload.movieCount=0;
                        jQuery('#qtip-blanket').fadeIn(this.options.show.effect.length);
                    },
                    beforeHide: function()
                    {
                        // Fade out the modal "blanket" using the defined hide speed
                        jQuery('#qtip-blanket').fadeOut(this.options.hide.effect.length);
                    }
                }
            });

}
</script>