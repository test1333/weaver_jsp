<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
  var sfcz="#field7162";
  jQuery(document).ready(function() {
    checkCustomize = function() {
		var sfcz_val=jQuery(sfcz).val();
		if(sfcz_val == ""){
			sfcz_val="0";
		}
		if(Number(sfcz_val)>Number("0")){
		  alert("收款账户已存在，请检查");	
		  return false;
		}
		return true;

    }
  });

</script>

