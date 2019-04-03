
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.general.StaticObj" %>
<%@ page import="java.util.*"%>

<%@ page import="weaver.hrm.HrmUserVarify"%>
<%@ page import="weaver.hrm.User"%>

<%@ page import="weaver.systeminfo.menuconfig.MenuMaint"%>
<%@ page import="weaver.systeminfo.SystemEnv"%>
<%@page import="weaver.general.GCONST,weaver.filter.MultiLangFilter"%>
<%@ page import="weaver.general.IsGovProj" %>
<%@page import="weaver.rdeploy.portal.PortalUtil"%>
<jsp:useBean id="baseBean" class="weaver.general.BaseBean" scope="page" />
<jsp:useBean id="MouldStatusCominfo" class="weaver.systeminfo.MouldStatusCominfo" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<%
    /*用户验证*/
    User user = HrmUserVarify.getUser(request, response);
    if (user == null) {
        response.sendRedirect("/login/Login.jsp");
        return;
    }
%>

<%
	//判断是否有微搜功能
	boolean microSearch=weaver.fullsearch.util.RmiConfig.isOpenMicroSearch();
    MenuMaint mm = new MenuMaint("left", 3, user.getUID(), user.getLanguage());
    String skin = (String)request.getAttribute("REQUEST_SKIN_FOLDER");
	 StaticObj staticobj = null;
    staticobj = StaticObj.getInstance();
    String software = (String)staticobj.getObject("software") ;
    if(software == null) software="ALL";

    int isgoveproj = Util.getIntValue(IsGovProj.getPath(),0);//0:非政务系统，1：政务系统
    String Customertype = Util.null2String(""+user.getType()) ;
    String logintype = Util.null2String(user.getLogintype()) ;
%>
<%
//获得动态绑定的搜索栏
RecordSet.executeSql("select * from mode_toolbar_search where isusedsearch=1 order by showorder");
%>
<style style="text/css">
    .searchBlockBgDiv {
	    float: left;
	    padding-top: 20px;
	    width: 230px;
	    height: 35px;
	   /*margin-left: 30px;*/
	    padding: 0;
	   /*margin-top: 7px!important;*/
	    background-color:#f0eded;
    }
    ._searchkeywork {outline:none;width: 130px;color:#674b48!important;font-size: 12px;height:32px !important;margin-top:1;background-color:transparent;border:none !important;line-height:30px;}
    .dropdown {
        padding-left:5px; 
        font-size:11px; 
        color:#000;
        height:35px;
        border-left:1px solid transparent;
        border-top:1px solid transparent;
        border-right:1px solid transparent;
    }
    .selectContent, .selectTile, .dropdown ul { margin:0px; padding:0px;}
    .selectContent { position:relative;z-index:6; }
    .dropdown a, .dropdown a:visited { color:#666666; text-decoration:none; outline:none;}
    .dropdown a:hover { color:#5d4617;}
    .selectTile a:hover { color:#5d4617;}
    .selectTile a {background:none; display:block;width:40px;margin-left:4px;margin-top:1px;}
    .selectTile a span {cursor:pointer; display:block; padding:6 0 0 0;background:none;height:25px;font-size:14px; }
    .selectContent ul { 
        background:#fff none repeat scroll 0 0; 
        border-left:1px solid #d0d0d0; 
        border-right:1px solid #d0d0d0;
        border-bottom:1px solid #d0d0d0;
        color:#C5C0B0; 
        display:none;
        left:-6px; 
        position:absolute; 
        top:8px; 
        
        min-width:50px; 
        list-style:none;}
    .selectContent ul a{
        position:relative;
        display: block;
    }
    
    .selectContent ul img{
        position:absolute;
        top:2px;
        display: block;
    }
    .selectContent ul span{
        padding-right:10px;
        padding-left:27px;
        white-space:nowrap;
        display:block;
        
    }
    .dropdown span.value { display:none;}
    .selectContent ul li{list-style:none;!important;height:25px;color:#656565}
    .selectContent ul li a { padding:0px; display:block;margin:0;height:25px;line-height:21px;font-size:14pt; }
    .selectContent ul li a:hover { background-color:#218bde;color:#fff!important;}
    .selectContent ul li a img {border:none;vertical-align:middle;padding-left:8px;}
    .selectContent ul li a span {margin-left:5px;}
    .flagvisibility { display:none;}
    .sampleSelected{
        background-color:#fff;
        border-left:1px solid rgb(170,210,242);
        border-top:1px solid rgb(170,210,242);
        border-right:1px solid rgb(170,210,242);
    }
    .sampleSelected .selectTile a span{
        color:#4a4a4a!important;
    }
    .sampleSelected .selectTile a div{
        color:#fff!important;
    }
    .sampleSelected .e8_dropdown{
        background-image:url(/wui/theme/ecology8/page/images/toolbar/up_wev8.png)!important;
    }
    .dropdown .e8_dropdown{
        background-image:url(/portal/plugin/images/fx_img/jt_1.png);
        width:12px;
        height:12px;
        float:left;
        margin-top:10px;
        background-position:50% 50%;
        background-repeat: no-repeat;
    }
    .keywordsearchbtn {
    float: right;
    background-color:#f0eded;
    height: 35px;
    width: 30px;
    }
    .searchTxtSplit {
    color: #d1d1d1;
    font-size: 16px;
    }
	
</style>

<script type="text/javascript">
<!--
function topMenuBgIframeOnload(_this) {
	_this.contentWindow.document.body.style.background = 'transparent';
	_this.contentWindow.document.body.style.border='none';
}
//-->
</script>
	<form name="searchForm" method="post" action="/system/QuickSearchOperation.jsp" target="_blank">
		<div class="searchBlockBgDiv slideItemText" style="overflow:visible;position:absolute;left:0px;top:0px;"></div>
			
					<input type="hidden" name="searchtype" value="<%=microSearch?9:2%>">
					<input type="hidden" id="mainid" name="mainid" value="">
					<input type="hidden" id="stype" name="stype" value="">
					<input type="hidden" id="fieldname" name="fieldname" value="">
						<div id="sample" class="dropdown" style="float:left;position:absolute;left:0px;top:0px">
							<div class="selectTile">
								<a href="#" style="width:57px;">
									<span style="height:35px;line-height:28px;float:left;width:32px;display:block;overflow:hidden;text-overflow:ellipsis;color:#666666;padding:0;" class="searchTxt">
										<%=microSearch?
												SystemEnv.getHtmlLabelName(31953,user.getLanguage()):
												SystemEnv.getHtmlLabelName(30042,user.getLanguage())%>
									</span>
									<div class="e8_dropdown"></div>
									<!--background: url(/wui/theme/ecology8/skins/default/page/ecologyShellImg_wev8.png);background-repeat: no-repeat; background-position: -262px  -62px;-->
									<div style="float:right;display: block; width:8px;height:18px;*height:18px;margin-top:3px;" class="searchTxt searchTxtSplit">|</div>
								</a>
							</div>
							<div class="selectContent" style="margin-top:26px;*margin-top:20px;_margin-top:0px;">
								<ul id="searchBlockUl">
									<iframe src="" style="filter:alpha(opacity=0);opacity:0;position:absolute; visibility:inherit; top:0px; left:0px; width:100%; height:100%; z-index:-1; filter='progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)';" >
									</iframe>
									<% if(microSearch){ %>
									<li><a href="#"><img src="/wui/theme/ecology8/page/images/toolbar/ws_wev8.png"/><span searchType="9"><%=SystemEnv.getHtmlLabelName(31953,user.getLanguage())%></span></a></li>
									<%}%>
									<li><a href="#"><img src="/wui/theme/ecology8/page/images/toolbar/hrs_wev8.png"/><span searchType="2"><%=SystemEnv.getHtmlLabelName(30042,user.getLanguage())%></span></a></li>
									<li><a href="#"><img src="/wui/theme/ecology8/page/images/toolbar/wls_wev8.png"/><span searchType="5"><%=SystemEnv.getHtmlLabelName(30045,user.getLanguage())%></span></a></li>
									<li><a href="#"><img src="/wui/theme/ecology8/page/images/toolbar/docs_wev8.png"/><span searchType="1"><%=SystemEnv.getHtmlLabelName(30041,user.getLanguage())%></span></a></li>
								<%if(isgoveproj==0){%>
									<%if((Customertype.equals("3") || Customertype.equals("4") || !logintype.equals("2"))&&("1".equals(MouldStatusCominfo.getStatus("crm"))||"".equals(MouldStatusCominfo.getStatus("crm")))){%> 
									<li><a href="#"><img src="/wui/theme/ecology8/page/images/toolbar/crm_wev8.png"/><span searchType="3"><%=SystemEnv.getHtmlLabelName(30043,user.getLanguage())%></span></a></li>
									<%
									}
								}
									%>
										<%if("1".equals(MouldStatusCominfo.getStatus("cwork"))||"".equals(MouldStatusCominfo.getStatus("cwork"))) {%>
									<li><a href="#"><img src="/wui/theme/ecology8/page/images/toolbar/xz_wev8.png"/><span searchType="8"><%=SystemEnv.getHtmlLabelName(30047,user.getLanguage())%></span></a></li>
								<%} %>
								<%
								if (PortalUtil.isShowEMail()) {
								%>
									<!--<li><a href="#"><img src="/wui/theme/ecology8/page/images/toolbar/mail_wev8.png"/><span searchType="7"><%=SystemEnv.getHtmlLabelName(71,user.getLanguage())%></span></a></li>-->
								<%
								}
								%>
							<%
								if(isgoveproj==0&&("1".equals(MouldStatusCominfo.getStatus("proj"))||"".equals(MouldStatusCominfo.getStatus("proj")))){%>
									<li><a href="#"><img src="/wui/theme/ecology8/page/images/toolbar/p_wev8.png"/><span searchType="6"><%=SystemEnv.getHtmlLabelName(30046,user.getLanguage())%></span></a></li>
								<%
								}
								%>
							<%
								if((!logintype.equals("2")) && software.equals("ALL")&&("1".equals(MouldStatusCominfo.getStatus("cpt"))||"".equals(MouldStatusCominfo.getStatus("cpt")))){%>
									<li><a href="#"><img src="/wui/theme/ecology8/page/images/toolbar/zc_wev8.png"/><span searchType="4"><%=SystemEnv.getHtmlLabelName(30044,user.getLanguage())%></span></a></li>
								<%
								}
								%>
							
								<%  
								    while(RecordSet.next()){
								       String tempName = RecordSet.getString("searchname");
								       if(tempName.length() > 2){
								    	   tempName = tempName.substring(0,2);  
								       }
								    %>
                                  <li>
                                      <a href="#"><img height="14" width="14" src="<%=RecordSet.getString("imageurl") %>"/><span searchType="10"><%=tempName %></span></a>
                                      <span style="display:none;" name="mainid" ><%=RecordSet.getInt("mainid") %></span>
                                      <span style="display:none;" name="stype"><%=RecordSet.getInt("serachtype") %></span>
                                      <span style="display:none;" name="fieldname"><%=RecordSet.getInt("searchField") %></span>
                                  </li>
                                
                                <% } %>
								
								</ul>
							</div>
						</div>
						
						<div style="float:left;vertical-align :middle;position:absolute;left:70px;top:0px;height:35px;" >
							<input type="text" id="searchvalue" name="searchvalue" onfocus="clearVal(this);" onblur="recoverVal(this);" class="_searchkeywork" value="<%=SystemEnv.getHtmlLabelName(84128,user.getLanguage()) %>" style="vertical-align:middle;color:#674b48;"/>
						</div>
						<div class="keywordsearchbtn" style="position:absolute;left:200px;top:0px;">
							<div  onclick="clearVal(document.getElementById('searchvalue'));searchForm.submit()" id="searchbt" style="cursor:pointer;height:100%;width:100%;">
								<img style="vertical-align:middle;margin-top:5px;position:absolute;left:3px" src="/portal/plugin/images/opzm/icon4.png"></img>
							</div>
						</div>
						
				 </form>


<!-- For slide-->
<script type="text/javascript" src="/wui/common/jquery/plugin/jquery.cycle.all_wev8.js"></script>
<script type="text/javascript" src="/wui/common/jquery/plugin/jquery.easing_wev8.js"></script>
<script type="text/javascript" src="/js/ecology8/jQueryRotate_wev8.js"></script>    
<script language="javascript">
 
jQuery(document).ready(function(){
     jQuery(".selectTile a").click(function() {
	        //jQuery("#searchBlockUl").hide();
	        //jQuery("#searchBlockUl").closest("div#sample").removeClass("sampleSelected");
            jQuery(".selectContent ul").toggle();
            if(jQuery(".selectContent ul").css("display")=="none"){
                jQuery(this).closest("div#sample").removeClass("sampleSelected");
            }else{
                jQuery(this).closest("div#sample").addClass("sampleSelected");
            }
     });
	jQuery(".selectContent ul li a").click(function() {
            //获得元素信息
            var sibling = jQuery(this).nextAll();
            if(sibling.length > 0){
                for(var i=0; i<sibling.length;i++){
                    if($(sibling[i]).attr("name") == "mainid"){
                        $("#mainid").val($(sibling[i]).html());
                    }else if($(sibling[i]).attr("name") == "stype"){
                        $("#stype").val($(sibling[i]).html());
                    }else{
                        $("#fieldname").val($(sibling[i]).html());
                    }
                }
            }
            var text = jQuery(this).children("span").html();
            jQuery(".selectTile a").children("span").html(text);
            jQuery("input[name='searchtype']").val(jQuery(this).children("span").attr("searchType"));
            jQuery(".selectContent ul").hide();
            jQuery(this).closest("div#sample").removeClass("sampleSelected");
        });
        jQuery(document).bind('click', function(e) {
            var $clicked = jQuery(e.target);
            if (! $clicked.parents().hasClass("dropdown")){
                jQuery(".selectContent ul").hide();
                jQuery(".selectContent ul").closest("div#sample").removeClass("sampleSelected");
            }
        });
});
var user_lang = <%=user.getLanguage()%>;
function clearVal(obj){
    if(obj.value=='请输入关键词搜索'||obj.value=='Please enter a keyword to search '){
        obj.value="";
    }
    //jQuery(obj).css("color","#fff");
}

function recoverVal(obj){
    if(obj.value==''||obj.value==null){
        if(user_lang=='7'){
            obj.value="请输入关键词搜索";
        }else{
            obj.value="Please enter a keyword to search ";
        }
        //jQuery(obj).css("color","#429ce1");
    }
}

</script>