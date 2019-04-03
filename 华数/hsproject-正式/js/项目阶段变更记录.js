<script type="text/javascript">
var xm = '#field107182';// 项目
var xmlx = '#field107179';// 项目类型
var xh_dt1 = '#field107181_';// 序号
var bj_dt1 = '#field107173_';// 编辑
var yz_dt1 = '#field107184_';// 原值
var xz_dt1 = '#field107178_';// 新值
var bgzd_dt1 = '#field107171_';// 变更字段
var sfxj = '#field107169';// 是否新建
var jdid =  '#field107174';// 阶段id
var jdlx =  '#field107180';// 阶段类型
jQuery(document).ready(function () {
    jQuery('button[name=addbutton0]').live('click', function () {
        var indexnum2 = jQuery('#indexnum0').val();
        dourl(indexnum2 - 1);
    });
});
function dourl (index) {
    var seqno = '';
    jQuery.ajax({
        type: 'POST',
        url: '/hsproject/project/jsp/get-prj-processchange-seqno.jsp',
        data: {},
        dataType: 'text',
        async: false, // 同步   true异步
        success: function (data) {
            data = data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
            seqno = data;
        }
    });
    jQuery(xh_dt1 + index).val(seqno);
    var url = "<a href=\"javascript:editInfo('" + index + "')\">编辑</a>";
    jQuery(bj_dt1 + index).val(url);
    jQuery(bj_dt1 + index + 'span').html(url);
    jQuery(yz_dt1 + index).attr('readonly', 'readonly');
    jQuery(xz_dt1 + index).attr('readonly', 'readonly');
}
function editInfo (index) {
    var seqno = jQuery(xh_dt1 + index).val();
    var prjid = jQuery(xm).val();
    var prjtype = jQuery(xmlx).val();
    var fieldid = jQuery(bgzd_dt1 + index).val();
    var sfxj_val = jQuery(sfxj).val();
	var processid = jQuery(jdid).val();
	var processtype = jQuery(jdlx).val();
    var newvalue = '';
    var oldvalue = '';
    if (fieldid == '') {
        alert('请先选择变更字段');
        return;
    }
    var title = '';
    var url = '/hsproject/project/view/hs-prj-process-field-change.jsp?prjid=' + prjid + '&prjtype=' + prjtype + '&fieldid=' + fieldid + '&seqno=' + seqno + '&sfxj=' + sfxj_val+ '&processid=' + processid + '&processtype=' + processtype;
    var diag_vote = new window.top.Dialog();
    diag_vote.currentWindow = window;
    diag_vote.Width = 600;
    diag_vote.Height = 450;
    diag_vote.Modal = true;
    diag_vote.Title = title;
    diag_vote.URL = url;
    diag_vote.isIframe = false;
    diag_vote.CancelEvent = function () {
        diag_vote.close();
        jQuery.ajax({
            type: 'POST',
            url: '/hsproject/project/jsp/get-prjchange-value.jsp',
            data: {'seqno':seqno,'fieldid':fieldid},
            dataType: 'text',
            async: false, // 同步   true异步
            success: function (data) {
                data = data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
				if(data == "null"){
					jQuery(yz_dt1 + index).val("");
					jQuery(xz_dt1 + index).val("");
				}else{
					eval('var obj =' + data);
					newvalue = obj.newvalue;
					oldvalue = obj.oldvalue;
					jQuery(yz_dt1 + index).val(oldvalue);
					jQuery(xz_dt1 + index).val(newvalue);
					jQuery(bgzd_dt1 + index+"_browserbtn").attr('disabled',true);
				}
            }
        });
    };
    diag_vote.show();
}
</script>