<script type="text/javascript" src="/js/feiliks/date.format.js"></script>
<script type="text/javascript">
    /*
    ����һ�� 
ƾ֤ժҪ��λ�Զ����ɣ�
���ɹ���ƾ֤ժҪ=���ڡ��·ݡ�+�¹�����������+��ȫ�������ϸ��ѭ��ȡֵ���á�/�����������ܳ���50���ַ���

    */

    var id_qkrq = "#field9406"; //�������
    var id_pzzy = "#field10841";//ƾ֤ժҪ
    var id_lk = "#field9511";//��ȫ������
    checkCustomize = function () {
        var isSuccess = true;
	var str=new Date($(id_qkrq).val().replace(/-/g, "/")).Format("MM");
	$("td[name='td_sgzrrxm']").each(function(){
	str=str+"/"+$(this).find("span").text()+"/"+$(id_lk).val();
	}
    );
        

        $(id_pzzy).val(str);
        return isSuccess;
    }

    



    jQuery(document).ready(function () {
        //jQuery(id_ksrq).bindPropertyChange(function () { resetCheck(); resetQJSS(); }); //��ʼ����
        
    });



</script>





