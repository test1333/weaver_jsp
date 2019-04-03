<script type="text/javascript">
var xm = '#field16104';// 项目
var xmlx = '#field16101';// 项目类型
var xh_dt1 = '#field16109_';// 序号
var bj_dt1 = '#field16110_';// 编辑
var yz_dt1 = '#field16112_';// 原值
var xz_dt1 = '#field16113_';// 新值
var bgzd_dt1 = '#field16111_';// 变更字段
var sfxj = '#disfield16103';// 是否新建
var jdid =  '#field16114';// 阶段id
var jdlx =  '#field16115';// 阶段类型
jQuery(document).ready(function () {
    var indexnum0 = jQuery('#indexnum0').val();
	 for(var index=0;index<indexnum0;index++){
		if(jQuery(bgzd_dt1+index).length>0){
			var url = "<a href=\"javascript:editInfo('" + index + "')\">编辑</a>";
			jQuery(bj_dt1 + index).val(url);
			jQuery(bj_dt1 + index + 'span').html(url);
		}
	 }
});
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
        
    };
    diag_vote.show();
}
</script>