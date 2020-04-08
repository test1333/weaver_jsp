alter function [dbo].[get_jxjlxs](@i_year varchar(20),@i_zq varchar(20),@i_xmid varchar(20),@i_ryid varchar(20)) 	
returns decimal(10,2)
as
begin
	declare @countnum int,
	@result decimal(10,2),
	@bl decimal(10,2)
	set @result=0.00
   select @countnum=count(a.id) from formtable_main_295 a,workflow_requestbase b where a.requestid=b.requestid and b.currentnodetype>=3  and xmmc=@i_xmid and khzqnf= @i_year and khzq=@i_zq
   if @countnum>0

   begin
    select  @bl=cast(isnull(num,0)*100/@countnum as numeric(10,2))  from (select row_number() over(order by khzgdf desc) as num ,fqr from formtable_main_295 a,workflow_requestbase b where a.requestid=b.requestid and b.currentnodetype>=3  and xmmc=@i_xmid and khzqnf= @i_year and khzq=@i_zq) a where fqr=@i_ryid
    select @result=isnull(b.tbjlxs,0) from uf_xmjxkhjg a,uf_tbjlxsfbsr b where  a.xmkhdj = b.xmkhdj and a.xmmc=@i_xmid and b.fbbl1<@bl and b.fbbl2>=@bl and a.khzqnf=@i_year and a.khzq=@i_zq
   end;
  return @result;
end