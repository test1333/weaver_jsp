<%@page import="weaver.general.TimeUtil"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.conn.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<html>
<%
int userid=user.getUID();
String sql = "select name from nickname where userid = "+userid;
rs.executeQuery(sql);
boolean hasnickname = false;
if(rs.getCounts()>0){
 hasnickname = true;
}

if(!hasnickname) {
  response.sendRedirect("/cowork/nickname/coworknicknameview.jsp") ;
   return ;
}



%>
<head>
	<title>论坛</title>
	<meta charset="UTF-8">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<link rel="stylesheet" href="css/index.css" type="text/css" />
<style type="text/css">
	*{
		padding:0px;
		margin:0px;
		font-family:'Microsoft YaHei';
		font-family:'微软雅黑';
	}

	html,body{
		height:100%;
		overflow: auto;
		background:rgb(240,242,245);
	}
	#forum{
		height:100%;
		min-width: 498px;
		max-width:10000px; 
		overflow:auto;
	}
	#forum .header{
		height:80px;
		background:rgb(255,255,255);
		position:fixed;
		left:0px; 
		top:0px;
		width:100%;
		z-index: 999; 
	}
	#forum .footer{
		position:fixed; 
		left:0px; 
		bottom:0px; 
		width:100%; 
		height:110px; 
		background:rgb(255,255,255);
	}
	li,a{
		list-style-type: none;
		text-decoration: none;
	}
	#forum .header ul{
		height:80px;
		background:rgb(255,255,255);
		display: inline-block;
		line-height: 80px;
		width:100%;
	}
	.header  li {
		background:rgb(255,255,255);
		color:#333333;
		font-size: 14px;
		font-weight:500;
	}
	.header  li a {
		background-color:rgb(255,255,255);
	}
	.logo{
		line-height: 80px;
	}

	.logo .logo_div img{
		width:100%;
		height:100%;	
	}
	#forum .content{
		position:relative;
		margin-top:85px;
		overflow:auto;
		background:rgb(240,242,245);
	}
	#forum .content .modual{
		position:absolute;
		width:65%;
		top:0px;
		left:0px;
	}
	#forum .content .news{
		position:absolute;
		width:35%;
		top:0px;
		right:0px;
	}
	.modual_content{
		height:210px;
		width:80%;
		margin-left: 10%

	}
	.modual_img{
		height:210px;
	}
	.modual_img img{
		width:100%;
		height:100%;
		background-repeat:no-repeat;
	}

	.modual_fun .modual_ul {
		margin-top:20px;
	}
	.modual_fun .modual_ul .modual_li{
		margin-top:30px;
		width:20%;
		float:left;
		margin-right:30px;
		height:70px;
		position:relative;
	}
	.modual_fun .modual_ul .modual_fun_img{
		position: absolute;
		height:70px;
		width:70px;
		top:0px;
		left:0px;
		border-radius: 50%;
	}
	.modual_fun_img img{
		width:100%;
		height:100%;
		border-radius: 50%;
	}
	.modual_fun .modual_ul .modual_fun_text{
		position:absolute;
		height:75px;
		width:50%;
		right:0px;
		top:0px;
		overflow:hidden;
	}
	.footer_div{
		margin:0px auto;
		height:100%;
		width:80%;
		background-color:rgb(255,255,255);
	}
	.modual_info_title{
		height:20px;
		font-size: 14px;
		font-weight:bold;
		color:rgba(51,51,51,1);
		line-height: 20px;
	}
	.modual_fun_text .modual_info_ul{
		width:100%;
		margin-top:0px;
		color:#666666;
		margin-left:2px;
		overflow: hidden;
	}
	.modual_info_ul .modual_info_li{
		font-size: 10px;
		white-space: nowrap; 
		text-overflow: ellipsis;  
		-o-text-overflow: ellipsis; 
		overflow: hidden;  
		list-style-type:disc; 
	}
	.footer_div .footer_ul {
		height:100%;
		width:100%;
		background-color: rgb(255,255,255);
	}
	.footer_div .footer_ul .footer_li{
		height:100%;
		width:20%;
		float:left;
		margin-left: 4%;
		background-color: rgb(255,255,255);
	}
	.footer_img{
		height:50px;
		width:50px;
		margin:20px auto;
	}
	.footer_title{
		margin:-15px auto;
		text-align: center;
		font-size: 13px;
		color: #333333;
		font-weight: 500;
		background-color: rgb(255,255,255);
	}
	.footer_img img{
		width:100%;
		height:100%;
	}
	.news_tg{
		height:210px;
	}
	.news_tg_title{
		height:30px;
		line-height: 30px;
		color: #333333;
		font-weight:bold;
		font-size: 20px;
	}
	.news_tg_more{
		float:right;
		margin-right: 20px;
		font-size: 14px;
		color:#696969;
	}
	.news_tg_split{
		height:15px;
		color:#999999;
		font-size: 12px;
		line-height: 15px;
		position:relative;
		margin-top:5px;
	}
	.split_title{
		top:0px;
		position: absolute;
		left: 0px;
	}
	.split_hr{
		top:0px;
		position:absolute;
		right: 0px;
		border-bottom: 1.5px solid #ADADAE;
		height:15px;
		margin-right: 20px;
		width:315px;
	}
	.news_tg_ul_dt1{
		margin-top:5px;
	}
	.news_tg_ul_dt1 ul{
		margin-right: 20px;

	}
	.news_tg_ul_dt1 ul .news_li{
		position:relative;
	}
	.news_tg_ul_dt1 ul .news_li div{
		float:left;
	}
	.nwes_order,.news_content,.news_date{
		margin-top:5px;
	}
	.nwes_order{
		top:0px;
		left:0px;
		width:20px;
		height:20px;
		text-align: center;
		line-height: 20px;
		color:#999999;
	}
	.news_content{
		top:0px;
		left:25px;
		width:300px; 
		white-space:nowrap; 
		text-overflow:ellipsis; 
		-o-text-overflow:ellipsis; 
		overflow: hidden; 
		color: #999999;
		margin-left: 15px;
	}
	.news_date{
		top:0px;
		left:325px;
		right:0px;
		text-align: right;
		white-space:nowrap; 
		text-overflow:ellipsis; 
		-o-text-overflow:ellipsis; 
		overflow: hidden; 
	}
	.active_tg{
		margin-top:30px;
	}
	.news_tg_more a{
		color:#333333;
	}
	.active_tg_title .news_tg_name{
		line-height: 30px;
	    color: #333333;
	    font-weight: bold;
	    font-size: 20px;
	} 
	.news_tg_more{
		line-height: 30px;
	    color: #333333;
	    font-weight: bold;;
	}

	.news_tg_ul_dt1 ul li:nth-child(1) .nwes_order,
	.news_tg_ul_dt1 ul li:nth-child(2) .nwes_order,
	.news_tg_ul_dt1 ul li:nth-child(3) .nwes_order,
	.active_tg ul li:nth-child(1) .nwes_order,
	.active_tg ul li:nth-child(2) .nwes_order,
	.active_tg ul li:nth-child(3) .nwes_order{
		border-radius: 50%;
		background-color: #2277FF;
		color:rgb(255,255,255);
	}
	
	.active_tg_ul .news_li div{
		float:left;
	}
	.active_tg .news_tg_split .split_hr{
		width:330px;
	}
	.a,.news_li{
		color:#999999
	}
	.blue{
		color:#003fff;
	}
	.div{
		color:#999999;
	}
	.header div{
		width:90%;
		height:100%;
		margin:0px auto;
	}
	.header_ul{
		width:100%;
		height:100%;
	}
	.header_ul li{
		width:16.6%;
		float:left;
		height:100%;
	}
	.header_ul .logo_div{
		height:50px;
		width:130px;
		margin:0px auto;
		margin-top:15px;
		margin-left: 5px;
	}
	.hed_mea{
		margin-left: -5%;
	}
	.head_forum{
		margin-left: 1%;
	}
	#seacher{
		width:30%;
		text-align: right;
	}
	.seacher_div{
		width:100%;
		position:relative;
	}
	.seacher_input{
		height:30px;
		text-indent: 2px;
		width:90%;
		color:#999999;
		font-size: 14px;
	}
	.header_ul{
		color:#333333;
	}
	#seacher_input_d{
		width:89%;
		position: absolute;

	}
	#seacher_button{
		border:1px solid red;
		width:10%;
		position:absolute;
		right:3px;
		height:32px;
		margin-top:23px;
		line-height: 30px;
		background:rgb(58,120,255);
		text-align: center;
		border:1px solid rgb(58,120,255);
		background-image: url(img/serach.gif);
		background-position: center 10px;
		background-repeat: no-repeat;
		cursor: pointer; 
	}
</style>
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
							 sql = "select id,mc from  (select * from uf_co_bk_mt where sfqy='0' order by xssx asc) where rownum<=8";
							 rs.execute(sql);
							 while(rs.next()){
								 String bkid = Util.null2String(rs.getString("id"));
								 String mc = Util.null2String(rs.getString("mc"));			
							 }
							%>
							<li class = "modual_li">
								<div class = "modual_fun_img">
									<img src = "img/gldt.png"/>
								</div>
								<div class = "modual_fun_text">
									<div class = "modual_info_title">管理动态</div>
									<ul class = "modual_info_ul">
										<li class = "modual_info_li">管理思基督教的大家都觉得基督教的</li>
									</ul>
								</div>
							</li>
							<li class = "modual_li">
								<div class = "modual_fun_img">
									<img src = "img/whsq.png"/>
								</div>
								<div class = "modual_fun_text">
									<div class = "modual_info_title">文化社区</div>
									<ul class = "modual_info_ul">
										<li class = "modual_info_li">维动力</li>
										<li class = "modual_info_li">维信诺之光</li>
										<li class = "modual_info_li">维动力</li>
										<li class = "modual_info_li">维动力</li>
									</ul>
								</div>
							</li>
							<li class = "modual_li">
								<div class = "modual_fun_img">
									<img src = "img/jcsh.png"/>
								</div>
								<div class = "modual_fun_text">
									<div class = "modual_info_title">精彩生活</div>
									<ul class = "modual_info_ul">
										<li class = "modual_info_li">读书 社团</li>
										<li class = "modual_info_li">运动 党委</li>
										<li class = "modual_info_li">旅游</li>
										<li class = "modual_info_li">亲子</li>
									</ul>
								</div>
							</li>
							<li class = "modual_li">
								<div class = "modual_fun_img">
									<img src = "img/ywjl.png"/>
								</div>
								<div class = "modual_fun_text">
									<div class = "modual_info_title">业务交流</div>
									<ul class = "modual_info_ul">
										<li class = "modual_info_li">技术交流</li>
										<li class = "modual_info_li">TPM提案改善</li>
									</ul>
								</div>
							</li>
							<li class = "modual_li">
								<div class = "modual_fun_img">
									<img src = "img/blsh.png"/>
								</div>
								<div class = "modual_fun_text">
									<div class = "modual_info_title">便利生活</div>
									<ul class = "modual_info_ul">
										<li class = "modual_info_li">房租租赁</li>
										<li class = "modual_info_li">拼车出行</li>
										<li class = "modual_info_li">失物招领</li>
									</ul>
								</div>
							</li>
							<li class = "modual_li">
								<div class = "modual_fun_img">
									<img src = "img/jsgy.png"/>
								</div>
								<div class = "modual_fun_text">
									<div class = "modual_info_title">集思广益</div>
									<ul class = "modual_info_ul">
										<li class = "modual_info_li">留言板</li>
									</ul>
								</div>
							</li>
							<li class = "modual_li">
								<div class = "modual_fun_img">
									<img src = "img/yjjy.png"/>
								</div>
								<div class = "modual_fun_text">
									<div class = "modual_info_title">意见建议</div>
									<ul class = "modual_info_ul">
										<li class = "modual_info_li">已解决问题</li>
										<li class = "modual_info_li">论坛公告</li>
									</ul>
								</div>
							</li>
							<li class = "modual_li">
								<div class = "modual_fun_img">
									<img src = "img/jdjj.png"/>
								</div>
								<div class = "modual_fun_text">
									<div class = "modual_info_title">监督检举</div>
									<ul class = "modual_info_ul">
										<li class = "modual_info_li">直接总裁</li>
										<li class = "modual_info_li">员工检举</li>
									</ul>
								</div>
							</li>
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

						%>
							<li class = "news_li">
								<div class = "nwes_order">1</div>
								<div class = "news_content">
									<a href = "https://www.baidu.com" target="_blank" class = "a">	
										这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容
									</a>
								</div>
								<div class = "news_date">2019-09-05 10:23</div>
							</li>
							<li class = "news_li">
								<div class = "nwes_order">2</div>
								<div class = "news_content">
									<a href = "https://www.baidu.com" target="_blank" class = "a">	
										这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容
									</a>
								</div>
								<div class = "news_date">2019-09-05 10:23</div>
							</li>
							<li class = "news_li">
								<div class = "nwes_order">3</div>
								<div class = "news_content">
									<a href = "https://www.baidu.com" target="_blank" class = "a">	
										这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容
									</a>
								</div>
								<div class = "news_date">2019-09-05 10:23</div>
							</li>
							<li class = "news_li">
								<div class = "nwes_order">4</div>
								<div class = "news_content">
									<a href = "https://www.baidu.com" target="_blank" class = "a">	
										这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容
									</a>
								</div>
								<div class = "news_date">2019-09-05 10:23</div>
							</li>
							<li class = "news_li">
								<div class = "nwes_order">5</div>
								<div class = "news_content">
									<a href = "https://www.baidu.com" target="_blank" class = "a">	
										这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容
									</a>
								</div>
								<div class = "news_date">2019-09-05 10:23</div>
							</li>
						</ul>
					</div>
				</div>
				<div class = "active_tg">
					<div class = "active_tg_title">
						<span class = "news_tg_name">活动报名</span>
						<span class = "news_tg_more">
							<a href = "https//www.baidu.com">更多</a>
						</span>
					</div>
					<div class = "news_tg_split">
						<div class = "split_title">REGISTRATION OF ACTIVITLES</div>
						<div class = "split_hr"></div>
					</div>
					<div>
						<ul class = "active_tg_ul">
							<li class = "news_li">
								<div class = "nwes_order">1</div>
								<div class = "news_content">
									<a href = "https://www.baidu.com" target="_blank" class = "a">
										这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容
									</a>
								</div>
								<div class = "news_date">2019-09-05 10:23</div>
							</li>
							<li class = "news_li">
								<div class = "nwes_order">2</div>
								<div class = "news_content">
									<a href = "https://www.baidu.com" target="_blank" class = "a">
										这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容
									</a>
								</div>
								<div class = "news_date">2019-09-05 10:23</div>
							</li>
							<li class = "news_li">
								<div class = "nwes_order">3</div>
								<div class = "news_content">
									<a href = "https://www.baidu.com" target="_blank" class = "a">
										这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容
									</a>
								</div>
								<div class = "news_date">2019-09-05 10:23</div>
							</li>
							<li class = "news_li">
								<div class = "nwes_order">4</div>
								<div class = "news_content">
									<a href = "https://www.baidu.com" target="_blank" class = "a">
										这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容
									</a>
								</div>
								<div class = "news_date">2019-09-05 10:23</div>
							</li>
							<li class = "news_li">
								<div class = "nwes_order">5</div>
								<div class = "news_content">
									<a href = "https://www.baidu.com" target="_blank" class = "a">
										这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容
									</a>
								</div>
								<div class = "news_date">2019-09-05 10:23</div>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<div class = "footer">
			<div class = "footer_div">
				<ul class = "footer_ul">
					<li class = "footer_li">
						<a href = "#">
							<div class = "footer_img">
								<img src = "img/gywm.gif"/>
							</div>
							<div class = "footer_title">关于我们</div>
						</a>
					</li>
					<li class = "footer_li">
						<a href = "#">
							<div class = "footer_img">
								<img src = "img/glgd.gif"/>
							</div>
							<div class = "footer_title">管理规定</div>
						</a>
					</li>
					<li class = "footer_li">
						<a href = "#">
							<div class = "footer_img">
								<img src = "img/bzzx.gif"/>
							</div>
							<div class = "footer_title">帮助中心</div>
						</a>
					</li>
					<li class = "footer_li">
						<a href = "contact.html" target="_blank" id = "lxwm">
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
<script type="text/javascript">
	jQuery(document).ready(function(){
		
		//浏览器自适应宽度/高度
		var win_height = jQuery(window).height();
		var mf_li_width = jQuery(".modual_fun ul .modual_li").eq(0).width();
		var modualt_width = jQuery(".modual").width();
		jQuery(".content").css("height",Number(win_height-190)+"px");
		jQuery(".modual_fun .modual_ul").css("margin-left",Number(Number(modualt_width)-Number(modualt_width*0.20*4)-120)/2+"px");
		jQuery(".news_date").css("width",jQuery(".news_tg_ul_dt1 ul .news_li").width()-50-jQuery(".news_content").width());
		jQuery(".active_tg .active_tg_ul .news_date").css("width",jQuery(".active_tg ul .news_li").width()-50-jQuery(".news_content").width());


		//交互动态
		jQuery(".header li a,.news_content a,.news_li").hover(
			function(){
				jQuery(this).addClass("blue");
　　　　		},
			function(){
     　　　　	jQuery(this).removeClass("blue");
			}
		)

		//页脚点击效果
		jQuery(".footer_li").click(function(){
			
			//字体颜色
			jQuery(".footer_li .footer_title").css("color","#333333");
			jQuery(this).find('.footer_title').css('color', 'rgb(58,120,255)');


			//所有logo src
			var logoSrc= jQuery(".footer_li").find('.footer_img img').attr("src");
			
			jQuery(".footer_li .footer_img img ").each(function(i){
				var logoSrc = jQuery(".footer_li").eq(i).find('.footer_img img').attr("src");
				if(logoSrc.indexOf("_act") >= 0 ){
					var subAfterSrc = logoSrc.replace("_act","");
					jQuery(".footer_li").eq(i).find('.footer_img img').attr("src",subAfterSrc);
				}else{
					jQuery(".footer_li").eq(i).find('.footer_img img').attr("src",logoSrc);
				}
			});

			var afterSrc = jQuery(this).find('.footer_img img').attr("src");
			var sub_src = afterSrc.substring(afterSrc.lastIndexOf('/')+1, afterSrc.lastIndexOf('.')); 
			jQuery(this).find('.footer_img img').attr('src',"img/"+sub_src+"_act.gif");
			return false;
		});

		//搜索
		jQuery("#seacher_button").click(function(){
			var textarea_val = jQuery(".seacher_input").val();
			if(textarea_val === ""){
				alert("请输入要搜索的关键字");
				return false;
			}
			alert(textarea_val);

		});
		
	});
</script>
</body>
</html>
