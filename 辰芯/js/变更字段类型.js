<!-- script���룬�����Ҫ����js�ļ�����ʹ����HTML����ͬ�ķ�ʽ�� -->
<script type="text/javascript">
var wblxid="#wblxid";//�ı�����id
var wbcdid="#wbcdid";//�ı�����id
var fdswsid="#fdswsid";//������λ��id
var llanid="#llanid";//�����ťid
var xzkid="#xzkid";//ѡ���id

var zdlx="field11986";//�ֶ�����
var wblx="field11987";//�ı�����
var wbcd="field11989";//�ı�����
var fdsws="field11990";//��������λ��
var llan="field11988";//�����ť

jQuery(document).ready(function(){
	showhide();
	showhide2();
	 jQuery("#"+zdlx).bind("change",function(){
      showhide();
     });	
    jQuery("#"+wblx).bind("change",function(){
      showhide2();
     });	 
	 
		
})

function showhide(){
	var zdlx_val=jQuery("#"+zdlx).val();
	if(zdlx_val==""||zdlx_val=="4"){
	  jQuery(wblxid).hide();	 
      jQuery(wbcdid).hide();
      jQuery(fdswsid).hide();
      jQuery(llanid).hide();
		
	}
	if(zdlx_val=="0"){
		jQuery(wblxid).show();	 
      jQuery(wbcdid).hide();
      jQuery(fdswsid).hide();
      jQuery(llanid).hide();
		showhide2();
	}
	if(zdlx_val=="1"){
	  jQuery(wblxid).hide();	 
      jQuery(wbcdid).hide();
      jQuery(fdswsid).hide();
      jQuery(llanid).show();
		
	}
	if(zdlx_val=="3"){
		jQuery(wblxid).hide();	 
      jQuery(wbcdid).hide();
      jQuery(fdswsid).hide();
      jQuery(llanid).hide();
		
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
