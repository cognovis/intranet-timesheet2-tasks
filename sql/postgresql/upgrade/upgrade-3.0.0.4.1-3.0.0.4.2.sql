

-- Add a "Del" column for tasks

insert into im_view_columns (column_id, view_id, group_id, column_name, column_render_tcl,
extra_select, extra_where, sort_order, visible_for) values (91022,910,NULL,
'"[im_gif del "Delete"]"',
'"<input type=checkbox name=task_id.$task_id>"', '', '', 22, '');



insert into im_view_columns (column_id, view_id, group_id, column_name, column_render_tcl,
extra_select, extra_where, sort_order, visible_for) values (91112,911,NULL, 
'"[im_gif del "Delete"]"', 
'"<input type=checkbox name=task_id.$task_id>"', '', '', 12, '');
