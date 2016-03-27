##Send the array through the pipeline

One of the really powerful aspects of Windows PowerShell is that it automatically handles arrays; For example, by using the pipeline and the Foreach-Object cmdlet, all the complexity disappears.

Today I learned a shorthand version for foreach cmdlet. 

```powershell
$ARRAY = "a","b","c"
$ARRAY | foreach-object { $_ }
```

Same as

```powershell
$ARRAY | % { $_ }
```

Cool huh?
