jQuery(document).ready(function() {
    //alert("加载document");
    checkCustomize = function() {
		//alert("提交");
		var result = true;
		var grqk = "field6641";//个人欠款
		var cdxjkje = "field18145";//冲借支金额
		
		var grqk_c = jQuery("#"+grqk).val();
		var cdxjkje_c = jQuery("#"+cdxjkje).val();
		
		result = getdbycf();
		
		if(Number(cdxjkje_c)>Number(grqk_c))
		{
			Dialog.alert("\"冲借支金额\"不能大于\"个人欠款\"！");
			result = false; 
		}
		
		return result;
	}
	
	function getdbycf()
	{
		var jjycf_m = "#field30865";//单笔交际应酬费(MAX)
        var fykm_d = "field7556_";//费用科目编码
        var je = "field6009_";//金额
		var nowRow = parseInt($G("indexnum0").value);
		var fykm_str = "";
		var result = true;
	    //费用-交际应酬费=6602130000
        var temp = "0";
        for(var i=0;i<=nowRow;i++){
		    if(jQuery("#"+fykm_d+i).length>0)
			{
				fykm_str = jQuery("#"+fykm_d+i).val();
				if (fykm_str=="6602130000")
				{
					var temp_1 = jQuery("#"+je+i).val();
					if(Number(temp_1) >= Number(temp)){ temp = temp_1;}	
				}
			}
	    }
        jQuery(jjycf_m).val(temp);
		return result;
	}
});