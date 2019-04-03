alter table workflow_flownode add isprintpage varchar(100)
/

alter table workflow_flownode add printnum varchar(100)
/

delete from HtmlLabelIndex where id=384351 
/
delete from HtmlLabelInfo where indexid=384351 
/
INSERT INTO HtmlLabelIndex values(384351,'明细每页打印条数') 
/
INSERT INTO HtmlLabelInfo VALUES(384351,'明细每页打印条数',7) 
/
INSERT INTO HtmlLabelInfo VALUES(384351,'Number of printing strips per page',8) 
/
INSERT INTO HtmlLabelInfo VALUES(384351,'明細每頁打印條數',9) 
/
