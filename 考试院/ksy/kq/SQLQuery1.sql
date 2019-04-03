select row_number() over(order by a.xm asc) as num ,a.* from (select distinct b.xm,c.workcode,c.lastname,c.departmentid,   d.departmentname,d.departmentcode from formtable_main_182 a,formtable_main_182_dt1 b,hrmresource c,HrmDepartment d ,workflow_requestbase e where a.id=b.mainid and b.xm=c.id and a.requestId=e.requestid and e.currentnodetype>=3 and c.departmentid=d.id  and a.sbzurq<'2017-05-01' and a.sbzurq>='2017-04-01') a order by num asc
select day(cast('2017-06-01' as datetime) - 1) as count
update formtable_main_182_dt1 set gh='1'
select * from formtable_main_182 a,formtable_main_182_dt1 b,workflow_requestbase c where a.id=b.mainid and a.requestId=c.requestid and c.currentnodetype>=3 and a.sbzurq<'2017-06-01' and a.sbzurq>='2017-05-01' and xm=4
select datepart(weekday, cast('2017-05-31' as datetime))
select convert(varchar(100),cast('2017-05-31' as datetime)-4+2,23)
select convert(varchar(100),cast('2017-05-01' as datetime)-1,23)
select b.* from formtable_main_182 a,formtable_main_182_dt1 b,workflow_requestbase c where a.id=b.mainid   and a.requestId=c.requestid and c.currentnodetype>=3 and a.sbzurq='2017-03-27' and xm=4
select dbo.[kq_hj]('4','8','2017-05-01','2017-06-01')
select datepart(weekday, cast('2017-05-31' as datetime))
