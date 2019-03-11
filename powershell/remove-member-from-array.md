I found the following helps if you're interested in removing just one or two properties from a large object. Convert your object into JSON then back to an object - all the properties are converted to type NoteProperty, at which point you can remove what you like.

```$mycomplexobject = $mycomplexobject | ConvertTo-Json | ConvertFrom-Json
