<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
  var hl="#field7086";//汇率
  var bb="#field7085";//币别
  var ysbb="#field7241";//预算编码
  var syje="#field7244";//剩余金额
  var bhszcb="#field7480";//不含税总金额
  jQuery(document).ready(function(){
	  var bb_val=jQuery(bb).val();
	  if(bb_val != ''){
		   var hl_val=gethl(bb_val);
	        jQuery(hl).val(hl_val);
	  }
	 
	  jQuery(bb).bindPropertyChange(function(){
		 var bb_val=jQuery(bb).val();
		  if(bb_val != ''){
			   var hl_val=gethl(bb_val);
			   jQuery(hl).val(hl_val);
		  }
	  })
	  checkCustomize = function () {
		var bhszcb_val=jQuery(bhszcb).val();
		var syje_val=jQuery(syje).val();
		if(bhszcb_val == ""){
			bhszcb_val="0";	
		}
		if(syje_val == ""){
			syje_val="0";	
		}
		if(Number(bhszcb_val)>Number(syje_val)){
			alert("当前预算编码剩余金额不足，无法提交");
			jQuery(ysbb).val("");
			jQuery(ysbb+"span").text("");
			return false;
		}
		  return true;
	  }
  });
  function gethl(curreny){
    var value=encodeURIComponent(curreny);
    var name_val="";
    $.ajax({
             type: "POST",
             url: "/weixin/mflex/fna/gethl.jsp",
             data: {'curreny':value},
             dataType: "text",
             async:false,//同步
             success: function(data){
                        data=data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
                        name_val=data;
                      }
         });
     return name_val;
}

</script>
