#!/usr/bin/env bash
#
# Usage:
# $ ./transform-all.sh nanopubs/np1/cage_clusters_version2 5
# $ ./transform-all.sh nanopubs/np2/gene_associations_version2 2
# $ ./transform-all.sh nanopubs/np3/ff_expressions_version2 1044

(for N in $(seq 1 1 $2); do gunzip -c $1_$N.nq.gz; done) \
  | sed -r 's_^([^ ]+ <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.nanopub.org/nschema#Nanopublication> [^ ]+)> .$_\1#Head> ._' \
  | sed -r 's_^([^ ]+ <http://www.nanopub.org/nschema#has(Assertion|Provenance|PublicationInfo)> [^ ]+ [^ ]+)> .$_\1#Head> ._' \
  | gzip \
  > $1.mod.nq.gz

np mktrusty -o $1.trusty.trig.gz $1.mod.nq.gz

