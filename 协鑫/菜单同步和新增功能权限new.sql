------菜单同步
insert into htmllabelindex (id,indexdesc) values (3924007,'公文中心');
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3924007,'公文中心',7);
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3924007,'公文中心',9);
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3924007,'Official document center',8);

insert into htmllabelindex (id,indexdesc) values (3924008,'公文门户');
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3924008,'公文门户',7);
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3924008,'公文門戶',9);
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3924008,'Official document portal',8);

insert into htmllabelindex (id,indexdesc) values (3924009,'公文传阅');
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3924009,'公文传阅',7);
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3924009,'公文傳閱',9);
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3924009,'Document circulation',8);

insert into htmllabelindex (id,indexdesc) values (3924010,'公文传阅办理');
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3924010,'公文传阅办理',7);
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3924010,'公文傳閱辦理',9);
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3924010,'Document circulation',8);

insert into htmllabelindex (id,indexdesc) values (3924011,'系统设置');
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3924011,'系统设置',7);
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3924011,'系統設置',9);
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3924011,'System settings',8);

insert into htmllabelindex (id,indexdesc) values (3924012,'公文归档异常处理');
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3924012,'公文归档异常处理',7);
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3924012,'公文歸檔異常處理',9);
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3924012,'Document archive exception handling',8);


insert into htmllabelindex (id,indexdesc) values (3924013,'常用组设置');
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3924013,'常用组设置',7);
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3924013,'常用組設置',9);
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3924013,'Common group settings',8);

insert into htmllabelindex (id,indexdesc) values (3924014,'报表查询');
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3924014,'报表查询',7);
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3924014,'報表查詢',9);
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3924014,'Report Query',8);

insert into htmllabelindex (id,indexdesc) values (3924015,'公文登记表');
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3924015,'公文登记表',7);
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3924015,'公文登記表',9);
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3924015,'Official registration form',8);

insert into htmllabelindex (id,indexdesc) values (3924016,'传阅效率报表');
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3924016,'传阅效率报表',7);
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3924016,'傳閱效率報表',9);
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3924016,'Circulation efficiency report',8);

insert into htmllabelindex (id,indexdesc) values (3924017,'公文搜索');
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3924017,'公文搜索',7);
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3924017,'公文搜索',9);
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3924017,'Official search',8);


--张瑞坤写的页面菜单
insert into htmllabelindex (id,indexdesc) values (3924018,'自动组查询');
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3924018,'自动组查询',7);
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3924018,'自動組查詢',9);
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3924018,'Automatic group query',8);


update Htmllabelinfo set indexid =3924017 where indexid=3924016  and labelname='公文搜索'
update Htmllabelinfo set indexid =3924017 where indexid=3924016  and labelname='Official search'
--一级菜单
insert into LeftMenuInfo
(ID,LabelID,linkaddress,menulevel,parentID,DefAultindex,relatedmoduleID,isCustom,refersubid)
Values(3619005,3924007,'',1,0,34,13,'0',-1);
/
---注释掉的四行因为菜单地址未提供，所以暂不执行
--Call LMConfig_U_ByInfoInsert (2,3619005,1)
--Call LMInfo_Insert (3619006,3924008,'/images_face/ecologyFace_2/LeftMenuIcon/level3.gif','/homepage/Homepage.jsp?hpid=5205',2,3619005,1,13)

--Call LMConfig_U_ByInfoInsert (2,3619005,2)
--Call LMInfo_Insert (3619007,3924017,'/images_face/ecologyFace_2/LeftMenuIcon/level3.gif','/workflow/search/WFCustomSearchBySimple.jsp?workflowid=690125'|| chr(38) ||'issimple=true',2,3619005,2,13)
----------
Call LMConfig_U_ByInfoInsert (2,3619005,3);
--                                              菜单层级   父菜单id   排序
Call LMInfo_Insert (3619008,3924009,'/images/xp/folder.png','',2,3619005,3,13);
--                               菜单id      标签id                                                                    一级菜单的13  
Call LMConfig_U_ByInfoInsert (3,3619008,1);
Call LMInfo_Insert (3619009,3924010,'/images_face/ecologyFace_2/LeftMenuIcon/level3.gif','/gcl/doc/doc-cy-list-Url.jsp',3,3619008,1,13);

Call LMConfig_U_ByInfoInsert (2,3619005,4);
Call LMInfo_Insert (3619010,3924011,'/images/xp/folder.png','',2,3619005,4,13);

Call LMConfig_U_ByInfoInsert (3,3619010,1);
Call LMInfo_Insert (3619011,3924012,'/images_face/ecologyFace_2/LeftMenuIcon/level3.gif','/gcl/post/doc-cy-exception-Url.jsp',3,3619010,1,13);

Call LMConfig_U_ByInfoInsert (3,3619010,2);
Call LMInfo_Insert (3619012,3924013,'/images_face/ecologyFace_2/LeftMenuIcon/level3.gif','/hrm/group/HrmGroup.jsp',3,3619010,2,13);

--张瑞坤的菜单
Call LMConfig_U_ByInfoInsert (3,3619010,3);
Call LMInfo_Insert (3619016,3924018,'/images_face/ecologyFace_2/LeftMenuIcon/level3.gif','/gcl/hrzdz/hrzdz_Url.jsp',3,3619010,3,13);

Call LMConfig_U_ByInfoInsert (2,3619005,5);
Call LMInfo_Insert (3619013,3924014,'/images/xp/folder.png','',2,3619005,5,13);

Call LMConfig_U_ByInfoInsert (3,3619013,1);
Call LMInfo_Insert (3619014,3924015,'/images_face/ecologyFace_2/LeftMenuIcon/level3.gif','/gcl/post/doc-cy-post-Url.jsp',3,3619013,1,13);

Call LMConfig_U_ByInfoInsert (3,3619013,2);
Call LMInfo_Insert (3619015,3924016,'/images_face/ecologyFace_2/LeftMenuIcon/level3.gif','/gcl/doc/doc-cy-efficiency-list.jsp',3,3619013,2,13);



--1.	公文门户：所有人
--2.	公文传阅：
--a)	公文传阅办理：机要秘书角色组
--3.	系统设置：
--a)	公文归档异常处理 ：分权管理员角色组；其中sysadmin可以看到所有异常、每个分权管理员可以看到所在分部及下级分部的异常
--b)	常用组设置 ：机要秘书角色组
--4.	报表查询 ：
--a)	公文登记表：机要秘书角色组
--b)	传阅效率报表：机要秘书角色组

--------增加功能权限
insert into SystemRights (id,rightdesc,righttype) values (2019040201,'公文传阅办理','7');
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (2019040201,7,'公文传阅办理','公文传阅办理');
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (2019040201,9,'公文傳閱辦理','公文傳閱辦理');
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (2019040201,8,'OfficialDoc:Oper','OfficialDoc:Oper');
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (2019040201,'公文传阅办理','OfficialDoc:Oper',2019040201); 


insert into SystemRights (id,rightdesc,righttype) values (2019040202,'公文归档异常处理','7');
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (2019040202,7,'公文归档异常处理','公文归档异常处理');
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (2019040202,9,'公文歸檔異常處理','公文歸檔異常處理');
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (2019040202,8,'DocException:Handling','DocException:Handling');
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (2019040202,'公文归档异常处理','DocException:Handling',2019040202); 


insert into SystemRights (id,rightdesc,righttype) values (2019040203,'常用组设置','7');
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (2019040203,7,'常用组设置','常用组设置');
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (2019040203,9,'常用組設置','常用組設置');
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (2019040203,8,'CommonGroup:Settings','CommonGroup:Settings');
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (2019040203,'常用组设置','CommonGroup:Settings',2019040203); 


insert into SystemRights (id,rightdesc,righttype) values (2019040204,'公文登记表','7');
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (2019040204,7,'公文登记表','公文登记表');
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (2019040204,9,'公文登記表','公文登記表');
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (2019040204,8,'OfficialRegistration:Form','OfficialRegistration:Form');
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (2019040204,'公文登记表','OfficialRegistration:Form',2019040204); 


insert into SystemRights (id,rightdesc,righttype) values (2019040205,'传阅效率报表','7');
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (2019040205,7,'传阅效率报表','传阅效率报表');
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (2019040205,9,'傳閱效率報表','傳閱效率報表');
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (2019040205,8,'CirculationEfficiency:Report','CirculationEfficiency:Report');
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (2019040205,'传阅效率报表','CirculationEfficiency:Report',2019040205); 

--张瑞坤
insert into SystemRights (id,rightdesc,righttype) values (2019040206,'自动组查询','7');
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (2019040206,7,'自动组查询','自动组查询');
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (2019040206,9,'自動組查詢','自動組查詢');
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (2019040206,8,'AutomaticGroup:Query','AutomaticGroup:Query');
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (2019040206,'自动组查询','AutomaticGroup:Query',2019040206); 

---------doc_table_map

insert into doc_table_map (id,WORKFLOWID,BILLTABLENAME,type) values (1,'1416129','formtable_main_3805','CY');

insert into doc_table_map (id,WORKFLOWID,BILLTABLENAME,type) values (2,'','formtable_main_3796','MJ');

insert into doc_table_map (id,WORKFLOWID,BILLTABLENAME,type) values (3,'','formtable_main_3797','JJCD');