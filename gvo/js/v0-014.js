<!-- script���룬�����Ҫ����js�ļ�����ʹ����HTML����ͬ�ķ�ʽ�� -->
<script type="text/javascript">
jQuery(document).ready(function() {
	/*����*/
	var aqjb = "field31445";//��ȫ����
    var gllc = "field29706";//������������
   var bxlx = "field32327";//��������	
	function check()
	{
		var aqjb_val = jQuery("#"+aqjb).val();
		var needcheck = document.all("needcheck");
		if (Number(aqjb_val)<43 && Number(aqjb_val)>=10)
		{
			if(jQuery("#"+gllc).length>0)
			{					
                document.all(gllc+"spanimg").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";	
				if(needcheck.value.indexOf(gllc)<0)
				{  //����Ǳ���������������ж�
					if(needcheck.value!='')
					needcheck.value += ",";
					needcheck.value += gllc;
				}				
			}
		}
        else if (Number(aqjb_val)>=43 || Number(aqjb_val)==7 || Number(aqjb_val)==8)
		{
			if(jQuery("#"+gllc).length>0)
			{					
				document.all(gllc+"spanimg").innerHTML = "";// ֵ���		
				if(needcheck.value.indexOf(gllc)>=0)
				{ 
					needcheck.value=needcheck.value.replace(","+gllc,"");  //�ɱ༭			
				}			
			}
		}
	}
	
	jQuery("#"+aqjb).bindPropertyChange(function(){
        check();
	});	
	
	
	checkCustomize = function() {
		//alert("�ύ");
		var result = true;
		var aqjb_v = jQuery("#"+aqjb).val();
		var gllc_v = jQuery("#"+gllc).val();
		var bxlx_v = jQuery("#"+bxlx).val();
		if(bxlx_v == '1'){
			if (Number(aqjb_v)<43 && Number(aqjb_v)>=10 && gllc_v.length==0) 
			{
				Dialog.alert("\"������������\"δ��д");
				result = false; 
				check();
			}
     	}

		return result;
	}
});
</script>













