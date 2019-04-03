<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
jQuery(document).ready(function () {
	var htze = "#field12364";
	var mxbj = "#field13350_";
	var htlx = "#field12349";
	checkCustomize = function (){
		var rs =true;
		var indexnum = jQuery("#indexnum0").val();
		var nosenum = jQuery("#nodesnum0").val();
		var ze = 0;
		var htze_val = jQuery(htze).val();
		for(var i=0;i<indexnum;i++){
			if(jQuery(mxbj+i).length>0){
				var mxbj_val = jQuery(mxbj+i).val();
				if(mxbj_val ==''){
					mxbj_val = "0.0";
				}
				ze = ze+parseFloat(mxbj_val);
			}
			
		}
		if(parseFloat(nosenum)>0){
			//alert("ze--"+parseFloat(ze)+"--parseFloat(htze_val)-"+parseFloat(htze_val));
			if(parseFloat(htze_val)!= parseFloat(ze)){
				Dialog.alert("明细报价综合不等于主表报价，请调整。")
				return false;
			}
		}
		return rs;
		
		
	}
	
	
})
</script>
























