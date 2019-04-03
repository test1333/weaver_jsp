select to_char(to_date('2017-06-01','yyyy-mm-dd')-1,'yyyy-mm-dd') from dual
select to_char(last_day(to_date('2016-02-01','yyyy-mm-dd')),'dd') as count from dual
select name from mode_selectitempage a,mode_selectitempagedetail b where a.id=b.mainid and a.selectitemname='¿¼ÇÚÀà±ð' and disorder=1
