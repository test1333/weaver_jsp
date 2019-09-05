<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var sfys_dt1 = "#field14694_";
jQuery(document).ready(function () {
	var htze = "#field13304";
	var mxbj = "#field13311_";
	var htlx = "#field13294";
	checkCustomize = function (){
		var rs =true;
		var indexnum = jQuery("#indexnum0").val();
		var nosenum = jQuery("#nodesnum0").val();
		var ze = 0;
		var htze_val = jQuery(htze).val();
		var count =0;
		for(var i=0;i<indexnum;i++){
			if(jQuery(mxbj+i).length>0){
				var mxbj_val = jQuery(mxbj+i).val();
				if(mxbj_val ==''){
					mxbj_val = "0.0";
				}
				ze = ze+parseFloat(mxbj_val);
				var sfys_dt1_val = jQuery(sfys_dt1+i).val();
				if(sfys_dt1_val == "1"){
					count = count + 1;
				}
			}
			
		}
		if(count == 0|| count>1){
			Dialog.alert("明细必须存在且只能有一个”是否验收“为是的行，请检查");
			return false;
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
























