```
forfiles -p "X:\SQLBackups" -s -m *.* /D -100 /C "cmd /c del @path"
```
