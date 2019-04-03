<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var ywlx="#field33780";//业务类型
var wllx="#field33781";//物料类型
var wllxid="field33781";
var butt1="#butt1";//明细1button K-基本视图数据
var butt2="#butt2";//明细2button E-采购视图
var butt3="#butt3";//明细3button D-MRP视图
var butt4="#butt4";//明细4button L-工厂存储视图
var butt5="#butt5";//明细5button Q-质量管理视图
var butt6="#butt6";//明细6button B-G财务会计视图
var butt7="#butt7";//明细7button V-销售视图
var butt8="#butt8";//明细8button A-工作计划视图
var butt9="#butt9";//明细9button X-删除标识

var wlbm_dt1="field34733_";//SAP物料编码	
var wlms_dt1="field33097_";//物料描述明细1
var jbjldw_dt1="field33093_";//基本计量单位明细1
var wlz_dt1="field33098_";//物料组明细1	
var zldw_dt1="field33094_";//重量单位明细1
var mz_dt1="field33038_";//毛重明细1
var jz_dt1="field33039_";//净重明细1
var kgcwlzt_dt1="field33095_";//跨工厂物料状态明细1
var spbzsm_dt1="field33040_";//审批备注说明明细1					
	
var zhjsm_dt4="field33560_";//总货架寿命
var zxsyhjsm_dt4="field33559_";//最小剩余货架寿命
var jgkz_dt6="field33588_";//价格控制
var bzjg_dt6="field33591_";//标准价格
var jgqd_dt6="field33592_";//价格确定
var mrplx_dt3="field33242_";//MRP类型
var mrpkzz_dt3="field33243_";//MRP控制者
var zdhd_dt3="field33244_";//再订货点
var pldxcl_dt3="field33245_";//批量大小策略
var gdpldx_dt3="field33246_";//固定批量大小
var jhclz_dt3="field33269_";//计划策略组
var zhmrp_dt3="field33274_";//综合MRP
var ywlx_old="";
var wllx_old="";
jQuery(document).ready(function(){
	  var ywlx_val = jQuery(ywlx).val();
	   if(ywlx_val !=''){
	   	   ywlx_old = ywlx_val;
	          jQuery(ywlx+"_browserbtn").attr('disabled',true);
	    }	
	     var wllx_val = jQuery(wllx).val();
	   if(wllx_val !=''){
	          jQuery(wllx+"_browserbtn").attr('disabled',true);
	    }
	    if(ywlx_val=='A01'){
	   removeaddcheckmain(ywlx_val);
	}
        showhideButton(ywlx_val,wllx_val);
        changedt4();
        changedt1();
        changedt6();
        changedt3();
	  jQuery(ywlx).bindPropertyChange(function () {
	  	  jQuery(ywlx+"_browserbtn").attr('disabled',true);
		  var ywlx_val = jQuery(ywlx).val();
		  var wllx_val = jQuery(wllx).val();
                if(ywlx_old==''){
                	ywlx_old = ywlx_val; 
              }else{
               jQuery(ywlx).val(ywlx_old);
                jQuery(ywlx+"span").text(ywlx_old);	  
            }
		  if(ywlx_val !="A01"){
		       jQuery(wllx+"_browserbtn").attr('disabled',true);
		       jQuery(wllx).val("");
		       jQuery(wllx+"span").text("");
		  }else{
		    removeaddcheckmain(ywlx_val);
		 }
		  showhideButton(ywlx_val,wllx_val);
	 })
	jQuery(wllx).bindPropertyChange(function () {
	  	  jQuery(wllx+"_browserbtn").attr('disabled',true);
		  var wllx_val = jQuery(wllx).val();
		  var ywlx_val = jQuery(ywlx).val();
		  showhideButton(ywlx_val,wllx_val);
		  changedt1();
		     if(wllx_old==''){
                	wllx_old = wllx_val; 
              }else{
               jQuery(wllx).val(wllx_old);
                jQuery(wllx+"span").text(wllx_old);	  
            }
	 })
	jQuery("#indexnum0").bindPropertyChange(function () {
		
			setTimeout('changedt1()',1000);
	});
	jQuery("#indexnum3").bindPropertyChange(function () {
			setTimeout('changedt4()',1000);

	});
	jQuery("#indexnum5").bindPropertyChange(function () {
			setTimeout('changedt6()',1000);
	});
	jQuery("#indexnum2").bindPropertyChange(function () {
	setTimeout('changedt3()',1000);
	});
	
});	

    function removeaddcheckmain(ywlx_val){

	  var wllx_val = jQuery(wllx).val();
	if(ywlx_val =='A01'){
		 if(wllx_val==''){
     	 	 	   jQuery("#"+wllxid+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
     	   }
     	 
     	    var needcheck = document.all("needcheck");
                if(needcheck.value.indexOf(","+wllxid)<0){
                  if(needcheck.value!='') needcheck.value+=",";
                   needcheck.value+=wllxid;
                }
     }else{
     	  jQuery("#"+wllxid+"spanimg").html("");
     	     var parastr = document.all('needcheck').value;
                parastr = parastr.replace(","+wllxid,"");
                document.all('needcheck').value=parastr;
     }
}

function changedt3(){
	var indexnum3= jQuery("#indexnum2").val();
	 for(var index=0;index <indexnum3;index++){
	      if(jQuery("#"+mrplx_dt3+index).length>0){
	          bindchangedt3(index);
	           var mrplx_dt3_val= jQuery("#"+mrplx_dt3+index).val();
	         removeaddcheckdt(mrplx_dt3_val,"PD",mrpkzz_dt3,'1',index);
	         removeaddcheckdt(mrplx_dt3_val,"VB",zdhd_dt3,'0',index); 
	           var pldxcl_dt3_val= jQuery("#"+pldxcl_dt3+index).val();
	             removeaddcheckdt(pldxcl_dt3_val,"FX",gdpldx_dt3,'0',index); 
	            var jhclz_dt3_val= jQuery("#"+jhclz_dt3+index).val();
         removeaddcheckdt3(jhclz_dt3_val,index); 
            }
	}
}
function bindchangedt3(index){
      jQuery("#"+mrplx_dt3+index).bindPropertyChange(function () {
         var mrplx_dt3_val= jQuery("#"+mrplx_dt3+index).val();
         removeaddcheckdt(mrplx_dt3_val,"PD",mrpkzz_dt3,'1',index); 
          removeaddcheckdt(mrplx_dt3_val,"VB",zdhd_dt3,'0',index); 
       })
        jQuery("#"+pldxcl_dt3+index).bindPropertyChange(function () {
         var pldxcl_dt3_val= jQuery("#"+pldxcl_dt3+index).val();
         removeaddcheckdt(pldxcl_dt3_val,"FX",gdpldx_dt3,'0',index); 
       })
       jQuery("#"+jhclz_dt3+index).bindPropertyChange(function () {
    
         var jhclz_dt3_val= jQuery("#"+jhclz_dt3+index).val();
         removeaddcheckdt3(jhclz_dt3_val,index); 
       })
  }
    function removeaddcheckdt3(jhclz_dt3_val,index){

	var zhmrp_dt3_val = jQuery("#"+zhmrp_dt3+index).val();
	var zhmrp=zhmrp_dt3+index;
	if(jhclz_dt3_val =='11' || jhclz_dt3_val =='70'){
		 if(zhmrp_dt3_val==''){
     	 	 	   jQuery("#"+zhmrp_dt3+index+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
     	   }
     	 
     	    var needcheck = document.all("needcheck");
                if(needcheck.value.indexOf(","+zhmrp)<0){
                  if(needcheck.value!='') needcheck.value+=",";
                   needcheck.value+=zhmrp;
                }
     }else{
     	  jQuery("#"+zhmrp_dt3+index+"spanimg").html("");
     	     var parastr = document.all('needcheck').value;
                parastr = parastr.replace(","+zhmrp,"");
                document.all('needcheck').value=parastr;
     }
}
function changedt6(){
	var indexnum5= jQuery("#indexnum5").val();
	 for(var index=0;index <indexnum5;index++){
	      if(jQuery("#"+jgkz_dt6+index).length>0){
	          bindchangedt6(index);
	           var jgkz_dt6_val= jQuery("#"+jgkz_dt6+index).val();
	         //removeaddcheckdt6(jgkz_dt6_val,index);
	         removeaddcheckdt(jgkz_dt6_val,"S",bzjg_dt6,'0',index);
            }
	}
}
function bindchangedt6(index){
      jQuery("#"+jgkz_dt6+index).bindPropertyChange(function () {
         var jgkz_dt6_val= jQuery("#"+jgkz_dt6+index).val();
           //removeaddcheckdt6(jgkz_dt6_val,index);
           removeaddcheckdt(jgkz_dt6_val,"S",bzjg_dt6,'0',index);
           if(jgkz_dt6_val=="S"){
           	    jQuery("#"+jgqd_dt6+index).val("3");
           	     jQuery("#"+jgqd_dt6+index+"span").text("3")
           	   	 jQuery("#"+jgqd_dt6+index+"spanimg").html("");
           }
           if(jgkz_dt6_val=="V"){
           	    jQuery("#"+jgqd_dt6+index).val("2");
           	     jQuery("#"+jgqd_dt6+index+"span").text("2")
           	   	 jQuery("#"+jgqd_dt6+index+"spanimg").html("");
           }
       })
  }
  
  function removeaddcheckdt(yz,bjz,btid,flag,index){
	var btid_val = jQuery("#"+btid+index).val();
	var btid_check=btid+index;
	if(yz ==bjz){
		 if(btid_val==''){
		 	         if(flag=='0'){ 
     	 	 	   jQuery("#"+btid+index+"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
     	 	 	  }else{
     	 	 	 jQuery("#"+btid+index+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
     	 	 	  } 	  
     	 	 	 
     	   }
     	 
     	    var needcheck = document.all("needcheck");
                if(needcheck.value.indexOf(","+btid_check)<0){
                  if(needcheck.value!='') needcheck.value+=",";
                   needcheck.value+=btid_check;
                }
     }else{
     	    if(flag=='0'){ 
     	  jQuery("#"+btid+index+"span").html("");
     	}else{
     	 jQuery("#"+btid+index+"spanimg").html("");
             }
     	     var parastr = document.all('needcheck').value;
                parastr = parastr.replace(","+btid_check,"");
                document.all('needcheck').value=parastr;
     }
}

  function removeaddcheckdt6(jgkz_dt6_val,index){
	var bzjg_dt6_val = jQuery("#"+bzjg_dt6+index).val();
	var bzjg=bzjg_dt6+index;
	if(jgkz_dt6_val =='S'){
		 if(bzjg_dt6_val==''){
     	 	 	   jQuery("#"+bzjg_dt6+index+"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
     	   }
     	 
     	    var needcheck = document.all("needcheck");
                if(needcheck.value.indexOf(","+bzjg)<0){
                  if(needcheck.value!='') needcheck.value+=",";
                   needcheck.value+=bzjg;
                }
     }else{
     	  jQuery("#"+bzjg_dt6+index+"span").html("");
     	     var parastr = document.all('needcheck').value;
                parastr = parastr.replace(","+bzjg,"");
                document.all('needcheck').value=parastr;
     }
}
function changedt4(){
	var indexnum3 = jQuery("#indexnum3").val();
	 for(var index=0;index <indexnum3;index++){
	      if(jQuery("#"+zhjsm_dt4+index).length>0){
	          bindchangedt4(index);
	           var zhjsm_dt4_val= jQuery("#"+zhjsm_dt4+index).val();
	          removeaddcheckdt4(zhjsm_dt4_val,index);
            }
	}
}


function removeaddcheckdt4(zhjsm_val,index){
	var zxsyhjsm_dt4_val = jQuery("#"+zxsyhjsm_dt4+index).val();
	var zxsyhjsm=zxsyhjsm_dt4+index;
	if(zhjsm_val !=''){
		 if(zxsyhjsm_dt4_val==''){
     	 	 	   jQuery("#"+zxsyhjsm_dt4+index+"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
     	   }
     	 
     	    var needcheck = document.all("needcheck");
                if(needcheck.value.indexOf(","+zxsyhjsm)<0){
                  if(needcheck.value!='') needcheck.value+=",";
                   needcheck.value+=zxsyhjsm;
                }
     }else{
     	  jQuery("#"+zxsyhjsm_dt4+index+"span").html("");
     	     var parastr = document.all('needcheck').value;
                parastr = parastr.replace(","+zxsyhjsm,"");
                document.all('needcheck').value=parastr;
     }
}
function bindchangedt4(index){
      jQuery("#"+zhjsm_dt4+index).bind("change",function () {
         var zhjsm_dt4_val= jQuery("#"+zhjsm_dt4+index).val();
            removeaddcheckdt4(zhjsm_dt4_val,index);
       })
  }
function changedt1(){
    var 	indexnum0 = jQuery("#indexnum0").val();
    	var wllx_val = jQuery(wllx).val();
	var ywlx_val = jQuery(ywlx).val();
    for(var index=0;index <indexnum0;index++){
      if(jQuery("#"+wlbm_dt1+index).length>0){
       
     	 if(ywlx_val == "A01" && (wllx_val=="Z007"||wllx_val=="HALB"||wllx_val=="ZFT1"||wllx_val=="FERT")){
     	 	 if(jQuery("#"+wlbm_dt1+index).val()==''){
     	 	 	   jQuery("#"+wlbm_dt1+index+"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
     	        }
     	 	 var wlbm=wlbm_dt1+index;
     	    var needcheck = document.all("needcheck");
                if(needcheck.value.indexOf(","+wlbm)<0){
                  if(needcheck.value!='') needcheck.value+=",";
                   needcheck.value+=wlbm;
                }
                 jQuery("#"+wlbm_dt1+index).removeAttr("readonly");
     	}else if(ywlx_val == "A02"){
	    jQuery("#"+wlbm_dt1+index).attr("readonly", "readonly");
	        jQuery("#"+wlms_dt1+index).attr("readonly", "readonly");
	    jQuery("#"+jbjldw_dt1+index+"_browserbtn").attr('disabled',true);
	     jQuery("#"+wlz_dt1+index+"_browserbtn").attr('disabled',true);
	       jQuery("#"+zldw_dt1+index+"_browserbtn").attr('disabled',true);
	    jQuery("#"+mz_dt1+index).attr("readonly", "readonly");
	      jQuery("#"+jz_dt1+index).attr("readonly", "readonly");
	         jQuery("#"+kgcwlzt_dt1+index+"_browserbtn").attr('disabled',true);
	        jQuery("#"+spbzsm_dt1+index).attr("readonly", "readonly");
     	}else{
     	     jQuery("#"+wlbm_dt1+index).attr("readonly", "readonly");	
    		}
     }
   
   }
    
}
 function showhideButton(ywlx_val,wllx_val){
 	 if(ywlx_val==''){
 	 	jQuery(butt1).hide();
 	      jQuery(butt2).hide();
 	      jQuery(butt3).hide();
 	      jQuery(butt4).hide();
 	      jQuery(butt5).hide();
 	      jQuery(butt6).hide();
 	      jQuery(butt7).hide();
 	      jQuery(butt8).hide();
 	      jQuery(butt9).hide();
       }
       if(ywlx_val=="A01" || ywlx_val=="A03" ){
 	 	jQuery(butt1).show();
 	 	jQuery(butt2).show();
 	 	jQuery(butt3).show();
 	 	jQuery(butt4).show();
 	 	jQuery(butt5).show();
 	 	jQuery(butt6).show();
 	 	jQuery(butt7).show();
 	 	jQuery(butt8).show();
 	 	if(ywlx_val=="A03"){
 	 		    jQuery("button[name=addbutton0]").css('display','none');
 	     }
 	      jQuery("button[name=addbutton1]").css('display','none');
 	  	jQuery("button[name=addbutton2]").css('display','none');
 	      jQuery("button[name=addbutton3]").css('display','none');
 	     jQuery("button[name=addbutton4]").css('display','none');
 	 jQuery("button[name=addbutton5]").css('display','none');
 	 jQuery("button[name=addbutton6]").css('display','none');
 	 jQuery("button[name=addbutton7]").css('display','none');
 	 	   jQuery(butt9).hide();
       }
          if(ywlx_val=="A02"  ){
          	 jQuery(butt1).show();
 	 	jQuery(butt2).show();
 	 	jQuery(butt3).show();
 	 	jQuery(butt4).show();
 	 	jQuery(butt5).show();
 	 	jQuery(butt6).show();
 	 	jQuery(butt7).show();
 	 	jQuery(butt8).show();
 	 	   jQuery(butt9).hide();
 	jQuery("button[name=addbutton0]").css('display','none');
 	jQuery("button[name=addbutton1]").css('display','none');
 	 jQuery("button[name=addbutton2]").css('display','none');
 	 jQuery("button[name=addbutton3]").css('display','none');
 	 jQuery("button[name=addbutton4]").css('display','none');
 	 jQuery("button[name=addbutton5]").css('display','none');
 	 jQuery("button[name=addbutton6]").css('display','none');
 	 jQuery("button[name=addbutton7]").css('display','none');
       }
       
       if(ywlx_val=="A05"){
       	jQuery(butt1).hide();
 	      jQuery(butt2).hide();
 	      jQuery(butt3).hide();
 	      jQuery(butt4).hide();
 	      jQuery(butt5).hide();
 	      jQuery(butt6).hide();
 	      jQuery(butt7).hide();
 	      jQuery(butt8).hide();
 	 	jQuery(butt9).show();
 	 	jQuery("button[name=addbutton8]").css('display','none');
       }
}
</script>	


