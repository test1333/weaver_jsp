<!-- script���룬�����Ҫ����js�ļ�����ʹ����HTML����ͬ�ķ�ʽ�� -->
<script type="text/javascript">
jQuery(document).ready(function () {
    var _tipsPhone = "tipsPhone"; //�绰Ȩ����ʾ��Ϣ
    var _xxx = "xxx"; //������Ȩ����ʾ��Ϣ   
    var _checkPhone = "#field8279"; //�绰Ȩ��
    var _checkFactory = "#field8280"; //���ڵ绰Ȩ��
    var _sn = "#field8281";           //ʡ�ڵ绰Ȩ��
    var _gn = "#field8282";           //���ڳ�;�绰Ȩ��
    var _gj = "#field8283";           //���ʳ�;�绰Ȩ��
    var _sqdhhm = "#field13201";   //����绰����Ȩ��
    var _ERP = "#field8284";        //ERPϵͳ
    var _ktERPzh = "#field8293";        //��ͨERP�ʺż�Ȩ��
    var _tzERPqx = "#field8294";        //����ERPȨ��
    var _MES = "#field8285";        //MESȨ��
    var _ktMESzh = "#field8296";        //��ͨMES�ʺż�Ȩ��
    var _tzMESqx = "#field8297";        //����MESȨ��
    var _OA = "#field8287";        //OAϵͳ
    var _ktoazh = "#field8299";        //��ͨOA�ʺ�
    var _xgspr = "#field8300";        //�޸�������
    var _xgryxx = "#field8302";        //�޸���Ա��Ϣ
    var _xgbdlc = "#field8301";        //�޸ı���������
    var _jd = "#field8289";        //���ϵͳ
    var _ktjdzh = "#field8304";        //��ͨ����ʺż�Ȩ��
    var _tzqx = "#field8305";        //����Ȩ��
    var _data = "#field8286";        //�ļ����ݹ�������
    var _ktdatazh = "#field8307";        //��ͨ�ļ����ݹ��������ʺ�
    var _SPC = "#field8862";        //SPCϵͳ
    var _ktSPCzh = "#field8863";        //��ͨSPC�ʺż�Ȩ��
    var _leader = "field8303";//ֱ���ϼ�
    var _ERPry = "field8295";//ERP��Ա
    var _MESry = "field8298";//MES��Ա
    var _jdry = "field8306";//�����Ա
    var _SPCry = "field8864";//SPC��Ա
    var _gxp = "#field8290";//������Ȩ��
    document.getElementById(_tipsPhone).innerHTML += "<img src='/images/tooltip_wev8.png' align='absMiddle'></img>"
    document.getElementById(_xxx).innerHTML += "<img src='/images/tooltip_wev8.png' align='absMiddle'></img>"
    jQuery(_checkFactory).attr("disabled", "disabled");
    jQuery(_sn).attr("disabled","disabled");
    jQuery(_gn).attr("disabled", "disabled");
    jQuery(_gj).attr("disabled", "disabled");
    jQuery(_sqdhhm).attr("disabled", "disabled");
    jQuery(_ktERPzh).attr("disabled", "disabled");
    jQuery(_tzERPqx).attr("disabled", "disabled");
    jQuery(_ktMESzh).attr("disabled", "disabled");
    jQuery(_tzMESqx).attr("disabled", "disabled");
    jQuery(_ktoazh).attr("disabled", "disabled");
    jQuery(_xgspr).attr("disabled", "disabled");
    jQuery(_xgryxx).attr("disabled", "disabled");
    jQuery(_xgbdlc).attr("disabled", "disabled");
    jQuery(_ktjdzh).attr("disabled", "disabled");
    jQuery(_tzqx).attr("disabled", "disabled");
    jQuery(_ktdatazh).attr("disabled", "disabled");
    jQuery(_gxp).attr("disabled", "disabled");

    checkCustomize = function() {
    var checkPhone_val=jQuery(_checkPhone).is(':checked') ;
    var ERP_val=jQuery(_ERP).is(':checked') ;
    var MES_val=jQuery(_MES).is(':checked') ;
    var OA_val=jQuery(_OA).is(':checked') ;
    var jd_val=jQuery(_jd).is(':checked') ;
    var checkFactory_val=jQuery(_checkFactory).is(':checked') ;
    var sn_val=jQuery(_sn).is(':checked') ;
    var gn_val=jQuery(_gn).is(':checked') ;
    var gj_val=jQuery(_gj).is(':checked') ;
    var sqdhhm_val=jQuery(_sqdhhm).is(':checked') ;
    var ktERPzh_val=jQuery(_ktERPzh).is(':checked') ;
    var tzERPqx_val=jQuery(_tzERPqx).is(':checked') ;
    var ktMESzh_val=jQuery(_ktMESzh).is(':checked') ;
    var tzMESqx_val=jQuery(_tzMESqx).is(':checked') ;
    var ktoazh_val=jQuery(_ktoazh).is(':checked') ;
    var xgspr_val=jQuery(_xgspr).is(':checked') ;
    var xgryxx_val=jQuery(_xgryxx).is(':checked') ;
    var xgbdlc_val=jQuery(_xgbdlc).is(':checked') ;
    var ktjdzh_val=jQuery(_ktjdzh).is(':checked') ;
    var tzqx_val=jQuery(_tzqx).is(':checked') ;
  if(checkPhone_val == true){
    if(checkFactory_val == false && sn_val== false && gn_val== false  && gj_val== false && sqdhhm_val== false ){
       alert("��Ŀ���Ϊ����������Ȩ�ޡ�����ϸ���У������ٹ�ѡ1�");
      return false;
    }
  } 
  if(ERP_val == true){
     if(ktERPzh_val == false && tzERPqx_val== false){
       alert("��Ŀ���Ϊ��EPRϵͳ������ϸ���У������ٹ�ѡ1�");
     return false;
   }
 } 
  if(MES_val == true){
     if(ktMESzh_val == false && tzMESqx_val== false){
       alert("��Ŀ���Ϊ��MESϵͳ������ϸ���У������ٹ�ѡ1�");
      return false;
   }
 }
  if(OA_val == true){
     if(ktoazh_val == false && xgspr_val== false && xgryxx_val== false && xgbdlc_val== false){
       alert("��Ŀ���Ϊ��OAϵͳ������ϸ���У������ٹ�ѡ1�");
      return false;
   }
}
  if(jd_val == true){
     if(ktjdzh_val == false && tzqx_val== false){
       alert("��Ŀ���Ϊ�����ϵͳ������ϸ���У������ٹ�ѡ1�");
      return false;
   }
}
  return true;
  }

    jQuery(_checkPhone).click(function () {
        if (jQuery(_checkPhone).is(':checked') == true) {
            jQuery(_checkFactory).attr("disabled", "");
            jQuery(_sn).attr("disabled", "");
            jQuery(_gn).attr("disabled", "");
            jQuery( _gj).attr("disabled", "");
            jQuery( _sqdhhm).attr("disabled", "");
            //document.all('needcheck').value += "," + _leader;
           // document.getElementById(_leader + "span").innerHTML = "<img src='/images/BacoError_wev8.gif' align='absMiddle' </img>";
        } 
       else {
            // var _parastr = document.all('needcheck').value;
            jQuery(_checkFactory).attr("checked", "");
            jQuery(_sn).attr("checked", "");
            jQuery(_gn).attr("checked", "");
            jQuery(_gj).attr("checked", "");
            jQuery(_sqdhhm).attr("checked", "");
            jQuery(_checkFactory).attr("disabled", "disabled");
            jQuery(_sn).attr("disabled", "disabled");
            jQuery(_gn).attr("disabled", "disabled");
            jQuery(_gj).attr("disabled", "disabled");
            jQuery(_sqdhhm).attr("disabled", "disabled");
            // document.getElementById(_leader + "span").innerHTML = "";
            // _parastr = _parastr.replace("," + _leader, "");
            // document.all('needcheck').value = _parastr;
              }
       })
       jQuery(_ERP).click(function () { 
   if (jQuery(_ERP).is(':checked') == true) {
            jQuery(_ktERPzh).attr("disabled", "");
            jQuery(_tzERPqx).attr("disabled", "");
           document.all('needcheck').value += "," + _ERPry;
           document.getElementById( _ERPry + "span").innerHTML = "<img src='/images/BacoError_wev8.gif' align='absMiddle' </img>";
        } 
       else {
            jQuery(_ktERPzh).attr("checked", "");
            jQuery(_tzERPqx).attr("checked", "");
            jQuery(_ktERPzh).attr("disabled", "disabled");
            jQuery(_tzERPqx).attr("disabled", "disabled");
            var _parastr = document.all('needcheck').value;
            document.getElementById( _ERPry + "span").innerHTML = "";
            _parastr = _parastr.replace("," + _ERPry, "");
            document.all('needcheck').value = _parastr;
              }
   })
    jQuery(_MES).click(function () {
   if (jQuery(_MES).is(':checked') == true) {
            jQuery(_ktMESzh).attr("disabled", "");
            jQuery(_tzMESqx).attr("disabled", "");
           document.all('needcheck').value += "," + _MESry;
           document.getElementById( _MESry + "span").innerHTML = "<img src='/images/BacoError_wev8.gif' align='absMiddle' </img>";
        } 
       else {
            jQuery(_ktMESzh).attr("checked", "");
            jQuery(_tzMESqx).attr("checked", "");
            jQuery(_ktMESzh).attr("disabled", "disabled");
            jQuery(_tzMESqx).attr("disabled", "disabled");
           var _parastr = document.all('needcheck').value;
            document.getElementById( _MESry + "span").innerHTML = "";
            _parastr = _parastr.replace("," + _MESry, "");
            document.all('needcheck').value = _parastr;
              }
   })
    jQuery(_OA).click(function () {
   if (jQuery(_OA).is(':checked') == true) {
            jQuery(_ktoazh).attr("disabled", "");
            jQuery(_xgspr).attr("disabled", "");
            jQuery(_xgryxx).attr("disabled", "");
            jQuery(_xgbdlc).attr("disabled", "");
        } 
       else {
            jQuery(_ktoazh).attr("checked", "");
            jQuery(_xgspr).attr("checked", "");
            jQuery(_xgryxx).attr("checked", "");
            jQuery(_xgbdlc).attr("checked", "");
            jQuery(_ktoazh).attr("disabled", "disabled");
            jQuery(_xgspr).attr("disabled", "disabled");
            jQuery(_xgryxx).attr("disabled", "disabled");
            jQuery(_xgbdlc).attr("disabled", "disabled");
              }
 jQuery(_ktoazh).click(function () {
    if (jQuery(_ktoazh).is(':checked') == true) {
           document.all('needcheck').value += "," + _leader;
           document.getElementById(_leader + "span").innerHTML = "<img src='/images/BacoError_wev8.gif' align='absMiddle' </img>";
            } 
    else {
          var _parastr = document.all('needcheck').value;
            document.getElementById( _leader + "span").innerHTML = "";
            _parastr = _parastr.replace("," + _leader, "");
            document.all('needcheck').value = _parastr;
              }
    })
   })
    jQuery(_jd).click(function () {
   if (jQuery(_jd).is(':checked') == true) {
            jQuery(_ktjdzh).attr("disabled", "");
            jQuery(_tzqx).attr("disabled", "");
           document.all('needcheck').value += "," + _jdry;
           document.getElementById( _jdry + "span").innerHTML = "<img src='/images/BacoError_wev8.gif' align='absMiddle' </img>";
        } 
       else {
            jQuery(_ktjdzh).attr("checked", "");
            jQuery(_tzqx).attr("checked", "");
            jQuery(_ktjdzh).attr("disabled", "disabled");
            jQuery(_tzqx).attr("disabled", "disabled");
           var _parastr = document.all('needcheck').value;
            document.getElementById( _jdry + "span").innerHTML = "";
            _parastr = _parastr.replace("," + _jdry, "");
            document.all('needcheck').value = _parastr;
              }
   })
    jQuery(_data).click(function (){
   if (jQuery(_data).is(':checked') == true) {
           jQuery(_ktdatazh).attr("checked", "checked");
            jQuery(_ktdatazh).attr("disabled", "disabled");
        } 
       else {
            jQuery(_ktdatazh).attr("checked", "");
            jQuery(_ktdatazh).attr("disabled", "disabled");
              }
   })
    jQuery(_SPC).click(function () {
   if (jQuery(_SPC).is(':checked') == true) {
           jQuery(_ktSPCzh).attr("checked", "checked");
           jQuery(_ktSPCzh).attr("disabled", "disabled");
           document.all('needcheck').value += "," + _SPCry;
           document.getElementById( _SPCry + "span").innerHTML = "<img src='/images/BacoError_wev8.gif' align='absMiddle' </img>";
        } 
       else {
            jQuery(_ktSPCzh).attr("checked", "");
            jQuery(_ktSPCzh).attr("disabled", "disabled");
           var _parastr = document.all('needcheck').value;
            document.getElementById( _SPCry + "span").innerHTML = "";
            _parastr = _parastr.replace("," + _SPCry, "");
            document.all('needcheck').value = _parastr;
              }

   })
  
});
</script>


























