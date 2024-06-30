# ocidpatchdb
This is a utility to automate OCI DB System GI and RU Patching.
The scripts will dynamically pickup the required OCID values for the GI/RU Patching

# ocidpatchdb prerequisites
The following prerequisites are needed to use the ocidenv
  1) OCI DB System Hostname [ as seen in OCI Web Console ]
  2) OCI DB Name            [ as seen in OCI Web Console ]
  3) DB/GI 
  4) OCI VCN Name
  5) jq to be installed in Linux 
    $ sudo yum install jq
  6) The OCI User in the profile will need to have the required IAM Policies for OCI Services to generate the OCID
  7) ocidtab environment variable files , if not availble  please refer : https://github.com/abhilash-8/ocidenv    
  
# Syntax for patching for GI Patching
$ ./ocidpatch_gi.sh DEV devdb01 orcl XX.XX.0.0.0 PRECHECK
$ ./ocidpatch_gi.sh DEV devdb01 orcl XX.XX.0.0.0 APPLY

i.e. XX.XX.0.0.0 can be referenced as 19.23.0.0.0 for 19.23 GI Patch


# Syntax for patching for GI Patching
$ ./ocidpatch_ru.sh DEV devdb01 orcl XX.XX.0.0.0 PRECHECK
$ ./ocidpatch_ru.sh DEV devdb01 orcl XX.XX.0.0.0 APPLY

i.e. XX.XX.0.0.0 can be referenced as 19.23.0.0.0 for 19.23 RU Patch

# NOTE
The ocidenv script comes with absolutely no gurantee , due diligence is needed for setting up the required ocidtab environment files.

