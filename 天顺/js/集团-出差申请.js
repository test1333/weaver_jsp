<style>
/*e8*/

.e8_os{

min-width:95% !important;
}

.e8_outScroll{
border:none;
}

 select {
    line-height: 22px;
    height: 22px;
    background: none;
    border: none;
    min-width: 95%;
}
/* e8 明细表斑马线 */
    .excelDetailTable tr:nth-child(2n+3) td {
      background: #f7f7f7!important;
    }
    .excelDetailTable tr:nth-child(2n+3) td:first-child ,  .excelDetailTable tr:nth-child(2n+3) td:last-child {
      background:transparent !important;
    }

  
    .excelDetailTable tr:nth-child(2n+3) td input{
      background: #f7f7f7!important;
    }



/* e9样式-明细表斑马线条纹 */
    tr.detail_even_row td{
      background: #FAFAFA!important;
    }
    tr.detail_even_row td:first-child{
      background: transparent !important;
    }
    tr.detail_even_row td:last-child{
      background: transparent !important;
    }
    tr.detail_even_row td .wf-input{
      background: #FAFAFA!important;
    }
   .excelDetailTable tr td:first-child{
      border-top-color: #efefef!important;
      border-left-color: #efefef!important;
    }
    .excelDetailTable tr td:last-child{
      border-top-color: #efefef!important;
      border-right-color: #efefef!important;
    }

 .excelDetailTable tr:nth-child(2n+2) td {
      background: transparent !important;
    }
 .excelDetailTable tr:nth-child(2n+2) td input{
      background: transparent !important;
    }


 /* 样式-下拉框长度 */
   .wea-select{
     width: 95%
   }
/*选择框宽度*/
.wea-select ,.ant-select-selection{
    width: 95%;
    border-style: none;
}

/*浏览框去边框，调整宽度*/
.wea-associative-search {
    border-style: none;
    min-width: 95% !important;
}
/* e9样式结束*/

/*通用圆角样式*/
.ysyj{
  height:15px;
  width:100%;
  background:#ffffff!important;
  border: 1px solid #ffffff!important;
  border-top-right-radius:9px;
}
.zxyj{
  height:15px;
  width:100%;
  background:#ffffff!important;
  border: 1px solid #ffffff!important;
  border-bottom-left-radius:9px;
}
.yxyj{
  height:15px;
  width:100%;
  background:#ffffff!important;
  border: 1px solid #ffffff!important;
  border-bottom-right-radius:9px;
}
.zsyj{
  height:15px;
  width:100%;
  background:#ffffff!important;
  border: 1px solid #ffffff!important;
  border-top-left-radius:9px;
}





/*单行文本去背景*/
input.InputStyle,
input.Inputstyle,
input.inputStyle,
input.inputstyle,
.excelMainTable input[type="text"],
.excelMainTable input[type="password"],
.e8_innerShowContent,
.excelMainTable textarea,
.sbHolder {
    /*border: 1px solid #F2F2F2 !important;*/
    border: none;
    background: none;
}



/* 修复 input 框 Chrome 自动填充屎黄色背景 */
    input:-webkit-autofill,.excelMainTable input:-webkit-autofill:hover,.excelMainTable input:-webkit-autofill:focus,.excelMainTable input:-webkit-autofill:active {
        -webkit-transition-delay: 99999s;
        -webkit-transition: color 99999s ease-out, background-color 99999s ease-out;
    }



</style>
<script type="text/javascript">
var sfzxcdp = "#field11566";//是否在携程预订机票
var sfzxcydjd = "#field20446";//是否在携程预订酒店
jQuery(document).ready(function () {
	jQuery(sfzxcdp).bind('change',function(){
		var sfzxcdp_val = jQuery(sfzxcdp).val();
		if(sfzxcdp_val == '1'){
			var nodesnum0 = jQuery("#nodesnum0").val();
			if(nodesnum0 >0){
			   jQuery("[name = check_node_0]:checkbox").attr("checked", true);
			   deleteRow0(0)
			}
		}

		
	})
	jQuery(sfzxcydjd).bind('change',function(){
		var sfzxcydjd_val = jQuery(sfzxcydjd).val();
		if(sfzxcydjd_val == '1'){
			var nodesnum1 = jQuery("#nodesnum1").val();
			if(nodesnum1 >0){
			   jQuery("[name = check_node_1]:checkbox").attr("checked", true);
			   deleteRow1(1)
			}
		}
		
	})
	
	
})




 isdel=function(){ 
    return true; 
 }

</script>






