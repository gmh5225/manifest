<h1>manifest</h1>
few CMD-scripts to help you with <code>manifest</code>-file management,  
post compilation.  
you may extract the MANIFEST (resource 24),  
embed a new-one,  
or simply quickly copy a generic manifest in the proper name to be used as side-by-side manifest.  

<hr/>

ResourceHacker is prefered in resource-extraction since it does not re-parse the resource, just dump it.  
<code>mt.exe</code> is used for embed-actions.  
before the target exe is modified it is copied as a backup.  

<hr/>

<code>_embed.cmd</code> accepts two arguments: a path to a manifest file, and a target file.  
<code>_extract_w_resourcehacker.cmd</code> accepts one argument: a path to a target file.  
<code>_side_by_side.cmd</code> also accepts just one argument: a path to a target file.  

<hr/>

if the file is a DLL, the embedded manifest will use the id `#2`, otherwise (exe/ocx/....anything really) it will use the id `#1` for the manifest. that is a common-practice.
<hr/>

<code>example_manifests/generic.manifest</code> is a well documented manifest file,  
that you may copy and modify in any-way needed,  

<hr/>

special formats and notes.  
manifest should have Windows-EOL, always, even if you've made it into a single line.  
a single whitespace is added to the end of each line.  
never use tabs.  
use JSBeautifier (HTML mode) to normalize a manifest to a readable format.  

<hr/>
if you just want to drag and drop exe/dll/ocx/..... over a CMD and be done with it,  
you may use the `_embed__use_generic_manifest.cmd` and `_side_by_side__use_generic_manifest.cmd`,  
which will use `_embed.cmd` and `_side_by_side.cmd`,  
with the currently available generic manifest at `example_manifests/generic.manifest`.  
you may edit `example_manifests/generic.manifest` before if you wish...  

<hr/>

<h3>do not use <code>highResolutionScrollingAware</code> and do not use <code>ultraHighResolutionScrollingAware</code>, Windows 10 can not handle it, and will notify you have a problem with the side-by-side (also embedded) manifest information.</h3>

<hr/>

using `longPathAware` requires the following registry patch to be applied on each machine (in addition to the value in the manifest):  

```reg
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem]
"LongPathsEnabled"=dword:00000001
```

<hr/>

OS lower than Windows 10 needs registry patch to prefer side-by-side manifest over existing embedded resource,  
which is useful in-case you can not embed a manifest into the file due to it being corrupted after that (which happens sometimes..):  

```reg
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SideBySide]
"PreferExternalManifest"=dword:00000001
```

<hr/>
segmented heap resources:  
https://windowsreport.com/windows-10-segment-heap/  
https://www.blackhat.com/docs/us-16/materials/us-16-Yason-Windows-10-Segment-Heap-Internals.pdf  
https://docs.microsoft.com/en-us/windows/win32/sbscs/application-manifests#heaptype  

long path resources:  
https://docs.microsoft.com/en-gb/windows/win32/fileio/maximum-file-path-limitation?tabs=cmd#enable-long-paths-in-windows-10-version-1607-and-later

<hr/>

<img alt="" src="resources/icon.png" />
