ALTER view [dbo].[v_cw_fpshst] as 
--------------------------------�й�����CW01 ���÷ѱ�����new
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_1' as keyid,c.workflowid,c.lastoperatedate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Jtm from uf_cbzx where id=a.cbzx1) as km,'��ͨ��' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00)-isnull(b.kdkje,0.00) as je,isnull(b.se,0.00) as se,isnull(b.kdkje,0.00) as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.bz
from formtable_main_326 a,formtable_main_326_dt1 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id and c.currentnodetype=3
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_2' as keyid,c.workflowid,c.lastoperatedate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Zsf from uf_cbzx where id=a.cbzx1) as km,'ס�޷�' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.bz
from formtable_main_326 a,formtable_main_326_dt2 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id and c.currentnodetype=3
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_3' as keyid,c.workflowid,c.lastoperatedate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Cf from uf_cbzx where id=a.cbzx1) as km,'�ͷ�' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.bz
from formtable_main_326 a,formtable_main_326_dt3 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id and c.currentnodetype=3
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_4' as keyid,c.workflowid,c.lastoperatedate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Clqtfy from uf_cbzx where id=a.cbzx1) as km,'��������' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.bz
from formtable_main_326 a,formtable_main_326_dt4 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id and c.currentnodetype=3
----------------------���й����죩CW01 ���÷ѱ�����new
union all
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_1' as keyid,c.workflowid,c.lastoperatedate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Jtm from uf_cbzx where id=a.cbzx1) as km,'��ͨ��' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00)-isnull(b.kdkje,0.00) as je,isnull(b.se,0.00) as se,isnull(b.kdkje,0.00) as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.bz
from formtable_main_333 a,formtable_main_333_dt1 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id and c.currentnodetype=3
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_2' as keyid,c.workflowid,c.lastoperatedate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Zsf from uf_cbzx where id=a.cbzx1) as km,'ס�޷�' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.bz
from formtable_main_333 a,formtable_main_333_dt2 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id and c.currentnodetype=3
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_3' as keyid,c.workflowid,c.lastoperatedate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Cf from uf_cbzx where id=a.cbzx1) as km,'�ͷ�' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.bz
from formtable_main_333 a,formtable_main_333_dt3 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id and c.currentnodetype=3
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_4' as keyid,c.workflowid,c.lastoperatedate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Clqtfy from uf_cbzx where id=a.cbzx1) as km,'��������' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.bz
from formtable_main_333 a,formtable_main_333_dt4 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id and c.currentnodetype=3
----------------------CW02 ����Ӧ��ѱ�����new
union all
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_1' as keyid,c.workflowid,c.lastoperatedate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Jjf from uf_cbzx where id=a.cbzx1) as km,'���ʷ�' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.bz
from formtable_main_331 a,formtable_main_331_dt1 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id and c.currentnodetype=3
