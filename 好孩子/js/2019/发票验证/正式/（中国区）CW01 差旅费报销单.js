<script type="text/javascript" src="/goodbaby/adore/js/cw.js"></script>
<script type="text/javascript">
var wbje="#field12810";
var sjje="#field_lable6927";
var kdkje_dt1 = "#field17829_";//明细1可抵扣金额
var jtgjlx_dt1 = "#field11560_";//明细1交通工具类型
var pmje_dt1 = "#field17831_";//明细1票面金额
var ryfjf_dt1 = "#field17826_";//明细1燃油附件费

var sjbxje_dt1 = "#field17827_";//明细1实际报销金额
var bxje_dt1 = "#field10319_";//明细1报销金额
var sjbxje_dt2 = "#field17836_";//明细2实际报销金额
var bxje_dt2 = "#field10327_";//明细2报销金额
var sjbxje_dt3 = "#field17855_";//明细3实际报销金额
var bxje_dt3 = "#field10335_";//明细3报销金额
var sjbxje_dt4 = "#field17859_";//明细4实际报销金额
var bxje_dt4 = "#field10343_";//明细4报销金额
jQuery(document).ready(function(){
	jQuery(wbje).attr("readonly", "readonly");
	jQuery(sjje).attr("readonly", "readonly");
});

jQuery(document).ready(function () {
	jQuery("button[name=addbutton0]").live("click", function () {
             var indexnum0 = jQuery("#indexnum0").val()-1;
			 jQuery(kdkje_dt1+indexnum0).attr('readonly', 'readonly')
			 bindjtgj(indexnum0);
        });
		var indexnum0 = jQuery("#indexnum0").val()
		for(var index = 0;index < indexnum0;index++){
            if(jQuery(jtgjlx_dt1+index).length>0){
				 jQuery(kdkje_dt1+index).attr('readonly', 'readonly')
				 bindjtgj(index);
                
            }
        }
    // add 2018-08-13 09:43:46,增加金额字段只读
    _C.run2(t1.ccje, function (p) {
        // console.log('p1=' + p.k)
        jQuery('#' + p.k + p.r).attr('readonly', 'readonly')
    })

    _C.run2(t2.ccje, function (p) {
        jQuery('#' + p.k + p.r).attr('readonly', 'readonly')
    })

    _C.run2(t3.ccje, function (p) {
        jQuery('#' + p.k + p.r).attr('readonly', 'readonly')
    })

    // 职级变化
    _C.run2(t0.jobLevel, function () {
        // 检查交通费
        _C.stEach(t1.jtgjlx1, function (r) {
            doCheckTravel(r)
        })

        // 检查住宿费
        _C.stEach(t2.fyfsrq, function (r) {
            doCheckHotel(r)
        })
    })

    // 明细1交通工具类型
    _C.run2(t1.jtgjlx1, function (p) {
        doCheckTravel(p.r)
    })

    // 明细1人民币金额
    _C.run2(t1.rmbje, function (p) {
        doCheckTravel(p.r)
    })

    // 明细1舱位等级
    _C.run2(t1.cwdj, function (p) {
        doCheckTravel(p.r)
    })

    // 明细1飞行时间
    // _C.run2(t1.fxsj, function (p) {
    //     doCheckTravel(p.r)
    // })

    // 明细2地区
    _C.run2(t2.cfdq2, function (p) {
        doCheckHotel(p.r)
    })

    // 明细2区域类别
    _C.run2(t2.qylb, function (p) {
        doCheckHotel(p.r)
    })

    // 明细2起住日期
    _C.run2(t2.qzrq, function (p) {
        doCheckHotel(p.r)
    })

    // 明细2结束日期
    _C.run2(t2.jsrq, function (p) {
        doCheckHotel(p.r)
    })

    // 明细2报销金额
    _C.run2(t2.bxje, function (p) {
        doCheckHotel(p.r)
    })

    // 明细2人民币金额
    _C.run2(t2.rmbje, function (p) {
        doCheckHotel(p.r)
    })

    // 明细3下标
    _C.run2('indexnum2', function () {
        _C.stEach(t3.zc, function (r) {
            checkMeal(t3.zc, r)
            checkMeal(t3.wc, r)
            checkMeal(t3.wanc, r)
        })
    })

    // 主表是否出国
    _C.run2(t0.sfcg, function () {
        _C.stEach(t3.zc, function (r) {
            doCheckMeal(r)
        })
    })

    // 明细3人民币金额
    _C.run2(t3.rmbje, function (p) {
        doCheckMeal(p.r)
    })

    checkCustomize = function () {
        // 默认加载主表未超标准
        checkMainOver('1')

        // 默认不需要归口部门审批
        jQuery('#' + t0.sfxyggbmsp).val('1')
        _C.v('dis' + t0.sfxyggbmsp, '1')

        var result = true
        // 遍历明细表1
        var arr = []
        _C.stEach(t1.jtgjlx1, function (r) {
            if (_C.v(t1.sfcbz + r) === '0') {
                checkMainOver('0')
            }
            if (_C.v(t1.jtgjlx1 + r) === '1') {
                arr.push(_C.v(t1.fyfsrq + r))
            } else if (_C.v(t1.jtgjlx1 + r) === '0') {
                if (_C.v(t1.jpzk + r) === '1') {
                    jQuery('#' + t0.sfxyggbmsp).val('0')
                    _C.v('dis' + t0.sfxyggbmsp, '0')
                }
            }
        })
        if (isRepeat(arr)) {
            Dialog.alert('交通工具为出租车时,同一天只能有一行明细')
            return false
        }

        var dateStr = ''
        // 遍历明细表2
        _C.stEach(t2.fyfsrq, function (r) {
            var begin = _C.v(t2.qzrq + r)
            var end = _C.v(t2.jsrq + r)
            if (begin >= end) {
                Dialog.alert('差旅住宿明细行结束日期必须大于起住日期,请检查')
                result = false
            } else {
                if (begin !== '' || end !== '') {
                    dateStr += getBetweenDays(begin, end)
                }
            }
            if (_C.v(t2.sfcbz + r) === '0') {
                checkMainOver('0')
            }
        })

        // 遍历明细表3
        _C.stEach(t3.sfcbz, function (r) {
            if (_C.v(t3.sfcbz + r) === '0') {
                checkMainOver('0')
            }
        })
        // console.log('dateStr=' + dateStr)
        var dateArr = dateStr.split(',')
        // console.log('dateArr=' + dateArr)
        if (isRepeat(dateArr)) {
            Dialog.alert('差旅住宿明细行间住宿日期有重复,请检查')
            return false
        }

        // 遍历明细表3
        var arr3 = []
        _C.stEach(t3.fyfsrq, function (r) {
            arr3.push(_C.v(t3.fyfsrq + r))
        })
        if (isRepeat(arr3)) {
            Dialog.alert('差旅餐费明细费用发生日期重复')
            return false
        }

        // 遍历明细表是否超标准字段，去除disabled属性以更新值到数据库
        _C.stEach(t1.sfcbz, function (r) {
            jQuery('#dis' + t1.sfcbz + r).removeAttr('disabled')
        })

        _C.stEach(t2.sfcbz, function (r) {
            jQuery('#dis' + t2.sfcbz + r).removeAttr('disabled')
        })

        _C.stEach(t3.sfcbz, function (r) {
            jQuery('#dis' + t3.sfcbz + r).removeAttr('disabled')
        })
		//金额校验
		var indexnum0=jQuery("#indexnum0").val(); 
        for( var index=0;index<indexnum0;index++){
            if( jQuery(sjbxje_dt1+index).length>0){
                var sjbxje_dt1_val = jQuery(sjbxje_dt1+index).val();
				var bxje_dt1_val = jQuery(bxje_dt1+index).val();
				if(sjbxje_dt1_val==""){
						sjbxje_dt1_val = "0";
				}
				if(bxje_dt1_val==""){
						bxje_dt1_val = "0";
				}
                if(Number(sjbxje_dt1_val)>Number(bxje_dt1_val)){
                	Dialog.alert("明细1中存在实际报销金额大于报销金额的数据，请检查");
                	return false; 
                }
            }
        }
		indexnum0=jQuery("#indexnum1").val(); 
        for( var index=0;index<indexnum0;index++){
            if( jQuery(sjbxje_dt2+index).length>0){
                var sjbxje_dt2_val = jQuery(sjbxje_dt2+index).val();
				var bxje_dt2_val = jQuery(bxje_dt2+index).val();
				if(sjbxje_dt2_val==""){
						sjbxje_dt2_val = "0";
				}
				if(bxje_dt2_val==""){
						bxje_dt2_val = "0";
				}
                if(Number(sjbxje_dt2_val)>Number(bxje_dt2_val)){
                	Dialog.alert("明细2中存在实际报销金额大于报销金额的数据，请检查");
                	return false; 
                }
            }
        }
		indexnum0=jQuery("#indexnum2").val(); 
        for( var index=0;index<indexnum0;index++){
            if( jQuery(sjbxje_dt3+index).length>0){
                var sjbxje_dt3_val = jQuery(sjbxje_dt3+index).val();
				var bxje_dt3_val = jQuery(bxje_dt3+index).val();
				if(sjbxje_dt3_val==""){
						sjbxje_dt3_val = "0";
				}
				if(bxje_dt3_val==""){
						bxje_dt3_val = "0";
				}
                if(Number(sjbxje_dt3_val)>Number(bxje_dt3_val)){
                	Dialog.alert("明细3中存在实际报销金额大于报销金额的数据，请检查");
                	return false; 
                }
            }
        }
		indexnum0=jQuery("#indexnum3").val(); 
        for( var index=0;index<indexnum0;index++){
            if( jQuery(sjbxje_dt4+index).length>0){
                var sjbxje_dt4_val = jQuery(sjbxje_dt4+index).val();
				var bxje_dt4_val = jQuery(bxje_dt4+index).val();
				if(sjbxje_dt4_val==""){
						sjbxje_dt4_val = "0";
				}
				if(bxje_dt4_val==""){
						bxje_dt4_val = "0";
				}
                if(Number(sjbxje_dt4_val)>Number(bxje_dt4_val)){
                	Dialog.alert("明细4中存在实际报销金额大于报销金额的数据，请检查");
                	return false; 
                }
            }
        }
        return result
    }

    /**
     * 检查交通费是否超标准
     *
     * @param {String} r 明细行下标
     * @return void
     */
    function doCheckTravel (r) {
        var type = _C.v(t1.jtgjlx1 + r)
        var money = _C.v(t1.rmbje + r)
        // var hours = _C.v(t1.fxsj + r)
        var berth = _C.v(t1.cwdj + r)
        if (type === '1') {
            if (Number(money) > 100) {
                // edit 2018-08-13 11:56:21 选择框只读
                disableSelected(t1.sfcbz + r, '0')
                // 该行添加黄色背景色
                trBackground(t1.sfcbz + r, '0')
                // add 2018-08-10 16:39:05,增加超出金额计算
                _C.v(t1.ccje + r, Number(money) - 100)
            } else {
                // edit 2018-08-13 11:56:21 选择框只读
                disableSelected(t1.sfcbz + r, '1')
                // 该行删除背景色
                trBackground(t1.sfcbz + r, '1')
                // add 2018-08-10 16:39:56 清空
                _C.v(t1.ccje + r, '0.00')
            }
        } else if (type === '0') {
            var result = isPlaneOver(_C.v(t0.jobLevel), berth)
            if (!result) {
                // edit 2018-08-13 11:56:21 选择框只读
                disableSelected(t1.sfcbz + r, '0')
                // 该行添加黄色背景色
                trBackground(t1.sfcbz + r, '0')
                // add 2018-08-10 16:40:41 增加超出金额计算
                _C.v(t1.ccje + r, money)
            } else {
                // edit 2018-08-13 11:56:21 选择框只读
                disableSelected(t1.sfcbz + r, '1')
                // 该行删除背景色
                trBackground(t1.sfcbz + r, '1')
                // add 2018-08-10 17:03:31 清空
                _C.v(t1.ccje + r, '0.00')
            }
        } else if (type === '2') {
            // 火车超标准
            if (berth === '3') {
                // edit 2018-08-13 11:56:21 选择框只读
                disableSelected(t1.sfcbz + r, '0')
                // 该行添加黄色背景色
                trBackground(t1.sfcbz + r, '0')
                // add 2018-08-10 17:32:27 增加超出金额计算
                _C.v(t1.ccje + r, money)
            } else if (berth === '2') {
                // edit 2018-08-13 11:56:21 选择框只读
                disableSelected(t1.sfcbz + r, '1')
                // 该行删除背景色
                trBackground(t1.sfcbz + r, '1')
                // add 2018-08-10 17:32:56 清空
                _C.v(t1.ccje + r, '0.00')
            }
        } else {
            // add 2018-08-13 13:30:06 防止新增选择框选项但是没有费控导致显示出错
            disableSelected(t1.sfcbz + r, '1')
            // 该行删除背景色
            trBackground(t1.sfcbz + r, '1')
            // add 2018-08-10 17:32:56 清空
            _C.v(t1.ccje + r, '0.00')
        }
    }

    /**
     * 检查飞机费用是否超标准
     *
     * @param {string} jobLevel 职级
     * @param {string} berth 舱位等级0商务舱、1经济舱
     * @return boolean
     */
    function isPlaneOver (jobLevel, berth) {
        var result = true
        if (Number(jobLevel) <= 17) {
            if (berth === '0') {
                result = false
            }
        }
        return result
    }

    /**
     * 检查数组是否有重复元素
     *
     * @param {*} arr 数组
     * @return boolean
     */
    function isRepeat (arr) {
        var hash = {}
        for (var i in arr) {
            if (hash[arr[i]]) {
                return true
            }
            hash[arr[i]] = true
        }
        return false
    }

    /**
     * 检查住宿费是否超标
     *
     * @param {string} r 明细表下标
     * @return boolean false 超标
     */
    function doCheckHotel (r) {
        var jobLevel = _C.v(t0.jobLevel)
        var area = _C.v(t2.cfdq2 + r)
        var cityType = _C.v(t2.qylb + r)
        var money = _C.v(t2.rmbje + r)
        var money2 = _C.v(t2.bxje + r)
        var sDate = _C.v(t2.qzrq + r)
        var eDate = _C.v(t2.jsrq + r)
        var days
        if (sDate === '' || eDate === '') {
            days = '0'
        } else {
            if (sDate === eDate) {
                days = '1'
            } else {
                days = cus_CalTimeDiff(t2.qzrq + r, t2.jsrq + r)
            }
            money = Number(money) / Number(days)
            money2 = Number(money2) / Number(days)
        }
        var result = isHotelOver(jobLevel, area, cityType, money, money2)
        if (Number(result) > 0) {
            // edit 2018-08-13 11:56:21 选择框只读
            disableSelected(t2.sfcbz + r, '0')
            // 该行添加黄色背景色
            trBackground(t2.sfcbz + r, '0')
            // add 2018-08-10 16:25:43 增加超出金额计算
            if (Number(days) > 0) {
                _C.v(t2.ccje + r, result * days)
            } else {
                _C.v(t2.ccje + r, result)
            }
        } else {
            // edit 2018-08-13 11:56:21 选择框只读
            disableSelected(t2.sfcbz + r, '1')
            // 去除背景色
            trBackground(t2.sfcbz + r, '1')
            // add 2018-08-10 16:29:41 去空
            _C.v(t2.ccje + r, '0.00')
        }
    }

    /**
     * 检查住宿费是否超标准
     *
     * @param {string} jobLevel
     * @param {string} area
     * @param {string} cityType
     * @param {string} money
     * @param {string} money2
     * @return number >0 超标准 add 2018-08-10 17:00:05 计算超出金额
     */
    function isHotelOver (jobLevel, area, cityType, money, money2) {
        var result = 0
        // 大陆地区
        if (area === '0') {
            // 职级7级及以下
            if (Number(jobLevel) <= 7) {
                result = checkCityType(cityType, money, '230', '170', '150')
            } else if (Number(jobLevel) === 8 || Number(jobLevel) === 9) {
                result = checkCityType(cityType, money, '250', '190', '160')
            } else if (Number(jobLevel) >= 10 && Number(jobLevel) <= 13) {
                result = checkCityType(cityType, money, '300', '220', '200')
            } else if (Number(jobLevel) >= 14 && Number(jobLevel) <= 16) {
                result = checkCityType(cityType, money, '400', '370', '340')
            } else if (Number(jobLevel) === 17) {
                result = checkCityType(cityType, money, '600', '500', '400')
            }
        } else if (area === '1')  { // 欧元区
            if (Number(money2) > 1200) {
                result = Number(money2) - 1200
            }
        } else if (area === '2')  { // 英镑区
            if (Number(money2) > 1500) {
                result = Number(money2) - 1500
            }
        } else { // 港澳台
            if (Number(money2) > 150) {
                result = Number(money2) - 150
            }
        }
        return result
    }

    /**
     * 检查各类地区是否超标准
     *
     * @param {string} cityType 地区类别
     * @param {string} money 报销费用
     * @param {string} money0 一类地区
     * @param {string} money1 二类地区
     * @param {string} money2 三类地区
     * @return number >0 超标准 edit 2018-08-10 16:59:20 计算超出金额
     */
    function checkCityType (cityType, money, money0, money1, money2) {
        var result = 0
        if (cityType === '0') {
            if (Number(money) > Number(money0)) {
                result = Number(money) - Number(money0)
            }
        } else if (cityType === '1') {
            if (Number(money) > Number(money1)) {
                result = Number(money) - Number(money1)
            }
        } else if (cityType === '2') {
            if (Number(money) > Number(money2)) {
                result = Number(money) - Number(money2)
            }
        }
        return result
    }

    /**
     * 餐费控制
     * @param {string} r 明细表下标
     * @return boolean false 超标
     */
    function isMealOver (r) {
        var result = true
        var meal = 0.00
        var meal1 = 0.00
        var meal2 = 0.00
        var meal3 = 0.00
        var isAbroad = _C.v(t0.sfcg)
        var check_1 = cus_getFieldValue(t3.zc + r) // 早餐是否选中
        var check_2 = cus_getFieldValue(t3.wc + r) // 午餐是否选中
        var check_3 = cus_getFieldValue(t3.wanc + r) // 晚餐是否选中
        var money = _C.v(t3.rmbje + r)
        if (isAbroad === '0') { // 出国
            if (check_1 === '1') {
                meal1 = 50.00
            } else {
                meal1 = 0.00
            }

            if (check_2 === '1') {
                meal2 = 150.00
            } else {
                meal2 = 0.00
            }

            if (check_3 === '1') {
                meal3 = 150.00
            } else {
                meal3 = 0.00
            }
        } else if (isAbroad === '1') {
            if (check_1 === '1') {
                meal1 = 20.00
            } else {
                meal1 = 0.00
            }

            if (check_2 === '1') {
                meal2 = 30.00
            } else {
                meal2 = 0.00
            }

            if (check_3 === '1') {
                meal3 = 30.00
            } else {
                meal3 = 0.00
            }
        }

        meal = Number(meal1) + Number(meal2) + Number(meal3)
        // console.log('meal=' + meal + '|类型=' + typeof meal)
        if (Number(money) > Number(meal)) {
            // add 2018-08-10 16:05:00,计算超额费用
            var over = Number(money) - Number(meal)
            _C.v(t3.ccje + r, over)
            // add end
            result = false
        } else {
            // add 2018-08-10 16:23:53 未超出，清空
            _C.v(t3.ccje + r, '0.00')
        }

        return result
    }

    /**
     * 绑定check框click事件
     *
     * @param {string} fieldid 字段id
     * @param {string} r 明细表下标
     * @return void
     */
    function checkMeal (fieldid, r) {
        jQuery('#' + fieldid + r).click(function () {
            // console.log('result=' + isMealOver(r) + '|r=' + r)
            var result = isMealOver(r)
            if (!result) {
                // edit 2018-08-13 11:56:21 选择框只读
                disableSelected(t3.sfcbz + r, '0')
                // 该行添加黄色背景色
                trBackground(t3.sfcbz + r, '0')
            } else {
                // 保存到数据库的值
                // jQuery('#' + t3.sfcbz + r).val('1')
                // 选中之后页面展示的值
                // _C.v('dis' + t3.sfcbz + r, '1')
                // edit 2018-08-13 11:56:21 选择框只读
                disableSelected(t3.sfcbz + r, '1')
                // 该行删除背景色
                trBackground(t3.sfcbz + r, '1')
            }
        })
    }

    /**
     * 判断餐费是否超标准
     *
     * @param {string} r 明细表下标
     * @return void
     */
    function doCheckMeal (r) {
        var result = isMealOver(r)
        if (!result) {
            // 保存到数据库的值
            // jQuery('#' + t3.sfcbz + r).val('0')
            // 选中之后页面展示的值
            // _C.v('dis' + t3.sfcbz + r, '0')
            // edit 2018-08-13 11:56:21 选择框只读
            disableSelected(t3.sfcbz + r, '0')
            // 该行添加黄色背景色
            trBackground(t3.sfcbz + r, '0')
        } else {
            // 保存到数据库的值
            // jQuery('#' + t3.sfcbz + r).val('1')
            // 选中之后页面展示的值
            // _C.v('dis' + t3.sfcbz + r, '1')
            // edit 2018-08-13 11:56:21 选择框只读
            disableSelected(t3.sfcbz + r, '1')
            // 该行删除背景色
            trBackground(t3.sfcbz + r, '1')
        }
    }

    /**
     * 修改明细行背景色
     *
     * @param {string} fieldid 字段id
     * @param {string} flag 标识，0添加背景，1取消背景
     * @return void
     */
    function trBackground (fieldid, flag) {
        var td = jQuery('#' + fieldid).parent()
        if (flag === '0') {
            // 该行添加黄色背景色
            td.parent().attr('style', 'background-color:yellow')
        } else {
            // 该行删除背景色
            td.parent().removeAttr('style')
        }
    }

    /**
     * 日期加天数
     *
     * @param {string} date 例如：2018-01-01
     * @param {String} days
     */
    function addDate (date, days) {
        if (days === undefined || days === '') {
            days = 1
        }
        var dateNew = new Date(date)
        dateNew.setDate(dateNew.getDate() + Number(days))
        var month = dateNew.getMonth() + 1
        var day = dateNew.getDate()
        return dateNew.getFullYear() + '-' + getFormatDate(month) + '-' + getFormatDate(day)
    }

    /**
     * 日期月份/天的显示，如果是1位数，则在前面加上'0'
     *
     * @param {string} arg
     */
    function getFormatDate (arg) {
        if (arg === undefined || arg === '') {
            return ''
        }

        var re = arg + ''
        if (re.length < 2) {
            re = '0' + re
        }

        return re
    }

    /**
     * 获取两段日期间的所有日期
     *
     * @param {string} begin 开始日期
     * @param {string} end 结束日期
     * @return {string} str
     */
    function getBetweenDays (begin, end) {
        var str = ''
        if (begin === '' || end === '') {
            return ''
        } else {
            if (begin === end) {
                return begin
            } else {
                var flag = ''
                for (var tmpDate = begin; tmpDate < end; tmpDate = addDate(tmpDate, '1')) {
                    flag = ','
                    str += tmpDate + flag
                }
            }
        }
        return str
    }

    function checkMainOver (flag) {
        // 保存到数据库的值
        // jQuery('#' + t0.sfcbz).val(flag)
        // 选中之后页面展示的值
        // _C.v('dis' + t0.sfcbz, flag)

        // edit 2018-08-13 11:56:21 选择框只读
        disableSelected(t0.sfcbz, flag)
    }

    /**
     * 选择框只读
     *
     *
     * @param {string} fieldid  表单字段
     * @param {string} flag 标识
     */
    function disableSelected (fieldid, flag) {
        jQuery('#' + fieldid).empty()
        // 保存到数据库的值
        // jQuery('#' + fieldid).val(flag)
        // 选中之后页面展示的值
        // _C.v('dis' + fieldid, flag)
        if (flag === '0') {
            jQuery('#' + fieldid).append("<option value='0' selected>是</option>") // 为Select追加一个Option(下拉项)
        } else {
            jQuery('#' + fieldid).append("<option value='1' selected>否</option>") // 为Select追加一个Option(下拉项)
        }
    }
})
function bindjtgj(index){
	jQuery(jtgjlx_dt1+index).bind("change",function(){
		getkdkje(index);
		
	})
	jQuery(pmje_dt1+index).bind("change",function(){
		getkdkje(index);
		
	})
	jQuery(ryfjf_dt1+index).bind("change",function(){
		getkdkje(index);
		
	})
	
}
function getkdkje(index){
	var jtgjlx_dt1_val = jQuery(jtgjlx_dt1+index).val();
		var pmje_dt1_val = jQuery(pmje_dt1+index).val();
		if(pmje_dt1_val == ""){
			pmje_dt1_val = "0.00";
		}
		var ryfjf_dt1_val = jQuery(ryfjf_dt1+index).val();
		if(ryfjf_dt1_val == ""){
			ryfjf_dt1_val = "0.00";
		}
		if(jtgjlx_dt1_val=="0"||jtgjlx_dt1_val=="2"||jtgjlx_dt1_val=="3"){
			var kdkje_val = "";
			
			  $.ajax({
				 type: "POST",
				 url: "/goodbaby/gb2019/getkdkje.jsp",
				 data: {'type':jtgjlx_dt1_val, 'pmje':pmje_dt1_val,'ryfjf':ryfjf_dt1_val},
				 dataType: "text",
				 async:false,//同步   true异步
				 success: function(data){
							data=data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
							kdkje_val=data;
				 }
			 });
			 jQuery(kdkje_dt1+index).val(kdkje_val);

		}else{
			jQuery(kdkje_dt1+index).val("0.00");
		}
}
var t0 = {
    _index: 0,
    lcbh: 'field10278' /** 流程编号-varchar(300)**/,
    sqr: 'field10279' /** 申请人-int**/,
    sqbm: 'field10280' /** 总经理部门-int**/,
    gs: 'field10281' /** 公司1-int**/,
    gh: 'field10282' /** 申请人工号-varchar(300)**/,
    zw: 'field10283' /** 职位-int**/,
    skrmc: 'field10284' /** 收款人名称-varchar(300)**/,
    skyhmc: 'field10285' /** 收款银行名称-varchar(300)**/,
    skyhzh: 'field10286' /** 收款银行账号-varchar(300)**/,
    cbzx: 'field10287' /** 成本中心（费用归属部门）-int**/,
    cbzxbm: 'field10288' /** 成本中心编码-varchar(300)**/,
    djrq: 'field10289' /** 单据日期-char(10)**/,
    zje: 'field10290' /** 总金额-decimal(15,2)**/,
    beiz: 'field10291' /** 备注-text**/,
    whbyj: 'field10292' /** 未还备用金-decimal(15,2)**/,
    jklsjl: 'field10293' /** 借款历史记录-varchar(4000)**/,
    bcsfje: 'field10294' /** 本次实发金额-decimal(15,2)**/,
    bcsfjedx: 'field10295' /** 本次实发金额大写-decimal(15,2)**/,
    xgfj: 'field10296' /** 相关附件-text**/,
    bz: 'field10308' /** 币种-int**/,
    zj: 'field10309' /** 总计-varchar(30)**/,
    tdr: 'field10310' /** 填单人-int**/,
    tdryx: 'field10311' /** 填单人部门-varchar(300)**/,
    tdrgh: 'field10312' /** 填单人工号-varchar(300)**/,
    sqryx: 'field10313' /** 申请人部门-varchar(300)**/,
    zffs: 'field10314' /** 支付方式-int**/,
    jt: 'field10315' /** 交通总金额-decimal(15,2)**/,
    zs: 'field10316' /** 住宿总金额-decimal(15,2)**/,
    cf: 'field10317' /** 餐费总金额-decimal(15,2)**/,
    qrf: 'field10318' /** 其他费用总金额-decimal(15,2)**/,
    sqrq: 'field10349' /** 申请日期-char(10)**/,
    cs: 'field10350' /** 城市-int**/,
    sfgc: 'field10353' /** 是否工厂-int**/,
    zjl: 'field10354' /** 总经理-int**/,
    xglc: 'field10355' /** 相关出差申请单(其他)-varchar(4000)**/,
    jec: 'field10356' /** 金额差-decimal(15,2)**/,
    whje: 'field10357' /** 未还金额-decimal(15,2)**/,
    bmjl: 'field10566' /** 部门经理-int**/,
    bm: 'field10600' /** 申请人部门ID-int**/,
    manager: 'field10707' /** 直接上级-int**/,
    pzfj: 'field10767' /** 凭证附件-text**/,
    gs1: 'field10822' /** 公司-int**/,
    ysbh: 'field11338' /** 预算编号-varchar(300)**/,
    tdbm: 'field11362' /** 填单部门-int**/,
    cbzx1: 'field11363' /** 成本中心（费用归属部门）-browser.cbzx**/,
    jl: 'field11429' /** 经理-int**/,
    VP: 'field11469' /** VP-int**/,
    SVP: 'field11470' /** SVP-int**/,
    sfcg: 'field11538' /** 是否出国-int**/,
    sfcbz: 'field11539' /** 是否超标准-int**/,
    jobLevel: 'field11757' /** 申请人职级-int**/,
    sfxyggbmsp: 'field11758' /** 是否需要归口部门审批-int**/,
    company: 'field11784' /** 公司-browser.Company**/,
    xgccsqd: 'field12798' /** 相关出差申请单(废弃)-varchar(4000)**/,
    ccsq: 'field12838' /** 相关出差申请单-int**/
}
var t1 = {
    _index: 1,
    fyfsrq: 'field10297' /** 费用发生日期-char(10)**/,
    cfcs: 'field10298' /** 出发城市1-int**/,
    mddcs: 'field10299' /** 目的地城市1-int**/,
    jtgj: 'field10300' /** 交通工具-varchar(300)**/,
    jtgjje: 'field10301' /** 交通工具金额-varchar(30)**/,
    fjfy: 'field10302' /** 房间费用-varchar(30)**/,
    cf: 'field10303' /** 餐费-varchar(30)**/,
    qtfy: 'field10304' /** 其他费用-varchar(30)**/,
    hj: 'field10305' /** 合计-varchar(30)**/,
    bz: 'field10306' /** 备注-varchar(300)**/,
    sfcbz: 'field10307' /** 是否超标准-int**/,
    bxje: 'field10319' /** 报销金额-decimal(15,2)**/,
    bz1: 'field10320' /** 币种-browser.huin**/,
    hl: 'field10321' /** 汇率-decimal(15,4)**/,
    rmbje: 'field10322' /** 人民币金额-decimal(15,2)**/,
    cf1: 'field10351' /** 出发城市-int**/,
    mdd1: 'field10352' /** 目的地城市-int**/,
    cfdq2: 'field11545' /** 地区-int**/,
    cfcs2: 'field11546' /** 出发城市-browser.cs**/,
    mdcs2: 'field11547' /** 目的城市-browser.cs**/,
    cwdj: 'field11548' /** 等级-int**/,
    jtgjlx1: 'field11560' /** 交通工具类型-int**/,
    fxsj: 'field11702' /** 飞行时间-decimal(15,1)**/,
    jpzk: 'field11759' /** 票价折扣-int**/,
    ccje: 'field12840' /** 超出金额-decimal(15,2)**/
}
var t2 = {
    _index: 2,
    fyfsrq: 'field10323' /** 费用发生日期-char(10)**/,
    jdmc: 'field10324' /** 酒店名称-varchar(200)**/,
    qzrq: 'field10325' /** 起住日期-char(10)**/,
    jsrq: 'field10326' /** 结束日期-char(10)**/,
    bxje: 'field10327' /** 报销金额-decimal(15,2)**/,
    bz1: 'field10328' /** 币种-browser.huin**/,
    hl: 'field10329' /** 汇率-decimal(15,4)**/,
    rmbje: 'field10330' /** 人民币金额-decimal(15,2)**/,
    bz: 'field10331' /** 备注-varchar(300)**/,
    sfcbz: 'field10332' /** 是否超标准-int**/,
    cs: 'field11550' /** 城市-browser.cs**/,
    sl: 'field11551' /** 税率-decimal(15,2)**/,
    sj: 'field11552' /** 税金-decimal(15,2)**/,
    cfdq2: 'field11700' /** 地区-int**/,
    qylb: 'field11701' /** 区域类别-int**/,
    ccje: 'field12841' /** 超出金额-decimal(15,2)**/
}
var t3 = {
    _index: 3,
    fyfsrq: 'field10333' /** 费用发生日期-char(10)**/,
    cflx: 'field10334' /** 餐费类型-int**/,
    bxje: 'field10335' /** 报销总金额-decimal(15,2)**/,
    bz1: 'field10336' /** 币种-browser.huin**/,
    hl: 'field10337' /** 汇率-decimal(15,4)**/,
    rmbje: 'field10338' /** 人民币金额-decimal(15,2)**/,
    bz: 'field10339' /** 备注-varchar(300)**/,
    sfcbz: 'field10340' /** 是否超标准-int**/,
    zc: 'field11692' /** 早餐-char(1)**/,
    wc: 'field11693' /** 午餐-char(1)**/,
    wanc: 'field11694' /** 晚餐-char(1)**/,
    ccje: 'field12842' /** 超出金额-decimal(15,2)**/
}
var t4 = {
    _index: 4,
    fyfsrq: 'field10341' /** 费用发生日期-char(10)**/,
    sx: 'field10342' /** 事项-varchar(300)**/,
    bxje: 'field10343' /** 报销金额-decimal(15,2)**/,
    bz1: 'field10344' /** 币种-browser.huin**/,
    hl: 'field10345' /** 汇率-decimal(15,4)**/,
    rmbje: 'field10346' /** 人民币金额-decimal(15,2)**/,
    bz: 'field10347' /** 备注-varchar(300)**/,
    sfcbz: 'field10348' /** 是否超标准-int**/,
    sl: 'field11557' /** 税率-decimal(15,2)**/,
    sj: 'field11558' /** 税金-decimal(15,2)**/
}

</script>	


