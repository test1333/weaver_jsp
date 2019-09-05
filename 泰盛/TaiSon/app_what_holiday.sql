create or replace function app_what_holiday(v_what_day varchar2)
-- 1:公休日2:工作日 3 休息日
return number
as
    v_holiday_res number;
    v_week_res varchar(30);
    v_changetype number;
    v_count number;
    begin
        v_changetype := -1;
    select to_char(to_date(v_what_day,'yyyy-MM-dd'),'day') into v_week_res from dual;
    select count(1) into v_count from HrmPubHoliday where holidaydate=v_what_day;
    -- 1:公休日2:工作日 3 休息日
    if v_count > 0 then
        select changetype into v_changetype from HrmPubHoliday where holidaydate=v_what_day;
        if v_changetype=1 or v_changetype=2 or v_changetype=3 then
            v_holiday_res := v_changetype;
        end if ;
    else
        if v_week_res ='星期六' or v_week_res ='星期日' or v_week_res ='Saturday' or v_week_res ='Sunday' then
            v_holiday_res := 3;
        else
            v_holiday_res := 2;
        end if ;
    end if ;
    return v_holiday_res;
  end;
