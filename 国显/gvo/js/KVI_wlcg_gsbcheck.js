
	/*����*/
	var gsb = "field28250";//��˾��
	/*��ϸ��*/
    var wlcx = "field12249_";//�������Ʋ�ѯ
	var wlcx_Z = "field29365_";//�������Ʋ�ѯ(ZVI)
   
	function checkM()
	{
		var gsb_val = jQuery("#"+gsb).val();
		var needcheck = document.all("needcheck");
		var nowRow = parseInt($G("indexnum0").value);
		//window.top.Dialog.alert(nowRow);
		if (gsb_val==1)
		{
            for (var i=0;i<nowRow;i++)
	        {
				if(jQuery("#"+wlcx+i).length>0)
				{
					document.all(wlcx+i+"span").innerHTML = "";// ֵ���		
					if(needcheck.value.indexOf(wlcx+i)>=0)
					{ 
						needcheck.value=needcheck.value.replace(","+wlcx+i,"");  //�ɱ༭			
					}
					jQuery("#"+wlcx+i).val("");
				}
				if(jQuery("#"+wlcx_Z+i).length>0)
				{
					document.all(wlcx_Z+i+"span").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
					if(needcheck.value.indexOf(wlcx_Z+i)<0)
					{  //����Ǳ���������������ж�
						if(needcheck.value!='')
						needcheck.value += ",";
						needcheck.value += wlcx_Z+i;
					}
				}
			}
		}
        else
		{
			for (var i=0;i<nowRow;i++)
	        {
				if(jQuery("#"+wlcx+i).length>0)
				{
					document.all(wlcx+i+"span").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
					if(needcheck.value.indexOf(wlcx+i)<0)
					{  //����Ǳ���������������ж�
						if(needcheck.value!='')
						needcheck.value += ",";
						needcheck.value += wlcx+i;
					}
				}
				if(jQuery("#"+wlcx_Z+i).length>0)
				{
					document.all(wlcx_Z+i+"span").innerHTML = "";// ֵ���		
					if(needcheck.value.indexOf(wlcx_Z+i)>=0)
					{ 
						needcheck.value=needcheck.value.replace(","+wlcx_Z+i,"");  //�ɱ༭			
					}
					jQuery("#"+wlcx_Z+i).val("");
				}
			}
		}			
	}
	
	jQuery("#"+gsb).bindPropertyChange(function(){
        checkM();
	});	

