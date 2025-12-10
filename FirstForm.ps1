#---Add Forms Assembly---#
Add-Type -AssemblyName System.Windows.Forms

#---Create Form----#
$Form1 = New-Object System.Windows.Forms.Form
$Form1.Text = 'Demo Powershell Form'
$Form1.Width = 600
$Form1.Height = 400
$Form1.AutoSize = $true
$Form1.StartPosition = "CenterScreen"

#----Add Control elements to the form----#

#----Labels-----#
$Label1 = New-Object System.Windows.Forms.Label
$Label1.Text = 'Installed KBs'
$Label1.Location = New-Object System.Drawing.Point(10,30)
$Label1.AutoSize = $true

$Label2 = New-Object System.Windows.Forms.Label
$Label2.Text = ""
$Label2.Location = New-Object System.Drawing.Point(10,200)
$Label2.AutoSize = $true

$Form1.Controls.Add($Label1)
$Form1.Controls.Add($Label2)

#-----Combobox-----#
$Combobox1 = New-Object System.Windows.Forms.ComboBox
$Combobox1.Width = 300

$HFixes = Get-HotFix | Select HotfixID
foreach($Hfix in $HFixes)
{
$Combobox1.Items.Add($Hfix.HotfixID)
}
$Combobox1.Location = New-Object System.Drawing.Point(120,30)
$Form1.Controls.Add($Combobox1)

#-----Button-------#
$Button1 = New-Object System.Windows.Forms.Button
$Button1.Size = New-Object System.Drawing.Size(120,23)
$Button1.Location = New-Object System.Drawing.Size(230,280)
$Button1.Text = "Surprise Me"

$Button1.Add_Click(
{
$installedDate = ((Get-HotFix $Combobox1.SelectedItem).InstalledOn)
$Label2.Text = ($Combobox1.SelectedItem) + " is installed on date " + $installedDate
}
)
$Form1.Controls.Add($Button1)

#----File/folder Dialogue box-------#

$Dbox1 = New-Object System.Windows.Forms.OpenFileDialog
#$Dbox1.RootFolder = 'Desktop'
$Dbox1.ShowDialog()

#-----Display Form----#

$Form1.ShowDialog()