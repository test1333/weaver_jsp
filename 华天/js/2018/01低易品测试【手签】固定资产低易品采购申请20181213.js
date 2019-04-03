<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript" src="/htGroup/js/cw.js"></script>
var bbdj01 = '#field28605' // 单价(本币)01
var bbdj02 = '#field28606' // 单价(本币)02
var bbdj03 = '#field28607' // 单价(本币)03
var bbdj04 = '#field28608' // 单价(本币)04
var bbdj05 = '#field28609' // 单价(本币)05
var wbdj01 = '#field28610' // 单价(外币)01
var wbdj02 = '#field28611' // 单价(外币)02
var wbdj03 = '#field28612' // 单价(外币)03
var wbdj04 = '#field28613' // 单价(外币)04
var wbdj05 = '#field28614' // 单价(外币)05

var sqbm = '#field28534' // 申请部门
var superDept = '#field28680' // 申请部门
var yfxmmc = '#field28670' // 研发项目名称
var _yfxmmc = 'field28670' // 研发项目名称
<script type="text/javascript">
    jQuery(document).ready(function () {
        var fieldsArr1 = [t0.sblx1, t0.sblx2, t0.sblx3, t0.sblx4, t0.sblx5] // 设备类型1
        var typeArr = [t0.sslb1, t0.sslb2, t0.sslb3, t0.sslb4, t0.sslb5] // 所属类别
        var assetArr = [t0.fl1, t0.fl2, t0.fl3, t0.fl4, t0.fl5] // 固定资产分类
        var priceArr1 = [t0.bbdj01, t0.bbdj02, t0.bbdj03, t0.bbdj04, t0.bbdj05] // 本币单价
        var rowHideArr = ['#hideRow1', '#hideRow2', '#hideRow3', '#hideRow4', '#hideRow4']

        for (var i = 0; i < typeArr.length; i++) {
            var tmpType = _C.v(typeArr[i])
            if (tmpType !== '') {
                if (!(tmpType === '2')) {
                    var parentTr1 = jQuery('#' + typeArr[i]).parent().parent().parent()
                    parentTr1.attr('style', 'display:none;')
                    var parentTr2 = jQuery('#' + fieldsArr1[i]).parent().parent().parent()
                    parentTr2.attr('style', 'display:none;')
                    var rowSpan01 = jQuery('#rowSpan01').parent()
                    var rowSpan1 = rowSpan01.attr('rowspan') - 1
                    rowSpan01.attr('rowspan', rowSpan1)
                    var rowSpan02 = jQuery('#rowSpan02').parent()
                    var rowSpan2 = rowSpan02.attr('rowspan') - 1
                    rowSpan02.attr('rowspan', rowSpan2)
                    var rowSpan03 = jQuery('#rowSpan03').parent()
                    var rowSpan3 = rowSpan03.attr('rowspan') - 1
                    rowSpan03.attr('rowspan', rowSpan3)
                    // jQuery(rowHideArr[i]).show()
                }
            } else {
                _C.v(priceArr1[i], '')
            }
        }

        jQuery('#xmmc').show()
        jQuery('#' + t0.yfxmmc).show()
        // jQuery('#' + t0.sqbm).bindPropertyChange(function () {
        var superDeptVal = _C.v(t0.superDept)
        // 如果是封装技术研究院，技术部，LED事业部的固定资产申请，需要在右上角显示研发项目名称
        if (superDeptVal === '642' || superDeptVal === '651' || superDeptVal === '656' || superDeptVal === '647' || superDeptVal === '1100') {
            jQuery('#xmmc').show()
            jQuery('#' + t0.yfxmmc).show()
            document.all('needcheck').value += ',' + t0.yfxmmc
            document.getElementById(t0.yfxmmc + 'span').innerHTML = "<img src='/images/BacoError_wev8.gif' align='absMiddle' </img>"
        } else {
            jQuery('#xmmc').hide()
            jQuery('#' + t0.yfxmmc).hide()
        }
        // })

        // 根据所属分类，重新合计
    //    _C.v(t0.bbzj, sumTotal('1'))
     //   _C.v(t0.wbzj, sumTotal('2'))
        // console.log('sum1=' + sumTotal('1'))
        // console.log('sum2=' + sumTotal('2'))

	var sel_arr_1 = ["#field28673","#field28674","#field28675","#field28676","#field28677"];
	var brr_3 = ["#field28595","#field28596","#field28597","#field28598","#field28599"];
	var brr_6 = ["#field28682","#field28683","#field28684","#field28685","#field28686"];
	var brr_7 = ["#field28610","#field28611","#field28612","#field28613","#field28614"];
	var price_1 = "#field28577";
	var price_2 = "#field28578";
	var price_all_1 = 0;
	var price_all_2 = 0;
    //   alert("调试 请忽略..  st ");
	for(var i=0; i<sel_arr_1.length; i++){
		var tmp_sel_id = sel_arr_1[i];
		var tmp_sel_val = jQuery(tmp_sel_id).val();
     //          alert("调试 请忽略..  " + " NO. --> " + i + "  KEY --> " +  tmp_sel_val);
		if(tmp_sel_val == '2'  ){
			var tmp_bz_val = jQuery(brr_6[i]).val();
			var tmp_s_val = accMul( jQuery(brr_3[i]).val(), jQuery(brr_7[i]).val());
			if(tmp_bz_val == '4'){
				price_all_1 = accAdd(price_all_1,tmp_s_val);
			}else{
				price_all_2 = accAdd(price_all_1,tmp_s_val);
			}
		}
	}
   //     alert("调试 请忽略..  " + " price_all_1. --> " + price_all_1 + "  price_all_2 --> " +  price_all_2);
	_C.v(t0.bbzj, price_all_1);
       _C.v(t0.wbzj, price_all_2);

	// 浮点数相加
       	function accAdd (arg1, arg2) {
		var r1, r2, m;
		try { r1 = arg1.toString().split('.')[1].length; } catch (e) { r1 = 0 }
		try { r2 = arg2.toString().split('.')[1].length; } catch (e) { r2 = 0 }
		m = Math.pow(10, Math.max(r1, r2))
		return (arg1 * m + arg2 * m) / m;
	}


        /**
         * 求和
         *
         * @param {string} flag 标志，1计算本币金额汇总；2计算外币金额汇总
         */
        function sumTotal (flag) {
            var typeArr = [t0.sslb1, t0.sslb2, t0.sslb3, t0.sslb4, t0.sslb5]
            var assetArr = [t0.fl1, t0.fl2, t0.fl3, t0.fl4, t0.fl5]
            var amountArr = [t0.sl01, t0.sl02, t0.sl03, t0.sl04, t0.sl05]
            var priceArr1 = [t0.bbdj01, t0.bbdj02, t0.bbdj03, t0.bbdj04, t0.bbdj05]
            var priceArr2 = [t0.wbdj01, t0.wbdj02, t0.wbdj03, t0.wbdj04, t0.wbdj05]
            var sumArr = []
            for (var i = 0; i < typeArr.length; i++) {
                var tmpSum = 0
                if (_C.v(typeArr[i]) === '2') {
                    if (flag === '1') {
                        tmpSum = accMul(_C.v(amountArr[i]), _C.v(priceArr1[i]))
                        sumArr.push(Number(tmpSum))
                    } else if (flag === '2') {
                        tmpSum = accMul(_C.v(amountArr[i]), _C.v(priceArr2[i]))
                        sumArr.push(Number(tmpSum))
                    }
                }
            }

            return Number(sumArray(sumArr)).toFixed(4)
        }

        // js数值相乘
        function accMul (arg1, arg2) {
            var m = 0
            var s1 = arg1.toString()
            var s2 = arg2.toString()
            try { m += s1.split('.')[1].length } catch (e) {}
            try { m += s2.split('.')[1].length } catch (e) {}
            return Number(s1.replace('.', '')) * Number(s2.replace('.', '')) / Math.pow(10, m)
        }

        /**
         * forEach数组求和
         *
         * @param {array} arr 待求和数组
         */
        function sumArray (arr) {
            var s = 0
            arr.forEach(function (val) {
                s += val
            }, 0)
            return s
        }
    })

    var t0 = {
        _index: 0,
        sqbm: 'field28534' /** 申请部门-integer**/,
        sqr: 'field28535' /** 申请人-integer**/,
        sqrq: 'field28536' /** 申请日期-char(10)**/,
        sqnr: 'field28537' /** 申请内容-varchar2(4000)**/,
        xnzb: 'field28538' /** 性能指标具体要求-varchar2(4000)**/,
        xypz: 'field28539' /** 现有配置情况说明-varchar2(4000)**/,
        byx: 'field28540' /** 投资的必要性-varchar2(4000)**/,
        xg: 'field28541' /** 投资所达到的效果-varchar2(4000)**/,
        bmzgld: 'field28542' /** 部门主管领导-varchar2(12)**/,
        bmld: 'field28543' /** 部门领导-varchar2(12)**/,
        IEzgld: 'field28544' /** IE主管领导-varchar2(12)**/,
        IEbmldyj: 'field28545' /** IE部门领导意见-varchar2(12)**/,
        qkls: 'field28546' /** 情况落实-varchar2(4000)**/,
        jdap: 'field28547' /** 进度安排-varchar2(4000)**/,
        sszgld: 'field28548' /** 实施主管领导-varchar2(12)**/,
        ssbmld: 'field28549' /** 实施部门领导-varchar2(12)**/,
        zjlyj: 'field28550' /** 总经理意见-varchar2(4000)**/,
        zjlqm: 'field28551' /** 总经理签名-varchar2(12)**/,
        ghzgld: 'field28552' /** 规划主管领导-varchar2(12)**/,
        ghbmld: 'field28553' /** 规划部门领导-varchar2(12)**/,
        dszqm: 'field28554' /** 董事长签名-varchar2(12)**/,
        dszyj: 'field28555' /** 董事长意见-varchar2(4000)**/,
        bh: 'field28556' /** 编号-varchar2(20)**/,
        fgsmc: 'field28557' /** 分公司名称-integer**/,
        xgfj: 'field28558' /** 相关附件-varchar2(4000)**/,
        tzgl: 'field28559' /** 投资归类-integer**/,
        tzys: 'field28560' /** 投资预算-number(15,2)**/,
        bb: 'field28561' /** 币 别-integer**/,
        bbzj: 'field28577' /** 本币总计-number(15,4)**/,
        wbzj: 'field28578' /** 外币总计-number(15,4)**/,
        bz05: 'field28579' /** 币种（本币总计）-integer**/,
        bz07: 'field28584' /** 币种（本币）-integer**/,
        sblx01: 'field28585' /** 设备类型01-varchar2(999)**/,
        sblx02: 'field28586' /** 设备类型02-varchar2(999)**/,
        sblx03: 'field28587' /** 设备类型03-varchar2(999)**/,
        sblx04: 'field28588' /** 设备类型04-varchar2(999)**/,
        sblx05: 'field28589' /** 设备类型05-varchar2(999)**/,
        ggxh01: 'field28590' /** 规格型号01-varchar2(999)**/,
        ggxh02: 'field28591' /** 规格型号02-varchar2(999)**/,
        ggxh03: 'field28592' /** 规格型号03-varchar2(999)**/,
        ggxh04: 'field28593' /** 规格型号04-varchar2(999)**/,
        ggxh05: 'field28594' /** 规格型号05-varchar2(999)**/,
        sl01: 'field28595' /** 数量01-integer**/,
        sl02: 'field28596' /** 数量02-integer**/,
        sl03: 'field28597' /** 数量03-integer**/,
        sl04: 'field28598' /** 数量04-integer**/,
        sl05: 'field28599' /** 数量05-integer**/,
        jq01: 'field28600' /** 交期01-varchar2(20)**/,
        jq02: 'field28601' /** 交期02-varchar2(20)**/,
        jq03: 'field28602' /** 交期03-varchar2(20)**/,
        jq04: 'field28603' /** 交期04-varchar2(20)**/,
        jq05: 'field28604' /** 交期05-varchar2(20)**/,
        bbdj01: 'field28605' /** 单价（本币）01-number(15,4)**/,
        bbdj02: 'field28606' /** 单价（本币）02-number(15,4)**/,
        bbdj03: 'field28607' /** 单价（本币）03-number(15,4)**/,
        bbdj04: 'field28608' /** 单价（本币）04-number(15,4)**/,
        bbdj05: 'field28609' /** 单价（本币）05-number(15,4)**/,
        wbdj01: 'field28610' /** 单价（外币）01-number(15,4)**/,
        wbdj02: 'field28611' /** 单价（外币）02-number(15,4)**/,
        wbdj03: 'field28612' /** 单价（外币）03-number(15,4)**/,
        wbdj04: 'field28613' /** 单价（外币）04-number(15,4)**/,
        wbdj05: 'field28614' /** 单价（外币）05-number(15,4)**/,
        sblx1: 'field28615' /** 设备类型1-varchar2(999)**/,
        sblx2: 'field28616' /** 设备类型2-varchar2(999)**/,
        sblx3: 'field28617' /** 设备类型3-varchar2(999)**/,
        sblx4: 'field28618' /** 设备类型4-varchar2(999)**/,
        sblx5: 'field28619' /** 设备类型5-varchar2(999)**/,
        ggxh1: 'field28620' /** 规格型号1-varchar2(999)**/,
        ggxh2: 'field28621' /** 规格型号2-varchar2(999)**/,
        ggxh3: 'field28622' /** 规格型号3-varchar2(999)**/,
        ggxh4: 'field28623' /** 规格型号4-varchar2(999)**/,
        ggxh5: 'field28624' /** 规格型号5-varchar2(999)**/,
        sl1: 'field28625' /** 数量1-integer**/,
        sl2: 'field28626' /** 数量2-integer**/,
        sl3: 'field28627' /** 数量3-integer**/,
        sl4: 'field28628' /** 数量4-integer**/,
        sl5: 'field28629' /** 数量5-integer**/,
        xqrq1: 'field28630' /** 需求日期1-char(10)**/,
        xqrq2: 'field28631' /** 需求日期2-char(10)**/,
        xqrq3: 'field28632' /** 需求日期3-char(10)**/,
        xqrq4: 'field28633' /** 需求日期4-char(10)**/,
        xqrq5: 'field28634' /** 需求日期5-char(10)**/,
        bz08: 'field28635' /** 币种（外币）-integer**/,
        bz06: 'field28636' /** 币种（外币总计）-integer**/,
        xx: 'field28637' /** 1-number(15,4)**/,
        kk: 'field28638' /** 2-number(15,4)**/,
        san: 'field28639' /** 3-number(15,4)**/,
        si: 'field28640' /** 4-number(15,4)**/,
        wu: 'field28641' /** 5-number(15,4)**/,
        liu: 'field28642' /** 6-number(15,4)**/,
        qi: 'field28643' /** 7-number(15,4)**/,
        ba: 'field28644' /** 8-number(15,4)**/,
        jiu: 'field28645' /** 9-number(15,4)**/,
        shi: 'field28646' /** 10-number(15,4)**/,
        ssbmgcs: 'field28647' /** 实施部门工程师-clob**/,
        dw01: 'field28648' /** 单位01-varchar2(15)**/,
        dw02: 'field28649' /** 单位02-varchar2(15)**/,
        dw03: 'field28650' /** 单位03-varchar2(15)**/,
        dw04: 'field28651' /** 单位04-varchar2(15)**/,
        dw05: 'field28652' /** 单位05-varchar2(15)**/,
        qgfl: 'field28653' /** 请购分类-integer**/,
        dw1: 'field28654' /** 单位1-varchar2(10)**/,
        dw2: 'field28655' /** 单位2-varchar2(10)**/,
        dw3: 'field28656' /** 单位3-varchar2(10)**/,
        dw4: 'field28657' /** 单位4-varchar2(10)**/,
        dw5: 'field28658' /** 单位5-varchar2(10)**/,
        ssbmfj: 'field28659' /** 实施部门附件-varchar2(4000)**/,
        cwfzyj: 'field28660' /** 常务副总意见-varchar2(999)**/,
        ssgcs: 'field28661' /** 实施工程师-integer**/,
        rq1: 'field28662' /** 董事长签核日期-char(10)**/,
        sj1: 'field28663' /** 董事长签核时间-char(5)**/,
        lb01: 'field28664' /** 类 别01-integer**/,
        lb02: 'field28665' /** 类 别02-integer**/,
        lb03: 'field28666' /** 类 别03-integer**/,
        lb04: 'field28667' /** 类 别04-integer**/,
        lb05: 'field28668' /** 类 别05-integer**/,
        sm: 'field28669' /** 说明-varchar2(999)**/,
        yfxmmc: 'field28670' /** 研发项目名称-varchar2(999)**/,
        sfwtsfgs: 'field28671' /** 是否为天水分公司-integer**/,
        sfwzdbm: 'field28672' /** 是否为指定部门-integer**/,
        sslb1: 'field28673' /** 所属类别1-integer**/,
        sslb2: 'field28674' /** 所属类别2-integer**/,
        sslb3: 'field28675' /** 所属类别3-integer**/,
        sslb4: 'field28676' /** 所属类别4-integer**/,
        sslb5: 'field28677' /** 所属类别5-integer**/,
        gzzx: 'field28678' /** 工作中心-browser.ht_gzzx**/,
        cbzx: 'field28679' /** 成本中心-browser.ht_cbzx**/,
        superDept: 'field28680' /** 一级部门-integer**/,
        assetType: 'field28681' /** 请购分类(hide)-browser.assetType**/,
        hl01: 'field28682' /** 汇率01-browser.ht_rate**/,
        hl02: 'field28683' /** 汇率02-browser.ht_rate**/,
        hl03: 'field28684' /** 汇率03-browser.ht_rate**/,
        hl04: 'field28685' /** 汇率04-browser.ht_rate**/,
        hl05: 'field28686' /** 汇率05-browser.ht_rate**/,
        hasPrinted: 'field28687' /** 是否打印-integer**/,
        hasAsset: 'field28688' /** 是否含有非低易品-integer**/,
        isOver5k: 'field28689' /** 单价是否超5k-integer**/,
        fl1: 'field28690' /** 低易品分类1-integer**/,
        fl2: 'field28691' /** 低易品分类2-integer**/,
        fl3: 'field28692' /** 低易品分类3-integer**/,
        fl4: 'field28693' /** 低易品分类4-integer**/,
        fl5: 'field28694' /** 低易品分类5-integer**/,
        flownum1: 'field34156' /** 低易品编号-varchar2(500)**/,
        flownum2: 'field34157' /** 货架等编号-varchar2(500)**/,
        yfxmmcdyp: 'field35184' /** 研发项目名称低易品-varchar2(999)**/,
        yfxmmchj: 'field35185' /** 研发项目名称货架-varchar2(999)**/,
        tzglhj: 'field35186' /** 投资归类货架-integer**/,
        tzgldyp: 'field35187' /** 投资归类低易品-integer**/
    }
</script>




