#!powershell
## Exctract *.rpa files in current dir
py -m unrpa (gci *.zip | % { "$_" })
