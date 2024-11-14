#Requires AutoHotkey v2.0

FileEncoding "UTF-8"
CoordMode "ToolTip", "Client"

orgFolder := "org\"
mtlFolder := "mtl\"
fileName := "script.txt"
curentLine := 12333
orgArr := []
mtlArr := []

gamePID := ""
myGui := Gui()
myGui.SetFont("s14", "Tahoma")
thisEdit := myGui.AddEdit("vMyEdit w400 h200", "")

!1::
{
  global curentLine := curentLine + 1
  thisEdit.Value := curentLine
  myGui.Show()
}

!Enter::
{
  Sleep 500
  activeTitle := WinGetTitle("A")
  global gamePID := WinGetPID(activeTitle)
  ToolTip "Game windows captured. Application ready!"

  Loop read, orgFolder . fileName
  {
    orgArr.Push(A_LoopReadLine)
  }

  Loop read, mtlFolder . fileName
  {
    mtlArr.Push(A_LoopReadLine)
  }
}

#HotIf WinActive("ahk_pid " . gamePID)
WheelDown::
{
  Send "{Enter Down}"
  Sleep 300
  Send "{Enter Up}"

  global curentLine := curentLine + 1
  showText()
}

Left::
{
  global curentLine := curentLine - 1
  showText()
}

Right::
{
  global curentLine := curentLine + 1
  showText()
}

PgUp::
{
  thisEdit.Value := orgArr[curentLine]
  myGui.Show()
}

Del::
{
  ToolTip
}

BackSpace::
{
  A_Clipboard := curentLine
  MsgBox "Current line copied: " . curentLine
  Run "sync_app_shortcut.lnk"
  ExitApp
}
#HotIf

F3::
{
  A_Clipboard := ""
  Sleep 300
  Send "^c"
  ClipWait
  myGui.Hide()
  Run "chrome.exe https://mazii.net/vi-VN/search/word/javi/" A_Clipboard
}

showText() {
  ToolTip
  ToolTip curentLine . "/" . orgArr.Length . ": " . orgArr[curentLine] . "`n" . mtlArr[curentLine] ,0,720
}