#Requires AutoHotkey v2.0
ModifyXButtons := false

^F3::
{
    global ModifyXButtons
    ModifyXButtons := !ModifyXButtons
}

#HotIf ModifyXButtons
XButton1::
{
    Send("!q")
}
XButton2::
{
    Send("!q")
}
#HotIf

