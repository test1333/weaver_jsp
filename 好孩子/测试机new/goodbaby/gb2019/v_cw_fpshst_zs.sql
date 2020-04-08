alter view [dbo].[v_cw_fpshst_zs] as 
--------------------------------中国区）CW01 差旅费报销单new
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_1' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc,isnull(d.bz,'人民币') as bz1 
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Jtm from uf_cbzx where id=a.cbzx1) as km,'交通费' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00)-isnull(b.kdkje,0.00) as je,isnull(b.se,0.00) as se,isnull(b.kdkje,0.00) as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_154 a,formtable_main_154_dt1 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id 
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_2' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc,isnull(d.bz,'人民币') as bz1 
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Zsf from uf_cbzx where id=a.cbzx1) as km,'住宿费' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_154 a,formtable_main_154_dt2 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id 
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_3' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc,isnull(d.bz,'人民币') as bz1 
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Cf from uf_cbzx where id=a.cbzx1) as km,'餐费' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_154 a,formtable_main_154_dt3 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id 
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_4' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc,isnull(d.bz,'人民币') as bz1 
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Clqtfy from uf_cbzx where id=a.cbzx1) as km,'其他费用' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_154 a,formtable_main_154_dt4 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id 
--------------------------------（中国制造）CW01 差旅费报销单
union all
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_1' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc,isnull(d.bz,'人民币') as bz1 
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Jtm from uf_cbzx where id=a.cbzx1) as km,'交通费' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00)-isnull(b.kdkje,0.00) as je,isnull(b.se,0.00) as se,isnull(b.kdkje,0.00) as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_39 a,formtable_main_39_dt1 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id 
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_2' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc,isnull(d.bz,'人民币') as bz1 
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Zsf from uf_cbzx where id=a.cbzx1) as km,'住宿费' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_39 a,formtable_main_39_dt2 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id 
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_3' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc,isnull(d.bz,'人民币') as bz1 
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Cf from uf_cbzx where id=a.cbzx1) as km,'餐费' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_39 a,formtable_main_39_dt3 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id 
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_4' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc,isnull(d.bz,'人民币') as bz1  
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Clqtfy from uf_cbzx where id=a.cbzx1) as km,'其他费用' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_39 a,formtable_main_39_dt4 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id 
--------------------------------（Rollplay）RP01 差旅费报销单
union all
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_1' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc,isnull(d.bz,'人民币') as bz1 
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Jtm from uf_cbzx where id=a.cbzx1) as km,'交通费' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00)-isnull(b.kdkje,0.00) as je,isnull(b.se,0.00) as se,isnull(b.kdkje,0.00) as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_289 a,formtable_main_289_dt1 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id 
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_2' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc,isnull(d.bz,'人民币') as bz1  
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Zsf from uf_cbzx where id=a.cbzx1) as km,'住宿费' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_289 a,formtable_main_289_dt2 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id 
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_3' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc,isnull(d.bz,'人民币') as bz1 
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Cf from uf_cbzx where id=a.cbzx1) as km,'餐费' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_289 a,formtable_main_289_dt3 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id 
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_4' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc,isnull(d.bz,'人民币') as bz1 
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Clqtfy from uf_cbzx where id=a.cbzx1) as km,'其他费用' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_289 a,formtable_main_289_dt4 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id 
--------------------------------（CW02 交际应酬费报销单
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_2' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc,isnull(d.bz,'人民币') as bz1 
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Jjf from uf_cbzx where id=a.cbzx1) as km,'餐费' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_250 a,formtable_main_250_dt1 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id 
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_3' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc,isnull(d.bz,'人民币') as bz1  
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Jjf from uf_cbzx where id=a.cbzx1) as km,'住宿费' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_250 a,formtable_main_250_dt2 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id 
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_4' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc,isnull(d.bz,'人民币') as bz1 
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Jjf from uf_cbzx where id=a.cbzx1) as km,'礼品费&其他费用' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.ajbxje,0.00) as sjbxje,b.bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_250 a,formtable_main_250_dt3 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id 
--------------------------------（Rollplay）RP02 交际应酬费报销单
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_2' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,a.cbzx1,(select cbzxbmmc from uf_cbzx where id=a.cbzx1) as cbzxbmmc,isnull(d.bz,'人民币') as bz1 
,(select gszt from uf_cbzx where id=a.cbzx1) as gszt,d.invoiceType,(select kjkm_Jjf from uf_cbzx where id=a.cbzx1) as km,'交际费' as ywlx,isnull(b.bxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_290 a,formtable_main_290_dt1 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphm=d.id 

--------------------------------（中国区）CW03 员工费用报销单
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_2' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,b.cbzx,(select cbzxbmmc from uf_cbzx where id=b.cbzx) as cbzxbmmc,isnull(d.bz,'人民币') as bz1 
,(select gszt from uf_cbzx where id=b.cbzx) as gszt,d.invoiceType,(select kmbm1 from uf_fykm where id=b.fybx) as km,b.fylx as ywlx,isnull(b.bxxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.nr as bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_153 a,formtable_main_153_dt1 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphmnew=d.id 
--------------------------------（中国制造）CW03 员工费用报销单
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_2' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,b.cbzx,(select cbzxbmmc from uf_cbzx where id=b.cbzx) as cbzxbmmc,isnull(d.bz,'人民币') as bz1  
,(select gszt from uf_cbzx where id=b.cbzx) as gszt,d.invoiceType,(select kmbm1 from uf_fykm where id=b.fykm) as km,b.fylx as ywlx,isnull(b.bxxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.nr as bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_41 a,formtable_main_41_dt1 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphmnew=d.id 

--------------------------------（Rollplay）RP03 员工费用报销单
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_2' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,b.cbzx,(select cbzxbmmc from uf_cbzx where id=b.cbzx) as cbzxbmmc,isnull(d.bz,'人民币') as bz1 
,(select gszt from uf_cbzx where id=b.cbzx) as gszt,d.invoiceType,(select kmbm1 from uf_fykm where id=b.fybx) as km,b.fylx as ywlx,isnull(b.bxxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.nr as bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_291 a,formtable_main_291_dt1 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphmnew=d.id 
--------------------------------（中国区）CW08 付款申请单
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_2' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,(select top 1 cbzx from formtable_main_152_dt2 where mainid=a.id ) as cbzx,(select cbzxbmmc from uf_cbzx where id=(select top 1 cbzx from formtable_main_152_dt2 where mainid=a.id ) ) as cbzxbmmc,isnull(d.bz,'人民币') as bz1 
,(select gszt from uf_cbzx where id=(select top 1 cbzx from formtable_main_152_dt2 where mainid=a.id ) ) as gszt,d.invoiceType,(select kmbm1 from uf_fykm where id=b.fykm) as km,b.fylx as ywlx,isnull(b.bxxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.nr as bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_152 a,formtable_main_152_dt1 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphmnew=d.id
--------------------------------（中国制造）CW08 付款申请单
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_2' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,(select top 1 cbzx from formtable_main_149_dt2 where mainid=a.id ) as cbzx,(select cbzxbmmc from uf_cbzx where id=(select top 1 cbzx from formtable_main_149_dt2 where mainid=a.id ) ) as cbzxbmmc,isnull(d.bz,'人民币') as bz1 
,(select gszt from uf_cbzx where id=(select top 1 cbzx from formtable_main_149_dt2 where mainid=a.id ) ) as gszt,d.invoiceType,(select kmbm1 from uf_fykm where id=b.fykm) as km,b.fylx as ywlx,isnull(b.bxxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.nr as bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_149 a,formtable_main_149_dt1 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphmnew=d.id

--------------------------------（Rollplay）RP04 付款申请单
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_2' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,(select top 1 cbzx from formtable_main_292_dt2 where mainid=a.id ) as cbzx,(select cbzxbmmc from uf_cbzx where id=(select top 1 cbzx from formtable_main_292_dt2 where mainid=a.id ) ) as cbzxbmmc,isnull(d.bz,'人民币') as bz1 
,(select gszt from uf_cbzx where id=(select top 1 cbzx from formtable_main_292_dt2 where mainid=a.id ) ) as gszt,d.invoiceType,(select kmbm1 from uf_fykm where id=b.fykm) as km,b.fylx as ywlx,isnull(b.bxxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.nr as bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_292 a,formtable_main_292_dt1 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphmnew=d.id
--------------------------------NPP付款申请单
union all 
select a.requestid,b.id as dtid ,convert(varchar(100),a.requestid)+'_'+convert(varchar(100),b.id)+'_2' as keyid,c.workflowid,c.createdate,c.requestmark,d.userid_new,a.sqr,sqryx,(select top 1 cbzx from formtable_main_292_dt2 where mainid=a.id ) as cbzx,(select cbzxbmmc from uf_cbzx where id=(select top 1 cbzx from formtable_main_292_dt2 where mainid=a.id ) ) as cbzxbmmc,isnull(d.bz,'人民币') as bz1 
,(select gszt from uf_cbzx where id=(select top 1 cbzx from formtable_main_292_dt2 where mainid=a.id ) ) as gszt,d.invoiceType,(select kmbm1 from uf_fykm where id=b.fykm) as km,b.fylx as ywlx,isnull(b.bxxje,0.00)-isnull(b.se,0.00) as je,isnull(b.se,0.00) as se,0.00 as kdkje,isnull(b.bxxje,0.00) as bxje,isnull(b.sjbxje,0.00) as sjbxje,b.nr as bz,d.invoicenumber,(select nodename from workflow_nodebase where id=c.currentnodeid) as nodename
from formtable_main_292 a,formtable_main_292_dt1 b,workflow_requestbase c,fnainvoiceledger d 
where a.id=b.mainid and a.requestid=c.requestid and b.fphmnew=d.id