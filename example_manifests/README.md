generic is a well documented example, it includes what to do an do not and can be used as is, 
in-fact, there are cmd scripts that work directly with it (drag/drop friendly).  
minimal in not having settings, and no theme support, just security and compatibility, you can use it for a command-line app, or build on top of it...  
`.min` is a variation without newlines, and w/o comments, not easy to read, but you can always use jsbeautifier (html mode) to make it readable.

you can also paste your prefered content into the generic one, to easily use the already provided cmd scripts that work with it.  

`.res` are binaries, compiled from `.rc` files (text based), in this case I've embedded each of the manifest-files, then used ResourceHacker to extract a `.res`,  
that includes just the manifest resource.  
you can embed `.res` in any architecture exe or dll. it is essentially just for developers that are compiling their program. see: https://github.com/eladkarako/gcc-manifest-icon (but don't use that manifest, it is old).
 
<hr/>

`.rc` files are text files that instruct the compiler how to embed the resources written in it, in compilation time.  
you do not really need it, this is just an example (in this case just pointing to a `generic.manifest` text-based file),  
note that there are two files one if you are compiling dll,  
and ANOTHER if you are compiling exe.  
both uses resource 24 (a.k.a "MANIFEST") but dll uses <strong>resource name</strong> of `2`,  
and exe uses resource name of `1`. I am not 100% sure why. but that is what explained in various M$ examples.  
 