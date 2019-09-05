<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="/page/maint/common/initNoCache.jsp"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
	String companyid = Util.null2String(request.getParameter("companyid"));
	String searchaffix = Util.null2String(request.getParameter("searchaffix"));
/* 	String sql = "select companyid ,shareaffix from ("+
				" select t1.companyid, t1.shareaffix from CPSHAREHOLDER t1"+
				" UNION "+
				" select t2.companyid,t2.drectorsaffix from CPBOARDDIRECTORS t2"+
				" UNION "+
				" select t3.companyid,t3.constituaffix from CPCONSTITUTION t3"+
				" union"+
				" select t4.companyid,t4.affixdoc from CPBUSINESSLICENSE t4 where t4.isdel='T'"+
				" ) where companyid = " + companyid; */
	//System.out.println(sql);
	
		//--得到该公司下的所有的附件
		String sql =" select companyid ,shareaffix,type from ( "+
			// --查询出所有的附件,并且指定附件的类型(模块类型)
		   "  select t1.companyid, t1.shareaffix,'lmshare'type from CPSHAREHOLDER t1 "+
		   "   UNION  select t2.companyid,t2.drectorsaffix,'lmdirectors' type from CPBOARDDIRECTORS t2 "+
		   "   UNION  select t3.companyid,t3.constituaffix,'lmconstitution' type from CPCONSTITUTION t3 "+
		   "   UNION  select t4.companyid,t4.affixdoc,'lmlicense' type from CPBUSINESSLICENSE t4 where t4.isdel='T' "+
		   "   )  sb where companyid = '"+companyid+"' and  ( shareaffix is not null or shareaffix !='' ) ";
		   	//System.out.println("得到该公司下的所有的附件"+sql);
		rs.execute(sql);
		//用于记录每个附件id，所属的附件类型(模块类型)
		HashMap m=new HashMap();
		String affixdoc = "";
		while(rs.next()){
			affixdoc+=Util.null2String(rs.getString("shareaffix"));
			String temp_[]=Util.null2String(rs.getString("shareaffix")).split(",");
			String kewvalue=Util.null2String(rs.getString("type"));
			for(int jk=0;jk<temp_.length;jk++){
					if(null!=temp_[jk]&&!"".equals(temp_[jk])){
							m.put(temp_[jk], kewvalue);//记录每一个附件id所对应的模块类型
					}
			}
		}
		if(!affixdoc.equals("")){
			if (',' == affixdoc.charAt(affixdoc.length() - 1)){
				affixdoc = affixdoc.substring(0,affixdoc.lastIndexOf(","));
			}
		}
 %>

<!--表头浮动层 start-->
<div
	class="Absolute OHeaderLayer6 Bgfff BorderLMDIVHide">
	<div class="OHeaderLayerTit FL OHeaderLayerW7 ">
		<span id="spanTitle_gdh" class="cBlue FontYahei FS16 PL15 FL"><%=SystemEnv.getHtmlLabelName(22629,user.getLanguage())%></span>
		<img src="images/O_40.jpg" class="FR MT10 MR10"
			style="cursor: hand;" onclick="javascript:closeMaint4Win();" />
	</div>
	<div class="FL">
		
		<div class="border17 FL PTop10 OHeaderLayerW8 ML33">
			

			<ul class="ONav FL cBlue">
				<li>
					<a href="javascript:void(0)" class="hover">
						<div>
							<div>
								<%=SystemEnv.getHtmlLabelName(30956,user.getLanguage())%>
							</div>
						</div> </a>
				</li>
			</ul>
			<div class="clear"></div>

		</div>
		<div class="FL ML33" style="height:25px;width:475px;">
		<table width="458" border="0" cellpadding="0" cellspacing="1"
			class="stripe OTable">
			<tr id="OTable2" class="cBlack">
				
				<td width="20%" align="center">
					<strong><%=SystemEnv.getHtmlLabelName(30957,user.getLanguage())%></strong>
				</td>
				<td width="73%" align="center">
					<strong><%=SystemEnv.getHtmlLabelName(23752,user.getLanguage())%></strong>
				</td>
			</tr>
		</table>
		<div class="FR" style="height:24px;width:16px;background-color:#eeeeee; margin-top:-26px"></div>
		</div>
		<div class="OContRightScroll FL OHeaderLayerW8 ML33" style="height:272px">
			<table id="webTable2gd" width="458" border="0" cellpadding="0" cellspacing="1"
				class="stripe OTable">
			<%
			/* 	String sqldoc = " select tc.*,td.accessoriesname"+
								" from docdetail tb ,("+
								" select ta.docid,ta.imagefileid,ta.imagefilename "+
								" from docimagefile ta where docid in("+affixdoc+") and imagefilename like '%"+searchaffix+"%') tc,"+
								" mytrainaccessoriestype td"+
								" where tc.docid = tb.id and tb.maincategory = td.mainid and tb.subcategory = td.subid and tb.seccategory = td.secid";
				//System.out.println(sqldoc); */
				searchaffix=searchaffix.replace("_","\\_");
				String sqldoc="  select imagefileid,imagefilename from imagefile ta where imagefileid in("+affixdoc+") and imagefilename like '%"+searchaffix+"%' ESCAPE '\\'";
				rs.execute(sqldoc);
				while(rs.next()){
			 %>	
			 	<tr>
					
					<td width="20%" align="center">
						<%
						  String _type=m.get(rs.getString("imagefileid"))+"";
						   if(_type.equals("lmlicense")){
								out.print(""+SystemEnv.getHtmlLabelName(30958,user.getLanguage()));
							}else if(_type.equals("lmconstitution")){
								out.print(""+SystemEnv.getHtmlLabelName(30941,user.getLanguage()));
							}else if(_type.equals("lmshare")){
								out.print(""+SystemEnv.getHtmlLabelName(28421,user.getLanguage()));
							}else if(_type.equals("lmdirectors")){
								out.print(""+SystemEnv.getHtmlLabelName(30936,user.getLanguage()));
							}else{
								out.print("");
							} 
						%>
					</td>
					<td width="73%">
						<A href="/weaver/weaver.file.FileDownload?fileid=<%=rs.getString("imagefileid") %>&download=1" class='aContent0 FL'><%=rs.getString("imagefilename") %></A>
					</td>
				</tr>
				
				
			<%
				}
			  %>
			</table>
		</div>
	</div>
</div>
<!--表头浮动层 end-->

<script type="text/javascript">
	/* 关闭 已打开的面板 */
	function closeMaint4Win()
	{
		jQuery("#searchImg").qtip('hide');
		jQuery("#searchImg").qtip('destroy');
	}
	
	//全部选择操作，复选框
	function selectall_chk(Tcheck){
	   if(Tcheck.checked==true){
	      $("input[type=checkbox][inWhichPage='gd']").each(function(){
				 $(this).attr("checked",true);
		  });
	   }else{
		  $("input[type=checkbox][inWhichPage='gd']").each(function(){
				 $(this).attr("checked",false);
		  });
	   }
	}
	 
	//选中其中的一个
	function selectone_chk(){
	    jQuery("#fileid").attr("checked",false); 
	}
	
	
</script>