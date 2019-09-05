------------权限
/*insert into SystemRights (id,rightdesc,righttype) values (2019080701,'公司信息查询','7');
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (2019080701,7,'公司信息查询','公司信息查询');
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (2019080701,9,'公司信息查詢','公司信息查詢');
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (2019080701,8,'CompanyInfo:Query','CompanyInfo:Query');
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (2019080701,'公司信息查询','CompanyInfo:Query',2019080701); */
-----------html标签
/*insert into htmllabelindex (id,indexdesc) values (3954003,'公司管理');
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3954003,'公司管理',7);
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3954003,'公司管理',9);
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3954003,'Company Management',8);
insert into htmllabelindex (id,indexdesc) values (3954004,'公司信息查询');
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3954004,'公司信息查询',7);
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3954004,'公司信息查詢',9);
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3954004,'CompanyInfo Query',8);
*/
-----------菜单

(ID,LabelID,iconurl,linkaddress,menulevel,parentID,DefAultindex,relatedmoduleID,isCustom,refersubid)
Values(3954002,3954003,'/images_face/ecologyFace_2/LeftMenuIcon/level3.gif','',1,0,34,13,'0',-1);

Call LMConfig_U_ByInfoInsert (2,3954002,1);
Call LMInfo_Insert (3954003,3954004,'/images_face/ecologyFace_2/LeftMenuIcon/level3.gif','/gcl/company/company-info-list.jsp',2,3954002,1,13);

