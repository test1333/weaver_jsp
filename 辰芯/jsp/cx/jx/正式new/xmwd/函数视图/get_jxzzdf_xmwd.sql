create function [dbo].[get_jxzzdf_xmwd](@year varchar(20),@zq varchar(20),@ryid varchar(20)) 	
returns decimal(10,2)
as
begin
	declare @zf decimal(10,2)
    select @zf=isnull(cast(sum(isnull(a.khzgdf,0)*isnull(a.ygkhqz,0)/100) as numeric(10,2)),0) from formtable_main_295 a,workflow_requestbase b where a.requestId=b.requestid and isnull(a.khzgdf,0)>0  and khzqnf=@year and khzq=@zq and fqr=@ryid
  return @zf;
end
GO