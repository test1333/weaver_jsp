alter function [dbo].[get_jxjlxs](@i_year varchar(20),@i_zq varchar(20),@i_xmid varchar(20),@i_ryid varchar(20)) 	
returns decimal(10,2)
as
begin
	declare @num int,
	@zqz decimal(10,2),
	@result decimal(10,2),
	@grqzhj decimal(10,2)
	set @result=0.00
   select @zqz=isnull(sum(isnull(ygkhqz,0.0)),0) from formtable_main_295 a,workflow_requestbase b where a.requestid=b.requestid   and xmmc=@i_xmid and khzqnf= @i_year and khzq=@i_zq and isnull(a.khzgdf,0)>0
   if @zqz>0

   begin
    select  @num=num  from (select row_number() over(order by khzgdf desc) as num ,fqr from formtable_main_295 a,workflow_requestbase b where a.requestid=b.requestid  and xmmc=@i_xmid and khzqnf= @i_year and khzq=@i_zq and isnull(a.khzgdf,0)>0 ) a where fqr=@i_ryid
	 select  @grqzhj=isnull(sum(isnull(ygkhqz,0.0)),0)  from (select row_number() over(order by khzgdf desc) as num ,fqr,ygkhqz from formtable_main_295 a,workflow_requestbase b where a.requestid=b.requestid  and xmmc=@i_xmid and khzqnf= @i_year and khzq=@i_zq and isnull(a.khzgdf,0)>0 ) a where num<=@num
    select @result=isnull(b.tbjlxs,0) from uf_xmjxkhjg a,uf_tbjlxsfbsr b where  a.xmkhdj = b.xmkhdj and a.xmmc=@i_xmid and (b.fbbl1/100*@zqz)<@grqzhj and (b.fbbl2/100*@zqz)>=@grqzhj and a.khzqnf=@i_year and a.khzq=@i_zq
   end;
  return @result;
end