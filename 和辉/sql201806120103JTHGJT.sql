alter table workflow_flownode add isprintpage varchar(100)
/

alter table workflow_flownode add printnum varchar(100)
/

delete from HtmlLabelIndex where id=384351 
/
delete from HtmlLabelInfo where indexid=384351 
/
INSERT INTO HtmlLabelIndex values(384351,'��ϸÿҳ��ӡ����') 
/
INSERT INTO HtmlLabelInfo VALUES(384351,'��ϸÿҳ��ӡ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(384351,'Number of printing strips per page',8) 
/
INSERT INTO HtmlLabelInfo VALUES(384351,'����ÿ퓴�ӡ�l��',9) 
/
