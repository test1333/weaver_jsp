------------Ȩ��
/*insert into SystemRights (id,rightdesc,righttype) values (2019080701,'��˾��Ϣ��ѯ','7');
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (2019080701,7,'��˾��Ϣ��ѯ','��˾��Ϣ��ѯ');
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (2019080701,9,'��˾��Ϣ��ԃ','��˾��Ϣ��ԃ');
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (2019080701,8,'CompanyInfo:Query','CompanyInfo:Query');
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (2019080701,'��˾��Ϣ��ѯ','CompanyInfo:Query',2019080701); */
-----------html��ǩ
/*insert into htmllabelindex (id,indexdesc) values (3954003,'��˾����');
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3954003,'��˾����',7);
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3954003,'��˾����',9);
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3954003,'Company Management',8);
insert into htmllabelindex (id,indexdesc) values (3954004,'��˾��Ϣ��ѯ');
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3954004,'��˾��Ϣ��ѯ',7);
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3954004,'��˾��Ϣ��ԃ',9);
insert into Htmllabelinfo (indexid,labelname,Languageid) values (3954004,'CompanyInfo Query',8);
*/
-----------�˵�

(ID,LabelID,iconurl,linkaddress,menulevel,parentID,DefAultindex,relatedmoduleID,isCustom,refersubid)
Values(3954002,3954003,'/images_face/ecologyFace_2/LeftMenuIcon/level3.gif','',1,0,34,13,'0',-1);

Call LMConfig_U_ByInfoInsert (2,3954002,1);
Call LMInfo_Insert (3954003,3954004,'/images_face/ecologyFace_2/LeftMenuIcon/level3.gif','/gcl/company/company-info-list.jsp',2,3954002,1,13);

