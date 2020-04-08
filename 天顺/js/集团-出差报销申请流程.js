<script type="text/javascript" src="/interface/ctrip/js/CtripOrderTicket.js"></script>
<script type="text/javascript">
    var aqjb = '#field20355';//安全级别
	var fysfcb = '#field20062';//费用是否超标
    var csjb_dt4 = '#field20354_';//明细4城市级别
    var ts_dt4 = '#field20095_';//明细4天数
    var jezs_dt4 = '#field20097_';//明细4金额住宿
	var fylx_dt3 = '#field20090_';//明细3费用类型
	var zgls_dt3 = '#field20353_';//明细3总公里数
    jQuery(document).ready(function() {
        checkCustomize = function() {
			var aqjb_val = jQuery(aqjb).val();        
			var	fysfcb_val = jQuery(fysfcb).val();    		
			var zsbz_val=0;
            var count =1;		
			if(fysfcb_val != "0"){
				if(aqjb_val != '100'){
					var indexnum4 = jQuery("#indexnum3").val();
					for (var index = 0; index < indexnum4; index++) {
						if(jQuery(csjb_dt4+index).length>0){
							var csjb_dt4_val = jQuery(csjb_dt4+index).val();
							var ts_dt4_val = jQuery(ts_dt4+index).val();
							var jezs_dt4_val = jQuery(jezs_dt4+index).val();
							if(csjb_dt4_val != "" && ts_dt4_val != "" && jezs_dt4_val !=""){
								if(Number(aqjb_val)>=90){
									if(csjb_dt4_val == "0"){
										zsbz_val = 700;
									}else if(csjb_dt4_val == "1"){
										zsbz_val = 500;
									}else if(csjb_dt4_val == "2"){
										zsbz_val = 400;
									}else if(csjb_dt4_val == "3"){
										zsbz_val = 1400;
									}
									 
								}else{
									if(csjb_dt4_val == "0"){
										zsbz_val = 350;
									}else if(csjb_dt4_val == "1"){
										zsbz_val = 280;
									}else if(csjb_dt4_val == "2"){
										zsbz_val = 230;
									}else if(csjb_dt4_val == "3"){
										zsbz_val = 1400;
									}
									
								}
								var hjje = accMul(ts_dt4_val,zsbz_val);
								if(Number(jezs_dt4_val)>Number(hjje)){
									alert("住宿第"+count+"行明细，申请费用超过差旅标准，请检查！");
									return false;
								}
							}
							count++;
						}
					}
				}
				count =1;	
				if(Number(aqjb_val) < Number('30') ){
					var indexnum3 = jQuery("#indexnum2").val();
					for (var index = 0; index < indexnum3; index++) {
						if(jQuery(fylx_dt3+index).length>0){
							var fylx_dt3_val = jQuery(fylx_dt3+index).val();
							var zgls_dt3_val = jQuery(zgls_dt3+index).val();
							if(fylx_dt3_val != "" && zgls_dt3_val != "" ){
								if(fylx_dt3_val == "2"){
									if(Number(zgls_dt3_val)>Number('200')){
										alert("交通第"+count+"行明细，私车公用里程超标，请检查！");
										return false;
									}
								}
							}
							count++;
						}
					}
				}
			}
			return true;
        }
    })

function accMul(arg1,arg2)
{
  var m=0,s1=arg1.toString(),s2=arg2.toString();
  try{m+=s1.split(".")[1].length}catch(e){}
  try{m+=s2.split(".")[1].length}catch(e){}
  return Number(s1.replace(".",""))*Number(s2.replace(".",""))/Math.pow(10,m)
}



</script>


