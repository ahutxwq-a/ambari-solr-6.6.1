# ambari-solr-6.6.1

Ambari Solr 6.6.1 Management Service Pack

# What it contains?

The repository contains Ambari Mpack for Solr 6. 
Includes script for creating local repository and installing them.
The nomenclature and path are exactly same as HDP-Search from lucidworks. 
I have updated the management packs to reference the latest Solr 6 and that is provided to Ambari as a local repo.

# Installation Instructions

```

git clone https://github.com/cheburakshu/ambari-solr-6.6.1.git

cd ambari-solr-6.6.1

./create_local_repo_solr.sh

```

# Note

Change Local IP in Ambari while installing. Currently defaulted to 10.138.0.3. Can be changed in solr-service-mpack-6.6.1/custom-services/SOLR/6.6.1/repos/repoinfo.xml also.
