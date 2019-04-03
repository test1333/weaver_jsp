<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
jQuery(document).ready(function () {
    var _tipsPhone = "tipsPhone"; //电话权限提示信息
    var _xxx = "xxx"; //共享盘权限提示信息   
    var _checkPhone = "#field8279"; //电话权限
    var _checkFactory = "#field8280"; //厂内电话权限
    var _sn = "#field8281";           //省内电话权限
    var _gn = "#field8282";           //国内长途电话权限
    var _gj = "#field8283";           //国际长途电话权限
    var _sqdhhm = "#field13201";   //申请电话号码权限
    var _ERP = "#field8284";        //ERP系统
    var _ktERPzh = "#field8293";        //开通ERP帐号及权限
    var _tzERPqx = "#field8294";        //调整ERP权限
    var _MES = "#field8285";        //MES权限
    var _ktMESzh = "#field8296";        //开通MES帐号及权限
    var _tzMESqx = "#field8297";        //调整MES权限
    var _OA = "#field8287";        //OA系统
    var _ktoazh = "#field8299";        //开通OA帐号
    var _xgspr = "#field8300";        //修改审批人
    var _xgryxx = "#field8302";        //修改人员信息
    var _xgbdlc = "#field8301";        //修改表单审批流程
    var _jd = "#field8289";        //金蝶系统
    var _ktjdzh = "#field8304";        //开通金蝶帐号及权限
    var _tzqx = "#field8305";        //调整权限
    var _data = "#field8286";        //文件数据管理中心
    var _ktdatazh = "#field8307";        //开通文件数据管理中心帐号
    var _SPC = "#field8862";        //SPC系统
    var _ktSPCzh = "#field8863";        //开通SPC帐号及权限
    var _leader = "field8303";//直接上级
    var _ERPry = "field8295";//ERP人员
    var _MESry = "field8298";//MES人员
    var _jdry = "field8306";//金蝶人员
    var _SPCry = "field8864";//SPC人员
    var _gxp = "#field8290";//共享盘权限
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
       alert("项目类别为【话机拨打权限】的明细项中，请至少勾选1项！");
      return false;
    }
  } 
  if(ERP_val == true){
     if(ktERPzh_val == false && tzERPqx_val== false){
       alert("项目类别为【EPR系统】的明细项中，请至少勾选1项！");
     return false;
   }
 } 
  if(MES_val == true){
     if(ktMESzh_val == false && tzMESqx_val== false){
       alert("项目类别为【MES系统】的明细项中，请至少勾选1项！");
      return false;
   }
 }
  if(OA_val == true){
     if(ktoazh_val == false && xgspr_val== false && xgryxx_val== false && xgbdlc_val== false){
       alert("项目类别为【OA系统】的明细项中，请至少勾选1项！");
      return false;
   }
}
  if(jd_val == true){
     if(ktjdzh_val == false && tzqx_val== false){
       alert("项目类别为【金蝶系统】的明细项中，请至少勾选1项！");
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


























