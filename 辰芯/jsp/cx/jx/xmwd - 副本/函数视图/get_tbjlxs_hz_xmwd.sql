alter function [dbo].[get_tbjlxs_hz_xmwd](@year varchar(20),@zq varchar(20),@ryid varchar(20)) 	
returns decimal(10,2)
as
begin
	declare @zf decimal(10,2)
    select @zf=isnull(cast(sum(isnull([dbo].[get_jxjlxs](khzqnf,khzq,xmmc,fqr),0)*isnull(a.ygkhqz,0)/100) as numeric(10,2)),0) from formtable_main_295 a,workflow_requestbase b,uf_ygzzsjxs c where a.requestId=b.requestid and isnull(a.khzgdf,0)>0 and e.gh=(select workcode from hrmresource where id=a.fqr) and e.khzqnf = a.khzqnf and e.khzq=a.khzq  and a.khzqnf=@year and a.khzq=@zq and a.fqr=@ryid
  return @zf;
end
GO