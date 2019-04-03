select pernr_f,lc_no,oa_md5 from zoat00020 for update
select * from zoa_data_log order by id desc
select * from zoat00020
insert into zoa_data_log(logtype,logtime,index_no,logtext,logtext1,logtext2,logtext3)
values(1,2,2,2,2,2,2)
select * from formtable_main_232 where requestid=8747
select * from formtable_main_209 where requestid=8747
select * from uf_Con_ku_Legal_OU4
select * from zoa_wfcode_mapping where lc_type='SPL_TISSU'
select * from zoa_wftable_map where fid=8
select *  from zoa_wffield_map where tid='9' and isactive=9
update zoa_wffield_map set isactive=0
select * from workflow_bill where tablename='formtable_main_305'
select * from zoa_wffield_map where tid=5 and fieldname='PERNR'
insert into zoa_wffield_map(tid,fieldname,sapfieldname,changetype,isactive) (select  8£¬fieldname,fieldname,0,0 from workflow_billfield where billid=-305 and detailtable ='formtable_main_305_dt1')
insert into zoa_wffield_map(tid,fieldname,sapfieldname,changetype,isactive) (select  9£¬fieldname,fieldname,0,0 from workflow_billfield where billid=-305 and detailtable is null and fieldname <>'MTDSHIP')
select fieldname,fieldname from workflow_billfield where billid=-305 and detailtable is null and fieldname <>'MTDSHIP'
select * from workflow_billfield where billid=-305 
select id as sqr from hrmresource where workcode='##sqr##' and status in(0,1,2,3)
select id as sqr from hrmresource where workcode='22' and status in(0,1,2,3)

select  from workflow_base where id in (1463,1543)
select a.*,b.activeversionid as wfidnew from zoa_wfcode_mapping a,workflow_base b  where a.wfid=b.id and a.lc_type='IPL' and a.isactive=0
