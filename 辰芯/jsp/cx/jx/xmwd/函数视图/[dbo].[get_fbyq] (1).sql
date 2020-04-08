alter function [dbo].[get_fbyq](@year varchar(20),@zq varchar(20),@xmid varchar(20),@dj varchar(20)) 	
returns decimal(10,2)
as
begin
	declare @zf decimal(10,2)
	set @zf=0.00
	select @zf=isnull(fbyq,0) from uf_grjxdjfbjy where khzqnf=@year and khzq=@zq and xm=@xmid and grjxkhdj=@dj
   
  return @zf;
end
GO