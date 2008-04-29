-- upgrade-3.2.9.0.0-3.3.0.0.0.sql

SELECT acs_log__debug('/packages/intranet-timesheet2-tasks/sql/postgresql/upgrade/upgrade-3.2.9.0.0-3.3.0.0.0.sql','');

create or replace view im_timesheet_tasks_view as
select
	t.task_id,
	t.material_id,
	t.uom_id,
	t.planned_units,
	t.billable_units,
	t.cost_center_id,
	t.invoice_id,
	t.priority,
	t.sort_order,
	t.gantt_project_id,
        p.parent_id as project_id,
        p.project_name as task_name,
        p.project_nr as task_nr,
        p.percent_completed,
        p.project_type_id as task_type_id,
        p.project_status_id as task_status_id,
        p.start_date,
        p.end_date,
        p.reported_hours_cache,
        p.reported_hours_cache as reported_units_cache
from
        im_projects p,
        im_timesheet_tasks t
where
        t.task_id = p.project_id
;

