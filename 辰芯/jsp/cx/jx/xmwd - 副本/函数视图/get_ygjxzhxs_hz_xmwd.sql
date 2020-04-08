alter function [dbo].[get_ygjxzhxs_hz_xmwd](@year varchar(20),@zq varchar(20),@ryid varchar(20)) 	
returns decimal(10,2)
as
begin
	declare @zf decimal(10,2)
    select @zf=isnull(cast(sum(isnull(c.xs,0)*isnull(d.xmkhxs,0)*isnull(e.zzsjxs,0)*isnull(a.ygkhqz,0)/100) as numeric(10,2)),0) from formtable_main_295 a,workflow_requestbase b,uf_yggrjxkhxs c,uf_xmjxkhjg d,uf_ygzzsjxs e  where a.requestId=b.requestid and isnull(a.khzgdf,0)>0 and  c.khzqnf=a.khzqnf and c.khzq=a.khzq and c.ygkhdj=a.khpjdj and a.xmmc=d.xmmc and e.gh=(select workcode from hrmresource where id=a.fqr) and e.khzqnf = a.khzqnf and e.khzq=a.khzq  and a.khzqnf=@year and a.khzq=@zq and a.fqr=@ryid and d.khzqnf=@year and d.khzq=@zq
  return @zf;
end
GO