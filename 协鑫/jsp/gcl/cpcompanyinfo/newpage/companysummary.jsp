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
	if(cu.canOperate(user,"2")||cu.canOperate(companyid,user,"2"))//��̨ά��Ȩ��
	{
		maintFlag = true;
	}	
	String companyname = Util.null2String(request.getParameter("companyname"));
	/*֤��<һ����Ӫҵִ��>*/
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
		mainId=rs.getString("mainId");//����Ĭ�ϵ�0
	 	subId=rs.getString("subId");//����Ĭ�ϵ�0
	 	secId=rs.getString("secId");//����Ĭ�ϵ�0c
	}
		//�ܹؼ���һ�������������жϺ���ҳ���Ƿ񿪷��༭Ȩ��
	//0--ֻ�������˾�Ĳ鿴Ȩ�ޣ�û��ά��Ȩ��
	//1--ӵ�������˾�鿴��ά��ȫ��
	String showOrUpdate = Util.null2String(request.getParameter("showOrUpdate"));
%>

<!--��ͷ������ start-->
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
        <%--������Ϣ--%>
        <%
            /*��˾��Ϣ*/
            String companyename = ""; //��˾Ӣ������
            String companyaddress = ""; //��˾��ַ
            String archivenum = ""; //ȫ�ں�
            String companyregion = ""; //����
            String foundingTime = ""; //��˾����ʱ��
            int businesstype = 0; //ҵ������
            String loancard = ""; //�����
            String companyvestin = ""; //��˾����
	/*Ӫҵִ����Ϣ*/
            String scopebusiness = "";
            String corporatdelegate = "";
            String licenseregistnum = "";
            String companytype = "";
	/*�³�*/
	/*���»�*/

//	�����ֶΣ����칫��ַ������״̬���ֶΣ�������ע����Ĭ��Ϊ����������
            String bgdz_ = "";
            String zt_ = "";
//	��������Ͷ���ܶ�������֡��ֶη��ڡ��½���˾������ά����
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
			/*��˾��Ϣ*/
                    companyname = Util.null2String(rs.getString("companyname")); //��˾����
                    companyename = Util.null2String(rs
                            .getString("companyename")); //��˾Ӣ������
                    companyaddress = Util.null2String(rs
                            .getString("companyaddress")); //��˾��ַ
                    archivenum = Util.null2String(rs.getString("archivenum")); //ȫ�ں�
                    companyregion =Util.null2String(rs.getString("companyregion")); //����
                    foundingTime=Util.null2String(rs.getString("foundingTime")); //��˾����ʱ��
                    if("NULL".equals(foundingTime)){
                        foundingTime="";
                    }
                    businesstype = rs.getInt("businesstype"); //ҵ������
                    loancard = Util.null2String(rs.getString("loancard")); //�����
                    companyvestin = Util.null2String(rs
                            .getString("companyvestin")); //��˾����
			/*Ӫҵִ����Ϣ*/
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
			/*�³�*/
			/*���»�*/
                    bgdz_=Util.null2String(rs.getString("bgdz_"));
                    zt_=""+Util.getIntValue( Util.null2String(rs.getString("zt_")),1);
                    AGGREGATEINVEST=Util.null2String(rs.getString("AGGREGATEINVEST"));
                    CURRENCYID=Util.null2String(rs.getString("CURRENCYID"));
                }
            }

        %>

        <div class="border17 FL PTop10 OHeaderLayerW6 ML33"> <ul class="ONav FL cBlue"> <li><a class="hover" href="#"> <div><div style="font-size: 14px;"> ������Ϣ </div> </div> </a> </li> </ul> <div class="clear"></div></div>
            <table width="620" border="0" <%=fromNEWPAGE?"":"align='center'"%> cellpadding="0" cellspacing="0" class="MT5">
                <tr >
                    <td height="25">
                        <strong>��ţ�</strong>
                    </td>
                    <td >
                        <span><%=archivenum %></span>
                    </td>
                    <td height="25">
                        <strong>����</strong>
                    </td>
                    <td >
                        <span><%=CompanyInfoTransMethod.getCompanyRegion( companyregion) %></span>
                    </td>
                </tr>
                <tr >
                    <td height="25">
                        <strong>���������</strong>
                    </td>
                    <td >
                        <span><%=CompanyInfoTransMethod.getGuanliguishu( ""+businesstype) %></span>
                    </td>
                    <td height="25">
                        <strong>��Ȩ������</strong>
                    </td>
                    <td >
                        <span><%=CompanyInfoTransMethod.getGuquanguishu( companyvestin) %></span>
                    </td>
                </tr>
                <tr >
                    <td height="25">
                        <strong>��˾���ƣ�</strong>
                    </td>
                    <td >
                        <span><%=companyname %></span>
                    </td>
                    <td height="25">
                        <strong>����ʱ�䣺</strong>
                    </td>
                    <td >
                        <span><%=foundingTime %></span>
                    </td>
                </tr>
                <tr >
                    <td height="25">
                        <strong>Ͷ���ܶ</strong>
                    </td>
                    <td >
                        <span><%=AGGREGATEINVEST %></span>
                    </td>
                    <td height="25">
                        <strong>���֣�</strong>
                    </td>
                    <td >
                        <span><%=CurrencyComInfo.getCurrencyname( CURRENCYID ) %></span>
                    </td>
                </tr>
                <tr >
                    <td height="25">
                        <strong>ע���ַ��</strong>
                    </td>
                    <td colspan="3">
                        <span><%=companyaddress %></span>
                    </td>
                </tr>
                <tr >
                    <td height="25">
                        <strong>�칫��ַ��</strong>
                    </td>
                    <td colspan="3">
                        <span><%=bgdz_ %></span>
                    </td>
                </tr>
            </table>





        <%--֤����Ϣ--%>
        <div class="border17 FL PTop10 OHeaderLayerW6 ML33"> <ul class="ONav FL cBlue"> <li><a class="hover" href="#"> <div><div style="font-size: 14px;"> ֤����Ϣ </div> </div> </a> </li> </ul> <div class="clear"></div></div>
            <div class="FL ML33" style="<%=fromNEWPAGE?"":"height:25px;width:630px;" %>">
                <table width="614" border="0" cellpadding="0" cellspacing="1"
                       class="stripe OTable">
                    <tr id="OTable2" class="cBlack">
                        <td width="16%" align="center">
                            <strong>֤������</strong>
                        </td>
                        <td width="18%" align="center">
                            <strong>ע���</strong>
                        </td>
                        <td width="10%" align="center">
                            <strong>��������</strong>
                        </td>
                        <td width="10%" align="center">
                            <strong>�������</strong>
                        </td>
                        <td width="8%" align="center">
                            <strong>�Ǽǻ���</strong>
                        </td>
                        <td width="10%" align="center">
                            <strong>��������</strong>
                        </td>
                        <td width="20%" align="center">
                            <strong>����</strong>
                        </td>
                        <td width="20%" align="center">
                            <strong>��ע</strong>
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




        <%--�³�--%>
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
        <div class="border17 FL PTop10 OHeaderLayerW6 ML33"> <ul class="ONav FL cBlue"> <li><a class="hover" href="#"> <div><div style="font-size: 14px;"> �³� </div> </div> </a> </li> </ul> <div class="clear"></div></div>
            <table width="620" border="0" <%=fromNEWPAGE?"":"align='center'"%> cellpadding="0" cellspacing="0" class="MT5">
                <tr >
                    <td height="25">
                        <strong>ע���ʱ���</strong>
                    </td>
                    <td >
                        <span><%=REGISTERCAPITAL %></span>
                    </td>
                    <td height="25">
                        <strong>ʵ���ʱ���</strong>
                    </td>
                    <td >
                        <span><%=PAICLUPCAPITAL %></span>
                    </td>
                </tr>
                <tr >
                    <td height="25">
                        <strong><%="2".equals(isvisitors)?"ִ�ж���":"���»�" %>��</strong>
                    </td>
                    <td >
                        <span><%=theboard %></span>
                    </td>
                    <td height="25">
                        <strong>��ֹʱ�䣺</strong>
                    </td>
                    <td >
                        <span><%=stitubegindate %> - <%=stituenddate %></span>
                    </td>
                </tr>
                <tr >
                    <td height="25">
                        <strong>���»᣺</strong>
                    </td>
                    <td >
                        <span><%=boardvisitors %></span>
                    </td>
                    <td height="25">
                        <strong>��ֹʱ�䣺</strong>
                    </td>
                    <td >
                        <span><%=visitbegindate %> - <%=visitenddate %></span>
                    </td>
                </tr>
                <tr >
                    <td height="25">
                        <strong>������ְ����(��)��</strong>
                    </td>
                    <td >
                        <span><%=appointduetime %></span>
                    </td>
                    <td height="25">
                        <strong>��ѡ���Σ�</strong>
                    </td>
                    <td >
                        <span><%="T".equals(isreappoint)?"��":"��" %></span>
                    </td>
                </tr>


                <tr>
                    <td height="25" align="left"  vAlign="top"><strong>������</strong></td>
                    <td colspan="3">
                        <%if(!CompanyInfoTransMethod.CheckPack("2")){out.println("<span style='color:red'>"+SystemEnv.getHtmlLabelName(31004,user.getLanguage())+"��</span>");}%>
                        <div id="licenseAffixUpload" style="display: none;" >
                            <input type="hidden" name="affixdoc" id="affixdoc">
						<span>
							<span id='spanButtonPlaceHolder'></span><!--ѡȡ����ļ�-->
						</span>
                            &nbsp;&nbsp;
						<span style="color: #262626; cursor: hand; TEXT-DECORATION: none;<%if(!CompanyInfoTransMethod.CheckPack("2")){out.println("display: none;");}%>"
                              disabled id="btnCancel_upload">
							<span><img src="/js/swfupload/delete.gif" border="0" onClick="oUploader.cancelQueue()"> </span> <span
                                style="height: 19px"> <font style="margin: 0 0 0 -1"><%=SystemEnv.getHtmlLabelName(21407,user.getLanguage()) %>
                            (<%=SystemEnv.getHtmlLabelName(18976,user.getLanguage()) %>100<%=SystemEnv.getHtmlLabelName(18977,user.getLanguage()) %>)
                        </font> <!--�������--> </span> </span>
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
                                        //����ĵ����⣬�ṩ����
                                        out.println(str);
                                        out.println("</div>");



                                        out.println("<div style='padding-right:0px;float:right;padding-top:0px'>");

                                        //��������ĵ�������
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


        <%--�ɶ���--%>

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
        <div class="border17 FL PTop10 OHeaderLayerW6 ML33"> <ul class="ONav FL cBlue"> <li><a class="hover" href="#"> <div><div style="font-size: 14px;"> �ɶ��� </div> </div> </a> </li> </ul> <div class="clear"></div></div>
            <table width="620" border="0" <%=fromNEWPAGE?"":"align='center'"%> cellpadding="0" cellspacing="0" class="MT5">
                <tr >
                    <td height="25">
                        <strong>�ɶ��᣺</strong>
                    </td>
                    <td >
                        <span id="BOARDSHAREHOLDER"><%=BOARDSHAREHOLDER %></span>
                    </td>
                    <td height="25">
                        <strong>����ʱ�䣺</strong>
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
                            <strong>����<%=SystemEnv.getHtmlLabelName(31040,user.getLanguage()) %></strong>
                        </td>
                        <td width="99" align="center">
                            <strong>ʵ��<%=SystemEnv.getHtmlLabelName(31040,user.getLanguage()) %></strong>
                        </td>
                        <td width="70" align="center">
                            <strong><%=SystemEnv.getHtmlLabelName(406,user.getLanguage()) %></strong>
                        </td>
                        <td width="120" align="center">
                            <strong><%=SystemEnv.getHtmlLabelName(31108,user.getLanguage()) %></strong>
                        </td>
                        <td width="120" align="center">
                            <strong>����<%=SystemEnv.getHtmlLabelName(31109,user.getLanguage()) %>(%)</strong>
                        </td>
                        <td width="120" align="center">
                            <strong>��;</strong>
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
                            <%="1".equals(rs.getString("isstop"))?"��":"��" %>
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
                        <strong>������</strong>
                    </td>
                    <td colspan="3">
                        <%if(!CompanyInfoTransMethod.CheckPack("3")){out.println("<span style='color:red'>"+SystemEnv.getHtmlLabelName(31004,user.getLanguage()) +"��</span>");}%>
                        <div id="licenseAffixUpload" style="display: none;" >
                            <input type="hidden" name="affixdoc" id="affixdoc">
						<span>
							<span id='spanButtonPlaceHolder'></span><!--ѡȡ����ļ�-->
						</span>
                            &nbsp;&nbsp;
						<span style="color: #262626; cursor: hand; TEXT-DECORATION: none;<%if(!CompanyInfoTransMethod.CheckPack("3")){out.println("display: none;");}%>"
                              disabled id="btnCancel_upload">
							<span><img src="/js/swfupload/delete.gif" border="0" onClick="oUploader.cancelQueue()"> </span> <span
                                style="height: 19px"> <font style="margin: 0 0 0 -1"><%=SystemEnv.getHtmlLabelName(21407,user.getLanguage()) %>
                            (<%=SystemEnv.getHtmlLabelName(18976,user.getLanguage()) %>100<%=SystemEnv.getHtmlLabelName(18977,user.getLanguage()) %>)
                        </font> <!--�������--> </span> </span>
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
                                        //����ĵ����⣬�ṩ����
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




        <%--���»�--%>
        <div class="border17 FL PTop10 OHeaderLayerW6 ML33"> <ul class="ONav FL cBlue"> <li><a class="hover" href="#"> <div><div style="font-size: 14px;"> ���»� </div> </div> </a> </li> </ul> <div class="clear"></div></div>




        <table width="620" border="0" <%=fromNEWPAGE?"":"align='center'"%> cellpadding="0"
			cellspacing="0" class="MT5">
			<tr >
				<td height="25">
					<strong><%=SystemEnv.getHtmlLabelName(23797,user.getLanguage()) %>��</strong>
				</td>
				<td colspan="3">
                    <span id="faren"></span>
				</td>
			</tr>
			<tr>
				<td height="25">
                    <strong><span id="ischairman_dsh"></span>��</strong>
				</td>
				<td  height="25">
                    <span id="chairman_dsh"></span>
                </td>
                <td>
					<strong><%=SystemEnv.getHtmlLabelName(17697,user.getLanguage()) %>��</strong>
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
					<strong><%=SystemEnv.getHtmlLabelName(20696,user.getLanguage())  %>��</strong>
				</td>
				<td  >
					<span id="generalmanager_dsh"></span>
					&nbsp;
                    <td>
					<strong><%=SystemEnv.getHtmlLabelName(17697,user.getLanguage())  %>��</strong>
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
						<!-- ���»���� -->
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
						<!-- �������� -->
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
						<!-- ��ʼʱ�� -->
							&nbsp;
							<INPUT  type=hidden value="<%=rs.getString("officebegindate") %>" id="officebegindate_input<%=ix%>">
							<span id="officebegindate_span<%=ix%>">
									<%=rs.getString("officebegindate") %>
							</span>
							
					</td>
					<td width="17%" >
						<!-- ����ʱ�� -->
						&nbsp;
						<INPUT  type=hidden  value="<%=rs.getString("officeenddate") %>" id="officeenddate_input<%=ix%>">
						<span id="officeenddate_span<%=ix%>">
									<%=rs.getString("officeenddate") %>
						</span>
					</td>
					<td width="8%" >
                        <%="1".equals( rs.getString("isstop"))?"��":"��" %>
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
		
		<!-- ���»��Ա -->
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
							<!-- ��ʼʱ�� -->
							&nbsp;
							<INPUT  type=hidden value="<%=rs.getString("SUPERBEGINDATE") %>"  id="superbegindate_input<%=jsix%>">
							<span  id="superbegindate_span<%=jsix%>">
									<%=rs.getString("SUPERBEGINDATE") %>
							</span>
					</td>
					<td width="17%" >
							<!-- ����ʱ�� -->
							&nbsp;
							<INPUT  type=hidden  value="<%=rs.getString("SUPERENDDATE") %>"  id=superenddate_input<%=jsix%>>
							<span  id=superenddate_span<%=jsix%>>
									<%=rs.getString("SUPERENDDATE") %>
							</span>
					</td>
					<td width="8%" >
                        <%="1".equals(rs.getString("isstop"))?"��":"��"  %>
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
				<td height="25" align="left" vAlign="top"><strong>������</strong></td>
		    	<td align="left"  colspan="3">
		    		<%if(!CompanyInfoTransMethod.CheckPack("4")){out.println("<span style='color:red'>"+SystemEnv.getHtmlLabelName(31004,user.getLanguage()) +"��</span>");}%>
					<div id="licenseAffixUpload" style="display: none;" >
					<input type="hidden" name="affixdoc" id="affixdoc">
						<span> 
							<span id='spanButtonPlaceHolder'></span><!--ѡȡ����ļ�-->
						</span>
						&nbsp;&nbsp;
						<span style="color: #262626; cursor: hand; TEXT-DECORATION: none;<%if(!CompanyInfoTransMethod.CheckPack("4")){out.println("display: none;");}%>"
							disabled id="btnCancel_upload">
							<span><img src="/js/swfupload/delete.gif" border="0" onClick="oUploader.cancelQueue()"> </span> <span
							style="height: 19px"> <font style="margin: 0 0 0 -1"><%=SystemEnv.getHtmlLabelName(21407,user.getLanguage()) %>
							(<%=SystemEnv.getHtmlLabelName(18976,user.getLanguage()) %>100<%=SystemEnv.getHtmlLabelName(18977,user.getLanguage()) %>)
							</font> <!--�������--> </span> </span>
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
									//����ĵ����⣬�ṩ����
									out.println(str);
									out.println("</div>");
									
									//out.println("<div style='width:40%;float:left;'>");
									//����ĵ�����ʱ��
									//out.println(dc.getDocCreateTime(slaves));
									//out.println("</div>");
									
									
									out.println("<div style='padding-right:0px;float:right;padding-top:0px'>");
									
									//out.println("�ĵ�������id"+dc.getDocCreaterid(slaves[i]));
									//getDocOwnerid
									
									//if(dc.getDocCreaterid(slaves[i]).equals(userid+""))//��ǰ�û����ĵ��Ĵ�����
								//	{		
										//���ɾ���ĵ�������												
										//isdoc = "affixdoc";
										//out.println("<img src='images/delwk.gif' onclick=delImg(imgfileDiv"+i+","+slaves[i]+") title='ɾ��'></a>");
									//}else
									//{
										//��������ĵ�������									
									
										out.println("<a href='/weaver/weaver.file.FileDownload?fileid="+fileid+"&download=1'><img src='../images/downLoadPic.gif'  title='����'  ></a>");
										if(!"0".equals(showOrUpdate)){
//											out.println("<img src='images/delwk.gif' onclick=delImg(imgfileDiv"+i+","+slaves[i]+") title='ɾ��'></a>");
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
<!--��ͷ������ end-->

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
			<!-- ��ʼʱ�� -->
			&nbsp;&nbsp;
			<BUTTON class=Clock   name="hidebegindate01"   type="button"></BUTTON>
			<INPUT  type=hidden>
			<span>
					<IMG align=absMiddle src='/images/BacoError.gif'>
			</span>
		</span>
		<span _calss="show">
			<!-- ����ʱ�� -->
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
				<!-- ��ʼʱ�� -->
				&nbsp;&nbsp;
				<BUTTON class=Clock   name="hidebegindate02"   type="button"></BUTTON>
				<INPUT  type=hidden>
				<span>
					<IMG align=absMiddle src='/images/BacoError.gif'>
				</span>
		 </span>
		<span _calss="show">
				<!-- ����ʱ�� -->
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

<!-- ֤�յ����� -->

<div style="clear:both;display:none" id="licenseDiv">
	<div id="wBox" style="top:80px;left:400px;"><!-- �������ʲôλ���� -->
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
		          						<td width="20px" title="�ر�" onclick="javascript:onLicenseDivClose();"><div class="wBox_close"></div></td>
		       						</tr>
		     					</table>
		     					<div class="wBox_content" id="wBoxContent" style="width:335px;height:325px;overflow-y:auto;">
		      					<!-- �������������� -->
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
 <!-- ���ֲ� start -->
<div id='wBox_overlay' class='wBox_hide' style="clear:both;"></div>
<!-- ���ֲ� end --> 

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
				jQuery(":text[id$='_dsh']").val("");		//����ı�����
				jQuery(".OSelect").val("1");	//ѡ���ԭ
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
		
		/*��ɫ��Ĭ�ϳ�ʼ��ֵ*/
		jQuery("#companyname_indsh").val("<%=companyname%>");
		jQuery("#corporation_indsh").val("<%=corporation%>");
		jQuery("#usefulbegindate_indsh").val("<%=usefulbegindate%>");
		jQuery("#usefulenddate_indsh").val("<%=usefulenddate%>");
		jQuery("#usefulyear_indsh").val("<%=usefulyear%>");
		
		//���水ťָ�򱣴淽��
		jQuery("#saveBoardDirectorsBtn").attr("href","javascript:saveDate();");
		
		var now = new Date();
		var currentYear = now.getFullYear();
		var selectdateoptions = '';
		var selectdateoptions2 = '';
        selectdateoptions2+= "<option value=''>"+"ȫ��"+"</option>";
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
	
	/*���� ���»�*/
	function saveBoardDirectors() 
	{
		
		jQuery("#saveBoardDirectorsBtn").attr("href","javascript:void(0);");	//���ñ����ظ����
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
           	//��װjson�����ַ���
           	
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
           	//��װjson�����ַ���
			
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
                alert("�������!");
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
	/*��֤�Ƿ�ͨ����ͨ���󷽱���*/
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
	
	/* �ر� �Ѵ򿪵���� */
	function closeMaint4Win()
	{
		jQuery("a[typepage='dsh']").qtip('hide');
		jQuery("a[typepage='dsh']").qtip('destroy');
		//�ص�ˢ�½�������
		refsh();
	}
	
	//ȫ��ѡ���������ѡ��
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
	//ȫ��ѡ���������ѡ��
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
	 
	 
	//ѡ�����е�һ��
	function selectone_chk(){
	    jQuery("#fileid").attr("checked",false); 
	}
	//ѡ�����е�һ��
	function selectone_chk2js(){
	    jQuery("#fileid2js").attr("checked",false); 
	}
	/*����һ��tr*/
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
				$(this).attr("name","");//��name��ֵ����ֹ�´�ѭ�����ҵ���
				$(this).click(function (){
						//gettheDate�������ֻ������ͨ���󣬲��ܰ�jquery���󴫽�ȥ
						onShowDate($(this).next().next()[0],$(this).next()[0]);
				})
		});
		jQuery("#webTable2dsh").find("tr").find("td").find("button[name='hideenddate01']").each(function(){
				$(this).attr("name","");//��name��ֵ����ֹ�´�ѭ�����ҵ���
				$(this).click(function (){
						//gettheDate�������ֻ������ͨ���󣬲��ܰ�jquery���󴫽�ȥ
						onShowDate($(this).next().next()[0],$(this).next()[0]);
				})
		});
		
		
	}
	/*����һ��tr*/
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
				$(this).attr("name","");//��name��ֵ����ֹ�´�ѭ�����ҵ���
				$(this).click(function (){
						//gettheDate�������ֻ������ͨ���󣬲��ܰ�jquery���󴫽�ȥ
						onShowDate($(this).next().next()[0],$(this).next()[0]);
				})
		});
		jQuery("#webTable2jsh").find("tr").find("td").find("button[name='hideenddate02']").each(function(){
				$(this).attr("name","");//��name��ֵ����ֹ�´�ѭ�����ҵ���
				$(this).click(function (){
						//gettheDate�������ֻ������ͨ���󣬲��ܰ�jquery���󴫽�ȥ
						onShowDate($(this).next().next()[0],$(this).next()[0]);
				})
		});
	}
	/*ɾ��һ�л����*/
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
	
	/*ɾ��һ�л����*/
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
			 var atime=$td.eq(3).find("input[type=hidden]").val(); //��һ��td������
			 var btime=$td.eq(4).find("input[type=hidden]").val();  //��һ��td������
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
			 var atime=$td.eq(3).find("input[type=hidden]").val(); //��һ��td������
			 var btime=$td.eq(4).find("input[type=hidden]").val();  //��һ��td������
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
				
				
				
		jQuery("#saveBoardDirectorsBtn").attr("href","javascript:void(0);");	//���ñ����ظ����
		if(checkForm()){
			var truthBeTold = window.confirm("<%=SystemEnv.getHtmlLabelName(31009,user.getLanguage()) %>��"); 
			if (truthBeTold) { 
				onversionAddDivOpen();
			} else {
				var truth4Told = window.confirm("<%=SystemEnv.getHtmlLabelName(31010,user.getLanguage()) %>��"); 
				if(truth4Told){
					StartUploadAll();
					checkuploadcomplet();
				}else{
					jQuery("#saveBoardDirectorsBtn").attr("href","javascript:saveDate();");	//�ָ����水ť
				}
			}
		}
		else
		{
			alert("<%=SystemEnv.getHtmlLabelName(15859,user.getLanguage()) %>��");
			jQuery("#saveBoardDirectorsBtn").attr("href","javascript:saveDate();");	//�ָ����水ť
		}
	} 
	
	
	/*�򿪰汾����ҳ��*/
	function openVersionManage(){
		jQuery("#wBoxContent").html("");
		jQuery("#wBox").css("top","130px").css("left","190px");
		jQuery("#wBoxContent").css("width","476px").css("height","225px");
		jQuery(".wBox_itemTitle").html("<%=SystemEnv.getHtmlLabelName(19450,user.getLanguage()) %>");
		jQuery("#wBoxContent").load("/cpcompanyinfo/CompanyVersionManage.jsp?directorsid="+jQuery("#directorsid").val()+"&oneMoudel=director&showOrUpdate=<%=showOrUpdate%>");
		jQuery("#wBox_overlay").removeClass("wBox_hide").addClass("wBox_overlayBG");
		jQuery("#licenseDiv").css("display","");
	}
	
	/*�򿪰汾����DIV*/
	function onversionAddDivOpen(){
		jQuery("#wBoxContent").html("");
		jQuery("#wBox").css("top","130px").css("left","330px");
		jQuery("#wBoxContent").css("width","335px").css("height","225px");
		jQuery(".wBox_itemTitle").html("<%=SystemEnv.getHtmlLabelName(31011,user.getLanguage()) %>");
		jQuery("#wBoxContent").load("CompanyVersionMaint.jsp?directorsid="+jQuery("#directorsid").val()+"&oneMoudel=director&companyid=<%=companyid%>");
		jQuery("#wBox_overlay").removeClass("wBox_hide").addClass("wBox_overlayBG");
		jQuery("#licenseDiv").css("display","");
	}
	
	/*�ر�ѡ��֤��DIV*/
	function onLicenseDivClose() {
		jQuery("#wBox_overlay").removeClass("wBox_overlayBG").addClass("wBox_hide");
		jQuery("#licenseDiv").css("display","none");
		jQuery("#saveBoardDirectorsBtn").attr("href","javascript:saveDate();");	//�ָ����水ť
	} 
	
	function onLicenseDivCloseNoSave(){
		jQuery("#wBox_overlay").removeClass("wBox_overlayBG").addClass("wBox_hide");
		jQuery("#licenseDiv").css("display","none");
	}
	
	/*�汾���� ��ʼ*/
	
	
	
	//���»ᱣ�桰���»��������Ϣ��
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
	
	
	/*ɾ��һ�л����*/
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
			alert("<%=SystemEnv.getHtmlLabelName(22686,user.getLanguage()) %>��");
			return;
		}
		var truthBeTold = window.confirm("<%=SystemEnv.getHtmlLabelName(31013,user.getLanguage()) %>��"); 
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
				alert("<%=SystemEnv.getHtmlLabelName(31017,user.getLanguage()) %>��");
		}else  if(versionids.split(",").length>2){
			alert("<%=SystemEnv.getHtmlLabelName(31014,user.getLanguage()) %>��");
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
				jQuery("#saveBoardDirectorsBtn").attr("href","javascript:nosaveAgain();");	//�ָ����水ť
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
		alert("<%=SystemEnv.getHtmlLabelName(31016,user.getLanguage()) %>��")
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
			alert("<%=SystemEnv.getHtmlLabelName(31017,user.getLanguage()) %>��");
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
	
	/*�汾���� ����*/
	
	/*flash�ϴ���Ҫ�ķ���*/
	function StartUploadAll() {  
        eval("SWFUpload.instances.SWFUpload_0.startUpload()");
        // files_queued��ǰ�ϴ������д��ڵ��ļ�����        
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
		var hasFlash = 0; //�Ƿ�װ��flash
		var flashVersion = 0; //flash�汾
		var isIE = /*@cc_on!@*/0; //�Ƿ�IE�����
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
	/*�ϴ��ռ��ж��Ƿ�װ��flash�ؼ�*/
	var fls = flashChecker();
	var flashversion = 0;
	if (fls.f)
		flashversion = fls.v;
	if (flashversion < 9)
		document.getElementById("fsUploadProgress").innerHTML = "<br>&nbsp;&nbsp;�����ϴ��Ĺ�����Ҫ��Ļ���֧��Flash9�������ϵİ汾���������ѡ��װ��ʽ:<br><br><a target='_blank' href='http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=shockwaveFlash'>&nbsp;&nbsp;���߰�װ<a>	<br><br><a href='/resource/install_flash9_player.exe' target='_blank'>&nbsp;&nbsp;���ذ�װ��</a>";	
	
</script>

<script language="javascript">

var upfilesnum=0;//������
var oUploader;//һ��SWFUpload ʵ��
var mode="add";//����ģʽ

var settings = {   
	
	flash_url : "/js/swfupload/swfupload.swf",     
	upload_url: "/cpcompanyinfo/action/uploaderOperate.jsp",
	post_params: {
                "mainId": <%=mainId%>,
                "subId":<%=subId%>,
                "secId":<%=secId%>
            },
	file_size_limit :"100MB",							//�����ļ���С
	file_types : "*.*;", 	//�����ļ�����
	file_types_description : "All Files",					//�����������������ǰ��
	file_upload_limit : "50",							//һ�����ϴ������ļ�
	file_queue_limit : "0",								
	//customSettings������һ���յ�JavaScript�������������洢��SWFUploadʵ������������ݡ�
	//�������ݿ���ʹ�����ö����е�custom_settings��������ʼ��
	custom_settings : {
		progressTarget : "fsUploadProgress",
		cancelButtonId : "btnCancel_upload"
	},
	debug: false,
	
	button_image_url : "/js/swfupload/add.png",	// Relative to the SWF file
	button_placeholder_id : "spanButtonPlaceHolder",
	
	button_width: 100,//���ϴ�"��ť�Ŀ��
	button_height: <%if(!CompanyInfoTransMethod.CheckPack("4")){out.println("0");}else{out.println("18");}%>,//���ϴ�����ť�ĸ߶�
	button_text : '<span class="button">'+"�ϴ�"+'</span>',//���ϴ�����ť������
	button_text_style : '.button { font-family: Helvetica, Arial, sans-serif; font-size: 12pt; } .buttonSmall { font-size: 10pt; }',
	button_text_top_padding: 0,//���ϴ�"��ť��top_padding
	button_text_left_padding: 18,//���ϴ�"��ť��left_padding
		
	button_window_mode: SWFUpload.WINDOW_MODE.TRANSPARENT,
	button_cursor: SWFUpload.CURSOR.HAND,//���ϴ�"��ť�����������ʽ
	
	file_queued_handler : fileQueued,
	file_queue_error_handler : fileQueueError,
	
	file_dialog_complete_handler : function(){	//�����¼��ص�����,file_dialog_complete_handlerΪ����������		
		//�ð�ťʧЧ
		//document.getElementById("btnCancel_upload").disabled = true;
		//alert("��ťϸС");
		//fileDialogComplete				
	},
	//�����¼��ص�����,upload_start_handlerΪ����������,���ļ���������ϴ�֮ǰ�������¼�����������������ϴ�ǰ�������֤�Լ���������Ҫ�Ĳ�����������ӡ��޸ġ�ɾ��post���ݵȡ�
	//��������Ĳ����Ժ������������false����ô����ϴ����ᱻ���������Ҵ���uploadError�¼���codeΪERROR_CODE_FILE_VALIDATION_FAILED����
	//�������true�����޷��أ���ô����ʽ�����ϴ�
	upload_start_handler : uploadStart,	
	upload_progress_handler : uploadProgress,//�����¼��ص�����,upload_progress_handlerΪ����������
	upload_error_handler : uploadError,//�����¼��ص�����,upload_error_handlerΪ����������
	queue_complete_handler : queueComplete,//�����¼��ص�����,queue_complete_handlerΪ����������

	//�ļ��ϴ��ɹ�����������ķ���
	upload_success_handler : function (file, server_data) {	//�����¼��ص�����,upload_success_handlerΪ����������
		if(mode=="add"){
			var imageid=server_data.replace(/(^\s*)|(\s*$)/g, "");			
			//�õ��ĵ�id,�õ��ļ�������	
			document.getElementById("affixdoc").value+=imageid+",";
		}

	},	
	//�ļ��ϴ��ɹ�����������ķ���			
	upload_complete_handler : function(){	
		upfilesnum=upfilesnum-1;//����������
	}
	
};	
function queueComplete(numFilesUploaded) {
	var status = document.getElementById("divStatus");
	status.innerHTML = numFilesUploaded + " file" + (numFilesUploaded === 1 ? "" : "s") + " uploaded.";
}
try{
	oUploader = new SWFUpload(settings);//����:һ��SWFUpload ʵ��
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