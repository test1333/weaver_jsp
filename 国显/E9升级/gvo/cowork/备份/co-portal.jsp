<%@page import="weaver.general.TimeUtil"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.conn.*" %>
<%@ page import="java.util.Date"%>
<%@ page import="gvo.cowork.PortalTransUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs_dt" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="CoworkService" class="weaver.cowork.CoworkService" scope="page" />
<jsp:useBean id="DocSearchManage" class="weaver.docs.search.DocSearchManage" scope="page" />
<jsp:useBean id="sharemanager" class="weaver.share.ShareManager" scope="page" />
<html>
<%
int userid=user.getUID();
PortalTransUtil ptu = new PortalTransUtil();
String sql = "select name from nickname where userid = "+userid;
String sql_dt = "";
rs.executeQuery(sql);
boolean hasnickname = false;
if(rs.getCounts()>0){
 hasnickname = true;
}

if(!hasnickname) {
  response.sendRedirect("/cowork/nickname/coworknicknameview.jsp?loca=99") ;
   return ;
}



%>
<head>
	<title>论坛</title>
	<meta charset="UTF-8">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<link rel="stylesheet" href="css/index.css?v=4.7" type="text/css" />
<link rel="stylesheet" href="/wui/theme/ecology8/jquery/js/zDialog_e8_wev8.css" type="text/css" />
<body>
	<div id = "forum">
		<div class = "header">
			<div>
				<ul class = "header_ul">
					<li>
						<div class = "logo_div"><img src = "img/logo.png"/></div>
					</li>
					<li class = "hed_mea head_forum">
						<a href = "/cowork/coworkview.jsp" target="_blank" class = "a">我的论坛</a>
					</li>
					<li class = "hed_mea">
						<a href = "/cowork/CoworkRelatedFrame.jsp" target="_blank" class = "a">与我相关</a>
					</li>
					<li class = "hed_mea">
						<a href = "/cowork/CoworkCollectFrame.jsp" target="_blank" class = "a" >我的收藏</a>
					</li>
					<li class = "hed_mea">
						<a href = "/cowork/CoworkMineFrame.jsp" target="_blank" class = "a">我的贴子</a>
					</li>
					<li id = "seacher">
						<div class = "seacher_div">
							<div id = "seacher_input_d">
								<input type = "text" class = "seacher_input" placeholder="请输入搜索内容" />
							</div>
							<div id = "seacher_button"></div>
						</div>
					</li>
				</ul>
			</div>
		</div>
		<div class = "content">
			<div class = "modual">
				<div class = "modual_content">
					<div class = "modual_img">
						<img src = "img/slider.png"/>
					</div>
					<div class = "modual_fun">
						<ul class = "modual_ul">
						<%
						 sql = "select id,mc,tpdz from  (select * from uf_co_bk_mt where sfqy='0' order by xssx asc) where rownum<=8";
						 rs.execute(sql);
						 while(rs.next()){
							String bkid = Util.null2String(rs.getString("id"));
							String mc = Util.null2String(rs.getString("mc"));	
							String tpdz = Util.null2String(rs.getString("tpdz"));
						%>
							<li class = "modual_li">
								<div class = "modual_fun_img">
									<img src = "<%=tpdz%>"/>
								</div>
								<div class = "modual_fun_text">
									<div class = "modual_info_title"><%=mc%></div>
									<%
										int dtcount =0;
										sql_dt = "select count(1) as count from uf_co_bk_mt_dt1 where mainid="+bkid;
										rs_dt.execute(sql_dt);
										if(rs_dt.next()){
											dtcount = rs_dt.getInt("count");
										}
										if(dtcount<=4){
								     %>
									 <ul class = "modual_info_ul">
									 <%
										}else{
									 %>
									 <ul class = "modual_info_ul" id = "two_clos" >
									 <%
										}
										sql_dt = "select nr,ljdz from (select * from uf_co_bk_mt_dt1 where mainid="+bkid+" order by xssx asc) where rownum<=8";
										rs_dt.execute(sql_dt);
										while(rs_dt.next()){
											String nr = Util.null2String(rs_dt.getString("nr"));
											String ljdz = Util.null2String(rs_dt.getString("ljdz"));
										%>
											<li class = "modual_info_li">
												<a href = "<%=ljdz%>" class = "com_a" target="_blank">
												<span id = "disc">·</span>	
													<%=nr%>
												</a>
											</li>
										<%
										}
									%>
										
									</ul>
								</div>
							</li>

						<%		
						 }
						
						%>
						
						</ul>
					</div>
				</div>
			</div>
			<div class = "news">
				<div class = "news_tg">
					<div class = "news_tg_title">
						<span class = "news_tg_name">热帖推荐</span>
						<span class = "news_tg_more">
							<a href = "/gvo/cowork/co-rtjh-list-Url.jsp" target="_blank">更多</a>
						</span>
					</div>
					<div class = "news_tg_split">
						<div class = "split_title">HOT NOTE RECOMMENDATION</div>
						<div class = "split_hr"></div>
					</div>
					<div class = "news_tg_ul_dt1">
						<ul>
						<%
						int rtcount = 1;
							sql = "select rownum,a.* from (select t.id,dis.id as dis,case when dis.topdiscussid = 0 then dis.id else dis.topdiscussid end as topdiscussid,dis.createdate as cjsj"+
							" from ( select t1.id,t1.name,t1.status,t1.typeid,t1.creater,t1.principal,t1.begindate,t1.enddate,t1.replyNum,t1.readNum,t1.lastdiscussant,t1.lastupdatedate,t1.lastupdatetime,t1.isApproval,t1.approvalAtatus,t1.isTop  from cowork_items t1   ) t,cowork_discuss dis,cowork_cream cre,uf_co_rt cort"+
							" where 1 = 1 and t.id=dis.coworkid and dis.id=cre.discussID and cre.id=cort.rt  and cort.sfqy=0 and cre.status='0' and (t.approvalAtatus=0 or (t.approvalAtatus=1 and (creater="+userid+" or principal="+userid+" )))  order by cort.px asc) a where rownum<=8";
							//out.print(sql);
							rs.execute(sql);
							while(rs.next()){
								String xh = Util.null2String(rs.getString("rownum"));
								String topdiscussid = Util.null2String(rs.getString("topdiscussid"));
								String cjsj = Util.null2String(rs.getString("cjsj"));
								String rtbt = ptu.getJhTitle(topdiscussid);
								rtcount++;
						%>
							<li class = "news_li">
								<div class = "nwes_order"><%=xh%></div>
								<div class = "news_content">
									<a href = "" target="_blank" class = "a rttj" value="<%=topdiscussid%>">	
										<%=rtbt%>
									</a>
								</div>
								<div class = "news_date"><%=cjsj%></div>
							</li>
						<%

							}
		
						%>
						<%
							sql = "select rownum,a.* from (select t.id,dis.id as dis,case when dis.topdiscussid = 0 then dis.id else dis.topdiscussid end as topdiscussid,dis.createdate as cjsj"+
							" from ( select t1.id,t1.name,t1.status,t1.typeid,t1.creater,t1.principal,t1.begindate,t1.enddate,t1.replyNum,t1.readNum,t1.lastdiscussant,t1.lastupdatedate,t1.lastupdatetime,t1.isApproval,t1.approvalAtatus,t1.isTop  from cowork_items t1   ) t,cowork_discuss dis,cowork_cream cre"+
							" where 1 = 1 and t.id=dis.coworkid and dis.id=cre.discussID  and cre.status='0' and cre.id not in(select rt from uf_co_rt where sfqy='0') and (t.approvalAtatus=0 or (t.approvalAtatus=1 and (creater="+userid+" or principal="+userid+" )))  order by cre.id desc) a where rownum<=8";
							//out.print(sql);
							rs.execute(sql);
							while(rs.next()){
								if(rtcount >8){
									break;
								}
								String xh = Util.null2String(rs.getString("rownum"));
								String topdiscussid = Util.null2String(rs.getString("topdiscussid"));
								String cjsj = Util.null2String(rs.getString("cjsj"));
								String rtbt = ptu.getJhTitle(topdiscussid);
								
						%>
							<li class = "news_li">
								<div class = "nwes_order"><%=rtcount%></div>
								<div class = "news_content">
									<a href = "" target="_blank" class = "a rttj" value="<%=topdiscussid%>">	
										<%=rtbt%>
									</a>
								</div>
								<div class = "news_date"><%=cjsj%></div>
							</li>
						<%
							rtcount++;
							}
		
						%>
							
						</ul>
					</div>
				</div>
				<div class = "active_tg">
					<div class = "active_tg_title">
						<span class = "news_tg_name">活动报名</span>
						<span class = "news_tg_more">
							<a href = "/gvo/cowork/co-hdbm-list-Url.jsp" target="_blank">更多</a>
						</span>
					</div>
					<div class = "news_tg_split">
						<div class = "split_title">REGISTRATION OF ACTIVITLES</div>
						<div class = "split_hr"></div>
					</div>
					<div>
						<ul class = "active_tg_ul">
						<%
						sql= "select rownum,a.* from (select t1.id,t3.hdbt,doccreatedate as createtime,doccreaterid "+
						" from DocDetail  t1,uf_co_hdbm_mt t3"+
						" where t1.id=t3.wd and t3.sfyx='0'  and ( ( t1.docstatus = 7 and  ( (t1.doccreaterid="+userid+" or t1.ownerid="+userid+")) ) or t1.docstatus in ('1','2','5')  )   and  (isreply!=1 or isreply is null)  and seccategory!=0 and (ishistory is null or ishistory = 0) order by t3.xssx asc) a where rownum<=8";
						rs.execute(sql);
						while(rs.next()){
							String xh = Util.null2String(rs.getString("rownum"));
							String createtime = Util.null2String(rs.getString("createtime"));
							String hdbt = Util.null2String(rs.getString("hdbt"));
							String docid = Util.null2String(rs.getString("id"));
						%>
							<li class = "news_li" >
								<div class = "nwes_order"><%=xh%></div>
								<div class = "news_content" >
									<a href = "/docs/docs/DocDsp.jsp?id=<%=docid%>" target="_blank" class = "a">
										<%=hdbt%>
									</a>
								</div>
								<div class = "news_date" ><%=createtime%></div>
							</li>
						<%	
						}
						%>
							
							
						</ul>
					</div>
				</div>
			</div>
		</div>
		<div class = "footer">
			<div class = "footer_div">
				<ul class = "footer_ul">
					<li class = "footer_li">
						<a href = "/docs/docs/DocDsp.jsp?id=361406" target="_blank">
							<div class = "footer_img">
								<img src = "img/gywm.gif"/>
							</div>
							<div class = "footer_title">关于我们</div>
						</a>
					</li>
					<li class = "footer_li">
						<a href = "/docs/docs/DocDsp.jsp?id=361391" target="_blank">
							<div class = "footer_img">
								<img src = "img/glgd.gif"/>
							</div>
							<div class = "footer_title">管理规定</div>
						</a>
					</li>
					<li class = "footer_li">
						<a href = "/docs/docs/DocDsp.jsp?id=361530" target="_blank">
							<div class = "footer_img">
								<img src = "img/bzzx.gif"/>
							</div>
							<div class = "footer_title">帮助中心</div>
						</a>
					</li>
					<li class = "footer_li">
						<a href = "/gvo/cowork/contact.jsp" target="_blank" id = "lxwm">
							<div class = "footer_img">
								<img src = "img/lxwm.gif"/>   
							</div>
							<div class = "footer_title">联系我们</div>
						</a>
					</li>
				</ul>
			</div>
		</div>
	</div>
<script type="text/javascript" src = "js/index.js?v=4.0"></script>
<script type="text/javascript">
		
		function getCoworkDialog(title,width,height){
            diag =new window.top.Dialog();
            diag.currentWindow = window; 
            diag.Modal = true;
            diag.Drag=true;
            diag.Width =width?width:680;
            diag.Height =height?height:420;
            diag.ShowButtonRow=false;
            diag.Title = title;
            //diag.Left=($(window.top).width()-235-width)/2+235;
            return diag;
}
	function ViewCoworkDiscuss(id){
        diag=getCoworkDialog("楼层信息",600,480);
        diag.URL = "/cowork/ViewCoWorkDiscuss.jsp?discussids="+id;
        diag.show();
	}
	jQuery(document).ready(function(){
		jQuery(".rttj").click(function(){
			var topdiscussid = jQuery(this).attr("value");
			ViewCoworkDiscuss(topdiscussid)
			return false;

		});
		jQuery("#seacher_button").click(function(){
			var textarea_val = jQuery(".seacher_input").val();
			if(textarea_val === ""){
				alert("请输入要搜索的关键字");
				return false;
			}
			window.open("/gvo/cowork/co-xzcx-list-Url.jsp?searchnr="+textarea_val,"_blank")

		});
	})
</script>
</body>
</html>
