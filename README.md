# telescope-template
offers an interface for creating projects and files based
on given templates.

## example

``` lua

local dotnet_templates = {
    name = 'C#',
    methods = {
	{
	    executable = "/usr/bin/dotnet",
	    text = "New C# Project",
	    params = {"projectName", "projectType", "projectDir"},
	    pre = function(params)
		print(params)
	    end,
	    args = { "new", "projectType"},
	    post = function(params)
		print(params)
	    end,
	},
    }
}

```
