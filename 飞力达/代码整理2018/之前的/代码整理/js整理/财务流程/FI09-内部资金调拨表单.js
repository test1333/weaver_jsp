<script type="text/javascript" src="/js/feiliks/date.format.js"></script>
<script type="text/javascript">
    /*
	 ����һ��
	��ϸ��һѡ����ɿͻ�����ϸ������Ը�����ϸ��һ�Զ�����δ����

	�������
	����������λ��������λ����Զ����ɣ�
	���ɹ��򣺵�������=��������ڡ��·ݡ�+���ͻ���ơ�+�ڲ��ʽ��������ϸ��ѭ��ȡֵ���á�/��������

    */

    var id_dbzj = "#field9504"; //�����ʽ�
   
	var id_qkrq = "#field9471";//�������
	var id_dbly = "#field9480"//��������

	var gysbh = "#field11082_"; //�ͻ����
    var pzbh = "#field9487_";//ƾ֤���
	var gzrq = "#field9488_";//��������
	var bz= "#field12182_"; // ����
	var je= "#field9492_"; // ���
	var wb = "#field9493_";//ժҪ
	var bh ="#field9994_";//��ϸ1�տ���
    var gsdm = "#field12459";
//������ϸ1ʱ��change�¼�
	jQuery("button[name=addbutton0]").live("click",function(){
      var indexnum0=jQuery("#indexnum0").val();
      for(var index =0;index <indexnum0;index ++){     
		   if(jQuery(bh+index).length>0){
            bindchange(index); 
			}     
      } 

    });
    //ɾ����ϸ1����ʱɾ��δ���������ݲ����¼���
	jQuery("button[name=delbutton0]").live("click",function(){
		var indexnum1 = jQuery("#indexnum1").val();
			if (indexnum1 > 0) {
				jQuery("[name = check_node_1]:checkbox").attr("checked", true);
				deleteRow1(1);
			}
			 getData1();
	}); 
//ҳ����ص�ʱ���change�¼�
	jQuery(document).ready(function () {
		 var nodesnum0=jQuery("#nodesnum0").val();
		  var indexnum0=jQuery("#indexnum0").val();
		 if(nodesnum0>0){
			 for(var index=0;index<indexnum0;index++){
				 if(jQuery(bh+index).length>0){
				 bindchange(index)
				 }
			 }
		 }
      

	});
//����ϸ1��Ӧ�̱�Ű��change�¼�
 function bindchange(index){

	 jQuery(bh+index).bindPropertyChange(function () {
			var indexnum1 = jQuery("#indexnum1").val();
			if (indexnum1 > 0) {
				jQuery("[name = check_node_1]:checkbox").attr("checked", true);
				deleteRow1(1);
			}
			 getData1();

		})

 }
 //��ȡ��ϸ1��Ӧ�̱��
 function getData1(){
 var indexnum0=jQuery("#indexnum0").val();
   var gysid='';
   var falgg='';
   for(var index1=0;index1<indexnum0;index1++){
	  if(jQuery(bh+index1).length>0){ 
      var bh_val=jQuery(bh+index1).val();
	  if(bh_val != ''){
		  gysid = gysid+falgg+bh_val;
		  falgg = ',';
	  }
	  }
     
   }
   getdetail2(gysid);
 }
 //������ϸ1��Ӧ�̱�Ŵ���δ����
 function getdetail2(gysid){
   var indexnum1=  jQuery("#indexnum1").val();
   var xhr = null;
   if (window.ActiveXObject) {//IE�����
		xhr = new ActiveXObject("Microsoft.XMLHTTP");
   } else if (window.XMLHttpRequest) {
		xhr = new XMLHttpRequest();
   }
   if (null != xhr) {
    var gsdm_val=jQuery(gsdm).val();
	xhr.open("GET","/feilida/finance/getFI09Info.jsp?id="+gysid+"&custom="+gsdm_val, false);
	xhr.onreadystatechange = function () {
	if (xhr.readyState == 4) {
	  if (xhr.status == 200) {
		var text = xhr.responseText;
		text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
		var text_arr = text.split("@@@");
		var length1=Number(text_arr.length)-1+Number(indexnum1);
		for(var i=indexnum1;i<length1;i++){
		  addRow1(1);
		  var tmp_arr = text_arr[i-indexnum1].split("###");
		  jQuery(gysbh+i).val(tmp_arr[0]);
		  jQuery(gysbh+i+"span").text(tmp_arr[0]);
	      jQuery(pzbh+i).val(tmp_arr[1]);
	      jQuery(pzbh+i+"span").text(tmp_arr[1]);
		  jQuery(gzrq+i).val(tmp_arr[2]);
	      jQuery(gzrq+i+"span").text(tmp_arr[2]);
	      jQuery(bz+i).val(tmp_arr[3]);
	      jQuery(bz+i+"span").text(tmp_arr[3]);
		  jQuery(je+i).val(tmp_arr[4]);
	      jQuery(je+i+"span").text(tmp_arr[4]);
		  jQuery(wb+i).val(tmp_arr[5]);
	      jQuery(wb+i+"span").text(tmp_arr[5]);
		}
	   }
      }
     }
	 xhr.send(null);
   }
 }

    checkCustomize = function () {
        var isSuccess = true;
	var str = new Date($(id_qkrq).val().replace(/-/g, "/")).Format("MM");//��ȡ�·�
	$("td[name='td_skfmc']").each(function(){
	str=str+"/"+$(this).find("span").text()+"/"+$(id_dbzj).val();
	}
	);
        

        $(id_dbly).val(str);
        return isSuccess;
    }

    



   


</script>











