alter table workflow_flownode add isprintpage varchar(100)
GO

alter table workflow_flownode add printnum varchar(100)
GO

delete from HtmlLabelIndex where id=384351 
GO
delete from HtmlLabelInfo where indexid=384351 
GO
INSERT INTO HtmlLabelIndex values(384351,'��ϸÿҳ��ӡ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(384351,'��ϸÿҳ��ӡ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(384351,'Number of printing strips per page',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(384351,'����ÿ퓴�ӡ�l��',9) 
GO