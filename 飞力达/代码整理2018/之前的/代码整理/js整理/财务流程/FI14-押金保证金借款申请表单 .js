<script type="text/javascript" src="/js/feiliks/date.format.js"></script>
<script type="text/javascript">
      var zffs="#field10712";//֧����ʽ
      var fkzh="field9897";//�����˺�
      var fkzhmc="field9856";//�����˺�����
      jQuery(zffs).bindPropertyChange(function () {
           var zffs_val=jQuery(zffs).val();
           if(zffs_val=="O"){
              jQuery("#"+fkzh).val("");
              jQuery("#"+fkzh+"span").text("");
              jQuery("#out"+fkzh+"div").hide();
              jQuery("#"+fkzh+"_browserbtn").hide();
              jQuery("#"+fkzh+"spanimg").html("");

              jQuery("#"+fkzhmc).val("");
              jQuery("#"+fkzhmc+"span").text("");
              jQuery("#"+fkzhmc).hide();

               var parastr = document.all('needcheck').value;
               parastr = parastr.replace(","+fkzh,"");
               parastr = parastr.replace(","+fkzhmc,"");
               document.all('needcheck').value=parastr;

           }else{
              jQuery("#"+fkzh).val("");
              jQuery("#"+fkzh+"span").text("");
              jQuery("#out"+fkzh+"div").show();
              jQuery("#"+fkzh+"_browserbtn").show();
              jQuery("#"+fkzh+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");

              jQuery("#"+fkzhmc).val("");
              jQuery("#"+fkzhmc+"span").text("");
              jQuery("#"+fkzhmc).show();

              var needcheck = document.all("needcheck");
              if(needcheck.value.indexOf(","+fkzh)<0){
                  if(needcheck.value!='') needcheck.value+=",";
                   needcheck.value+=fkzh;
              }
              if(needcheck.value.indexOf(","+fkzhmc)<0){
                  if(needcheck.value!='') needcheck.value+=",";
                  needcheck.value+=fkzhmc;
              }


           }
      })
    /*
	 ����һ��
	��1��������ɣ����ֶ���ϳ������������룬����+��Ӧ��/�ͻ����ƣ����ܳ���50���ַ���

    */

  
	var id_qkrq = "#field9852";//�������
	var id_qkly = "#field10721";//�������

    checkCustomize = function () {
        var isSuccess = true;
	var str = new Date($(id_qkrq).val().replace(/-/g, "/")).Format("MM");//��ȡ�·�
	
	str=str+$("td[name='td_khjc']").find("span").text();
	
	
        

        $(id_qkly).val(str);
        return isSuccess;
    }

    



    jQuery(document).ready(function () {
       
        
    });



</script>








