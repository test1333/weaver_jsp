	jQuery(document).ready(function(){
		
		//浏览器自适应宽度/高度
		var win_height = jQuery(window).height();
		var modualt_width = jQuery(".modual").width();
		
		jQuery(".content").css("height",Number(win_height-140)+"px");
		jQuery(".modual_fun .modual_ul").css("margin-left",Number(Number(modualt_width)-Number(modualt_width*0.20*4)-120)/2+"px");




		//交互动态
		jQuery(".header li a,.news_content a,.news_li,.modual_info_li a").hover(
			function(){
				jQuery(this).addClass("blue");
　　　　		},
			function(){
     　　　　	jQuery(this).removeClass("blue");
			}
		)

		//页脚交互效果
		jQuery(".footer_li").hover(function(){
			
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

		},function(){
			jQuery(".footer_li .footer_title").css("color","#333333");
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
		});



		//热帖推荐
		jQuery(".news_tg .split_hr").css("width",
			Number(jQuery(".news_tg_split").width())-Number(jQuery(".split_title").width())-20+"px");
		jQuery(".news_tg .news_content").css("width",
			Number(jQuery(".news_tg .news_li").width())-115+"px");

		//活动报名
		jQuery(".active_tg .news_tg_split .split_hr").css("width",
			Number(jQuery(".active_tg .news_tg_split").width())-
				Number(jQuery(".active_tg .split_title").width())-20+"px");


		//键盘事件
		jQuery(document).keydown(function(e){
			setRightMeau();
		});

		//鼠标滑轮事件
		$(document).bind('mousewheel', function(e){
			setRightMeau();
		});



		//重新计算布局右侧文档目录
		function setRightMeau(){
			jQuery(".news_tg .news_content").css("width",
				Number(jQuery(".news_tg .news_li").width())-Number(jQuery(".news_tg .news_date").width())-45+"px");
		}
		
		jQuery(".active_tg .news_content").css("width",
			Number(jQuery(".active_tg .news_li").width())-115+"px");
	});
