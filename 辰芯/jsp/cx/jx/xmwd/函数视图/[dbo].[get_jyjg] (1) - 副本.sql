alter function [dbo].[get_jyjg](@year varchar(20),@zq varchar(20),@xmid varchar(20),@dj varchar(20)) 	
returns varchar(20)
as
begin
	declare @result varchar(20)
	if [dbo].[get_xmrls](@year,@zq,@xmid,'') != 0.000 
	 begin
		if @dj = '0' 
			begin
				if isnull([dbo].[get_fbyq](@year,@zq,@xmid,'0'),0)/100<(cast([dbo].[get_xmrls](@year,@zq,@xmid,'0')/[dbo].[get_xmrls](@year,@zq,@xmid,'') as numeric(10,4)))
					begin
						set @result='不通过'
					end
				else
					begin
						set @result='通过'
					end
			end
		else if @dj = '1'
			begin
			if isnull([dbo].[get_fbyq](@year,@zq,@xmid,'0')+[dbo].[get_fbyq](@year,@zq,@xmid,'1'),0)/100<(cast([dbo].[get_xmrls](@year,@zq,@xmid,'0')/[dbo].[get_xmrls](@year,@zq,@xmid,'') as numeric(10,4))+cast([dbo].[get_xmrls](@year,@zq,@xmid,'1')/[dbo].[get_xmrls](@year,@zq,@xmid,'') as numeric(10,4)))
					begin
						set @result='不通过'
					end
				else
					begin
						set @result='通过'
					end
			end
		else if @dj = '2'
			begin
				if isnull([dbo].[get_fbyq](@year,@zq,@xmid,'0')+[dbo].[get_fbyq](@year,@zq,@xmid,'1')+[dbo].[get_fbyq](@year,@zq,@xmid,'2'),0)/100<(cast([dbo].[get_xmrls](@year,@zq,@xmid,'0')/[dbo].[get_xmrls](@year,@zq,@xmid,'') as numeric(10,4))+cast([dbo].[get_xmrls](@year,@zq,@xmid,'1')/[dbo].[get_xmrls](@year,@zq,@xmid,'') as numeric(10,4))+cast([dbo].[get_xmrls](@year,@zq,@xmid,'2')/[dbo].[get_xmrls](@year,@zq,@xmid,'') as numeric(10,4)))
						begin
							set @result='不通过'
						end
					else
						begin
							set @result='通过'
						end
			end
		else if @dj = '3'
			begin
				if isnull([dbo].[get_fbyq](@year,@zq,@xmid,'0')+[dbo].[get_fbyq](@year,@zq,@xmid,'1')+[dbo].[get_fbyq](@year,@zq,@xmid,'2')+[dbo].[get_fbyq](@year,@zq,@xmid,'3'),0)/100<(cast([dbo].[get_xmrls](@year,@zq,@xmid,'0')/[dbo].[get_xmrls](@year,@zq,@xmid,'') as numeric(10,4))+cast([dbo].[get_xmrls](@year,@zq,@xmid,'1')/[dbo].[get_xmrls](@year,@zq,@xmid,'') as numeric(10,4))+cast([dbo].[get_xmrls](@year,@zq,@xmid,'2')/[dbo].[get_xmrls](@year,@zq,@xmid,'') as numeric(10,4))+cast([dbo].[get_xmrls](@year,@zq,@xmid,'3')/[dbo].[get_xmrls](@year,@zq,@xmid,'') as numeric(10,4)))
						begin
							set @result='不通过'
						end
					else
						begin
							set @result='通过'
						end
			end
	 end
	else 
		begin
			if [dbo].[get_xmrls](@year,@zq,@xmid,@dj) != 0.000 
				begin
					set @result='不通过'
				end
			else 
				begin
					set @result='通过'
				end
		end


   
  return @result;
end
GO