`iconv` can be used to convert file to UTF-8.

```txt
-t ENCODING, --to-code=ENCODING
                            the encoding of the output
```

specifying `from` is not needed but you may always use:  
`iconv -f UTF-16 -t UTF-8 myfile.txt`  

<hr/>

`mac2unix` and `dos2unix` can be used to normalize EOL to unix,  
and eventually `unix2dos` can be used to normalize a file to Windows-EOL.  

the following command can make sure there is no BOM.  

```txt
-r, --remove-bom      remove Byte Order Mark
```

<hr/>

help-information included in `readme_iconv.txt`, `readme_dos2unix.txt`, `readme_mac2unix.txt`, `readme_unix2dos.txt`, `readme_unix2mac.txt`.

<hr/>

binaries are from https://github.com/git-for-windows/git/releases  
extracted from `PortableGit-2.33.0-32-bit.7z.exe` and `PortableGit-2.33.0-64-bit.7z.exe` - using <a href="https://github.com/mcmilk/7-Zip-zstd/releases">7zip</a>, from `/usr/bin/` .  
