#!/bin/bash -l 
#############################################################################################################
#Script Name    : ocidpatch_ru.sh
#Description    : Runs PRECHECK / APPLY action for a specified RU Patch for a OCI DB System
#Args           : ocidpatch_ru.sh <compartment_name> <hostname_in_oci> <dbname> <version_needed> <action>
#               : ./ocidpatch_ru.sh DEV devdb01 orcl 19.XX.0.0.0 PRECHECK 
#               : ./ocidpatch_ru.sh DEV devdb01 orcl 19.XX.0.0.0 APPLY 
#Author         : Abhilash Kumar Bhattaram
#Email          : abhilash8@gmail.com     
#GitHb          : https://github.com/abhilash-8/ocidpatchdb
#############################################################################################################
DBENV=${1}
HOSTNAME_IN_OCI=${2}
DBNAME_IN_OCI=${3}
VERSION_TO_APPLY=${4}
ACTION=${5}
call_ru()
{
        source ~/.$DBENV-ocidtab
        echo "### DB System Arguments Provided"
        echo $DBENV
        echo $HOSTNAME_IN_OCI
        echo $DBNAME_IN_OCI
        echo $ACTION
        echo " "
        echo "### DB System Summary "
        oci db system list -c $COMP_OCID --profile SHAI-PROFILE --query "data[?contains(\"hostname\",'$HOSTNAME_IN_OCI')].{hostname:hostname,\"database-edition\":\"database-edition\",dbsysversion:version,id:id}" --output table
        echo " "
        echo "### OCID for DB System to run Patch/PreRequisites"
        export DB_SYSTEM_OCID=$(oci db system list -c $COMP_OCID --profile SHAI-PROFILE --query "data[?contains(\"hostname\",'$HOSTNAME_IN_OCI')].{id:id}" |  jq -r '.[]."id"');echo $DB_SYSTEM_OCID
        echo " "
        echo "### OCID for Database"
        #oci db database list --compartment-id $COMP_OCID --profile SHAI-PROFILE --output table  
        oci db database list --compartment-id $COMP_OCID --profile SHAI-PROFILE --query "data[?contains(\"db-name\",'$DBNAME_IN_OCI')].{\"db-name\":\"db-name\",\"db-unique-name\":\"db-unique-name\",id:id}" --output table
        echo " "        
        echo "### OCID for Database to Patch/PreRequisites"     
        export DB_OCID=$(oci db database list --compartment-id $COMP_OCID --profile SHAI-PROFILE --query "data[?contains(\"db-name\",'$DBNAME_IN_OCI')]" |  jq -r '.[]."id"');echo $DB_OCID
        echo " "
        echo "### OCID for Databse RU Patches which are available"
        oci db patch list by-database --database-id $DB_OCID --profile SHAI-PROFILE --all #--output table
        echo " "
        echo "### OCID for DB RU Patch"
        export PATCH_OCID=$(oci db patch list by-database --database-id $DB_OCID --profile SHAI-PROFILE --all --query "data[?contains(\"version\",'$VERSION_TO_APPLY')]" |  jq -r '.[]."id"');echo $PATCH_OCID
        echo " "
        echo "### DB RU Apply Action " $ACTION
        oci db database patch --database-id $DB_OCID --patch-id $PATCH_OCID --patch-action $ACTION  --profile SHAI-PROFILE
}
## Main
if [ -z "$5" ]
then
        echo " "        
        echo "######################################################################################### "       
        echo "Usage is ocidpatch_ru.sh <compartment_name> <hostname_in_oci> <dbname> <action>"
        echo " "        
        echo "E.g.  # sh ocidpatch_ru.sh DEV devdb01 orcl 19.XX.0.0.0 PRECHECK "
        echo "E.g.  # sh ocidpatch_ru.sh DEV devdb01 orcl 19.XX.0.0.0 APPLY "
        echo " "        
        echo "Pre-requisites : ocidtab environment variable files to be available  "    
        echo "               : Refer https://github.com/abhilash-8/ocidenv to generate ocidtab file  "  
        echo "######################################################################################### "       
        echo " " 
else
        call_ru
fi
