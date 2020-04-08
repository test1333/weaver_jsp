<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
jQuery(document).ready(function(){
	var yfkbl = "#field12343";//主表 预付款比例1
	var sfyPO = "#field12094";//主表 是否有PO
	var wsje = "#field12374";//主表 本次请款未税金额
	var hsje = "#field12373";//主表 本次请款含税金额
	var hxmjehs_dt1 = "#field12308_";//明细1 行项目金额(含税)
	var hxmjews_dt1 = "#field12308_";//明细1 行项目金额(含税)
	var cgddsqyfje_dt1 = "#field12326_";//明细1 采购订单申请预付金额
	var cgddsyDPje_dt1 = "#field12129_";//明细1 采购订单剩余DP金额
	jQuery(wsje).attr("readonly", "readonly");
	jQuery(hsje).attr("readonly", "readonly");
	var indexnum0 = jQuery("#indexnum0").val();
	for(var index=0; index<indexnum0;index++){
		
	}
	jQuery(sfyPO).bind('change',function(){
		alert(1);
		var sfyPO_val = jQuery(sfyPO).val();
		if(sfyPO_val=="1"){
			//是否有PO==否
			jQuery("#fktj").hide();
                        jQuery("#pozje").hide();
		}else{
			jQuery("#fktj").show();
                        jQuery("#pozje").show();
		}
		
	});     
	
	
	checkCustomize = function () {
		var yfkbl_val = jQuery(yfkbl).val();
		var wsje_val = jQuery(wsje).val();
		var hsje_val = jQuery(hsje).val();
		var indexnum0 = jQuery("#indexnum0").val();

		if(wsje_val=="0.00" || hsje_val=="0.00"){
			Dialog.alert("本次请款未税金额和本次请款含税金额未填写,请检查");
			return false;
		}
		var countnum=0;
		for(var index=0; index<indexnum0;index++){
			alert(1);
			var hxmjehs_dt1_val = jQuery(hxmjehs_dt1+index).val();   
			var cgddsyDPje_dt1_val = jQuery(cgddsyDPje_dt1+index).val();
			var test = Number(yfkbl_val)*Number(hxmjehs_dt1_val);
			test = test.toFixed(2);
			alert(test);
			jQuery(cgddsqyfje_dt1+index).val(test);//采购订单申请预付金额=行项目金额(含税)*预付款比例1
            var cgddsqyfje_dt1_val = jQuery(cgddsqyfje_dt1+index).val(); 
            countnum = countnum +1;
			if(Number(cgddsqyfje_dt1_val)>Number(cgddsyDPje_dt1_val)){
				Dialog.alert("明细 第"+countnum+"行明细采购订单申请预付金额大于采购订单剩余DP金额,请检查");
				return false;
            }
			
			
            
        }
		return true;
    }
	   	   
})

</script>































