
# ---------------------------------------------------------------------
# Defaults, Security & Globals
# ---------------------------------------------------------------------

set link "<a href='/intranet-timesheet2-tasks/convert-task-to-subproject?task_id=$task_id'>Convert task to subproject</a>"
set err_not_float [lang::message::lookup "" intranet-timesheet2-tasks.ErrValueNotFloat "Please provide an number for planned units, e.g.: 0.5"] 

# ------------------------------------------------------------------
# Sanity checks
# ------------------------------------------------------------------

# Anything that prevents splitting? 
set log_hours_on_parents_p [parameter::get -package_id [apm_package_id_from_key intranet-timesheet2] -parameter "LogHoursOnParentWithChildrenP" -default 0]
if { !$log_hours_on_parents_p } {
    set number_hours [db_string get_data "select count(*) from im_hours where project_id = :task_id" -default 0]
    if {  0 != $number_hours } {
        return  [lang::message::lookup "" intranet-timesheet2-tasks.SplitNotAllowed \
         "Splitting this task is not allowed since there are halready hours logged \
          on this task and Parameter 'LogHoursOnParentWithChildrenP' prevents logging hours on a project level"]
    }
}

# ------------------------------------------------------------------
# Output
# ------------------------------------------------------------------

set table_rows "" 

set option_items_uom [im_cost_uom_options 0]
set uom_options_html ""
foreach option $option_items_uom {
    set value [lindex $option 1]
    set label [lindex $option 0]
    if { 320 != $value} {
        append uom_options_html "<option value='$value'>$label</option>"
    } else {
        append uom_options_html "<option value='$value' selected='selected'>$label</option>"
    }
}

# get start/end date of source task 
db_1row get_dates_of_source_task "
    select
        to_char(start_date, 'YYYY-MM-DD') as start_date_source_task,
        to_char(end_date, 'YYYY-MM-DD') as end_date_source_task
    from 
        im_projects 
    where 
        project_id = :task_id		 
"

# TODO: Limit the employees to the employees asssigned to the parent project
for {set i 1} {$i < 6} {incr i} {
    append table_rows " 
                <tr>
                <td><nobr><input onblur='set_project_nr_st(this);' name='task_name_st.$i' value='' id='task_name_st.$i' size='20' type='text'>&nbsp;&nbsp; </nobr></td>
                <td><nobr><input name='task_nr_st.$i' id='task_nr_st.$i' size='20' type='text'>&nbsp;&nbsp;</nobr></td>
                <td><nobr>[im_employee_select_multiple assignee_id.$i "" 1]</nobr></td>
                <td>
            <nobr>
            <input name='start_date.$i' id='start_date.$i' size='10' type='text' value='$start_date_source_task'>
            <input type=\"button\" style=\"height:20px; width:20px; background: url('/resources/acs-templating/calendar.gif')\" onclick =\"return showCalendar('start_date.$i', 'y-m-d');\" >
            &nbsp;&nbsp;
            </nobr>
        </td>
                <td>
            <nobr>
            <input name='end_date.$i' id='end_date.$i' size='10' type='text' value='$end_date_source_task'>
            <input type=\"button\" style=\"height:20px; width:20px; background: url('/resources/acs-templating/calendar.gif')\" onclick =\"return showCalendar('end_date.$i', 'y-m-d');\" >
            &nbsp;&nbsp;
            </nobr>
        </td>

                <td>
             <nobr>
            <select name='uom_id.$i' id='uom_id.$i'>
            $uom_options_html
                        </select>&nbsp;&nbsp;
             </nobr>
                </td>
                <td><nobr><input onblur='calc_total();' name='planned_units.$i' value='0' id='planned_units.$i' size='5' type='text'> </nobr></td>
                </tr>
        "	
}

# set label_remove_planned_units [lang::message::lookup "" intranet-timesheet2-tasks.RemovePlannedHours "Remove 'Planned Hours' from source task"]
