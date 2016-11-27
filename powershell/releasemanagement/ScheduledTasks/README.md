
# MS-ReleaseManagement-ScheduledTasks
Microsoft Release Management Scheduled Tasks (Run,End,Disable,Enable)
Sometimes during deployement you need to Run,End,Enable,Disable a Scheduled Task. This Tool will help you do that. 
The powershell will check to see if the service account is admin, if it is, it will run the task in privilege mode so jobs configured with anohter user account can be started / stopped / Disabeld / Enabled. 


## How to
You will need to create two Tools, and four Actions
* Tools
 * Run/End Scheduled Tasks  (Scheduled_Task_End_Run.ps1)
 * Enable/Disable Scheduled Tasks (Scheduled_Task_Disable_Enable.ps1)
* Actions
 * Run Scheduled Task
 * End Scheduled Task
 * Disable Scheduled Task
 * Enable Scheduled Task

### Under Inventory -> Tools  Create New Tool

#### Scheduled Tasks (End/Run)
```
Name: Scheduled Tasks (End/Run)
Description: Runs Scheduled Task 
Command: PowerShell
Argument: -command ./Scheduled_Task_End_Run.ps1 -Taskaction '__Taskaction __' -Taskname '__Taskname __'
```

![alt text](https://github.com/roozbehk/til/blob/master/powershell/releasemanagement/ScheduledTasks/images/tools-run-end.png?raw=true "Tools Run/End Scheduled Task")

Upload `Scheduled_Task_End_Run.ps1`
Save New Tool.

#### Scheduled Tasks (Disable/Enable)
```
Name: Scheduled Tasks (Disable/Enable)
Description: Enable or Disable a Task
Command: PowerShell
Argument: -command ./Scheduled_Task_Disable_Enable.ps1 -Taskaction '__Taskaction __' -Taskname '__Taskname __'`
```

![alt text](https://github.com/roozbehk/til/blob/master/powershell/releasemanagement/ScheduledTasks/images/tools-enable-disable.png?raw=true "Tools Enable/Disable Task")

Upload `Scheduled_Task_Disable_Enable.ps1`
Save New Tool.


### Create Actions (Run/End/Enable/Disable)

#### Run Scheduled Task
```
Name: Run Scheduled Task
Description: Run Scheduled Task
Categories: Custom
Tools used: Scheduled Tasks (End/Run)
Argument: -command ./Scheduled_Task_End_Run.ps1 -Taskaction Run -Taskname '__Taskname __'
```
![alt text](https://github.com/roozbehk/til/blob/master/powershell/releasemanagement/ScheduledTasks/images/action-run.png?raw=true "Run Scheduled Task")

#### End Scheduled Task

```
Name: End Scheduled Task
Description: End Scheduled Task
Categories: Custom
Tools used: Scheduled Tasks (End/Run)
Argument: -command ./Scheduled_Task_End_Run.ps1 -Taskaction End -Taskname '__Taskname __'
```
![alt text](https://github.com/roozbehk/til/blob/master/powershell/releasemanagement/ScheduledTasks/images/action-end.png?raw=true "End Scheduled Task")

#### Enable Scheduled Task

```
Name: Enable Scheduled Task
Description: Enable Scheduled Task
Categories: Custom
Tools used: Scheduled Tasks (Disable/Enable)
Argument: -command ./Scheduled_Task_Disable_Enable.ps1 -Taskaction Enable -Taskname '__Taskname __'
```
![alt text](https://github.com/roozbehk/til/blob/master/powershell/releasemanagement/ScheduledTasks/images/action-enable.png?raw=true "Enable Scheduled Task")


#### Disable Scheduled Task
```
Name: Disable Scheduled Task
Description: Disable Scheduled Task
Categories: Custom
Tools used: Scheduled Tasks (Disable/Enable)
Argument: -command ./Scheduled_Task_Disable_Enable.ps1 -Taskaction Disable -Taskname '__Taskname __'
```

![alt text](https://github.com/roozbehk/til/blob/master/powershell/releasemanagement/ScheduledTasks/images/action-disable.png?raw=true "Disable Scheduled Task")

### Release Template 
Create a new release template (configure apps->new)  under custom actions you can now find your four actions

![alt text](https://github.com/roozbehk/til/blob/master/powershell/releasemanagement/ScheduledTasks/images/rm-custom.png?raw=true "Disable Scheduled Task")
![alt text](https://github.com/roozbehk/til/blob/master/powershell/releasemanagement/ScheduledTasks/images/rm-custom-example.png?raw=true "Disable Scheduled Task")


### License

open-sourced software licensed under the [MIT license](http://opensource.org/licenses/MIT)
