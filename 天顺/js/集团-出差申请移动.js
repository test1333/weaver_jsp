<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<head>

<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" name="viewport" />
</head>

<script type="text/javascript">
var sfzxcdp = "#field11566";//是否在携程预订机票
var sfzxcydjd = "#field20446";//是否在携程预订酒店
window.cardCollapse = function() {
    $('tr.wea-zd-start').click(function() {
      var $start = $(this);
      var $end = $start.next();
      while ($end.attr('class') != 'wea-zd-end') {
        $end.toggle();
        $end = $end.next();
      }
    })
  }
    /*
    *  TODO
     *  请在此处编写javascript代码
     */

$(document).ready(function(){
  $(".Inputstyle").css('width','100%');
 cardCollapse();
 jQuery(sfzxcdp).bind('change',function(){
		var sfzxcdp_val = jQuery(sfzxcdp).val();
		if(sfzxcdp_val == '1'){
			var nodesnum0 = jQuery("#nodenum0").val();
			alert(nodesnum0)
			if(nodesnum0 >0){
			   jQuery("[name = check_node_0]:checkbox").attr("checked", true);
			   deleteRow00(0)
			}
		}

		
	})
	jQuery(sfzxcydjd).bind('change',function(){
		var sfzxcydjd_val = jQuery(sfzxcydjd).val();
		if(sfzxcydjd_val == '1'){
			var nodesnum1 = jQuery("#nodenum1").val();
			if(nodesnum1 >0){
			   jQuery("[name = check_node_1]:checkbox").attr("checked", true);
			   deleteRow11(1)
			}
		}
		
	})
});
 
 function deleteRow11(groupid){
            	var oTable = jQuery("#oTable"+groupid);
                var delRecords = oTable.find("input[name='check_node_"+groupid+"']:checked");
                
                if(true){
                    delRecords.each(function(){
                        var recordid = jQuery(this).val();
                        if(recordid != "on"){
                            jQuery("#deleteId"+groupid).val(jQuery("#deleteId"+groupid).val()+recordid+",");
                        }
                        var rowIndex = jQuery(this).attr("_rowindex");
                        jQuery("#deleteRowIndex"+groupid).val(jQuery("#deleteRowIndex"+groupid).val()+rowIndex+",");
                        jQuery("tr[name='trView_"+groupid+"_"+rowIndex+"']").remove();
                        jQuery("tr#trEdit_"+groupid+"_"+rowIndex).remove();
                    });
                    var detailIndexSpanStr = "span[name='detailIndexSpan"+groupid+"']";
                    //模板含序号，序号排列
                    if(jQuery(detailIndexSpanStr).size() > 0){
                    	jQuery("input[name='check_node_"+groupid+"']").each(function(index){
	                    	var rowIndex = jQuery(this).attr("_rowindex");
	                    	jQuery("tr[name='trView_"+groupid+"_"+rowIndex+"']").find(detailIndexSpanStr).text(index+1);
	                    });
                    }
                    oTable.find("input[name='check_all_record']").attr("checked", false);
                    try{
	                    calSum(groupid);        //行列规则计算
	                }catch(e){}
	                try{        //自定义删除行后函数接口
	                    if(typeof _customMobileDelFun_1 === 'function')
	                        _customMobileDelFun_1();
	                }catch(e){}
                }
            }
  function deleteRow00(groupid){
            	var oTable = jQuery("#oTable"+groupid);
                var delRecords = oTable.find("input[name='check_node_"+groupid+"']:checked");
                
                if(true){
                    delRecords.each(function(){
                        var recordid = jQuery(this).val();
                        if(recordid != "on"){
                            jQuery("#deleteId"+groupid).val(jQuery("#deleteId"+groupid).val()+recordid+",");
                        }
                        var rowIndex = jQuery(this).attr("_rowindex");
                        jQuery("#deleteRowIndex"+groupid).val(jQuery("#deleteRowIndex"+groupid).val()+rowIndex+",");
                        jQuery("tr[name='trView_"+groupid+"_"+rowIndex+"']").remove();
                        jQuery("tr#trEdit_"+groupid+"_"+rowIndex).remove();
                    });
                    var detailIndexSpanStr = "span[name='detailIndexSpan"+groupid+"']";
                    //模板含序号，序号排列
                    if(jQuery(detailIndexSpanStr).size() > 0){
                    	jQuery("input[name='check_node_"+groupid+"']").each(function(index){
	                    	var rowIndex = jQuery(this).attr("_rowindex");
	                    	jQuery("tr[name='trView_"+groupid+"_"+rowIndex+"']").find(detailIndexSpanStr).text(index+1);
	                    });
                    }
                    oTable.find("input[name='check_all_record']").attr("checked", false);
                    try{
	                    calSum(groupid);        //行列规则计算
	                }catch(e){}
	                try{        //自定义删除行后函数接口
	                    if(typeof _customMobileDelFun_0 === 'function')
	                        _customMobileDelFun_0();
	                }catch(e){}
                }
            }

window.onload = function(){
  $(".Inputstyle").css('width','100%');
}

</script>

<style>

body{
 background:#f3f3f3
}

.Inputstyle{
  border:none;
   text-align:right !important;

 
}
.excelMainTable textarea{
 width:100%;
}

input.InputStyle, input.Inputstyle, input.inputStyle, input.inputstyle,.excelMainTable input[type="text"],.excelMainTable input[type="password"], .e8_innerShowContent,.excelMainTable textarea, .sbHolder{

  border:none;
  width: 100%!important;


}

input.InputStyle, input.Inputstyle, input.inputStyle, input.inputstyle, .excelMainTable input[type="text"], .excelMainTable input[type="password"], .e8_innerShowContent, .excelMainTable textarea, .sbHolder{
  text-align: right !important;

}
.excelMainTable{
width: 100% !important;
}
 .form_out_content{
 margin: 0px !important;
}


/*圆角样式*/

td{
 padding:0px;
}
.ysyj{
  height:100%;
  width:100%;
  background:#ffffff!important;
  border: 1px solid #ffffff!important;
  border-top-right-radius:9px;
}
.zxyj{
  height:100%;
  width:100%;
  background:#ffffff!important;
  border: 1px solid #ffffff!important;
  border-bottom-left-radius:9px;
}
.yxyj{
  height:100%;
  width:100%;
  background:#ffffff!important;
  border: 1px solid #ffffff!important;
  border-bottom-right-radius:9px;
}
.zsyj{
  height:100%;
  width:100%;
  background:#ffffff!important;
  border: 1px solid #ffffff!important;
  border-top-left-radius:9px;
}


</style>


</style>



