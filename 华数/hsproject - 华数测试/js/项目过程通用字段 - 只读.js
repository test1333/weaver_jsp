<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var wblxid="#wblxid";//文本类型id
var wbcdid="#wbcdid";//文本长度id
var fdswsid="#fdswsid";//浮点数位数id
var llanid="#llanid";//浏览按钮id
var xzkid="#xzkid";//选择框id

var zdlx="disfield100792";//字段类型
var wblx="disfield100793";//文本类型
var wbcd="field100795";//文本长度
var fdsws="field100796";//浮点数的位数
var llan="field100794";//浏览按钮
var xzk="field100797";//选择框

var isMust="#field100800";//必填
var isEdit="#field100785";//编辑
var isReadonly="#field100789";//只读
jQuery(document).ready(function(){
	showhide();
	showhide2();
	
		
})
function showhide(){
	var zdlx_val=jQuery("#"+zdlx).val();
	if(zdlx_val==""||zdlx_val=="4"){
	  jQuery(wblxid).hide();	 
      jQuery(wbcdid).hide();
      jQuery(fdswsid).hide();
      jQuery(llanid).hide();
	  jQuery(xzkid).hide();
		
	}
	if(zdlx_val=="0"){
		jQuery(wblxid).show();	 
      jQuery(wbcdid).hide();
      jQuery(fdswsid).hide();
      jQuery(llanid).hide();
	  jQuery(xzkid).hide();
		showhide2();
	}
	if(zdlx_val=="1"){
	  jQuery(wblxid).hide();	 
      jQuery(wbcdid).hide();
      jQuery(fdswsid).hide();
      jQuery(llanid).show();
	  jQuery(xzkid).hide();
		
	}
	if(zdlx_val=="3"){
		jQuery(wblxid).hide();	 
      jQuery(wbcdid).hide();
      jQuery(fdswsid).hide();
      jQuery(llanid).hide();
	  jQuery(xzkid).show();
		
	}
	
}
function showhide2(){
	var zdlx_val = jQuery("#"+zdlx).val();
	var wblx_val=jQuery("#"+wblx).val();
	if (zdlx_val!="0"){
		return;
	}
	if(wblx_val==""||wblx_val=="1"){	 
      jQuery(wbcdid).hide();
      jQuery(fdswsid).hide();
		
	}
	if(wblx_val=="0"){	 
      jQuery(wbcdid).show();
      jQuery(fdswsid).hide();
		
	}
	if(wblx_val=="2"){	 
      jQuery(wbcdid).hide();
      jQuery(fdswsid).show();
		
	}
	
	
}

</script>

