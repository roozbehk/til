### To intentionally delay joining the target computer to the domain during the deployment process, you can remove certain elements from the Unattend.xml file. The ZTIConfigure.wsf script will skip over writing properties to the Unattend.xml file if the associated property element is missing from the file.



Prepare the unattend.xml file so the target computer does not attempt to join the domain during Windows Setup

1.   Click Start, and then point to All Programs. Point to Microsoft Deployment Toolkit, and then click Deployment Workbench.

2.   In the Deployment Workbench console tree, go to Deployment Workbench/Deployment Shares/deployment_share/Task Sequences/task_sequence (where deployment_share is the name of the deployment share and task_sequence is the name of the task sequence to be configured).

3.   In the Actions pane, click Properties.

4.   On the OS Info tab, click Edit Unattend.xml.

The Windows System Image Manager (Windows SIM) starts.

5.   In the Answer File pane, go to 4 specialize/Identification/Credentials. Right-click Credentials, and then click Delete.

6.   Click Yes.

7.   Save the answer file, and then exit Windows SIM.

8.   Click OK on the task sequence Properties dialog box.

With the Credentials elements missing from the unattend.xml file, the ZTIConfigure.wsf script is not able to populate the domain join information in the Unattend.xml file, which will prevent Windows Setup from attempting to join the domain.

To add a task sequence step that joins the target computer to the domain

1.   Click Start, and then point to All Programs. Point to Microsoft Deployment Toolkit, and then click Deployment Workbench.

2.   In the Deployment Workbench console tree, go to Deployment Workbench/Deployment Shares/deployment_share/Task Sequences/task_sequence (where deployment_share is the name of the deployment share and task_sequence is the name of the task sequence to be configured).

3.   In the Actions pane, click Properties.

4.   On the Task Sequence tab, go to and expand the State Restore node.

5.   Verify that the Recover From Domain task sequence step is present. If yes, proceed to step 9.

6.   In the task sequence Properties dialog box, click Add, go to Settings, and click Recover From Domain.

7.   Add the Recover From Domain task sequence step to the task sequence editor. Verify that the step is in the desired location in the task sequence.

8.   Verify that the settings for the Recover From Domain task sequence step are configured to meet your needs.

9.   Click OK on the task sequence Properties dialog box to save the task sequence.


 
