#!/usr/bin/env bash
#
# Usage:
# $ ./check.sh

echo nanopubs/np1/trusty.cage_clusters_version2.mod.nq.gz
np check nanopubs/np1/trusty.cage_clusters_version2.mod.nq.gz
echo nanopubs/np2/trusty.gene_associations_version2.mod.nq.gz
np check nanopubs/np2/trusty.gene_associations_version2.mod.nq.gz
echo nanopubs/np3/trusty.ff_expressions_version2.mod.nq.gz
np check nanopubs/np3/trusty.ff_expressions_version2.mod.nq.gz

