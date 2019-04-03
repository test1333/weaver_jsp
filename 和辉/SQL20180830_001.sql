alter table workflow_flownode add isprintpage varchar(100)
GO

alter table workflow_flownode add printnum varchar(100)
GO

delete from HtmlLabelIndex where id=384351 
GO
delete from HtmlLabelInfo where indexid=384351 
GO
INSERT INTO HtmlLabelIndex values(384351,'明细每页打印条数') 
GO
INSERT INTO HtmlLabelInfo VALUES(384351,'明细每页打印条数',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(384351,'Number of printing strips per page',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(384351,'明細每頁打印條數',9) 
GO