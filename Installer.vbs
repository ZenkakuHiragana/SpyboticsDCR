'Name of the program.
InstallerName = "Spybotics"

'Folder to copy.
CopyFolder = "spybotics"

'Folder to install to.
TargetFolder = "C:\xampp\htdocs\"

'Set objects.
Set WScriptShell = CreateObject("WScript.Shell")
Set ScriptingFileSystemObject = CreateObject("Scripting.FileSystemObject")

'Ask to install. If not OK, create message and quit.
QuestionBox1 = MsgBox ("Ready to install " & InstallerName & "." & Vbcrlf & "Click OK to continue or Cancel to exit the installation." & Vbcrlf & "Note: Make sure you have already installed XAMPP or" & Vbcrlf & "another local server program before continuing.", 1, InstallerName & " Installer")
If QuestionBox1 <> vbOK Then
MsgBox "Installation cancelled.", 0, InstallerName & " Installer"
WScript.Quit
End If

'Ask for path to install and provide default location.
CopyToPath = InputBox("Input the path to install " & InstallerName & ". For XAMPP installed to the default directory (C:\), click OK. If you installed XAMPP to a different directory or used another program, enter the correct top level server folder path below, then click OK.", InstallerName & " Installer", TargetFolder) 

'If Cancel was clicked, or nothing was entered, create message and exit.
If CopyToPath = "" Then
MsgBox "Installation cancelled.", 0, InstallerName & " Installer"
WScript.Quit
End If

'Check if the target folder already exists and ask to overwrite. If No was clicked, create message and exit.
If ScriptingFileSystemObject.FolderExists(CopyToPath & "\" & CopyFolder) Then
QuestionBox2 = MsgBox ("This program has detected that " & InstallerName & " is already installed." & Vbcrlf & "Do you wish to reinstall? Click Yes to reinstall, or No to exit the installation.", 4 + 256, InstallerName & " Installer")
If QuestionBox2 <> vbYes Then
MsgBox "Installation cancelled.", 0, InstallerName & " Installer"
WScript.Quit
End If
End If

'Get current directory.
WScriptShell.CurrentDirectory = ScriptingFileSystemObject.GetParentFolderName(Wscript.ScriptFullName)

'Set current directory variable.
CurrentDirectory = WScriptShell.CurrentDirectory

'Set path to copy from.
CopyFromPath = CurrentDirectory & "\" & CopyFolder

'Set objects.
Set ShellApplication = CreateObject("Shell.Application")
Set NameSpaceCopyPath = ShellApplication.NameSpace(CopyToPath)

'Check if the folder exists to copy from, else create an error message and exit.
If Not ScriptingFileSystemObject.FolderExists(CopyFromPath) Then
MsgBox "Could not find folder: " & CopyFolder & Vbcrlf & "Check the path and try again.", 0, InstallerName & " Installer"
WScript.Quit
End If

'Check if the folder exists to copy to, else create an error message and exit.
If Not ScriptingFileSystemObject.FolderExists(CopyToPath) Then
MsgBox "Could not find folder: " & Vbcrlf & CopyToPath & Vbcrlf & "Check the path and try again.", 0, InstallerName & " Installer"
WScript.Quit
End If

'If it exists, delete old folder first.
If ScriptingFileSystemObject.FolderExists(CopyToPath & "\" & CopyFolder) Then
Set DeleteFolder = ScriptingFileSystemObject.GetFolder(CopyToPath & "\" & CopyFolder)
DeleteFolder.Delete
End If

'Copy the folder to install.
NameSpaceCopyPath.CopyHere CopyFromPath, 16

'Create final message box, then exit.
MsgBox "Installation complete. You can now play " & InstallerName & Vbcrlf & "with Launcher.html.", 0, InstallerName & " Installer"
wscript.quit