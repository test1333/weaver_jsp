jQuery(document).ready(function(){
	var bc = "field8688_"      //���
	var jblx = "field8825_"    //�Ӱ�����
	var ygtxss = "field8985_"  //Ա����дʱ��
    //alert(123456);
	// ��ǰ����
	var date = new Date();
	//alert(date);
	date.setDate(date.getDate() - 3);
	//date = date - 1000*60*60*24*3;
	//alert(date);
	var year = date.getFullYear();
	var month = date.getMonth() + 1;
	var today = date.getDate();
	
	if (month >= 1 && month <= 9) {
	   month = "0" + month;
	}
	if (today >= 0 && today <= 9) {
	   today = "0" + today;
	}
	// ϵͳ��ǰ���ں�3��
	var currentDate = year + "-" + month + "-" + today;
	checkCustomize = function() {
	//  ���������ֶ�
	var s_date = "field8195_";
	var res = true;
	for(var index=0;index<100;index++){
		
		if(jQuery("#"+s_date+index).length>0){
			var tmp_1 = jQuery("#"+s_date+index).val();
			
			// �����һ�еĹ��������� ϵͳ��ǰ����ǰ3��  �ͷ���false
			if(tmp_1 < currentDate){
				res =false;
				index = 101;
			}
			
		}else{
			index = 101;
		}
	}
	
	if(	res== false) { alert("3��ǰ�ļӰ಻�����ᱨ");
	return result;
	}
	//����ύʱ��
	var result = true;
		for(var index = 0; index<200; index++){
			if(result){ 
				if(jQuery("#"+bc+index).length>0){
					var val_bc = jQuery("#"+bc+index).val();
					var val_jblx = jQuery("#"+jblx+index).val();
					var val_ygtxss = jQuery("#"+ygtxss+index).val();
					//alert(123456789);
					
					if(val_ygtxss.length==0||Number(val_ygtxss)==0){
						//alert("1231241");
						result = false;
					}

					if(val_bc.length==0){
						result = false;
					}
					if(val_jblx.length==0){
						result = false;
					}
					
				}else{
					index = 201;
				}
			}else{
				index = 201;
			}
		}
		if(result == false)  alert("�Ӱ����ͻ��Σ�����Ϊ��");
		return result;
	}
	//����Ρ����Ϊ��
});