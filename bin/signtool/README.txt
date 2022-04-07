https://gist.github.com/eladkarako/9521158fe156bdf02f3f8cb52c3d6966#file-signtool-txt

the M$ documentation page is an unreadable cr^p.
here is a plain text alternative.

if you are looking for an example on how to generate and sign an exe, dll, ...
see: https://github.com/eladkarako/sign-exe
all included, no dependencies (see https://github.com/eladkarako/sign-exe/blob/master/sign.cmd for more notes).

if you install Windows 10 SDK, you'll find a perfectly working signtool inside:  
C:\Program Files (x86)\Windows Kits\10\App Certification Kit

if you'll copy just the signtool.exe you will loose some functionality and the console will not show you anything, 
since the files are splitted to libs and mui languages in multiple resources and libs 
(you can try the Windows 7 signtool or simply copy the entire 'App Certification Kit' folder).


-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--=


signtool.exe
-------------------------------------------------
Usage: signtool <command> [options]

  Valid commands:
    sign       --  Sign files using an embedded signature.
    timestamp  --  Timestamp previously-signed files.
    verify     --  Verify embedded or catalog signatures.
    catdb      --  Modify a catalog database.
    remove     --  Remove embedded signature(s) or reduce the size of an
                   embedded signed file.

For help on a specific command, enter "signtool <command> /?"
-------------------------------------------------


signtool.exe sign
-------------------------------------------------
Usage: signtool sign [options] <filename(s)>

Use the "sign" command to sign files using embedded signatures. Signing
protects a file from tampering, and allows users to verify the signer (you)
based on a signing certificate. The options below allow you to specify signing
parameters and to select the signing certificate you wish to use.

Certificate selection options:
/a          Select the best signing cert automatically. SignTool will find all
            valid certs that satisfy all specified conditions and select the
            one that is valid for the longest. If this option is not present,
            SignTool will expect to find only one valid signing cert.
/ac <file>  Add an additional certificate, from <file>, to the signature block.
/c <name>   Specify the Certificate Template Name (Microsoft extension) of the
            signing cert.
/f <file>   Specify the signing cert in a file. If this file is a PFX with
            a password, the password may be supplied with the "/p" option.
            If the file does not contain private keys, use the "/csp" and "/kc"
            options to specify the CSP and container name of the private key.
/i <name>   Specify the Issuer of the signing cert, or a substring.
/n <name>   Specify the Subject Name of the signing cert, or a substring.
/p <pass.>  Specify a password to use when opening the PFX file.
/r <name>   Specify the Subject Name of a Root cert that the signing cert must
            chain to.
/s <name>   Specify the Store to open when searching for the cert. The default
            is the "MY" Store.
/sm         Open a Machine store instead of a User store.
/sha1 <h>   Specify the SHA1 thumbprint of the signing cert.
/fd         Specifies the file digest algorithm to use for creating file
            signatures. (Default is SHA1)
/u <usage>  Specify the Enhanced Key Usage that must be present in the cert.
            The parameter may be specified by OID or by string. The default
            usage is "Code Signing" (1.3.6.1.5.5.7.3.3).
/uw         Specify usage of "Windows System Component Verification"
            (1.3.6.1.4.1.311.10.3.6).

Private Key selection options:
/csp <name> Specify the CSP containing the Private Key Container.
/kc <name>  Specify the Key Container Name of the Private Key.

Signing parameter options:
/as         Append this signature. If no primary signature is present, this   
            signature will be made the primary signature instead.
/d <desc.>  Provide a description of the signed content.
/du <URL>   Provide a URL with more information about the signed content.
/t <URL>    Specify the timestamp server's URL. If this option is not present,
            the signed file will not be timestamped. A warning is generated if
            timestamping fails.
/tr <URL>   Specifies the RFC 3161 timestamp server's URL. If this option
            (or /t) is not specified, the signed file will not be timestamped.
            A warning is generated if timestamping fails.  This switch cannot
            be used with the /t switch.
/tseal <URL> Specifies the RFC 3161 timestamp server's URL for timestamping a
            sealed file.
/td <alg>   Used with the /tr or /tseal switch to request a digest algorithm
            used by the RFC 3161 timestamp server.
/sa <OID> <value> Specify an OID and value to be included as an authenticated
                  attribute in the signature. The value will be encoded as an
                  ASN1 UTF8 string. This option may be given multiple times.
/seal       Add a sealing signature if the file format supports it.
/itos       Create a primary signature with the intent-to-seal attribute.
/force      Continue to seal or sign in situations where the existing signature
            or sealing signature needs to be removed to support sealing.
/nosealwarn Sealing-related warnings do not affect SignTool's return code.

Digest options:
/dg <path>   Generates the to be signed digest and the unsigned PKCS7 files.
             The output digest and PKCS7 files will be: <path>\<file>.dig and
             <path>\<file>.p7u. To output an additional XML file, see /dxml.
/ds          Signs the digest only. The input file should be the digest
             generated by the /dg option. The output file will be:
             <file>.signed.
/di <path>   Creates the signature by ingesting the signed digest to the
             unsigned PKCS7 file. The input signed digest and unsigned
             PKCS7 files should be: <path>\<file>.dig.signed and
             <path>\<file>.p7u.
/dxml        When used with the /dg option, produces an XML file. The output
             file will be: <path>\<file>.dig.xml.
/dlib <dll>  Specifies the DLL implementing the AuthenticodeDigestSign or
             AuthenticodeDigestSignEx function to sign the digest with. This
             option is equivalent to using SignTool separately with the
             /dg, /ds, and /di switches, except this option invokes all three
             as one atomic operation.
/dmdf <file> When used with the /dlib option, passes the file's contents to
             the AuthenticodeDigestSign or AuthenticodeDigestSignEx function
             without modification.

PKCS7 options:
/p7 <path>    Specifies that for each specified content file a PKCS7 file is 
              produced. The PKCS7 file will be named: <path>\<file>.p7
/p7co <OID>   Specifies the <OID> that identifies the signed content.
/p7ce <Value> Defined values:
                Embedded           - Embeds the signed content in the PKCS7.
                DetachedSignedData - Produces the signed data part of
                                     a detached PKCS7.
                Pkcs7DetachedSignedData - Produces a full detached PKCS7.
              The default is 'Embedded'

Other options:
/ph         Generate page hashes for executable files if supported.
/nph        Suppress page hashes for executable files if supported.
            The default is determined by the SIGNTOOL_PAGE_HASHES
            environment variable and by the wintrust.dll version.
/rmc        Specifies signing a PE file with the relaxed marker check semantic.
            The flag is ignored for non-PE files. During verification, certain
            authenticated sections of the signature will bypass invalid PE
            markers check. This option should only be used after careful
            consideration and reviewing the details of MSRC case MS12-024 to
            ensure that no vulnerabilities are introduced.
/q          No output on success and minimal output on failure. As always, 
            SignTool returns 0 on success, 1 on failure, and 2 on warning.
/v          Print verbose success and status messages. This may also provide
            slightly more information on error.
/debug      Display additional debug information.
-------------------------------------------------


signtool.exe timestamp
-------------------------------------------------
Usage: signtool timestamp [options] <filename(s)>

Use the "timestamp" command to add a timestamp to a previously-signed file.
The "/t" option is required.

/q          No output on success and minimal output on failure. As always, 
            SignTool returns 0 on success and 1 on failure.
/t <URL>    Specify the timestamp server's URL.
/tr <URL>   Specifies the RFC 3161 timestamp server's URL.
/tseal <URL> Specifies the RFC 3161 timestamp server's URL for timestamping a
            sealed file.  One of /t, /tr or /tseal is required.
/td <alg>   Used with the /tr or /tseal switch to request a digest algorithm
            used by the RFC 3161 timestamp server.
/tp <index> Timestamps the signature at <index>.
/p7         Timestamps PKCS7 files.
/force      Remove any sealing signature that is present in order to timestamp.
/nosealwarn Warnings for removing a sealing signature do not affect SignTool's
            return code.
/v          Print verbose success and status messages. This may also provide
            slightly more information on error.
/debug      Display additional debug information.
-------------------------------------------------


signtool.exe verify
-------------------------------------------------
Usage: signtool verify [options] <filename(s)>

Use the "verify" command to verify embedded or catalog signatures.
Verification determines if the signing certificate was issued by a trusted
party, whether that certificate has been revoked, and whether the certificate
is valid under a specific policy. Options allow you to specify requirements
that must be met and to specify how to find the catalog, if appropriate.

Catalogs are used by Microsoft and others to sign many files very efficiently.
Catalog options:
/a          Automatically attempt to verify the file using all methods. First
            search for a catalog using all catalog databases. If the file is
            not signed in any catalog, attempt to verify the embedded
            signature. When verifying files that may or may not be signed in a
            catalog, such as Windows files and drivers, this option is the
            easiest way to ensure that the signature is found.
/ad         Find the catalog automatically using the default catalog database.
/as         Find the catalog automatically using the system component (driver)
            catalog database.
/ag <GUID>  Find the catalog automatically in the specified catalog database.
            Catalog databases are identified by GUID.
            Example GUID: {F750E6C3-38EE-11D1-85E5-00C04FC295EE}
/c <file>   Specify the catalog file.
/o <ver>    When verifying a file that is in a signed catalog, verify that the
            file is valid for the specified platform.
            Parameter format is: PlatformID:VerMajor.VerMinor.BuildNumber
/hash <SHA1 | SHA256> Optional hash algorithm to use when searching for
            a file in a catalog.

SignTool uses the "Windows Driver" Verification Policy by default. The options
below allow you to use alternate Policies.
Verification Policy options:
/pa         Use the "Default Authenticode" Verification Policy.
/pg <GUID>  Specify the verification policy by GUID (also called ActionID).

Signature requirement options:
/ca <h>     Verify that the file is signed with an intermediate CA cert with
            the specified hash. This option may be specified multiple times;
            one of the specified hashes must match.
/r <name>   Specify the Subject Name of a Root cert that the signing cert must
            chain to.
/sha1 <h>   Verify that the signer certificate has the specified hash. This
            option may be specified multiple times; one of the specified hashes
            must match.
/tw         Generate a Warning if the signature is not timestamped.
/u <usage>  Generate a Warning if the specified Enhanced Key Usage is not
            present in the cert. This option may be given multiple times.

Other options:
/all        Verify all signatures in a file with multiple signatures.
/ds <index> Verify the signature at <index>.
/ms         Use multiple verification semantics. This is the default behavior
            of a Win8 WinVerifyTrust call.
/sl         Verify sealing signatures for supported file types.
/p7         Verify PKCS7 files. No existing policies are used for p7 validation.
            The signature is checked and a chain is built for the signing
            certificate.
/bp         Perform the verification with the Biometric mode signing policy.
/enclave    Perform the verification with the enclave signing policy. This also
            prints the Unique ID and Author ID information.
/kp         Perform the verification with the kernel-mode driver signing policy.
/q          No output on success and minimal output on failure. As always, 
            SignTool returns 0 on success, 1 on failure, and 2 on warning.
/ph         Print and verify page hash values.
/d          Print Description and Description URL.
/v          Print verbose success and status messages. This may also provide
            slightly more information on error. If you want to see information
            about the signer, you should use this option.
/debug      Display additional debug information.
/p7content <file> Provide p7 content file incase of detached signatures (signed using PKCS7DetachedSignedData).
-------------------------------------------------


signtool.exe catdb
-------------------------------------------------
Usage: signtool catdb [options] <filename(s)>

Use the "catdb" command to add or remove catalog files to or from a catalog
database. Catalog databases are used for automatic lookup of catalog files,
and are identified by GUID.

Catalog Database options allow you to select which catalog database to operate
on. If you do not specify a catalog database, SignTool operates on the system
component (driver) database.
Catalog Database options:
/d          Operate on the default catalog database instead of the system
            component (driver) catalog database.
/g <GUID>   Operate on the specified catalog database.

Other options specify what to do with the selected catalog database, and other
behavior. If you do not specify any other options, SignTool will add the
specified catalogs to the catalog database, replacing any existing catalog
which has the same name.
Other options:
/q          No output on success and minimal output on failure. As always, 
            SignTool returns 0 on success and 1 on failure.
/r          Remove the specified catalogs from the catalog database.
/u          Automatically generate a unique name for the added catalogs. The
            catalog files will be renamed if necessary to prevent name
            conflicts with existing catalog files.
/v          Print verbose success and status messages. This may also provide
            slightly more information on error.
/debug      Display additional debug information.
-------------------------------------------------


signtool.exe remove
-------------------------------------------------
Usage: signtool remove [options] <filename(s)>

Use the "remove" command to remove the embedded signature(s) or sections of
the embedded signature on a PE/COFF file.

WARNING: This command will modify the file on the disk. Please create a backup
copy if you want to preserve the original file.

The option "/c" and/or "/u", or "/s" is required.

/c          Remove all certificates, except for the signer certificate 
            from the signature.
/q          No output on success and minimal output on failure. As always, 
            SignTool returns 0 on success and 1 on failure.
/s          Remove the signature(s) entirely.
/u          Remove the unauthenticated attributes from the signature
            e.g. Dual signatures and timestamps.
/v          Print verbose success and status messages. This may also provide
            slightly more information on error.
-------------------------------------------------
