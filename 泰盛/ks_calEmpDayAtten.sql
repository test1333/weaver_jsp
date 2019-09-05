CREATE OR REPLACE PROCEDURE ks_calEmpDayAtten(v_emp_id number,v_atten_day varchar2)
as
  v_count_cc number;
  v_is_work_day number;
  v_atten_id number;
  v_start_time varchar2(8);
  v_end_time varchar2(8);
  v_atten_start_time varchar2(8);
  v_atten_end_time varchar2(8);
  v_atten_mid_time varchar2(8);
  v_min_time varchar2(8);
  v_max_time varchar2(8);
  v_val1 number;
  v_val2 number;
  v_temp_start_time varchar2(8);
  v_temp_end_time varchar2(8);
  v_temp_val number;
  -- v_number number;
  v_isEs number;
  v_fg_card number;
  v_fg_reqid number;
  v_before_day_time varchar2(8);
  v_be_card number;
  v_is_exception number;
  v_re_va1_1 number;
  v_re_val_2 number;
  begin

    if   v_atten_day >  to_char(sysdate,'yyyy-mm-dd') then
         return;
    end if;

    -- has atten
    select  count(1) into v_count_cc  from uf_jtzbkqry where xm = v_emp_id;
    select v_count_cc + count(1) into v_count_cc from  uf_tsmygskqry where xm = v_emp_id;

    if v_count_cc = 0 then
       delete from uf_all_atten_info where emp_id = v_emp_id and atten_day = v_atten_day;
       commit;
       return;
    end if;


    -- is not workday
    select ks_what_holiday(v_atten_day) into v_is_work_day from dual;
    if v_is_work_day != 2 then
       -- all delete
       -- delete from uf_all_atten_info where emp_id = v_emp_id and atten_day = v_atten_day;


         select min(signtime) into v_atten_start_time from  hrmschedulesign where userid = v_emp_id
           and signdate = v_atten_day;

         select max(signtime) into v_atten_end_time from hrmschedulesign where userid = v_emp_id
           and signdate = v_atten_day;

             v_min_time := v_atten_start_time;
         v_max_time := v_atten_end_time ;

             v_start_time := '08:30:59';
        v_end_time := '17:30:00';

         declare
           cursor v_cur_p0_ks is
           select requestid,ccksrq,cckssj,ccjsrq,ccjssj,bcsjccts
                from  formtable_main_250
                 where requestid in (select requestid from workflow_requestbase where workflowid = 4103 and currentnodetype = 3)
              and ccksrq <= v_atten_day and ccjsrq >= v_atten_day and sqr = v_emp_id;

           v_p0_reqid formtable_main_250.requestid%type;
           v_p0_start_date formtable_main_250.ccksrq%type;
           v_p0_start_time formtable_main_250.cckssj%type;
           v_p0_end_date formtable_main_250.ccjsrq%type;
           v_p0_end_time formtable_main_250.ccjssj%type;
           v_p0_hours formtable_main_250.bcsjccts%type;

         begin
           open v_cur_p0_ks;
           if v_cur_p0_ks%ISOPEN THEN

             loop
               fetch v_cur_p0_ks into v_p0_reqid,v_p0_start_date,v_p0_start_time,v_p0_end_date,v_p0_end_time,v_p0_hours;
                 exit when v_cur_p0_ks%notfound;
             --    v_number := v_number + 1;
             --    DBMS_OUTPUT.PUT_LINE('3 hao ' || v_number );
             --    insert into uf_all_atten_info_dt1(rqid,start_time,end_time,type) value(v_atten_id,

                -- if startdate and enddate is same
                if v_p0_start_date =  v_p0_end_date then
                    begin
                      if v_min_time is null or v_min_time > v_p0_start_time then
                          v_min_time := v_p0_start_time;
                      end if;
                      if v_max_time is null or v_max_time < v_p0_end_time then
                          v_max_time := v_p0_end_time;
                       end if;

                    end;
                elsif   v_p0_start_date = v_atten_day then
                   begin
                      if v_min_time is null or v_min_time > v_p0_start_time then
                          v_min_time := v_p0_start_time;
                      end if;
                      v_max_time := v_end_time;

                   end;
                elsif   v_p0_end_date = v_atten_day then
                   begin
                      v_min_time := v_start_time;
                      if v_max_time is null or v_max_time < v_p0_end_time then
                          v_max_time := v_p0_end_time;
                      end if;

                   end;
                else
                   begin
                      v_min_time := v_start_time;
                      v_max_time := v_end_time;

                   end;
                end if;

             end loop;
           end if;
           close v_cur_p0_ks;
          end;

  declare
       cursor v_cur_p4_ks is
       select requestid,wcqrq,wcqssj,wcjsrq,wcjssj,wcxs
            from  formtable_main_249
            where requestid in (select requestid from workflow_requestbase where   currentnodetype = 3)
          and wcqrq <= v_atten_day and wcjsrq >= v_atten_day and sqr = v_emp_id;

       v_p4_reqid formtable_main_249.requestid%type;
       v_p4_start_date formtable_main_249.wcqrq%type;
       v_p4_start_time formtable_main_249.wcqssj%type;
       v_p4_end_date formtable_main_249.wcjsrq%type;
       v_p4_end_time formtable_main_249.wcjssj%type;
       v_p4_hours formtable_main_249.wcxs%type;

     begin
       open v_cur_p4_ks;
       if v_cur_p4_ks%ISOPEN THEN

         loop
           fetch v_cur_p4_ks into v_p4_reqid,v_p4_start_date,v_p4_start_time,v_p4_end_date,v_p4_end_time,v_p4_hours;
             exit when v_cur_p4_ks%notfound;

            if v_p4_start_date =  v_p4_end_date then
                begin
                  if v_min_time is null or v_min_time > v_p4_start_time then
                      v_min_time := v_p4_start_time;
                  end if;
                  if v_max_time is null or v_max_time < v_p4_end_time then
                      v_max_time := v_p4_end_time;
                   end if;
                end;
            elsif   v_p4_start_date = v_atten_day then
               begin
                  if v_min_time is null or v_min_time > v_p4_start_time then
                      v_min_time := v_p4_start_time;
                  end if;
                  v_max_time := v_end_time;
               end;
            elsif   v_p4_end_date = v_atten_day then
               begin
                  v_min_time := v_start_time;
                  if v_max_time is null or v_max_time < v_p4_end_time then
                      v_max_time := v_p4_end_time;
                  end if;
               end;
            else
               begin
                  v_min_time := v_start_time;
                  v_max_time := v_end_time;
               end;
            end if;
           exit when v_cur_p4_ks%notfound;
         end loop;
        end if ;
       close v_cur_p4_ks;
      end;
     

         if v_min_time is not null then
           begin
             if length(v_min_time) = 5 then
          select v_min_time||':00' into v_min_time from dual;
        end if;
      if length(v_max_time) = 5 then
          select v_max_time||':00' into v_max_time from dual;
      end if;
             select count(1) into v_count_cc from uf_all_atten_info where emp_id = v_emp_id and atten_day = v_atten_day;
          if v_count_cc = 0 then
             insert into uf_all_atten_info(emp_id,atten_day) values(v_emp_id,v_atten_day);
             commit;
          end if;

             update uf_all_atten_info set atten_start_time=v_atten_start_time,atten_end_time=v_atten_end_time,late_times=0,early_leave_times=0,
               min_time = v_min_time,max_time = v_max_time where emp_id = v_emp_id and atten_day = v_atten_day;

--              insert into uf_all_atten_info(emp_id,atten_day,atten_start_time,atten_end_time,late_times,early_leave_times,min_time,max_time)
--                    values(v_emp_id,v_atten_day,v_atten_start_time,v_atten_end_time,0,0,v_min_time,v_max_time);
            end;
         else
           delete from uf_all_atten_info where emp_id = v_emp_id and atten_day = v_atten_day;
         end if;

         commit;

       return;
    end if;

    -- normal atten begin
    select count(1) into v_count_cc from uf_all_atten_info where emp_id = v_emp_id and atten_day = v_atten_day;
    if v_count_cc = 0 then
       insert into uf_all_atten_info(emp_id,atten_day) values(v_emp_id,v_atten_day);
       commit;
    end if;
    -- get atten id
    select id into v_atten_id from uf_all_atten_info where emp_id = v_emp_id and atten_day = v_atten_day;

    if v_atten_id is null or v_atten_id < 1 then
       return;
    end if;

    -- delete detail data
    delete from uf_all_atten_info_dt1 where mainid = v_atten_id;
    commit;

    -- if  13:30  leave  ,must  get system database info
    v_start_time := '08:30:59';
    v_end_time := '17:30:00';
    v_atten_mid_time := '13:30:00';

    select min(signtime) into v_atten_start_time from  hrmschedulesign where userid = v_emp_id
           and signdate = v_atten_day and signtime < v_atten_mid_time;
    select max(signtime) into v_atten_end_time from hrmschedulesign where userid = v_emp_id
           and signdate = v_atten_day and signtime >= v_atten_mid_time;

     v_min_time := v_atten_start_time;
     v_max_time := v_atten_end_time ;

     -- v_number := 0;
    -- holiday  tiaoxiu
    declare
       cursor v_cur_p1_ks is
       select requestid,qjlx1,qjkssrq,qjkssj,qjjssrq,qjjssj,bcqjts1
       from formtable_main_256
       where requestid in (select requestid from workflow_requestbase where   currentnodetype = 3)
       and qjkssrq <= v_atten_day and qjjssrq >= v_atten_day and sqr = v_emp_id
       and requestid not in (select xztxjlc  from formtable_main_276 
       where requestid in(select requestid from workflow_requestbase where currentnodetype = 3) and sqr = v_emp_id);

       v_p1_reqid formtable_main_256.requestid%type;
       v_p1_type formtable_main_256.qjlx1%type;
       v_p1_start_date formtable_main_256.qjkssrq%type;
       v_p1_start_time formtable_main_256.qjkssj%type;
       v_p1_end_date formtable_main_256.qjjssrq%type;
       v_p1_end_time formtable_main_256.qjjssj%type;
       v_p1_hours formtable_main_256.bcqjts1%type;

     begin
       open v_cur_p1_ks;

       if v_cur_p1_ks%ISOPEN THEN

         loop
           fetch v_cur_p1_ks into v_p1_reqid,v_p1_type,v_p1_start_date,v_p1_start_time,v_p1_end_date,v_p1_end_time,v_p1_hours;
        --     v_number := v_number + 1;
        --     DBMS_OUTPUT.PUT_LINE('1 hao ' || v_number );
               exit when v_cur_p1_ks%notfound;
            -- if startdate and enddate is same

            if v_p1_start_date =  v_p1_end_date then
                begin
                  if v_min_time is null or v_min_time > v_p1_start_time then
                      v_min_time := v_p1_start_time;
                  end if;
                  if v_max_time is null or v_max_time < v_p1_end_time then
                      v_max_time := v_p1_end_time;
                   end if;

                   v_temp_start_time :=  v_p1_start_time;
                   v_temp_end_time := v_p1_end_time;
                end;
            elsif   v_p1_start_date = v_atten_day then
               begin
                  if v_min_time is null or v_min_time > v_p1_start_time then
                      v_min_time := v_p1_start_time;
                  end if;
                  v_max_time := v_end_time;

                  v_temp_start_time :=  v_p1_start_time;
                  v_temp_end_time := v_end_time;
               end;
            elsif   v_p1_end_date = v_atten_day then
               begin
                  v_min_time := v_start_time;
                  if v_max_time is null or v_max_time < v_p1_end_time then
                      v_max_time := v_p1_end_time;
                  end if;

                  v_temp_start_time :=  v_start_time;
                  v_temp_end_time := v_p1_end_time;
               end;
            else
               begin
                  v_min_time := v_start_time;
                  v_max_time := v_end_time;

                  v_temp_start_time :=  v_start_time;
                  v_temp_end_time := v_end_time;
               end;
            end if;

            select getWorkTimeHour(v_temp_start_time,v_temp_end_time,0) into v_temp_val from dual;

            if length(v_temp_start_time) = 5 then
                select v_temp_start_time||':00' into v_temp_start_time from dual;
             end if;
             if length(v_temp_end_time) = 5 then
                  select v_temp_end_time||':00' into v_temp_end_time from dual;
             end if;

            insert into uf_all_atten_info_dt1(mainid,rqid,start_time,end_time,type,hours,dttype)
                   values(v_atten_id,v_p1_reqid,v_temp_start_time,v_temp_end_time,0,v_temp_val,v_p1_type);


         end loop;
       end if;
       close v_cur_p1_ks;
      end;

    -- holiday  nianjia
  --  select requestid,sqr,qjlx1,qjkssrq,qjkssj,qjjssrq,qjjssj,bcqjxs
  --     from formtable_main_251
  --     where requestid in (select requestid from workflow_requestbase where workflowid = 4201 and currentnodetype = 3)
   --    and qjkssrq <= v_atten_day and qjjssrq >= v_atten_day;
   declare
       cursor v_cur_p2_ks is
       select requestid,qjlx1 ,qjkssrq,qjkssj,qjjssrq,qjjssj,bcqjxs
            from  formtable_main_251
             where requestid in (select requestid from workflow_requestbase where  currentnodetype = 3)
          and qjkssrq <= v_atten_day and qjjssrq >= v_atten_day and sqr = v_emp_id
          and requestid not in (select xtnjlc from formtable_main_276 
       where requestid in(select requestid from workflow_requestbase where currentnodetype = 3) and sqr = v_emp_id);

       v_p2_reqid formtable_main_251.requestid%type;
       v_p2_type formtable_main_251.qjlx1%type;
       v_p2_start_date formtable_main_251.qjkssrq%type;
       v_p2_start_time formtable_main_251.qjkssj%type;
       v_p2_end_date formtable_main_251.qjjssrq%type;
       v_p2_end_time formtable_main_251.qjjssj%type;
       v_p2_hours formtable_main_251.bcqjxs%type;

     begin
       open v_cur_p2_ks;
       if v_cur_p2_ks%ISOPEN THEN

         loop
           fetch v_cur_p2_ks into v_p2_reqid,v_p2_type,v_p2_start_date,v_p2_start_time,v_p2_end_date,v_p2_end_time,v_p2_hours;
             exit when v_cur_p2_ks%notfound;
         --    v_number := v_number + 1;
         --    DBMS_OUTPUT.PUT_LINE('2 hao ' || v_number );
         --    insert into uf_all_atten_info_dt1(rqid,start_time,end_time,type) value(v_atten_id,

            -- if startdate and enddate is same
            if v_p2_start_date =  v_p2_end_date then
                begin
                  if v_min_time is null or v_min_time > v_p2_start_time then
                      v_min_time := v_p2_start_time;
                  end if;
                  if v_max_time is null or v_max_time < v_p2_end_time then
                      v_max_time := v_p2_end_time;
                   end if;

                   v_temp_start_time :=  v_p2_start_time;
                   v_temp_end_time := v_p2_end_time;

                end;
            elsif   v_p2_start_date = v_atten_day then
               begin
                  if v_min_time is null or v_min_time > v_p2_start_time then
                      v_min_time := v_p2_start_time;
                  end if;
                  v_max_time := v_end_time;

                  v_temp_start_time :=  v_p2_start_time;
                  v_temp_end_time := v_end_time;

               end;
            elsif   v_p2_end_date = v_atten_day then
               begin
                  v_min_time := v_start_time;
                  if v_max_time is null or v_max_time < v_p2_end_time then
                      v_max_time := v_p2_end_time;
                  end if;

                  v_temp_start_time :=  v_start_time;
                  v_temp_end_time := v_p2_end_time;

               end;
            else
               begin
                  v_min_time := v_start_time;
                  v_max_time := v_end_time;

                  v_temp_start_time :=  v_start_time;
                  v_temp_end_time := v_end_time;
               end;
            end if;

            select getWorkTimeHour(v_temp_start_time,v_temp_end_time,1) into v_temp_val from dual;

            if length(v_temp_start_time) = 5 then
                select v_temp_start_time||':00' into v_temp_start_time from dual;
             end if;
             if length(v_temp_end_time) = 5 then
                  select v_temp_end_time||':00' into v_temp_end_time from dual;
             end if;

            insert into uf_all_atten_info_dt1(mainid,rqid,start_time,end_time,type,hours,dttype)
                   values(v_atten_id,v_p2_reqid,v_temp_start_time,v_temp_end_time,1,v_temp_val,v_p2_type);

         end loop;
        end if;
       close v_cur_p2_ks;
      end;

    -- chucha
 --   select sqr,ccksrq,cckssj,ccjsrq,ccjssj,bcsjccts
  --     from  formtable_main_250
   --    where requestid in (select requestid from workflow_requestbase where workflowid = 4103 and currentnodetype = 3)
    --   and ccksrq <= v_atten_day and ccjsrq >= v_atten_day;
   declare
       cursor v_cur_p3_ks is
       select requestid,ccksrq,cckssj,ccjsrq,ccjssj,bcsjccts
            from  formtable_main_250
             where requestid in (select requestid from workflow_requestbase where   currentnodetype = 3)
          and ccksrq <= v_atten_day and ccjsrq >= v_atten_day and sqr = v_emp_id;

       v_p3_reqid formtable_main_250.requestid%type;
       v_p3_start_date formtable_main_250.ccksrq%type;
       v_p3_start_time formtable_main_250.cckssj%type;
       v_p3_end_date formtable_main_250.ccjsrq%type;
       v_p3_end_time formtable_main_250.ccjssj%type;
       v_p3_hours formtable_main_250.bcsjccts%type;

     begin
       open v_cur_p3_ks;
       if v_cur_p3_ks%ISOPEN THEN

         loop
           fetch v_cur_p3_ks into v_p3_reqid,v_p3_start_date,v_p3_start_time,v_p3_end_date,v_p3_end_time,v_p3_hours;
             exit when v_cur_p3_ks%notfound;
         --    v_number := v_number + 1;
         --    DBMS_OUTPUT.PUT_LINE('3 hao ' || v_number );
         --    insert into uf_all_atten_info_dt1(rqid,start_time,end_time,type) value(v_atten_id,

            -- if startdate and enddate is same
            if v_p3_start_date =  v_p3_end_date then
                begin
                  if v_min_time is null or v_min_time > v_p3_start_time then
                      v_min_time := v_p3_start_time;
                  end if;
                  if v_max_time is null or v_max_time < v_p3_end_time then
                      v_max_time := v_p3_end_time;
                   end if;

                  v_temp_start_time :=  v_p3_start_time;
                  v_temp_end_time := v_p3_end_time;

                end;
            elsif   v_p3_start_date = v_atten_day then
               begin
                  if v_min_time is null or v_min_time > v_p3_start_time then
                      v_min_time := v_p3_start_time;
                  end if;
                  v_max_time := v_end_time;

                  v_temp_start_time :=  v_p3_start_time;
                  v_temp_end_time := v_end_time;
               end;
            elsif   v_p3_end_date = v_atten_day then
               begin
                  v_min_time := v_start_time;
                  if v_max_time is null or v_max_time < v_p3_end_time then
                      v_max_time := v_p3_end_time;
                  end if;

                  v_temp_start_time :=  v_start_time;
                  v_temp_end_time := v_p3_end_time;
               end;
            else
               begin
                  v_min_time := v_start_time;
                  v_max_time := v_end_time;

                  v_temp_start_time :=  v_start_time;
                  v_temp_end_time := v_end_time;
               end;
            end if;

            select getWorkTimeHour(v_temp_start_time,v_temp_end_time,2) into v_temp_val from dual;

            if length(v_temp_start_time) = 5 then
                select v_temp_start_time||':00' into v_temp_start_time from dual;
             end if;
             if length(v_temp_end_time) = 5 then
                  select v_temp_end_time||':00' into v_temp_end_time from dual;
             end if;

            insert into uf_all_atten_info_dt1(mainid,rqid,start_time,end_time,type,hours)
                   values(v_atten_id,v_p3_reqid,v_temp_start_time,v_temp_end_time,2,v_temp_val);

         end loop;
       end if;
       close v_cur_p3_ks;
      end;

    -- waichu
 --   select sqr,wcqrq,wcqssj,wcjsrq,wcjssj,wcxs
  --     from formtable_main_249
  --     where requestid in (select requestid from workflow_requestbase where workflowid = 4102 and currentnodetype = 3)
  --     and wcqrq <= v_atten_day and wcjsrq >= v_atten_day;

     declare
       cursor v_cur_p4_ks is
       select requestid,wcqrq,wcqssj,wcjsrq,wcjssj,wcxs
            from  formtable_main_249
            where requestid in (select requestid from workflow_requestbase where   currentnodetype = 3)
          and wcqrq <= v_atten_day and wcjsrq >= v_atten_day and sqr = v_emp_id;

       v_p4_reqid formtable_main_249.requestid%type;
       v_p4_start_date formtable_main_249.wcqrq%type;
       v_p4_start_time formtable_main_249.wcqssj%type;
       v_p4_end_date formtable_main_249.wcjsrq%type;
       v_p4_end_time formtable_main_249.wcjssj%type;
       v_p4_hours formtable_main_249.wcxs%type;

     begin
       open v_cur_p4_ks;
       if v_cur_p4_ks%ISOPEN THEN

         loop
           fetch v_cur_p4_ks into v_p4_reqid,v_p4_start_date,v_p4_start_time,v_p4_end_date,v_p4_end_time,v_p4_hours;
             exit when v_cur_p4_ks%notfound;
         --    v_number := v_number + 1;
         --    DBMS_OUTPUT.PUT_LINE('4 hao ' || v_number );
         --    insert into uf_all_atten_info_dt1(rqid,start_time,end_time,type) value(v_atten_id,

            -- if startdate and enddate is same
            if v_p4_start_date =  v_p4_end_date then
                begin
                  if v_min_time is null or v_min_time > v_p4_start_time then
                      v_min_time := v_p4_start_time;
                  end if;
                  if v_max_time is null or v_max_time < v_p4_end_time then
                      v_max_time := v_p4_end_time;
                   end if;

                   v_temp_start_time :=  v_p4_start_time;
                   v_temp_end_time := v_p4_end_time;

                end;
            elsif   v_p4_start_date = v_atten_day then
               begin
                  if v_min_time is null or v_min_time > v_p4_start_time then
                      v_min_time := v_p4_start_time;
                  end if;
                  v_max_time := v_end_time;

                  v_temp_start_time :=  v_p4_start_time;
                  v_temp_end_time := v_end_time;

               end;
            elsif   v_p4_end_date = v_atten_day then
               begin
                  v_min_time := v_start_time;
                  if v_max_time is null or v_max_time < v_p4_end_time then
                      v_max_time := v_p4_end_time;
                  end if;

                  v_temp_start_time :=  v_start_time;
                  v_temp_end_time := v_p4_end_time;

               end;
            else
               begin
                  v_min_time := v_start_time;
                  v_max_time := v_end_time;

                  v_temp_start_time :=  v_start_time;
                  v_temp_end_time := v_end_time;
               end;
            end if;

            select getWorkTimeHour(v_temp_start_time,v_temp_end_time,3) into v_temp_val from dual;

             if length(v_temp_start_time) = 5 then
                select v_temp_start_time||':00' into v_temp_start_time from dual;
             end if;
             if length(v_temp_end_time) = 5 then
                  select v_temp_end_time||':00' into v_temp_end_time from dual;
             end if;

            insert into uf_all_atten_info_dt1(mainid,rqid,start_time,end_time,type,hours)
                   values(v_atten_id,v_p4_reqid,v_temp_start_time,v_temp_end_time,3,v_temp_val);

           exit when v_cur_p4_ks%notfound;
         end loop;
        end if ;
       close v_cur_p4_ks;
      end;

  select count(1) into v_count_cc from forget_card_view where atten_day = v_atten_day and emp_id = v_emp_id;
  if v_count_cc >0 then
    begin

          select requestid into v_fg_reqid from forget_card_view where atten_day = v_atten_day and emp_id = v_emp_id;

          select typex into v_fg_card from forget_card_view where atten_day = v_atten_day and emp_id = v_emp_id;

          if v_fg_card = 0 then
            begin
                if v_min_time is null or v_min_time > v_start_time then
                   v_min_time := v_start_time;
                end if;
            end;
          end if;

          if v_fg_card = 1 then
            begin
                if v_max_time is null or v_max_time < v_end_time then
                   v_max_time := v_end_time;
                end if;
            end ;
           end if;
     end;
   end if;

  if length(v_min_time) = 5 then
    select v_min_time||':00' into v_min_time from dual;
  end if;
  if length(v_max_time) = 5 then
    select v_max_time||':00' into v_max_time from dual;
  end if;

  select diffTimeForAll(v_start_time,v_min_time,240) into v_val1 from dual;
  select diffTimeForAll(v_max_time,v_end_time,240) into v_val2 from dual;

  v_re_va1_1 := 0;
  v_re_val_2 := 0;
  
  declare
    cursor v_cur_p5_ks is
       
         select sxb from lactation_end_view    
          where qjqssj <= v_atten_day and qjjssj >= v_atten_day and sqr = v_emp_id;

       v_p5_type lactation_end_view.sxb%type;

     begin
       open v_cur_p5_ks;
       if v_cur_p5_ks%ISOPEN THEN

         loop
           fetch v_cur_p5_ks into v_p5_type;
             exit when v_cur_p5_ks%notfound;
                 if v_p5_type = 0 then
                   v_re_va1_1 := 60;
                 end if;
                 if v_p5_type = 1 then
                   v_re_val_2 := 60;
                 end if;
           exit when v_cur_p5_ks%notfound;
         end loop;
        end if ;
       close v_cur_p5_ks;
      end;

  -- look before day is work day and leave over 21:00
  v_be_card := 0;
  select max(signtime) into v_before_day_time from hrmschedulesign where userid = v_emp_id
           and signdate = ks_next_n_day(v_atten_day,-1) and ks_what_holiday(signdate) = 2;
  if v_before_day_time >= '21:00.00' then
     begin
         v_be_card := 1;
         if v_val1 <=60 then
           v_val1 := 0;
         else
           v_val1 := v_val1 - 60;
           end if;
     end;
  end if;

  v_is_exception := 0;

  select v_val1 - v_re_va1_1 into v_val1 from dual;
  select v_val2 - v_re_val_2 into v_val2 from dual;

  if v_val1 < 0 then
     v_val1 := 0;
  end if;

  if v_val2 < 0 then
     v_val2 := 0;
  end if;

  if v_val1 > 0 then
    begin
      v_is_exception := 1;
    end;
  end if;

  if v_val2 > 0 then
    begin
      v_is_exception := 1;
    end;
  end if;


  v_isEs := 0;

  if v_min_time is null or v_max_time is null then
     v_isEs := 1;
     v_is_exception := 1;
  end if;

   if v_min_time is null and v_max_time is null then
     v_isEs := 2;
     v_is_exception := 1;
  end if;

  if length(v_start_time) > 5 then
     v_start_time := SUBSTR(v_start_time,0,5);
  end if;

  if length(v_end_time) > 5 then
     v_end_time := SUBSTR(v_end_time,0,5);
  end if;
  if v_val1 = 240 then
     v_isEs := 1;
     v_val1 := 0;
     v_is_exception := 1;
  end if;
  
   if v_val2 = 240 then
     v_isEs := 1;
     v_val2 := 0;
     v_is_exception := 1;
  end if;

   update uf_all_atten_info set am_begin_time = v_start_time,pm_end_time = v_end_time,
          atten_start_time = v_atten_start_time,atten_end_time = v_atten_end_time,late_times = v_val1,early_leave_times = v_val2,
          min_time = v_min_time,max_time = v_max_time ,isEx = v_isEs,fg_requestid = v_fg_reqid,is_be_card = v_be_card,is_exception = v_is_exception
    where id = v_atten_id;

    commit;

  end;
