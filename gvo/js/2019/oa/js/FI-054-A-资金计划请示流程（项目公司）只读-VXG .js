<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
    jQuery(document).ready(function () {

    	setTimeout("changetab()",'1000');
	
})
function changetab(){
	var zjjhlb_val = jQuery("#"+t0.zjjhlb).val();
	if(zjjhlb_val == "1"){
		jQuery("#tab_3").click();
	}
}
var t0 = {
    _index: 0,
    lcmc: 'field109244' /**流程名称-varchar2(4000)**/ ,
    lcbh: 'field109245' /**流程编号-varchar2(100)**/ ,
    sqr: 'field109246' /**申请人-integer**/ ,
    sqbm: 'field109247' /**申请部门-integer**/ ,
    sqrq: 'field109248' /**申请日期-char(10)**/ ,
    gs: 'field109249' /**公司-integer**/ ,
    year: 'field109250' /**年度-integer**/ ,
    llyyz: 'field109251' /**流程拥有者-integer**/ ,
    lllxr: 'field109252' /**流程联系人-integer**/ ,
    month: 'field109253' /**月份-integer**/ ,
    zjjhlb: 'field109254' /**资金计划类别-integer**/ ,
    lcid: 'field109270' /**流程id-browser.workflowID**/
};
var t1 = {
    _index: 1,
    type: 'field109255' /**资金支出明细-integer**/ ,
    month: 'field109256' /**开始月-number(15,2)**/ ,
    month1: 'field109257' /**中间月-number(15,2)**/ ,
    month2: 'field109258' /**结束月-number(15,2)**/ ,
    sum: 'field109259' /**合计-number(15,2)**/
};
var t2 = {
    _index: 2,
    type: 'field109260' /**受限资金明细-integer**/ ,
    month: 'field109261' /**开始月-number(15,2)**/ ,
    month1: 'field109262' /**中间月-number(15,2)**/ ,
    month2: 'field109263' /**结束月-number(15,2)**/ ,
    sum: 'field109264' /**合计-number(15,2)**/
};
var t3 = {
    _index: 3,
    type: 'field109265' /**资金收入明细-integer**/ ,
    month: 'field109266' /**开始月-number(15,2)**/ ,
    month1: 'field109267' /**中间月-number(15,2)**/ ,
    month2: 'field109268' /**结束月-number(15,2)**/ ,
    sum: 'field109269' /**合计-number(15,2)**/
};
</script>
