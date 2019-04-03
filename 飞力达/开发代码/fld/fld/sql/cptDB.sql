create or replace function fl_cptType(v_type int) return int as
  v_typeid int;
begin
  select decode(v_type, 0, 61, 1, 62, 2, 63, 0) into v_typeid from dual;
  return v_typeid;
end;
create or replace function fl_cptProperty(v_property int) return int as
  v_typeid int;
begin
  select substr(supassortmentstr,3,instr(supassortmentstr,'|',2,2)-3) into v_typeid from cptcapitalassortment where id=v_property;
  return v_typeid;
end;
--资产资料申请（1为资产资料）
select * from cptcapital where isdata=1 and capitalgroupid =fl_cptCapital(0,0) and blongsubcompany=
create or replace view fl_cptCaptical_view as
select a.id,a.name,a.blongsubcompany,a.capitalgroupid,d.assortmentname||'>'||b.assortmentname as assortname,fl_cptProperty(capitalgroupid) as supgroupid,c.subcompanyname  from cptcapital a
left join cptcapitalassortment b on a.capitalgroupid=b.id
left join hrmsubcompany c on a.blongsubcompany=c.id
left join cptcapitalassortment d on fl_cptProperty(a.capitalgroupid)=d.id
where isdata=1
--资产领用（2为资产）
create or replace view fl_cptCaptical_receive_view as
select a.id,a.name,a.blongsubcompany,a.capitalgroupid,d.assortmentname||'>'||b.assortmentname as assortname,fl_cptProperty(capitalgroupid) as supgroupid,c.subcompanyname  from cptcapital a
left join cptcapitalassortment b on a.capitalgroupid=b.id
left join hrmsubcompany c on a.blongsubcompany=c.id
left join cptcapitalassortment d on fl_cptProperty(a.capitalgroupid)=d.id
where isdata=2
--资产管理员权限function
create or replace function fl_cptType_auth(v_resourceid int) return varchar2 as
  v_count int;v_cptGroup varchar2(2000);
begin
  -- v_cptGroup := '(';
  select count(id) into v_count from HrmRoleMembers where roleid=507 and resourceid=v_resourceid;
  if v_count > 0 then
     v_cptGroup := v_cptGroup||'61,';
  end if;
  select count(id) into v_count from HrmRoleMembers where roleid=508 and resourceid=v_resourceid;
  if v_count > 0 then
     v_cptGroup := v_cptGroup||'62,';
  end if;
  select count(id) into v_count from HrmRoleMembers where roleid=509 and resourceid=v_resourceid;
  if v_count > 0 then
     v_cptGroup := v_cptGroup||'63,';
  end if;
  v_cptGroup := v_cptGroup||'0';
  return v_cptGroup;
end;
--定义行对象(oracle 表函数)
create type fl_row_type as object
(
  empid int,
  cptType int
)
; --定义行对象
create type fl_table_type as table of fl_row_type; --定义表对象
create or replace function fl_cptAdmin_fun(v_empid in int)
  return fl_table_type
  pipelined is
  fl_v fl_row_type; --定义为行对象类型
begin
  for thisrow in (select m.cpttype,dt.empid from uf_cptUseAdmin m left join uf_cptUseAdmin_dt1 dt on m.id=dt.mainid where dt.empid=v_empid ) loop
    fl_v := fl_row_type(thisrow.empid,thisrow.cpttype);
    pipe row(fl_v);
  end loop;
  return;
end;

select * from table(fl_cptAdmin_fun(3323));


select id,name,blongsubcompany,capitalgroupid,assortname,supgroupid,subcompanyname from fl_cptCaptical_receive_view where blongsubcompany=964 and supgroupid in(select cpttype from table(fl_cptAdmin_fun(3323))
)
