 <script type=text/javascript>

    function validate_form(e) {
        if (!calc_total()) {
            alert('$err_not_float');
            e.returnValue = false;
        } else {
            e.returnValue = true;
        }
    }

    function calc_total() {
        var err_p = 0; 

        var val_1 = document.getElementById('planned_units.1').value;
        var val_2 = document.getElementById('planned_units.2').value;
        var val_3 = document.getElementById('planned_units.3').value;
        var val_4 = document.getElementById('planned_units.4').value;
        var val_5 = document.getElementById('planned_units.5').value;
        // alert(parseFloat(val_1) + parseInt(val_2) + parseFloat(val_3)); 
        // Check for non number in Planned Units 

        for (i=1;i<=6;i++) {
            var var_ = 'val_' + i;
            if ( (!var_ != '') && (!isFloat(var_)) ) {
                err_p = 1;
            };
        };
        if ( err_p == 0 ) {
            document.getElementById('sum_planned_units').innerHTML = parseFloat(val_1) + parseFloat(val_2) + parseFloat(val_3)+ parseFloat(val_4) + parseFloat(val_5);
            return 1;
        } else {
            alert('$err_not_float');
            return 0;
        }; 	
    }
	
    function set_project_nr_st(el) {
        var idx = el.id;
        var var_task_name = el.id; 
        var var_task_nr = el.id.replace('task_name_st', 'task_nr_st'); 
                var tmp = replaceSpaces_st(document.getElementById(var_task_name).value);
                document.getElementById(var_task_nr).value = removeSpaces_st(tmp.replace(/\[^a-zA-Z 0-9 _ \]+/g,'')).substring(0,29);
    }
    function removeSpaces_st(string) {
         return string.split(' ').join('');
    }
    function replaceSpaces_st(string) {
        return string.split(' ').join('_');
    }
	
    calc_total();

    function isInt(n) {return n % 1 == 0;}
    function isFloat(n) {return n===+n && n!==(n|0);}

</script>
	   
<!--<h3>Split-up Task</h3>-->
#intranet-timesheet2-tasks.SplitUpTaskExplain#
<br><br>      
   <form action='/intranet-timesheet2-tasks/convert-task-to-subproject?advanced=0' onsubmit='return validate_form(event)' method='POST'>
    <input type='hidden' name='source_task_id' value='@task_id@'>
    <table>
        <tr>
            <td><strong>Task Name</strong></td>
            <td><strong>Task No.</strong></td>
            <td><strong>User</strong></td>
            <td><strong>Start Date</strong></td>
            <td><strong>End Date</strong></td>
            <td><strong>UoM</strong></td>
            <td><strong>Planned Units</strong></td>
        </tr>	    
	    
@table_rows;noquote@

        <tr>
            <td colspan=6><strong>Total</strong></td>
            <td><strong><span id='sum_planned_units'></span></strong></td>
        </tr>
    </table>
    <!--<input type='checkbox' name='remove_planned_units_p'> DOLLARlabel_remove_planned_units<br>-->
    <br>
    <input name='formbutton:edit' value='Submit' type='submit'>
</form>