alter view [dbo].[v_cw_fpshst_zs] as 
--------------------------------�й�����CW01 ���÷ѱ�����new
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_1' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc,isnull(d.bz,'�����') as bz1 
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Jtm from uf_cbzx where id=a.cbzx1) as km,'��ͨ��' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00)-isnull(b.kdkje,0.00) as je,isnull(b.se,0.00) as se,isnull(b.kdkje,0.00) as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_154 a,formtable_main_154_dt1 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id 
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_2' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc,isnull(d.bz,'�����') as bz1 
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Zsf from uf_cbzx where id=a.cbzx1) as km,'ס�޷�' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_154 a,formtable_main_154_dt2 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id 
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_3' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc,isnull(d.bz,'�����') as bz1 
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Cf from uf_cbzx where id=a.cbzx1) as km,'�ͷ�' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_154 a,formtable_main_154_dt3 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id 
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_4' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc,isnull(d.bz,'�����') as bz1 
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Clqtfy from uf_cbzx where id=a.cbzx1) as km,'��������' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_154 a,formtable_main_154_dt4 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id 
--------------------------------���й����죩CW01 ���÷ѱ�����
union all
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_1' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc,isnull(d.bz,'�����') as bz1 
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Jtm from uf_cbzx where id=a.cbzx1) as km,'��ͨ��' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00)-isnull(b.kdkje,0.00) as je,isnull(b.se,0.00) as se,isnull(b.kdkje,0.00) as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_39 a,formtable_main_39_dt1 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id 
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_2' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc,isnull(d.bz,'�����') as bz1 
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Zsf from uf_cbzx where id=a.cbzx1) as km,'ס�޷�' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_39 a,formtable_main_39_dt2 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id 
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_3' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc,isnull(d.bz,'�����') as bz1 
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Cf from uf_cbzx where id=a.cbzx1) as km,'�ͷ�' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_39 a,formtable_main_39_dt3 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id 
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_4' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc,isnull(d.bz,'�����') as bz1  
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Clqtfy from uf_cbzx where id=a.cbzx1) as km,'��������' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_39 a,formtable_main_39_dt4 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id 
--------------------------------��Rollplay��RP01 ���÷ѱ�����
union all
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_1' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc,isnull(d.bz,'�����') as bz1 
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Jtm from uf_cbzx where id=a.cbzx1) as km,'��ͨ��' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00)-isnull(b.kdkje,0.00) as je,isnull(b.se,0.00) as se,isnull(b.kdkje,0.00) as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_289 a,formtable_main_289_dt1 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id 
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_2' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc,isnull(d.bz,'�����') as bz1  
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Zsf from uf_cbzx where id=a.cbzx1) as km,'ס�޷�' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_289 a,formtable_main_289_dt2 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id 
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_3' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc,isnull(d.bz,'�����') as bz1 
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Cf from uf_cbzx where id=a.cbzx1) as km,'�ͷ�' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_289 a,formtable_main_289_dt3 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id 
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_4' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc,isnull(d.bz,'�����') as bz1 
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Clqtfy from uf_cbzx where id=a.cbzx1) as km,'��������' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_289 a,formtable_main_289_dt4 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id 
--------------------------------��CW02 ����Ӧ��ѱ�����
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_2' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc,isnull(d.bz,'�����') as bz1 
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Jjf from uf_cbzx where id=a.cbzx1) as km,'�ͷ�' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_250 a,formtable_main_250_dt1 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id 
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_3' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc,isnull(d.bz,'�����') as bz1  
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Jjf from uf_cbzx where id=a.cbzx1) as km,'ס�޷�' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_250 a,formtable_main_250_dt2 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id 
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_4' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc,isnull(d.bz,'�����') as bz1 
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Jjf from uf_cbzx where id=a.cbzx1) as km,'��Ʒ��&��������' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.ajbxje,0.00) as sjbxje,b.bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_250 a,formtable_main_250_dt3 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id 
--------------------------------��Rollplay��RP02 ����Ӧ��ѱ�����
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_2' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc,isnull(d.bz,'�����') as bz1 
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Jjf from uf_cbzx where id=a.cbzx1) as km,'���ʷ�' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_290 a,formtable_main_290_dt1 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id 

--------------------------------���й�����CW03 Ա�����ñ�����
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_2' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,b.cbzx,(select cbzxbmmc from uf_cbzx where id=b.cbzx) as cbzxbmmc,isnull(d.bz,'�����') as bz1 
,(select gszt from uf_cbzx where id=b.cbzx) as gszt,d.invoiceType,(select kmbm1 from uf_fykm where id=b.fybx) as km,b.fylx as ywlx,isnull(b.bxxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.nr as bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_153 a,formtable_main_153_dt1 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphmnew=d.id 
--------------------------------���й����죩CW03 Ա�����ñ�����
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_2' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,b.cbzx,(select cbzxbmmc from uf_cbzx where id=b.cbzx) as cbzxbmmc,isnull(d.bz,'�����') as bz1  
,(select gszt from uf_cbzx where id=b.cbzx) as gszt,d.invoiceType,(select kmbm1 from uf_fykm where id=b.fykm) as km,b.fylx as ywlx,isnull(b.bxxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.nr as bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_41 a,formtable_main_41_dt1 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphmnew=d.id 

--------------------------------��Rollplay��RP03 Ա�����ñ�����
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_2' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,b.cbzx,(select cbzxbmmc from uf_cbzx where id=b.cbzx) as cbzxbmmc,isnull(d.bz,'�����') as bz1 
,(select gszt from uf_cbzx where id=b.cbzx) as gszt,d.invoiceType,(select kmbm1 from uf_fykm where id=b.fybx) as km,b.fylx as ywlx,isnull(b.bxxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.nr as bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_291 a,formtable_main_291_dt1 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphmnew=d.id 
--------------------------------���й�����CW08 �������뵥
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_2' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,(select top 1 cbzx from formtable_main_152_dt2 where mainid=a.id ) as cbzx,(select cbzxbmmc from uf_cbzx where id=(select top 1 cbzx from formtable_main_152_dt2 where mainid=a.id ) ) as cbzxbmmc,isnull(d.bz,'�����') as bz1 
,(select gszt from uf_cbzx where id=(select top 1 cbzx from formtable_main_152_dt2 where mainid=a.id ) ) as gszt,d.invoiceType,(select kmbm1 from uf_fykm where id=b.fykm) as km,b.fylx as ywlx,isnull(b.bxxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.nr as bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_152 a,formtable_main_152_dt1 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphmnew=d.id
--------------------------------���й����죩CW08 �������뵥
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_2' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,(select top 1 cbzx from formtable_main_149_dt2 where mainid=a.id ) as cbzx,(select cbzxbmmc from uf_cbzx where id=(select top 1 cbzx from formtable_main_149_dt2 where mainid=a.id ) ) as cbzxbmmc,isnull(d.bz,'�����') as bz1 
,(select gszt from uf_cbzx where id=(select top 1 cbzx from formtable_main_149_dt2 where mainid=a.id ) ) as gszt,d.invoiceType,(select kmbm1 from uf_fykm where id=b.fykm) as km,b.fylx as ywlx,isnull(b.bxxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.nr as bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_149 a,formtable_main_149_dt1 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphmnew=d.id

--------------------------------��Rollplay��RP04 �������뵥
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_2' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,(select top 1 cbzx from formtable_main_292_dt2 where mainid=a.id ) as cbzx,(select cbzxbmmc from uf_cbzx where id=(select top 1 cbzx from formtable_main_292_dt2 where mainid=a.id ) ) as cbzxbmmc,isnull(d.bz,'�����') as bz1 
,(select gszt from uf_cbzx where id=(select top 1 cbzx from formtable_main_292_dt2 where mainid=a.id ) ) as gszt,d.invoiceType,(select kmbm1 from uf_fykm where id=b.fykm) as km,b.fylx as ywlx,isnull(b.bxxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.nr as bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_292 a,formtable_main_292_dt1 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphmnew=d.id
--------------------------------NPP�������뵥
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_2' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,(select top 1 cbzx from formtable_main_292_dt2 where mainid=a.id ) as cbzx,(select cbzxbmmc from uf_cbzx where id=(select top 1 cbzx from formtable_main_292_dt2 where mainid=a.id ) ) as cbzxbmmc,isnull(d.bz,'�����') as bz1 
,(select gszt from uf_cbzx where id=(select top 1 cbzx from formtable_main_292_dt2 where mainid=a.id ) ) as gszt,d.invoiceType,(select kmbm1 from uf_fykm where id=b.fykm) as km,b.fylx as ywlx,isnull(b.bxxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.nr as bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_292 a,formtable_main_292_dt1 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphmnew=d.id