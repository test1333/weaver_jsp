create function [dbo].[get_jxdfqz](@i_year varchar(20),@i_zq varchar(20),@i_xmid varchar(20),@i_ryid varchar(20)) 	
returns decimal(10,1)
as
begin
	declare @result decimal(10,2),
	@countnum int
	set @result=0.00
	if @i_year != '' and @i_zq != '' and @i_xmid != '' and @i_ryid != ''
		begin
			if @i_zq = '0' --ȫ��
				begin
					select  @countnum=count(distinct yf) from uf_ygtrxx where xm1=@i_ryid and nf=@i_year  
					 if @countnum = 0 
						begin 
							set @countnum = 1
						end
					 select @result=cast(isnull(sum(isnull(rltrbl,0)),0)/@countnum as numeric(10,1)) from uf_ygtrxx  where xm=@i_xmid and xm1=@i_ryid and nf=@i_year 
				end
			else if @i_zq = '1' --�ϰ���
				begin
					select  @countnum=count(distinct yf) from uf_ygtrxx where xm1=@i_ryid and nf=@i_year and yf in(0,1,2,3,4,5)
					 if @countnum = 0 
						begin 
							set @countnum = 1
						end
					 select @result=cast(isnull(sum(isnull(rltrbl,0)),0)/@countnum as numeric(10,1)) from uf_ygtrxx  where xm=@i_xmid and xm1=@i_ryid and nf=@i_year and yf in(0,1,2,3,4,5)
				end
			else if @i_zq = '2' --�°���
				begin
					select  @countnum=count(distinct yf) from uf_ygtrxx where xm1=@i_ryid and nf=@i_year and yf in(6,7,8,9,10,11)
					 if @countnum = 0 
						begin 
							set @countnum = 1
						end
					 select @result=cast(isnull(sum(isnull(rltrbl,0)),0)/@countnum as numeric(10,1)) from uf_ygtrxx  where xm=@i_xmid and xm1=@i_ryid and nf=@i_year and yf in(6,7,8,9,10,11)
				end
			else if @i_zq = '3' --��һ����
				begin
					select  @countnum=count(distinct yf) from uf_ygtrxx where xm1=@i_ryid and nf=@i_year and nf=@i_year and yf in(0,1,2)
					 if @countnum = 0 
						begin 
							set @countnum = 1
						end
					 select @result=cast(isnull(sum(isnull(rltrbl,0)),0)/@countnum as numeric(10,1)) from uf_ygtrxx  where xm=@i_xmid and xm1=@i_ryid and nf=@i_year and yf in(0,1,2)					
				end
			else if @i_zq = '4' --�ڶ�����
				begin
					select  @countnum=count(distinct yf) from uf_ygtrxx where xm1=@i_ryid and nf=@i_year andyf in(3,4,5)
					 if @countnum = 0 
						begin 
							set @countnum = 1
						end
					 select @result=cast(isnull(sum(isnull(rltrbl,0)),0)/@countnum as numeric(10,1)) from uf_ygtrxx  where xm=@i_xmid and xm1=@i_ryid and nf=@i_year and yf in(3,4,5)
				end
			else if @i_zq = '5' --��������
				begin
					select  @countnum=count(distinct yf) from uf_ygtrxx where xm1=@i_ryid and nf=@i_year and yf in(6,7,8)
					 if @countnum = 0 
						begin 
							set @countnum = 1
						end
					 select @result=cast(isnull(sum(isnull(rltrbl,0)),0)/@countnum as numeric(10,1)) from uf_ygtrxx  where xm=@i_xmid and xm1=@i_ryid and nf=@i_year and yf in(6,7,8)
				end
			else if @i_zq = '6' --���ļ���
				begin
					select  @countnum=count(distinct yf) from uf_ygtrxx where xm1=@i_ryid and nf=@i_year and yf in(9,10,11)
					 if @countnum = 0 
						begin 
							set @countnum = 1
						end
					 select @result=cast(isnull(sum(isnull(rltrbl,0)),0)/@countnum as numeric(10,1)) from uf_ygtrxx  where xm=@i_xmid and xm1=@i_ryid and nf=@i_year and yf in(9,10,11)
				end
		end
  
  return @result;
end