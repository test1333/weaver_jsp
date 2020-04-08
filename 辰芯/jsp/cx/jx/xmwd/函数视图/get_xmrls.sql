alter function [dbo].[get_xmrls](@year varchar(20),@zq varchar(20),@xmid varchar(20),@dj varchar(20)) 	
returns decimal(10,3)
as
begin
	declare @zf decimal(10,3)
	if @dj = '' 
		begin
			 select @zf=isnull(sum(isnull(ygkhqz,0)),0) from formtable_main_295 a,workflow_requestbase b where a.requestId=b.requestid and b.currentnodetype=3  and a.khzqnf=@year and a.khzq=@zq  and a.xmmc=@xmid
		end
	else
		begin
			 select @zf=isnull(sum(isnull(ygkhqz,0)),0) from formtable_main_295 a,workflow_requestbase b where a.requestId=b.requestid and b.currentnodetype=3  and a.khzqnf=@year and a.khzq=@zq  and a.xmmc=@xmid and a.khpjdj=@dj
		end
   
  return @zf;
end
GO