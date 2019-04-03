function sycal() {
    //alert(1111);
    var userlist = new Array();
    userlist = document.getElementsByName("ids"); //（通过name获取页面输入的值）
    var amBeginTime = "#SHamBeginTimeAll";
    var amEndTime = "#SHamEndTimeAll";
    var pmBeginTime = "#SHpmBeginTimeAll";
    var pmEndTime = "#SHpmEndTimeAll";
    var effeStartDateAll = "#SHeffeStartDateAll";
    var effeEndDateAll = "#SHeffeEndDateAll";
    var invalidDateAll = "#SHinvalidDateAll";
    //alert("userlist="+userlist.length);
    var amBeginTime_val = jQuery(amBeginTime).val();
    var amEndTime_val = jQuery(amEndTime).val();
    var pmBeginTime_val = jQuery(pmBeginTime).val();
    var pmEndTime_val = jQuery(pmEndTime).val();
    var effeStartDateAll_val = jQuery(effeStartDateAll).val();
    var effeEndDateAll_val = jQuery(effeEndDateAll).val();
    var invalidDateAll_val = jQuery(invalidDateAll).val();
    //alert("amBeginTime_val="+amBeginTime_val);
    for (var i=0;i<userlist.length;i++) { 
    	//alert("userlist="+userlist[i].value);
    	var tmp_amBeginTime = "#amBeginTime"+userlist[i].value;
    	var tmp_amEndTime = "#amEndTime"+userlist[i].value;
    	var tmp_pmBeginTime = "#pmBeginTime"+userlist[i].value;
    	var tmp_pmEndTime = "#pmEndTime"+userlist[i].value;
    	var tmp_effeStartDate = "#effeStartDate"+userlist[i].value;
    	var tmp_effeEndDate = "#effeEndDate"+userlist[i].value;
    	var tmp_invalidDate = "#invalidDate"+userlist[i].value;

    	jQuery(tmp_amBeginTime+"SH").val(amBeginTime_val);
		jQuery(tmp_amBeginTime+"Span").html(amBeginTime_val);
		jQuery(tmp_amEndTime+"SH").val(amEndTime_val);
		jQuery(tmp_amEndTime+"Span").html(amEndTime_val);
		jQuery(tmp_pmBeginTime+"SH").val(pmBeginTime_val);
		jQuery(tmp_pmBeginTime+"Span").html(pmBeginTime_val);
		jQuery(tmp_pmEndTime+"SH").val(pmEndTime_val);
		jQuery(tmp_pmEndTime+"Span").html(pmEndTime_val);
		jQuery(tmp_effeStartDate+"SH").val(effeStartDateAll_val);
		jQuery(tmp_effeStartDate+"Span").html(effeStartDateAll_val);
		jQuery(tmp_effeEndDate+"SH").val(effeEndDateAll_val);
		jQuery(tmp_effeEndDate+"Span").html(effeEndDateAll_val);
		jQuery(tmp_invalidDate+"SH").val(invalidDateAll_val);
		jQuery(tmp_invalidDate+"Span").html(invalidDateAll_val);
        //alert("tmp_amBeginTime="+tmp_amBeginTime);
        //alert("tmp_amBeginTime+empid_val="+tmp_amBeginTime+"span");
    }
    



}