# ocidpatchdb
This is a utility to automate OCI DB System GI and RU Patching 

ocidpatchdb_gi.sh is a script that will run PRECHECK/APPLY for GI Patching for OCI DB Systems
-- 

ocidpatchdb_ru.sh is a script that will run PRECHECK/APPLY for RU Patching for OCI DB Systems



# ocidenv prerequisites
The following prerequisites are needed to use the ocidenv
  1) OCI Config Path 
  2) OCI Profile 
  3) OCI Compartment 
  4) OCI VCN Name
  5) jq to be installed in Linux 
    $ sudo yum install jq
  6) The OCI User in the profile will need to have the required IAM Policies for OCI Services to generate the OCID     
  
# ocidenv syntax to generate ocidtab 
$ . ./ocidenv.sh <config_file_path> <oci_profile> <compartment_name> <vcn_name> && env | grep OCID

# ocidtab usage
The ocidenv.sh output will generate ocidtab files 

for e.g.
$ . ./ocidenv.sh ~/.oci/config DEV-PROFLE1 DEV-COMP1 DEV-VCN1 && env | grep OCID

This command will generate a ocidtab file ~/.DEV-PROFLE1-ocidtab which can be sourced as Environment Variable files or shell scripts 

$ . .DEV-PROFLE1-ocidtab

$ oci iam region-subscription list --all --output table --profile $CONFIG_PROFILE

$ oci iam availability-domain list -c $TENANCY_OCID --output table --profile $CONFIG_PROFILE

In the above ehe $CONFIG_PROFILE and $TENANCY_OCID variable will be sourced from the ocidtab file  .DEV-PROFLE1-ocidtab


# NOTE
The ocidenv script comes with absolutely no gurantee , due diligence is needed for setting up the required ocidtab environment files.

