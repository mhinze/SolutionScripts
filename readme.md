SolutionScripts is a Nuget package that sources custom scripts and includes custom powershell modules

Installation instructions:
---

    Install-Package SolutionScripts


Why?
---

When Visual Studio opens a solution, Nuget looks at each installed package for an init.ps1 script in the package's tools directory. If that script exists it will be executed.  [This is the way that package authors enhance the package manager console experience for consumers of their packages](http://haacked.com/archive/2011/04/19/writing-a-nuget-package-that-adds-a-command-to-the.aspx).

_However_, sometimes developers want to add functions or custom script that will execute in the package manager console independent of a particular package. In this case, a lone developer can customize the [powershell profile that the package manager console uses](http://docs.nuget.org/docs/start-here/using-the-package-manager-console#Setting_up_a_NuGet_Powershell_Profile).

This doesn't scale. When sharing custom scripts and global functions across an entire team for a particular project, it doesn't make sense to edit each developer's profile. The profile works across multiple solutions. That would also be weird, to edit a user's profile automaticaly.  It also doesn't make sense to install a custom package just for each global function you wanted to register. You could do that, but you'd then have a billion highly targetted packages in your solution. 

With SolutionScripts you can check in custom scripts in the `SolutionScripts` directory (which by convention sits at the same level as the packages directory). SolutionScripts will run them every time you load up the solution. If you want to refresh the scripts in the `SolutionScripts` directory without reloading the solution, just issue the `Update-SolutionScripts` command in the package manager console. 

How?
---

SolutionScripts looks for (or creates) a directory called `SolutionScripts` at the same level as the packages directory. 

It looks in that directory for ps1 files. If any exist, it [dot sources](http://technet.microsoft.com/en-us/library/ee176949.aspx#ECAA) them. 

It also looks for psm1 files (modules). If any exist, init will [import](http://technet.microsoft.com/en-us/library/dd819454.aspx) them. (this is prefered way over ps1 files - [example](http://stackoverflow.com/a/6040725))

What else?---

That's it, as far as SolutionScripts goes.

Package Manager Console Tips
---

- If you want to see all the global functions, issue `dir function:`

- If you want to see all the imported modules, issue `Get-Module`