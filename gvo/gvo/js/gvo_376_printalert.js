/**
 * Created by adore on 16/3/31.
 */
jQuery(document).ready(function() {
    checkCustomize = function() {
        var result = true;
        if(confirm("请确认转固单是否已经打印?")) {
                result = true;
        }
        else {
                result = false;
        }
        return result;
    }
});
