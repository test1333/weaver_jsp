create or replace view view_action_plan as
  select * from uf_action_plan
   where is_send is null;
