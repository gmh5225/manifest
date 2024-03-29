Microsoft (R) Manifest Tool
Copyright (c) Microsoft Corporation. 
All rights reserved.

Usage:
-----

```txt
mt.exe  
    [ -manifest <manifest1 name> <manifest2 name> ... ]
    [ -identity:<identity string> ]
    [ < <[-rgs:<.rgs filename>] [-tlb:<.tlb filename>] [-winmd:<.winmd filename>]> -dll:<filename> > [ -replacements:<XML filename> ] ] 
    [ -managedassemblyname:<managed assembly> [ -nodependency ] ]
    [ -out:<output manifest name> ]
    [ -inputresource:<file>[;[#]<resource_id>] ]
    [ -outputresource:<file>[;[#]<resource_id>] ]
    [ -updateresource:<file>[;[#]<resource_id>] ]
    [ -hashupdate[:<path to the files>] ]
    [ -makecdfs ]
    [ -validate_manifest ]
    [ -validate_file_hashes:<path to the files> ]
    [ -canonicalize ]
    [ -check_for_duplicates ]
    [ -nologo ]

Options:
-------
-manifest                  Used to specify manifests that need to be processed.
                           At least one manifest name should follow this option.
                           NOTE: There is no colon(:) after -manifest.
                                    
<manifest1 name> <manifest2 name> ...   
                           Names of manifests to be processed and/or merged.
                           Required if the -manifest option is used.
                           NOTE: More than one manifest automatically indicates
                           a manifest "merge" operation.  In that case, an
                           output specified by one of -out / -outputresource /
                           -updateresource is mandatory.
                                         
-identity:<identity string>
                           The identity string contains the attributes of the
                           assemblyIdentity element.  The identity string is a
                           set of comma separated name=value pairs starting
                           with the "name" attribute's value.  e.g.:
                           "Microsoft.Windows.Common-Controls,
                           processorArchitecture=x86, version=6.0.0.0,
                           type=win32, publicKeyToken=6595b64144ccf1df".
                           NOTE: Only the "name" attribute is not of the form
                           "name=value" and it should be the first attribute in
                           the identity string.

-rgs:                      Takes the name of the .RGS (Registrar script).

-tlb:                      Takes the name of the .TLB (Typelib file).

-winmd:                    Takes the name of the .WINMD (Windows Runtime metadata file).

-dll:                      Takes the name of the DLL: this represents the DLL
                           that is eventually built from the .RGS, .TLB, and .WINMD
                           files. Required if -rgs, -tlb, or -winmd is specified.

-replacements:<.XML filename>           
                           Specifies the file that contains values for
                           replaceable strings in the RGS file.

-managedassemblyname:<managed assembly> [ -nodependency ] 
                           Generates a manifest from a managed assembly.
                           -nodependency suppresses the generation
                           of dependency elements in the final manifest.
                                         
-out:<Output manifest name> 
                           Name of the output manifest.  If this is skipped
                           and only one manifest is being operated upon by the
                           tool, that manifest is modified in place.

-inputresource:<file>[;[#]<resource_id>]
                           Input the manifest from a resource of type
                           RT_MANIFEST with the specified id.
                           resource_id is restricted to be a non-negative,
                           16 bit number.
                           resource_id is optional and defaults to
                           CREATEPROCESS_MANIFEST_RESOURCE_ID (winuser.h).

-outputresource:<file>[;[#]<resource_id>]
                           Output the manifest to a resource of type
                           RT_MANIFEST with the specified id.
                           resource_id is restricted to be a non-negative,
                           16 bit number.
                           resource_id is optional and defaults to
                           CREATEPROCESS_MANIFEST_RESOURCE_ID (winuser.h).

-updateresource:<file>[;[#]<resource_id>]
                           Equivalent to specifying both -inputresource and
                           -ouputresource with identical parameters.
                           resource_id is restricted to be a non-negative,
                           16 bit number.

-hashupdate:<path to the files>         
                           Computes the hash of files specified in the file
                           elements and updates the hash attribute with this
                           value.  The searchpath for the actual files
                           specified in the file elements is specified
                           explicitly.  If <path to the files> is not
                           specified, the searchpath defaults to the location
                           of the output manifest.

-makecdfs                  Generates Catalog Definition Files (.cdf) - used to
                           make catalogs.
                                    
-validate_manifest         Validates to check syntactic correctness of a
                           manifest and its conformance to the manifest schema.

-validate_file_hashes:<path to the files> 
                           Validates the hash values of all the file elements.
                                        
-canonicalize              Does a C14N canonicalization of the output manifest
                           contents.

-check_for_duplicates      Performs a check to see if the final manifest
                           contains duplicate elements.

-nologo                    Runs without displaying standard Microsoft copyright
                           data. This may be used to suppress unwanted output
                           in log files when running mt.exe as part of a build
                           process or from a build environment.

Samples:
-------

> To update the hash of an XML manifest:
mt.exe -manifest 1.manifest -hashupdate -out:updated.manifest

> To update the hash of an XML manifest while simultaneously producing the .cdf file:
mt.exe -manifest 1.manifest -hashupdate -makecdfs -out:updated.manifest

> To merge two manifests:
mt.exe -manifest 1.manifest 2.manifest -out:merged.manifest

> To merge two manifests and finally update the hash to produce the final merged manifest. 
> Note: The searchpath for the actual files specified in the file elements is specified explicitly.
mt.exe -manifest 1.manifest 2.manifest -hashupdate:d:\filerepository -out:merged.manifest

> To generate a manifest from an RGS and/or TLB file:
mt.exe -rgs:MSClus.rgs -tlb:MSClus.tlb -dll:foo.dll -replacements:replacements.manifest -identity:"type=win32, name=Microsoft.Tools.SampleAssembly, version=6.0.0.0, processorArchitecture=x86, publicKeyToken=6595b64144ccf1df" -out:rgstlb.manifest

> To generate an XML manifest from a managed assembly:
mt.exe -managedassemblyname:managed.dll -out:out.manifest
> To suppress dependencies:
mt.exe -managedassemblyname:managed.dll -nodependency -out:out.manifest

> To extract manifest out of a dll:
mt.exe -inputresource:dll_with_manifest.dll;#1 -out:extracted.manifest

> To merge two manifests, one of them embedded in a dll, and embedding final merged manifest into another dll's resource:
mt.exe -inputresource:dll_with_manifest.dll;#1 -manifest 2.manifest -outputresource:dll_with_merged_manifest.dll;#3

> To update the manifest in a PE's resource (by updating the hashes of the file elements): 
mt.exe -updateresource:dll_with_manifest.dll;#1 -hashupdate:f:\files

> To validate the hash values of all the file elements:
mt.exe -manifest 1.manifest -validate_file_hashes:"c:\files"

> To validate a manifest (i.e., to see if it conforms to the manifest schema):
mt.exe -manifest 1.manifest -validate_manifest

> To do a C14N canonicalization of a manifest (in order to get rid of spurious namespace prefixes (like "dsig")):
mt.exe -manifest 1.manifest -canonicalize

> To check for duplicate elements in a manifest:
mt.exe -manifest 1.manifest -check_for_duplicates
```