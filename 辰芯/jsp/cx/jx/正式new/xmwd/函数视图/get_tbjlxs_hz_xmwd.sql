alter function [dbo].[get_tbjlxs_hz_xmwd](@year varchar(20),@zq varchar(20),@ryid varchar(20)) 	
returns decimal(10,4)
as
begin
	declare @zf decimal(10,4)
    select @zf=isnull(cast(sum(isnull([dbo].[get_jxjlxs](a.khzqnf,a.khzq,xmmc,fqr),0)*isnull(a.ygkhqz,0)/100) as numeric(10,4)),0) from formtable_main_295 a,workflow_requestbase b,uf_ygzzsjxs c where a.requestId=b.requestid and b.currentnodetype>=3 and c.gh=(select workcode from hrmresource where id=a.fqr) and c.khzqnf = a.khzqnf and c.khzq=a.khzq  and a.khzqnf=@year and a.khzq=@zq and a.fqr=@ryid
  return @zf;
end
GO