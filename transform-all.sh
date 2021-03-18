#!/usr/bin/env bash
#
# Usage:
# $ ./transform-all.sh nanopubs/np1/cage_clusters_version2 5
# $ ./transform-all.sh nanopubs/np2/gene_associations_version2 2
# $ ./transform-all.sh nanopubs/np3/ff_expressions_version2 1044

(for N in $(seq 1 1 $2); do gunzip -c $1_$N.nq.gz; done) \
  | sed -r 's!^([^ ]+ <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.nanopub.org/nschema#Nanopublication> [^ ]+)> .$!\1#Head> .!' \
  | sed -r 's!^([^ ]+ <http://www.nanopub.org/nschema#has(Assertion|Provenance|PublicationInfo)> [^ ]+ [^ ]+)> .$!\1#Head> .!' \
  | sed -r 's!(<http://purl.org/dc/terms/hasVersion> "2.0")\^\^<http://www.w3.org/2001/XMLSchema#double>!\1!g' \
  | sed -r 's!<http://rdf.biosemantics.org/nanopubs/riken/fantom5/version_2/([^ #]+)#?([^ #]*)>!<http://purl.org/nanopub/temp/\1\2>!g' \
  | gzip \
  > $1.mod.nq.gz

np op filter -o $1.mod.trig $1.mod.nq.gz
cat prefixes.trig $1.mod.trig | gzip > $1.mod.trig.gz
np mktrusty -o $1.trusty.trig.gz $1.mod.trig.gz

rm $1.mod.nq.gz $1.mod.trig $1.mod.trig.gz
